module ArchivosHelper

  def abrir_archivo(file)
  	case File.extname(file.original_filename)
  	  when ".csv" then Roo::CSV.new(file.path, options={})
  	  when ".xls" then Roo::Excel.new(file.path, options={})
  	  when ".xlsx" then Roo::Excelx.new(file.path, options={})
    	else raise nil
  	end
  end

  def importar(file_path)
    modo
    @contador = { buenos: 0, malos: 0 }
    file = abrir_archivo(file_path)
      File.open("public/archivos/errores.xls", "a+"){|f|;
        f.write("\n");
        f.write("Archivo de errores ");
        f.write("\n");
        f.write(Time.now);
        f.write("\n");
        f.write(file_path.original_filename);
        f.write("\n");
        f.write("Linea");
        f.write("\t");
        f.write("Numero");
        f.write("\t");
        f.write("Nombre");
        f.write("\t");
        f.write("Observacion");
        f.write("\n");
        (1..file.last_row).each do |i|
          fila = file.row(i)
        error = false
        numero = fila[0].to_s
        nombre = fila[1]
        numero = numero.gsub(/[ .,;()-]*/, '')
        numero = numero.to_i / 10 if numero.last == '0'
        if numero.to_i > 4120100000 && numero.to_i < 4269999999
          numero = numero.to_i
          area = numero.to_s[0,3]
          if area == '412' || area == '414' || area == '424' || area == '416' || area == '426'
            if Contacto.exists?(numero: numero)
              error = true
              mensaje = 'Contacto existe en la BD'
            else
              @contacto=Contacto.new
              @contacto.numero  = numero
              @contacto.nombre  = nombre 
              @contacto.archivo = file_path.original_filename
              @contacto.user_id = current_user.id if @modo != 'campanna'
              @contacto.save  
              @contador[:buenos] += 1       
            end
          else
            error = true
            mensaje = 'codigo de area incorrecto'
          end 
        else
          error = true
          mensaje = 'Numero fuera de rango'
        end 
        if error
          f.write(i);
          f.write("\t");
          f.write(fila[0]);
          f.write("\t");
          f.write(nombre);
          f.write("\t");
          f.write(mensaje);
          f.write("\n");
          @contador[:malos] += 1       
        end
    end
    f.close();
    };
  end

end
