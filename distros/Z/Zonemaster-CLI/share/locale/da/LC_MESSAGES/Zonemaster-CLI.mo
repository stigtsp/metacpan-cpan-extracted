��    9      �  O   �      �      �     
  X     &   u     �     �  
   �     �     �  �   �  �   h  Y   �  u   O     �     �     �      �  3   �  :   /  O   j  a   �  f   	  f   �	     �	  4   �	  
   $
     /
  	   L
     V
     ^
  (   l
     �
  <   �
  7   �
  '     >   9  5   x     �  ;   �  (     +   +     W  #   s     �  �   �  "  3  ?   V     �  +   �  +   �  f   �  @   e     �  a   �  [     ^   l    �     �     �  ]     5   c     �     �  
   �     �     �  �   �  �   m  n     v   v     �     �     �       7     A   V  W   �  ]   �  z   N  z   �     D  :   I  
   �     �  
   �     �     �  ,   �     �  H   �  2   H  3   {  G   �  ;   �  (   3  ?   \  !   �  (   �      �       	   #  �   -  �   �  ?   �     �  8   	  ;   B  c   ~  M   �     0  u   9  e   �  h        ,               5                 !   '      -      8      
              (   *   )                       "          2                  9                 0         #                4                            1   3       %   +   7             .      &      /      $   6      	        

   Level	Number of log entries %8s	%5d entries.
 --level must be one of CRITICAL, ERROR, WARNING, NOTICE, INFO, DEBUG, DEBUG2 or DEBUG3.
 --ns must be a name or a name/ip pair. ======= =======  =========  ============  ==============  A name/ip string giving a nameserver for undelegated tests, or just a name which will be looked up for IP addresses. Can be given multiple times. As soon as a message at this level or higher is logged, execution will stop. Must be one of CRITICAL, ERROR, WARNING, NOTICE, INFO or DEBUG. At the end of a run, print a summary of the times the zone's name servers took to answer. Boolean flag for activity indicator. Defaults to on if STDOUT is a tty, off if it is not. Disable with --no-progress. CRITICAL DEBUG ERROR Failed to recognize stop level ' Flag indicating if output should be in JSON or not. Flag indicating if output should be streaming JSON or not. Flag indicating if output should be translated to human language or dumped raw. Flag indicating if streaming JSON output should include the translated message of the tag or not. Flag to permit or deny queries being sent via IPv4. --ipv4 permits IPv4 traffic, --no-ipv4 forbids it. Flag to permit or deny queries being sent via IPv6. --ipv6 permits IPv6 traffic, --no-ipv6 forbids it. INFO Instead of running a test, list all available tests. Level      Loading profile from {path}. Looks OK. Message Module        Must give the name of a domain to test.
 NOTICE Name of a file to restore DNS data from before running test. Name of a file to save DNS data to after running tests. Name of profile file to load. (DEFAULT) Name of the character encoding used for command line arguments Print a count of the number of messages at each level Print level on entries. Print the effective profile used in JSON format, then exit. Print the name of the module on entries. Print the name of the test case on entries. Print timestamp on entries. Print version information and exit. Seconds  Source IP address used to send queries. Setting an IP address not correctly configured on a local network interface causes cryptic error messages. Specify test to run. Should be either the name of a module, or the name of a module and the name of a method in that module separated by a "/" character (Example: "Basic/basic1"). The method specified must be one that takes a zone object as its single argument. This switch can be repeated. Strings with DS data on the form "keytag,algorithm,type,digest" Testcase        The domain name contains consecutive dots.
 The locale to use for messages translation. The minimum severity level to display. Must be one of CRITICAL, ERROR, WARNING, NOTICE, INFO or DEBUG. The name of the nameserver '{nsname}' contains consecutive dots. WARNING Warning: Zonemaster::LDNS not compiled with IDN support, cannot handle non-ASCII names correctly. Warning: setting locale category LC_CTYPE to %s failed (is it installed on this system?).

 Warning: setting locale category LC_MESSAGES to %s failed (is it installed on this system?).

 Project-Id-Version: 0.0.5
Report-Msgid-Bugs-To: 
PO-Revision-Date: 2022-06-08 14:01+0000
Last-Translator: haarbo@dk-hostmaster.dk
Language-Team: Zonemaster Team
Language: da
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
 

   Niveau	Antal logbeskeder %8s	%5d beskeder.
 --level skal være enten CRITICAL, ERROR, WARNING, NOTICE, INFO, DEBUG, DEBUG2 eller DEBUG3.
 --ns skal være et navn eller et navn/IP-adresse par. ======= =======  =========  ============  ==============  Et navn/IP-adresse som angiver navneserveren til prædelegerede test eller blot et navn, som vil blive oversat til IP-adresser. Kan anføres flere gange. Så snart en hændelse med dette niveau eller højere logges, vil kørslen afbrydes. Skal være enten CRITICAL, ERROR, WARNING, NOTICE, INFO eller DEBUG. Efter afsluttet afvikling, udskriv en opsummering af svarftiderne som zonens navneservere brugte på at svare. Boolsk flag til aktivitetsindikator. Aktiveret hvis STDOUT er en tty, ellers deaktiveret. Deaktiver med --no-progress. KRITISK FEJLSØG FEJL Ukendt afslutningsniveau ' Flag angiver om output-format skal være JSON eller ej. Flag angiver om output-format skal være streaming JSON eller ej. Flag angiver om output'et skal oversættes til menneskesprog eller vises i råt format. Flag angiver om streaming JSON-output skal inkludere den oversatte besked af tag'et eller ej. Flag til angivelse af om forespørgsler må sendes via IPv4 eller ej. --ipv4 tillader IPv4 trafik, --no-ipv4 forbyder det. Flag til angivelse af om forespørgsler må sendes via IPv6 eller ej. --ipv6 tillader IPv6 trafik, --no-ipv6 forbyder det. INFO I stedet for at afvikle en test, udskriv alle mulige test. Niveau     Indlæser policy fra {path}. Ser OK ud. Besked Modul         Domænenavn, der skal testes, skal angives.
 NOTER Filnavn indeholdende DNS-data som skal indlæses før afvikling af test. Filnavn indeholdende DNS-data efter udførte test. Navn på profil-fil, der skal indlæses. (STANDARD) Navn på tegnkodningen, der skal anvendes for kommandolinje-argumenter. Udskriv antallet af registrerede beskeder på hvert niveau. Udskriv alvorlighedsniveauer på poster. Udskriv den effektive profil benyttet i JSON-format, og afslut. Udskriv modulets navn på poster. Udskriv navnet på testcasen på poster. Udskriv tidsstempler på poster. Udskriv version og afbryd. Sekunder  IP-adresse brugt til at sende forespørgsler fra. En ikke korrekt konfiguret IP-adresse på et lokalt interface medfører kryptiske fejlbeskeder. Angiver test som skal afvikles. Skal enten være et modulnavn eller et modulnavn og navnet på en metode i modulet adskilt af en skråstreg (Eksempel: "Basic/basic1"). Den valgte metode skal tage en enkelt zone som argument. Dette flag kan gentages. En streng med DS-data i formatet "keytag,algorithm,type,digest" Testcase        Domænenavnet indeholder flere dots (.) efter hinanden.
 Det 'locale' som skal bruges ved oversættelse af beskeder. Det mindste alvorlighedsniveau skal være enten CRITICAL, ERROR, WARNING, NOTICE, INFO eller DEBUG. Navnet på navneserveren '{nsname}' indeholder flere dots (.) efter hinanden. ADVARSEL Advarsel: Zonemaster::LDNS er ikke kompileret med IDN-support, og kan derfor ikke håndtere ikke-ASCII navne korrekt. Advarsel: Kunne ikke sætte locale kategori LC_CTYPE til %s (er det installeret på dette system?).

 Advarsel: Kunne ikke sætte locale kategori LC_MESSAGES til %s (er det installeret på dette system?).

 