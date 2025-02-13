#!/usr/bin/perl

no utf8;

# Net::Radius test input
# Made with $Id: cisco-acs-ar-02.p 64 2007-01-09 20:01:04Z lem $

$VAR1 = {
          'packet' => '� X%*W�W�C{鼊�ϭ�
abaloa01�mo  #  CiscoSecure ACS v4.0(1.27)|�ϐ{�gZB39�+z',
          'secret' => undef,
          'description' => 'CiscoSecure ACS v4.0 (1.27) - Access-Request',
          'authenticator' => '%*W�W�C{鼊�ϭ�',
          'identifier' => 217,
          'dictionary' => undef,
          'opts' => {
                      'secret' => undef,
                      'output' => 'packets/cisco-acs-ar-02',
                      'description' => 'CiscoSecure ACS v4.0 (1.27) - Access-Request',
                      'authenticator' => '%*W�W�C{鼊�ϭ�',
                      'identifier' => 217,
                      'dictionary' => [
                                        'dicts/dictionary'
                                      ],
                      'dont-embed-dict' => 1,
                      'noprompt' => 1,
                      'slots' => 5
                    },
          'slots' => 5
        };
