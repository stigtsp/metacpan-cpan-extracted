# vim: set ts=8 sts=2 sw=2 tw=100 et :
use strictures 2;
use 5.020;
use experimental qw(signatures postderef);
use if "$]" >= 5.022, experimental => 're_strict';
no if "$]" >= 5.031009, feature => 'indirect';
no if "$]" >= 5.033001, feature => 'multidimensional';
no if "$]" >= 5.033006, feature => 'bareword_filehandles';
use utf8;
use open ':std', ':encoding(UTF-8)'; # force stdin, stdout, stderr into utf8

use Test::More;
use Test::Deep;
use Test::Fatal;
use OpenAPI::Modern;
use JSON::Schema::Modern::Utilities 'jsonp';
use Test::File::ShareDir -share => { -dist => { 'OpenAPI-Modern' => 'share' } };
use constant { true => JSON::PP::true, false => JSON::PP::false };
use YAML::PP 0.005;

use lib 't/lib';
use Helper;

my $openapi_preamble = <<'YAML';
---
openapi: 3.1.0
info:
  title: Test API
  version: 1.2.3
YAML

# the absolute uri we will see in errors
my $doc_uri_rel = Mojo::URL->new('/api');
my $doc_uri = $doc_uri_rel->to_abs(Mojo::URL->new('https://example.com'));
my $yamlpp = YAML::PP->new(boolean => 'JSON::PP');

my $type_index = 0;

START:
$::TYPE = $::TYPES[$type_index];
note 'REQUEST/RESPONSE TYPE: '.$::TYPE;

subtest 'request is parsed to get path information' => sub {
  my $openapi = OpenAPI::Modern->new(
    openapi_uri => '/api',
    openapi_schema => $yamlpp->load_string(<<YAML));
$openapi_preamble
paths:
  /foo/{foo_id}:
    post:
      operationId: my-post-path
  /foo/bar:
    get:
      operationId: my-get-path
webhooks:
  my_hook:
    description: I like webhooks
    post:
      operationId: hooky
YAML

  my $request = request('GET', 'http://example.com/foo/bar');
  ok(!$openapi->find_path($request, my $options = { path_template => '/foo/baz', path_captures => {} }),
    'find_path returns false');
  cmp_deeply(
    $options,
    {
      path_template => '/foo/baz',
      path_captures => {},
      method => 'get',
      errors => [
        methods(TO_JSON => {
          instanceLocation => '/request/uri/path',
          keywordLocation => '/paths',
          absoluteKeywordLocation => $doc_uri->clone->fragment('/paths')->to_string,
          error => 'missing path-item "/foo/baz"',
        }),
      ],
    },
    'unsuccessful path extraction results in the error being returned in the options hash',
  );


  ok(!$openapi->find_path($request, $options = { operation_id => 'bloop', path_captures => {} }),
    'find_path returns false');
  cmp_deeply(
    $options,
    {
      method => 'get',
      path_captures => {},
      operation_id => 'bloop',
      errors => [
        methods(TO_JSON => {
          instanceLocation => '/request/uri/path',
          keywordLocation => jsonp('/paths'),
          absoluteKeywordLocation => $doc_uri->clone->fragment(jsonp('/paths'))->to_string,
          error => 'unknown operation_id "bloop"',
        }),
      ],
    },
    'path template does not exist under /paths',
  );


  ok(!$openapi->find_path($request, $options = { operation_id => 'hooky', path_captures => {} }),
    'find_path returns false');
  cmp_deeply(
    $options,
    {
      method => 'get',
      path_captures => {},
      operation_id => 'hooky',
      errors => [
        methods(TO_JSON => {
          instanceLocation => '/request/uri/path',
          keywordLocation => '/webhooks/my_hook/post/operationId',
          absoluteKeywordLocation => $doc_uri->clone->fragment(jsonp('/webhooks/my_hook/post/operationId'))->to_string,
          error => 'operation id does not have an associated path',
        }),
      ],
    },
    'path template does not exist under /paths',
  );


  ok(!$openapi->find_path(request('GET', 'http://example.com/foo/bloop'), $options = {}),
    'find_path returns false');
  cmp_deeply(
    $options,
    {
      method => 'get',
      path_template => '/foo/{foo_id}',
      path_captures => { foo_id => 'bloop' },
      errors => [
        methods(TO_JSON => {
          instanceLocation => '/request/method',
          keywordLocation => jsonp(qw(/paths /foo/{foo_id} get)),
          absoluteKeywordLocation => $doc_uri->clone->fragment(jsonp(qw(/paths /foo/{foo_id} get)))->to_string,
          error => 'missing operation for HTTP method "get"',
        }),
      ],
    },
    'operation does not exist under /paths/<path_template>/<method>',
  );


  ok(!$openapi->find_path(request('POST', 'http://example.com/foo/bar'),
      $options = { path_template => '/foo/{foo_id}', operation_id => 'my-get-path', path_captures => {} }),
    'find_path returns false');
  cmp_deeply(
    $options,
    {
      method => 'post',
      path_template => '/foo/{foo_id}',
      path_captures => {},
      operation_id => 'my-get-path',
      errors => [
        methods(TO_JSON => {
          instanceLocation => '/request/uri/path',
          keywordLocation => '/paths/~1foo~1bar',
          absoluteKeywordLocation => $doc_uri->clone->fragment(jsonp('/paths', qw(/foo/bar)))->to_string,
          error => 'operation does not match provided path_template',
        }),
      ],
    },
    'path_template and operation_id are inconsistent',
  );


  ok(!$openapi->find_path(request('POST', 'http://example.com/foo/bar'),
      $options = { operation_id => 'my-get-path', path_captures => {} }),
    'find_path returns false');
  cmp_deeply(
    $options,
    {
      method => 'post',
      path_captures => {},
      operation_id => 'my-get-path',
      errors => [
        methods(TO_JSON => {
          instanceLocation => '/request/method',
          keywordLocation => '/paths/~1foo~1bar/get',
          absoluteKeywordLocation => $doc_uri->clone->fragment(jsonp('/paths', qw(/foo/bar get)))->to_string,
          error => 'wrong HTTP method post',
        }),
      ],
    },
    'request HTTP method does not match operation',
  );


  ok(!$openapi->find_path(request('POST', 'http://example.com/foo/bar'), $options = { method => 'GET'}),
    'find_path returns false');
  cmp_deeply(
    $options,
    {
      method => 'GET',
      errors => [
        methods(TO_JSON => {
          instanceLocation => '/request/method',
          keywordLocation => '',
          absoluteKeywordLocation => $doc_uri->clone->to_string,
          error => 'wrong HTTP method POST',
        }),
      ],
    },
    'request HTTP method does not match method option',
  );


  ok(!$openapi->find_path(request('POST', 'http://example.com/foo/bar'),
        $options = { path_template => '/foo/{foo_id}', path_captures => { bloop => 'bar' } }),
    'find_path returns false');
  cmp_deeply(
    $options,
    {
      method => 'post',
      path_template => '/foo/{foo_id}',
      path_captures => { bloop => 'bar' },
      errors => [
        methods(TO_JSON => {
          instanceLocation => '/request/uri/path',
          keywordLocation => '/paths/~1foo~1{foo_id}',
          absoluteKeywordLocation => $doc_uri->clone->fragment(jsonp(qw(/paths /foo/{foo_id})))->to_string,
          error => 'provided path_captures names do not match path template "/foo/{foo_id}"',
        }),
      ],
    },
    'path template does not match path captures',
  );


  ok($openapi->find_path(request('GET', 'http://example.com/foo/bar'),
      $options = { path_template => '/foo/bar', operation_id => 'my-get-path', path_captures => {} }),
    'find_path returns successfully');
  cmp_deeply(
    $options,
    {
      method => 'get',
      path_template => '/foo/bar',
      path_captures => {},
      operation_id => 'my-get-path',
      errors => [],
    },
    'path_template and operation_id can both be passed, if consistent',
  );


  ok(!$openapi->find_path(request('GET', 'http://example.com/something/else'),
      $options = { path_template => '/foo/bar', path_captures => {} }),
    'find_path returns false');
  cmp_deeply(
    $options,
    {
      method => 'get',
      path_template => '/foo/bar',
      path_captures => {},
      errors => [
        methods(TO_JSON => {
          instanceLocation => '/request/uri/path',
          keywordLocation => jsonp(qw(/paths /foo/bar)),
          absoluteKeywordLocation => $doc_uri->clone->fragment(jsonp(qw(/paths /foo/bar)))->to_string,
          error => 'provided path_template does not match request URI',
        }),
      ],
    },
    'path_template is not consistent with request URI, with no captures',
  );


  ok(!$openapi->find_path(request('POST', 'http://example.com/something/else'),
      $options = { path_template => '/foo/{foo_id}', path_captures => { foo_id => 123 } }),
    'find_path returns false');
  cmp_deeply(
    $options,
    {
      method => 'post',
      path_template => '/foo/{foo_id}',
      path_captures => { foo_id => 123 },
      errors => [
        methods(TO_JSON => {
          instanceLocation => '/request/uri/path',
          keywordLocation => jsonp(qw(/paths /foo/{foo_id})),
          absoluteKeywordLocation => $doc_uri->clone->fragment(jsonp(qw(/paths /foo/{foo_id})))->to_string,
          error => 'provided path_template does not match request URI',
        }),
      ],
    },
    'path_template is not consistent with request URI, with captures',
  );


  ok(!$openapi->find_path(request('POST', 'http://example.com/something/else'),
      $options = { path_template => '/foo/{foo_id}' }),
    'find_path returns false');
  cmp_deeply(
    $options,
    {
      method => 'post',
      path_template => '/foo/{foo_id}',
      errors => [
        methods(TO_JSON => {
          instanceLocation => '/request/uri/path',
          keywordLocation => jsonp(qw(/paths /foo/{foo_id})),
          absoluteKeywordLocation => $doc_uri->clone->fragment(jsonp(qw(/paths /foo/{foo_id})))->to_string,
          error => 'provided path_template does not match request URI',
        }),
      ],
    },
    'path_template is not consistent with request URI, captures not provided',
  );


  ok(!$openapi->find_path(request('GET', 'http://example.com/something/else'),
      $options = { operation_id => 'my-get-path', path_captures => {} }),
    'find_path returns false');
  cmp_deeply(
    $options,
    {
      method => 'get',
      path_captures => {},
      operation_id => 'my-get-path',
      errors => [
        methods(TO_JSON => {
          instanceLocation => '/request/uri/path',
          keywordLocation => jsonp(qw(/paths /foo/bar)),
          absoluteKeywordLocation => $doc_uri->clone->fragment(jsonp(qw(/paths /foo/bar)))->to_string,
          error => 'provided operation_id does not match request URI',
        }),
      ],
    },
    'operation_id is not consistent with request URI',
  );


  ok(!$openapi->find_path(request('POST', 'http://example.com/foo/hello'),
      $options = { operation_id => 'my-post-path', path_captures => { foo_id => 'goodbye' } }),
    'find_path returns false');
  cmp_deeply(
    $options,
    {
      method => 'post',
      path_captures => { foo_id => 'goodbye' },
      operation_id => 'my-post-path',
      errors => [
        methods(TO_JSON => {
          instanceLocation => '/request/uri/path',
          keywordLocation => jsonp(qw(/paths /foo/{foo_id})),
          absoluteKeywordLocation => $doc_uri->clone->fragment(jsonp(qw(/paths /foo/{foo_id})))->to_string,
          error => 'provided path_captures values do not match request URI',
        }),
      ],
    },
    'path_captures values are not consistent with request URI',
  );


  $openapi = OpenAPI::Modern->new(
    openapi_uri => '/api',
    openapi_schema => $yamlpp->load_string(<<YAML));
$openapi_preamble
paths:
  /foo: {}
YAML

  ok(!$openapi->find_path(request('POST', 'http://example.com/foo/bar'),
      $options = { path_template => '/foo', path_captures => {} }),
    'find_path returns false');
  cmp_deeply(
    $options,
    {
      method => 'post',
      path_template => '/foo',
      path_captures => {},
      errors => [
        methods(TO_JSON => {
          instanceLocation => '/request/method',
          keywordLocation => jsonp(qw(/paths /foo post)),
          absoluteKeywordLocation => $doc_uri->clone->fragment(jsonp(qw(/paths /foo post)))->to_string,
          error => 'missing operation for HTTP method "post"',
        }),
      ],
    },
    'operation does not exist under /paths/<path-template>',
  );


  $openapi = OpenAPI::Modern->new(
    openapi_uri => '/api',
    openapi_schema => $yamlpp->load_string(<<YAML));
$openapi_preamble
paths:
  /foo/{foo_id}:
    get:
      operationId: my-get-path
YAML

  ok($openapi->find_path(request('GET', 'http://example.com/foo/123'),
      $options = { path_template => '/foo/{foo_id}' }),
    'find_path returns successfully',
  );
  cmp_deeply(
    $options,
    {
      operation_id => 'my-get-path',
      path_template => '/foo/{foo_id}',
      path_captures => { foo_id => '123' },
      method => 'get',
      errors => [],
    },
    'path capture values and method are extracted from the path template and request uri',
  );


  ok($openapi->find_path(request('GET', 'http://example.com/foo/123'),
      $options = { operation_id => 'my-get-path' }),
    'find_path returns successfully',
  );
  cmp_deeply(
    $options,
    {
      operation_id => 'my-get-path',
      path_template => '/foo/{foo_id}',
      path_captures => { foo_id => '123' },
      method => 'get',
      errors => [],
    },
    'path capture values are extracted from the operation id and request uri',
  );


  ok($openapi->find_path(request('GET', 'http://example.com/foo/123'), $options = {}),
    'find_path returns successfully');
  cmp_deeply(
    $options,
    {
      path_template => '/foo/{foo_id}',
      path_captures => { foo_id => '123' },
      method => 'get',
      operation_id => 'my-get-path',
      errors => [],
    },
    'path_item and path_capture variables are returned in the provided options hash',
  );


  ok(!$openapi->find_path(request('GET', 'http://example.com/foo/123'),
      $options = { path_captures => { foo_id => 'a' } }),
    'find_path returns false');
  cmp_deeply(
    $options,
    {
      method => 'get',
      path_template => '/foo/{foo_id}',
      path_captures => { foo_id => 'a' },
      errors => [
        methods(TO_JSON => {
          instanceLocation => '/request/uri/path',
          keywordLocation => jsonp('/paths'),
          absoluteKeywordLocation => $doc_uri->clone->fragment(jsonp('/paths'))->to_string,
          error => 'provided path_captures values do not match request URI',
        }),
      ],
    },
    'request URI is inconsistent with provided path captures',
  );


  ok(!$openapi->find_path(request('GET', 'http://example.com/bloop/blah'), $options = {}),
    'find_path returns false');
  cmp_deeply(
    $options,
    {
      method => 'get',
      errors => [
        methods(TO_JSON => {
          instanceLocation => '/request/uri/path',
          keywordLocation => jsonp('/paths'),
          absoluteKeywordLocation => $doc_uri->clone->fragment(jsonp('/paths'))->to_string,
          error => 'no match found for URI path "/bloop/blah"',
        }),
      ],
    },
    'failure to extract path template and capture values from the request uri',
  );


  my $uri = uri('http://example.com', '', 'foo', 'hello // there ಠ_ಠ!');
  ok($openapi->find_path(request('GET', $uri),
      $options = { path_template => '/foo/{foo_id}', path_captures => { foo_id => 'hello // there ಠ_ಠ!' } }),
    'find_path returns successfully');
  cmp_deeply(
    $options,
    {
      method => 'get',
      path_template => '/foo/{foo_id}',
      path_captures => { foo_id => 'hello // there ಠ_ಠ!' },
      operation_id => 'my-get-path',
      errors => [],
    },
    'path capture variables are found to be consistent with the URI when some values are url-escaped',
  );


  ok($openapi->find_path(request('GET', $uri), $options = {}), 'find_path returns successfully');
  cmp_deeply(
    $options,
    {
      operation_id => 'my-get-path',
      path_captures => { foo_id => 'hello // there ಠ_ಠ!' },
      path_template => '/foo/{foo_id}',
      method => 'get',
      errors => [],
    },
    'path captures can be properly extracted from the URI when some values are url-escaped',
  );


  $openapi = OpenAPI::Modern->new(
    openapi_uri => '/api',
    openapi_schema => $yamlpp->load_string(<<YAML));
$openapi_preamble
paths:
  /foo/{foo_id}:
    get: {}
YAML

  $request = request('GET', 'http://example.com/foo/bar');
  ok($openapi->find_path($request, $options = {}),
    'find_path returns successfully');
  cmp_deeply(
    $options,
    {
      path_template => '/foo/{foo_id}',
      path_captures => { foo_id => 'bar' },
      method => 'get',
      errors => [],
    },
    'no path_template provided; no operation_id is recorded, because one does not exist in the schema document',
  );


  ok($openapi->find_path($request, $options = { path_template => '/foo/{foo_id}' }),
    'find_path returns successfully');
  cmp_deeply(
    $options,
    {
      path_template => '/foo/{foo_id}',
      path_captures => { foo_id => 'bar' },
      method => 'get',
      errors => [],
    },
    'path_template provided; no operation_id is recorded, because one does not exist in the schema document',
  );
};

subtest 'no request is provided: options are relied on as the sole source of truth' => sub {
  my $openapi = OpenAPI::Modern->new(
    openapi_uri => '/api',
    openapi_schema => $yamlpp->load_string(<<YAML));
$openapi_preamble
paths:
  /foo/{foo_id}:
    get:
      operationId: my-get-path
YAML

  like(
    exception { ()= $openapi->find_path(undef, my $options = { path_captures => {} }) },
    qr/^at least one of request, \$options->\{method\} and \$options->\{operation_id\} must be provided/,
    'method can only be derived from request or operation_id',
  );

  ok(!$openapi->find_path(undef, my $options = { operation_id => 'my-get-path', method => 'POST', path_captures => {} }),
    'find_path returns false');

  cmp_deeply(
    $options,
    {
      operation_id => 'my-get-path',
      method => 'POST',
      path_captures => {},
      errors => [
        methods(TO_JSON => {
          instanceLocation => '/request/method',
          keywordLocation => jsonp(qw(/paths /foo/{foo_id} get)),
          absoluteKeywordLocation => $doc_uri_rel->clone->fragment(jsonp('/paths', qw(/foo/{foo_id} get)))->to_string,
          error => 'wrong HTTP method POST',
        }),
      ],
    },
    'no request provided; operation method does not match passed-in method',
  );

  like(
    exception { ()= $openapi->find_path(undef, $options = { method => 'get', path_captures => {} }) },
    qr/^at least one of request, \$options->\{path_template\} and \$options->\{operation_id\} must be provided/,
    'path_template can only be derived from request or operation_id',
  );

  ok(!$openapi->find_path(undef, $options = { path_template => '/foo/{foo_id}', path_captures => {}, method => 'get' }), 'find_path failed');
  cmp_deeply(
    $options,
    {
      path_template => '/foo/{foo_id}',
      path_captures => {},
      method => 'get',
      errors => [
        methods(TO_JSON => {
          instanceLocation => '/request/uri/path',
          keywordLocation => '/paths/~1foo~1{foo_id}',
          absoluteKeywordLocation => $doc_uri_rel->clone->fragment(jsonp(qw(/paths /foo/{foo_id})))->to_string,
          error => 'provided path_captures names do not match path template "/foo/{foo_id}"',
        }),
      ],
    },
    'no request provided; path template does not match path captures',
  );

  ok($openapi->find_path(undef, $options = { operation_id => 'my-get-path', path_captures => { foo_id => 'a' } }), 'find_path succeeded');
  cmp_deeply(
    $options,
    {
      operation_id => 'my-get-path',
      path_captures => { foo_id => 'a' },
      path_template => '/foo/{foo_id}',
      method => 'get',
      errors => [],
    },
    'no request provided; path_template and method are extracted from operation_id and path_captures',
  );

  ok($openapi->find_path(undef, $options = { method => 'get', path_template => '/foo/{foo_id}', path_captures => { foo_id => 'a' } }), 'find_path succeeded');
  cmp_deeply(
    $options,
    {
      operation_id => 'my-get-path',
      path_captures => { foo_id => 'a' },
      path_template => '/foo/{foo_id}',
      method => 'get',
      errors => [],
    },
    'no request provided; operation_id are extracted from method and path_template',
  );


  $openapi = OpenAPI::Modern->new(
    openapi_uri => '/api',
    openapi_schema => $yamlpp->load_string(<<YAML));
$openapi_preamble
paths:
  /foo/{foo_id}:
    get: {}
YAML

  ok($openapi->find_path(undef,
      $options = { method => 'get', path_template => '/foo/{foo_id}', path_captures => { foo_id => 'bar' } }),
    'find_path succeeded');
  cmp_deeply(
    $options,
    {
      path_template => '/foo/{foo_id}',
      path_captures => { foo_id => 'bar' },
      method => 'get',
      errors => [],
    },
    'no operation_id is recorded, because one does not exist in the schema document',
  );
};

goto START if ++$type_index < @::TYPES;

done_testing;
