# MRBS con postgres DB usando docker


Lanza `build.sh` para construir las imagenes (mrbs_postgres y mrbs_php).

Ejecuta `run.sh` para crear y lanzar los containers. 

Se lanzan 3 containers:
* postgres -> La BBDD
* pgadmin -> Una interfaz web para administrar la base de datos (no es necesaria, es solo para mirar que todo está bien)
* mrbs -> El servidor apache con los archivos php. Importante: No se ha añadido ningún tipo de seguridad. Aunque como el mrbs ya tiene usuarios no se si es necesario. 
