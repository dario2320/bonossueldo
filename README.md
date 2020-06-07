# bonossueldo
aplicativo para bajar online bonos de sueldo

El aplicativo tiene como propósito tomar un archivo de bonos de sueldo en pdf e indexar legajo con número de página en una base de datos, en este caso postgres.
Se usa la gema pdf-reader para leer un archivo pdf, compuesto por muchas páginas iguales, en este caso es un archivo de bonos de sueldo.
En directorio /config se encuentra el archivo indice.rb el cual contiene un script que toma los archivos pdf de una carpeta y los procesa generando la indexación en la base de datos.

Cuando se elige el mes y año, se busca en la base el archivo y página del bono según el usuario y se extrae del archivo a través de pdftk.

El código esta hardcodeado en varias partes, y hay muchas cosas que se pueden hacer mejor.

