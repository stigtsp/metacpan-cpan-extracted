# Devel-IPerl

[![Coverage Status](https://coveralls.io/repos/EntropyOrg/p5-Devel-IPerl/badge.png?branch=master)](https://coveralls.io/r/EntropyOrg/p5-Devel-IPerl?branch=master)
[![CPAN version](https://badge.fury.io/pl/Devel-IPerl.svg)](https://metacpan.org/pod/Devel::IPerl)

## Installation

### Dependencies

Devel::IPerl depends upon the ZeroMQ library (ZMQ) and Project Jupyter in order to work.

#### ZeroMQ

##### Debian

On Debian-based systems, you can install ZeroMQ using `apt`.

    sudo apt install libzmq3-dev 

##### macOS

If you use Homebrew on macOS, you can install ZeroMQ by using

    brew install zmq

You may also need to install `cpanm` this way by using

    brew install cpanm

Then you will need to install `ZMQ::LibZMQ3` by running:

    export ARCHFLAGS='-arch x86_64';
    cpanm --build-args 'OTHERLDFLAGS=' ZMQ::LibZMQ3;

##### Installing ZeroMQ without a package manager

Some systems may not have a package manager (e.g,. Windows) or you may want to
avoid using the package manager.

Make sure you have Perl, a C/C++ compiler, `lwp-request` (or another HTTP
downloading tool that outputs the contents of an HTTP request to STDOUT such as
`wget -O -` or `curl`), and `cpanm` on your system.

Then run this following command (read the [source first](https://raw.githubusercontent.com/zmughal-CPAN/p5-Alt-Alien-ZMQ-Alien-ZMQ-latest/master/maint/install-zmq-libzmq.pl)!):

    # use `cpanm LWP` to install `lwp-request`
    lwp-request https://raw.githubusercontent.com/zmughal-CPAN/p5-Alt-Alien-ZMQ-Alien-ZMQ-latest/master/maint/install-zmq-libzmq.pl | perl - --notest Alt::Alien::ZMQ::Alien::ZMQ::latest ZMQ::LibZMQ3 Net::Async::ZMQ

What this does is install CPAN modules for

 - [building ZMQ](https://p3rl.org/Alien::ZMQ::latest),
 - [binding ZMQ](https://p3rl.org/ZMQ::LibZMQ3),
 - and [handling asynchronous ZMQ events](https://p3rl.org/Net::Async::ZMQ).

Installing these modules can be tricky, so this script handles it for you.

It has been tested on GNU/Linux, macOS, and Windows (Strawberry Perl 5.26.1.1).

Note: There are currently issues with installing on Windows using ActivePerl
and older versions of Strawberry Perl. These are mostly due to having an older
toolchain which causes builds of the native libraries to fail.

#### Jupyter

See the [Jupyter install](http://jupyter.org/install.html) page to see how to
install Jupyter.

On Debian, you can install using `apt`:

    sudo apt install jupyter-console jupyter-notebook

If you know how to use `pip`, this may be as easy as

    pip install -U jupyter
    # or use pip3 (for Python 3) instead of pip

Make sure Jupyter is in the path by running

    jupyter --version

### Install from CPAN

    cpanm Devel::IPerl

If you have a [problem with failing tests for Markdown::Pod](https://github.com/keedi/Markdown-Pod/issues/8),
you can install an older version using

    cpanm Markdent@0.26 Markdown::Pod@0.006

## Running

    iperl console  # start the console

    iperl notebook # start the notebook

See the [wiki](https://github.com/EntropyOrg/p5-Devel-IPerl/wiki) for more
information and example notebooks!
