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
  '     >   9  5   x     �  ;   �  (     +   +     W  #   s     �  �   �  "  3  ?   V     �  +   �  +   �  f   �  @   e     �  a   �  [     ^   l    �     �       ^     +   {     �     �  
   �     �     �  �   �  �   �  z   8  �   �     q     z     �  -   �  3   �  F   �  Q   5  j   �  {   �  {   n     �  G   �  
   7     B     `     l     t  /   �     �  N   �  Q     2   Z  m   �  >   �  $   :  D   _  1   �  8   �  ,     0   <  	   m  �   w  8  7  d   p     �  3   �  ;     q   [  J   �       p   $  u   �  x         ,               5                 !   '      -      8      
              (   *   )                       "          2                  9                 0         #                4                            1   3       %   +   7             .      &      /      $   6      	        

   Level	Number of log entries %8s	%5d entries.
 --level must be one of CRITICAL, ERROR, WARNING, NOTICE, INFO, DEBUG, DEBUG2 or DEBUG3.
 --ns must be a name or a name/ip pair. ======= =======  =========  ============  ==============  A name/ip string giving a nameserver for undelegated tests, or just a name which will be looked up for IP addresses. Can be given multiple times. As soon as a message at this level or higher is logged, execution will stop. Must be one of CRITICAL, ERROR, WARNING, NOTICE, INFO or DEBUG. At the end of a run, print a summary of the times the zone's name servers took to answer. Boolean flag for activity indicator. Defaults to on if STDOUT is a tty, off if it is not. Disable with --no-progress. CRITICAL DEBUG ERROR Failed to recognize stop level ' Flag indicating if output should be in JSON or not. Flag indicating if output should be streaming JSON or not. Flag indicating if output should be translated to human language or dumped raw. Flag indicating if streaming JSON output should include the translated message of the tag or not. Flag to permit or deny queries being sent via IPv4. --ipv4 permits IPv4 traffic, --no-ipv4 forbids it. Flag to permit or deny queries being sent via IPv6. --ipv6 permits IPv6 traffic, --no-ipv6 forbids it. INFO Instead of running a test, list all available tests. Level      Loading profile from {path}. Looks OK. Message Module        Must give the name of a domain to test.
 NOTICE Name of a file to restore DNS data from before running test. Name of a file to save DNS data to after running tests. Name of profile file to load. (DEFAULT) Name of the character encoding used for command line arguments Print a count of the number of messages at each level Print level on entries. Print the effective profile used in JSON format, then exit. Print the name of the module on entries. Print the name of the test case on entries. Print timestamp on entries. Print version information and exit. Seconds  Source IP address used to send queries. Setting an IP address not correctly configured on a local network interface causes cryptic error messages. Specify test to run. Should be either the name of a module, or the name of a module and the name of a method in that module separated by a "/" character (Example: "Basic/basic1"). The method specified must be one that takes a zone object as its single argument. This switch can be repeated. Strings with DS data on the form "keytag,algorithm,type,digest" Testcase        The domain name contains consecutive dots.
 The locale to use for messages translation. The minimum severity level to display. Must be one of CRITICAL, ERROR, WARNING, NOTICE, INFO or DEBUG. The name of the nameserver '{nsname}' contains consecutive dots. WARNING Warning: Zonemaster::LDNS not compiled with IDN support, cannot handle non-ASCII names correctly. Warning: setting locale category LC_CTYPE to %s failed (is it installed on this system?).

 Warning: setting locale category LC_MESSAGES to %s failed (is it installed on this system?).

 Project-Id-Version: 0.0.5
Report-Msgid-Bugs-To: 
PO-Revision-Date: 2022-05-23 16:40-0400
Last-Translator: hsalgado@vulcano.cl
Language-Team: Zonemaster Team
Language: es
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Generator: Poedit 3.0
 

   Nivel	Número de registros %8s	%5d registros.
 --level debe ser alguno entre CRITICAL, ERROR, WARNING, NOTICE, INFO, DEBUG, DEBUG2 o DEBUG3.
 --ns debe ser un nombre o un par nombre/ip. ======= =======  =========  ============  ==============  Una etiqueta nombre/IP para el servidor de nombres en las pruebas no-delegadas, o solo un nombre que será resuelto para buscar la dirección IP. Puede repetirse varias veces. Tan pronto como se registra un mensaje en este nivel o uno superior, la ejecución se detendrá. Debe ser alguno entre CRITICAL, ERROR, WARNING, NOTICE, INFO o DEBUG. Al finalizar una ejecución, despliega un resumen del tiempo que le tomó responder a los servidores de nombre de la zona. Opción booleana para el indicador de actividad. El predeterminado es encendido si la salida estándar (STDOUT) es un terminal, apagado si no lo es. Se puede deshabilitar con --no-progress. CRÍTICO DEPURACIÓN ERROR Fallo en identificar el nivel de detención ' Opción que indica si la salida será en JSON o no. Opción que indica si la salida debiera ser transmisión de JSON o no. Opción que indica si la salida se traducirá a idioma humano o en formato crudo. Opción que indica si la salida de transmisión de JSON debiera incluir el mensaje traducido del tag o no. Opción para permitir o prohibir el envío de consultas vía IPv4. --ipv4 autoriza el tráfico IPv4, --no-ipv4 lo prohíbe. Opción para permitir o prohibir el envío de consultas vía IPv6. --ipv6 autoriza el tráfico IPv6, --no-ipv6 lo prohíbe. INFO En vez de ejecutar una prueba, despliega todas las pruebas disponibles. Nivel      Cargando perfil desde {path}. Se ve bien. Mensaje Módulo        Debe indicar el nombre de un dominio a probar.
 AVISO Nombre de un archivo para recuperar los datos DNS antes de ejecutar la prueba. Nombre de un archivo para guardar los datos DNS después de ejecutar las pruebas. Nombre del archivo de perfiles a cargar. (DEFAULT) Nombre de la codificación de caracteres ("encoding") que se usa para los argumentos en la línea de comandos Despliega un contador de la cantidad de mensajes en cada nivel Despliega el nivel en los registros. Despliega el perfil definitivo usado en formato JSON, luego termina. Despliega el nombre del módulo en los registros. Despliega el nombre del caso de prueba en los registros. Despliega marcas de tiempo en los registros. Despliega información de la versión y termina. Segundos  Dirección IP de origen usada para enviar las consultas. Indicar una dirección IP que no esté correctamente configurada en una interfaz de red local puede causar mensajes de error confusos. Indica la prueba a ejecutar. Debe ser el nombre de un módulo, o el nombre de un módulo y el nombre de un método de ese módulo separado por el caracter "/" (por ejemplo: "Basic/basic1"). El método especificado debe ser uno que recibe un objecto de zona como su único argumento. Esta opción puede repetirse. Etiquetas con los datos DS en la forma "tag,algoritmo,tipo,resumen" ("keytag,algorithm,type,digest") Caso de prueba        El nombre de dominio contiene puntos consecutivos.
 Localización (locale) para la traducción de los mensajes. El nivel de severidad mínimo para mostrar. Debe ser alguno entre CRITICAL, ERROR, WARNING, NOTICE, INFO o DEBUG. El nombre del servidor de nombres '{nsname}' contiene puntos consecutivos. ADVERTENCIA Advertencia: Zonemaster::LDNS no fue compilado con soporte IDN, no puede manejar correctamente nombres no-ASCII. Advertencia: fallo en definir la categoría de localización LC_CTYPE como %s (¿está instalada en este sistema?).

 Advertencia: fallo en definir la categoría de localización LC_MESSAGES como %s (¿está instalada en este sistema?).

 