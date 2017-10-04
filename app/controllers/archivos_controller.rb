class ArchivosController < ApplicationController
 before_action :authenticate_user!
 before_action :saldo_sms
 Ruta_directorio_archivos = "public/archivos/"

include ArchivosHelper

 def cargar
  
    @archivos = Dir.entries(Ruta_directorio_archivos)

    if request.post?
       archivo = params[:archivo]
       if archivo.blank?
         redirect_to archivos_cargar_url, notice: 'Debe carga un archivo...'
       else   
         ruta_al_archivo = Ruta_directorio_archivos + archivo.original_filename
         if File.exist?(ruta_al_archivo)
            redirect_to archivos_cargar_url, notice: "El archivo #{archivo.original_filename} ya existe en el sistema!!!" 
         else
            #Nombre original del archivo.
            nombre = archivo.original_filename
            #Directorio donde se va a guardar.
            directorio = Ruta_directorio_archivos
            #Extensión del archivo.
            extension = File.extname(archivo.original_filename)
            if extension == ".csv" or extension == ".xls" or extension == ".xlsx"
               #Ruta del archivo.
               path = File.join(directorio, nombre)
               #Crear en el archivo en el directorio. Guardamos el resultado en una variable, será true si el archivo se ha guardado correctamente.
               importar(params[:archivo])
               resultado = File.open(path, "wb") { |f| f.write(archivo.read) }
               if resultado
                  redirect_to archivos_cargar_url, notice: "Se cargó el archivo #{archivo.original_filename} con #{@contador[:buenos]} contactos buenos y #{@contador[:malos]} contactos con errores (ver archivo de errores.xls)" 
               else
                  redirect_to archivos_cargar_url, notice: "No se pudo cargar el archivo #{archivo.original_filename}" 
               end
            else
              redirect_to archivos_cargar_url, notice: "El formato del achivo #{archivo.original_filename} es incorrecto. Sólo puede subir archivos tipo .csv, .xls, y .xlsx"
            end
         end
       end
    end

 end

 def borrar
    #Recuperamos el nombre del archivo.
    archivo_a_borrar = params[:archivo_a_borrar]
    #Guardamos la ruta del archivo a eliminar.
    ruta_al_archivo = Ruta_directorio_archivos + archivo_a_borrar
    #Verificamos que el archivo exista para eliminarlo.
    if File.exist?(ruta_al_archivo)
       #Si el archivo existe se intentará eliminarlo. Dentro de la variable resultado se guardará true si se pudo eliminar y false si no.
       resultado = File.delete(ruta_al_archivo)
       redirect_to archivos_cargar_url, notice: "El archivo #{archivo_a_borrar} ha sido borrado" 
    else
       #El archivo no existe así que no se pudo eliminar nada.
       redirect_to archivos_cargar_url, notice: "El archivo #{archivo_a_borrar} no se pudo borrar porque no existe" 
    end
 end

end