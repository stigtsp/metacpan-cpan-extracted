#!perl

BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    print qq{1..0 # SKIP these tests are for testing by the author\n};
    exit
  }
}


use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::Perl::Critic::Subset 3.001.006

use Test::Perl::Critic (-profile => "") x!! -e "";

my $filenames = ['lib/App/lcpan.pm','lib/App/lcpan/Cmd/author.pm','lib/App/lcpan/Cmd/author_deps.pm','lib/App/lcpan/Cmd/author_deps_by_dependent_count.pm','lib/App/lcpan/Cmd/author_dists.pm','lib/App/lcpan/Cmd/author_mods.pm','lib/App/lcpan/Cmd/author_rdeps.pm','lib/App/lcpan/Cmd/author_rels.pm','lib/App/lcpan/Cmd/author_scripts.pm','lib/App/lcpan/Cmd/authors.pm','lib/App/lcpan/Cmd/authors_by_dist_count.pm','lib/App/lcpan/Cmd/authors_by_filesize.pm','lib/App/lcpan/Cmd/authors_by_mod_count.pm','lib/App/lcpan/Cmd/authors_by_mod_mention_count.pm','lib/App/lcpan/Cmd/authors_by_rdep_count.pm','lib/App/lcpan/Cmd/authors_by_rel_count.pm','lib/App/lcpan/Cmd/authors_by_script_count.pm','lib/App/lcpan/Cmd/changes.pm','lib/App/lcpan/Cmd/contents.pm','lib/App/lcpan/Cmd/copy_mod.pm','lib/App/lcpan/Cmd/copy_rel.pm','lib/App/lcpan/Cmd/copy_script.pm','lib/App/lcpan/Cmd/db_path.pm','lib/App/lcpan/Cmd/delete_rel.pm','lib/App/lcpan/Cmd/deps.pm','lib/App/lcpan/Cmd/deps_by_dependent_count.pm','lib/App/lcpan/Cmd/dist.pm','lib/App/lcpan/Cmd/dist2author.pm','lib/App/lcpan/Cmd/dist2rel.pm','lib/App/lcpan/Cmd/dist_contents.pm','lib/App/lcpan/Cmd/dist_meta.pm','lib/App/lcpan/Cmd/dist_mods.pm','lib/App/lcpan/Cmd/dist_rdeps.pm','lib/App/lcpan/Cmd/dist_scripts.pm','lib/App/lcpan/Cmd/dists.pm','lib/App/lcpan/Cmd/dists_by_dep_count.pm','lib/App/lcpan/Cmd/dists_by_mod_count.pm','lib/App/lcpan/Cmd/dists_by_script_count.pm','lib/App/lcpan/Cmd/doc.pm','lib/App/lcpan/Cmd/extract_dist.pm','lib/App/lcpan/Cmd/extract_mod.pm','lib/App/lcpan/Cmd/extract_rel.pm','lib/App/lcpan/Cmd/extract_script.pm','lib/App/lcpan/Cmd/heaviest_dists.pm','lib/App/lcpan/Cmd/inject.pm','lib/App/lcpan/Cmd/log.pm','lib/App/lcpan/Cmd/mentions.pm','lib/App/lcpan/Cmd/mentions_by_mod.pm','lib/App/lcpan/Cmd/mentions_by_script.pm','lib/App/lcpan/Cmd/mentions_for_all_mods.pm','lib/App/lcpan/Cmd/mentions_for_mod.pm','lib/App/lcpan/Cmd/mentions_for_script.pm','lib/App/lcpan/Cmd/mod.pm','lib/App/lcpan/Cmd/mod2author.pm','lib/App/lcpan/Cmd/mod2dist.pm','lib/App/lcpan/Cmd/mod2rel.pm','lib/App/lcpan/Cmd/mod_contents.pm','lib/App/lcpan/Cmd/mods.pm','lib/App/lcpan/Cmd/mods_by_mention_count.pm','lib/App/lcpan/Cmd/mods_by_rdep_author_count.pm','lib/App/lcpan/Cmd/mods_by_rdep_count.pm','lib/App/lcpan/Cmd/mods_from_same_dist.pm','lib/App/lcpan/Cmd/module.pm','lib/App/lcpan/Cmd/modules.pm','lib/App/lcpan/Cmd/most_depended_mods.pm','lib/App/lcpan/Cmd/most_mentioned_mods.pm','lib/App/lcpan/Cmd/most_mentioned_scripts.pm','lib/App/lcpan/Cmd/namespaces.pm','lib/App/lcpan/Cmd/rdeps.pm','lib/App/lcpan/Cmd/rdeps_scripts.pm','lib/App/lcpan/Cmd/rel.pm','lib/App/lcpan/Cmd/related_mods.pm','lib/App/lcpan/Cmd/release.pm','lib/App/lcpan/Cmd/releases.pm','lib/App/lcpan/Cmd/rels.pm','lib/App/lcpan/Cmd/reset.pm','lib/App/lcpan/Cmd/script.pm','lib/App/lcpan/Cmd/script2author.pm','lib/App/lcpan/Cmd/script2dist.pm','lib/App/lcpan/Cmd/script2mod.pm','lib/App/lcpan/Cmd/script2rel.pm','lib/App/lcpan/Cmd/scripts.pm','lib/App/lcpan/Cmd/scripts_by_mention_count.pm','lib/App/lcpan/Cmd/scripts_from_same_dist.pm','lib/App/lcpan/Cmd/src.pm','lib/App/lcpan/Cmd/stats.pm','lib/App/lcpan/Cmd/stats_last_index_time.pm','lib/App/lcpan/Cmd/subnames_by_count.pm','lib/App/lcpan/Cmd/subs.pm','lib/App/lcpan/Cmd/update.pm','lib/App/lcpan/Cmd/whatsnew.pm','lib/App/lcpan/Cmd/x_mentions_for_mod.pm','lib/App/lcpan/PodParser.pm','lib/End/PrintBytesIn.pm','lib/LWP/UserAgent/Plugin/FilterLcpan.pm','script/lcpan','script/lcpanm','script/lcpanm-namespace','script/lcpanm-script'];
unless ($filenames && @$filenames) {
    $filenames = -d "blib" ? ["blib"] : ["lib"];
}

all_critic_ok(@$filenames);
