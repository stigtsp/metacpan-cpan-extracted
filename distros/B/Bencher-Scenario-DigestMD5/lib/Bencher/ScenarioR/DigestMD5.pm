package Bencher::ScenarioR::DigestMD5;

our $VERSION = 0.004; # VERSION

our $results = [
  [
    200,
    "OK",
    [
      {
        errors => 3.6e-05,
        participant => "Digest::MD5",
        rate => 15,
        samples => 6,
        time => 66.8,
        vs_slowest => 1,
      },
      {
        errors => 2.6e-05,
        participant => "md5sum",
        rate => 15,
        samples => 6,
        time => 66.7,
        vs_slowest => 1,
      },
    ],
    {
      "func.bencher_args"              => {
                                            action => "bench",
                                            note => "Run by Pod::Weaver::Plugin::Bencher::Scenario",
                                            scenario_module => "DigestMD5",
                                          },
      "func.bencher_version"           => undef,
      "func.cpu_info"                  => [
                                            {
                                              address_width                => 64,
                                              architecture                 => "AMD-64",
                                              bus_speed                    => undef,
                                              data_width                   => 64,
                                              family                       => 6,
                                              flags                        => [
                                                                                "fpu",
                                                                                "vme",
                                                                                "de",
                                                                                "pse",
                                                                                "tsc",
                                                                                "msr",
                                                                                "pae",
                                                                                "mce",
                                                                                "cx8",
                                                                                "apic",
                                                                                "sep",
                                                                                "mtrr",
                                                                                "pge",
                                                                                "mca",
                                                                                "cmov",
                                                                                "pat",
                                                                                "pse36",
                                                                                "clflush",
                                                                                "dts",
                                                                                "acpi",
                                                                                "mmx",
                                                                                "fxsr",
                                                                                "sse",
                                                                                "sse2",
                                                                                "ss",
                                                                                "ht",
                                                                                "tm",
                                                                                "pbe",
                                                                                "syscall",
                                                                                "nx",
                                                                                "rdtscp",
                                                                                "lm",
                                                                                "constant_tsc",
                                                                                "arch_perfmon",
                                                                                "pebs",
                                                                                "bts",
                                                                                "rep_good",
                                                                                "nopl",
                                                                                "xtopology",
                                                                                "nonstop_tsc",
                                                                                "aperfmperf",
                                                                                "eagerfpu",
                                                                                "pni",
                                                                                "pclmulqdq",
                                                                                "dtes64",
                                                                                "monitor",
                                                                                "ds_cpl",
                                                                                "vmx",
                                                                                "smx",
                                                                                "est",
                                                                                "tm2",
                                                                                "ssse3",
                                                                                "cx16",
                                                                                "xtpr",
                                                                                "pdcm",
                                                                                "pcid",
                                                                                "sse4_1",
                                                                                "sse4_2",
                                                                                "x2apic",
                                                                                "popcnt",
                                                                                "tsc_deadline_timer",
                                                                                "aes",
                                                                                "xsave",
                                                                                "avx",
                                                                                "lahf_lm",
                                                                                "ida",
                                                                                "arat",
                                                                                "epb",
                                                                                "xsaveopt",
                                                                                "pln",
                                                                                "pts",
                                                                                "dtherm",
                                                                                "tpr_shadow",
                                                                                "vnmi",
                                                                                "flexpriority",
                                                                                "ept",
                                                                                "vpid",
                                                                              ],
                                              L2_cache                     => { max_cache_size => "6144 KB" },
                                              manufacturer                 => "GenuineIntel",
                                              model                        => 42,
                                              name                         => "Intel(R) Core(TM) i5-2400 CPU \@ 3.10GHz",
                                              number_of_cores              => 4,
                                              number_of_logical_processors => 4,
                                              processor_id                 => 0,
                                              speed                        => 3251.488,
                                              stepping                     => 7,
                                            },
                                            {
                                              address_width                => 64,
                                              architecture                 => "AMD-64",
                                              bus_speed                    => undef,
                                              data_width                   => 64,
                                              family                       => 6,
                                              flags                        => [
                                                                                "fpu",
                                                                                "vme",
                                                                                "de",
                                                                                "pse",
                                                                                "tsc",
                                                                                "msr",
                                                                                "pae",
                                                                                "mce",
                                                                                "cx8",
                                                                                "apic",
                                                                                "sep",
                                                                                "mtrr",
                                                                                "pge",
                                                                                "mca",
                                                                                "cmov",
                                                                                "pat",
                                                                                "pse36",
                                                                                "clflush",
                                                                                "dts",
                                                                                "acpi",
                                                                                "mmx",
                                                                                "fxsr",
                                                                                "sse",
                                                                                "sse2",
                                                                                "ss",
                                                                                "ht",
                                                                                "tm",
                                                                                "pbe",
                                                                                "syscall",
                                                                                "nx",
                                                                                "rdtscp",
                                                                                "lm",
                                                                                "constant_tsc",
                                                                                "arch_perfmon",
                                                                                "pebs",
                                                                                "bts",
                                                                                "rep_good",
                                                                                "nopl",
                                                                                "xtopology",
                                                                                "nonstop_tsc",
                                                                                "aperfmperf",
                                                                                "eagerfpu",
                                                                                "pni",
                                                                                "pclmulqdq",
                                                                                "dtes64",
                                                                                "monitor",
                                                                                "ds_cpl",
                                                                                "vmx",
                                                                                "smx",
                                                                                "est",
                                                                                "tm2",
                                                                                "ssse3",
                                                                                "cx16",
                                                                                "xtpr",
                                                                                "pdcm",
                                                                                "pcid",
                                                                                "sse4_1",
                                                                                "sse4_2",
                                                                                "x2apic",
                                                                                "popcnt",
                                                                                "tsc_deadline_timer",
                                                                                "aes",
                                                                                "xsave",
                                                                                "avx",
                                                                                "lahf_lm",
                                                                                "ida",
                                                                                "arat",
                                                                                "epb",
                                                                                "xsaveopt",
                                                                                "pln",
                                                                                "pts",
                                                                                "dtherm",
                                                                                "tpr_shadow",
                                                                                "vnmi",
                                                                                "flexpriority",
                                                                                "ept",
                                                                                "vpid",
                                                                              ],
                                              L2_cache                     => { max_cache_size => "6144 KB" },
                                              manufacturer                 => "GenuineIntel",
                                              model                        => 42,
                                              name                         => "Intel(R) Core(TM) i5-2400 CPU \@ 3.10GHz",
                                              number_of_cores              => 4,
                                              number_of_logical_processors => 4,
                                              processor_id                 => 1,
                                              speed                        => 3247.492,
                                              stepping                     => 7,
                                            },
                                            {
                                              address_width                => 64,
                                              architecture                 => "AMD-64",
                                              bus_speed                    => undef,
                                              data_width                   => 64,
                                              family                       => 6,
                                              flags                        => [
                                                                                "fpu",
                                                                                "vme",
                                                                                "de",
                                                                                "pse",
                                                                                "tsc",
                                                                                "msr",
                                                                                "pae",
                                                                                "mce",
                                                                                "cx8",
                                                                                "apic",
                                                                                "sep",
                                                                                "mtrr",
                                                                                "pge",
                                                                                "mca",
                                                                                "cmov",
                                                                                "pat",
                                                                                "pse36",
                                                                                "clflush",
                                                                                "dts",
                                                                                "acpi",
                                                                                "mmx",
                                                                                "fxsr",
                                                                                "sse",
                                                                                "sse2",
                                                                                "ss",
                                                                                "ht",
                                                                                "tm",
                                                                                "pbe",
                                                                                "syscall",
                                                                                "nx",
                                                                                "rdtscp",
                                                                                "lm",
                                                                                "constant_tsc",
                                                                                "arch_perfmon",
                                                                                "pebs",
                                                                                "bts",
                                                                                "rep_good",
                                                                                "nopl",
                                                                                "xtopology",
                                                                                "nonstop_tsc",
                                                                                "aperfmperf",
                                                                                "eagerfpu",
                                                                                "pni",
                                                                                "pclmulqdq",
                                                                                "dtes64",
                                                                                "monitor",
                                                                                "ds_cpl",
                                                                                "vmx",
                                                                                "smx",
                                                                                "est",
                                                                                "tm2",
                                                                                "ssse3",
                                                                                "cx16",
                                                                                "xtpr",
                                                                                "pdcm",
                                                                                "pcid",
                                                                                "sse4_1",
                                                                                "sse4_2",
                                                                                "x2apic",
                                                                                "popcnt",
                                                                                "tsc_deadline_timer",
                                                                                "aes",
                                                                                "xsave",
                                                                                "avx",
                                                                                "lahf_lm",
                                                                                "ida",
                                                                                "arat",
                                                                                "epb",
                                                                                "xsaveopt",
                                                                                "pln",
                                                                                "pts",
                                                                                "dtherm",
                                                                                "tpr_shadow",
                                                                                "vnmi",
                                                                                "flexpriority",
                                                                                "ept",
                                                                                "vpid",
                                                                              ],
                                              L2_cache                     => { max_cache_size => "6144 KB" },
                                              manufacturer                 => "GenuineIntel",
                                              model                        => 42,
                                              name                         => "Intel(R) Core(TM) i5-2400 CPU \@ 3.10GHz",
                                              number_of_cores              => 4,
                                              number_of_logical_processors => 4,
                                              processor_id                 => 2,
                                              speed                        => 3269.773,
                                              stepping                     => 7,
                                            },
                                            {
                                              address_width                => 64,
                                              architecture                 => "AMD-64",
                                              bus_speed                    => undef,
                                              data_width                   => 64,
                                              family                       => 6,
                                              flags                        => [
                                                                                "fpu",
                                                                                "vme",
                                                                                "de",
                                                                                "pse",
                                                                                "tsc",
                                                                                "msr",
                                                                                "pae",
                                                                                "mce",
                                                                                "cx8",
                                                                                "apic",
                                                                                "sep",
                                                                                "mtrr",
                                                                                "pge",
                                                                                "mca",
                                                                                "cmov",
                                                                                "pat",
                                                                                "pse36",
                                                                                "clflush",
                                                                                "dts",
                                                                                "acpi",
                                                                                "mmx",
                                                                                "fxsr",
                                                                                "sse",
                                                                                "sse2",
                                                                                "ss",
                                                                                "ht",
                                                                                "tm",
                                                                                "pbe",
                                                                                "syscall",
                                                                                "nx",
                                                                                "rdtscp",
                                                                                "lm",
                                                                                "constant_tsc",
                                                                                "arch_perfmon",
                                                                                "pebs",
                                                                                "bts",
                                                                                "rep_good",
                                                                                "nopl",
                                                                                "xtopology",
                                                                                "nonstop_tsc",
                                                                                "aperfmperf",
                                                                                "eagerfpu",
                                                                                "pni",
                                                                                "pclmulqdq",
                                                                                "dtes64",
                                                                                "monitor",
                                                                                "ds_cpl",
                                                                                "vmx",
                                                                                "smx",
                                                                                "est",
                                                                                "tm2",
                                                                                "ssse3",
                                                                                "cx16",
                                                                                "xtpr",
                                                                                "pdcm",
                                                                                "pcid",
                                                                                "sse4_1",
                                                                                "sse4_2",
                                                                                "x2apic",
                                                                                "popcnt",
                                                                                "tsc_deadline_timer",
                                                                                "aes",
                                                                                "xsave",
                                                                                "avx",
                                                                                "lahf_lm",
                                                                                "ida",
                                                                                "arat",
                                                                                "epb",
                                                                                "xsaveopt",
                                                                                "pln",
                                                                                "pts",
                                                                                "dtherm",
                                                                                "tpr_shadow",
                                                                                "vnmi",
                                                                                "flexpriority",
                                                                                "ept",
                                                                                "vpid",
                                                                              ],
                                              L2_cache                     => { max_cache_size => "6144 KB" },
                                              manufacturer                 => "GenuineIntel",
                                              model                        => 42,
                                              name                         => "Intel(R) Core(TM) i5-2400 CPU \@ 3.10GHz",
                                              number_of_cores              => 4,
                                              number_of_logical_processors => 4,
                                              processor_id                 => 3,
                                              speed                        => 3253.183,
                                              stepping                     => 7,
                                            },
                                          ],
      "func.elapsed_time"              => 1.02297306060791,
      "func.module_startup"            => undef,
      "func.module_versions"           => {
                                            "__PACKAGE__" => 1.039,
                                            "Bencher::Scenario::DigestMD5" => undef,
                                            "Benchmark::Dumb" => 0.111,
                                            "Devel::Platform::Info" => 0.16,
                                            "Digest::MD5" => 2.55,
                                            "perl" => "v5.26.0",
                                            "String::ShellQuote" => 1.04,
                                            "Sys::Info" => 0.78,
                                          },
      "func.note"                      => "Run by Pod::Weaver::Plugin::Bencher::Scenario",
      "func.permute"                   => ["perl", ["perl"], "participant", [0, 1], "dataset", [0]],
      "func.platform_info"             => {
                                            archname => "x86_64",
                                            codename => "jessie",
                                            is32bit  => 0,
                                            is64bit  => 1,
                                            kernel   => "linux-3.16.0-4-amd64",
                                            kname    => "Linux",
                                            kvers    => "3.16.0-4-amd64",
                                            osflag   => "linux",
                                            oslabel  => "Debian",
                                            osname   => "GNU/Linux",
                                            osvers   => "8.0",
                                            source   => {
                                                          "cat /etc/.issue" => "",
                                                          "cat /etc/issue"  => "Debian GNU/Linux 8 \\n \\l",
                                                          "lsb_release -a"  => "Distributor ID:\tDebian\nDescription:\tDebian GNU/Linux 8.0 (jessie)\nRelease:\t8.0\nCodename:\tjessie",
                                                          "uname -a"        => "Linux builder 3.16.0-4-amd64 #1 SMP Debian 3.16.36-1+deb8u2 (2016-10-19) x86_64 GNU/Linux",
                                                          "uname -m"        => "x86_64",
                                                          "uname -o"        => "GNU/Linux",
                                                          "uname -r"        => "3.16.0-4-amd64",
                                                          "uname -s"        => "Linux",
                                                        },
                                          },
      "func.precision"                 => 6,
      "func.scenario_module"           => "Bencher::Scenario::DigestMD5",
      "func.scenario_module_md5sum"    => "a5a9e1f2e15e4a1f397ae277e32b67e2",
      "func.scenario_module_mtime"     => 1499687037,
      "func.scenario_module_sha1sum"   => "317549f3877b606f22bd623a02fcf571f4744ebc",
      "func.scenario_module_sha256sum" => "123a4e25ad2d944dfd21d3b779493d3ef7b4bbb9b11a05fb7e1b1924ad42c9bf",
      "func.time_end"                  => 1499687077.97433,
      "func.time_factor"               => 1000,
      "func.time_start"                => 1499687076.95136,
      "table.field_aligns"             => ["left", "number", "number", "number", "number", "number"],
      "table.field_units"              => [undef, "/s", "ms"],
      "table.fields"                   => ["participant", "rate", "time", "vs_slowest", "errors", "samples"],
    },
  ],
];

1;
# ABSTRACT: Benchmark Digest::MD5 against md5sum utility

=head1 DESCRIPTION

This module is automatically generated by Pod::Weaver::Plugin::Bencher::Scenario during distribution build.

A Bencher::ScenarioR::* module contains the raw result of sample benchmark and might be useful for some stuffs later.

