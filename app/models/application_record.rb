class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

private
  def actualizar_grupo
    grupo = {"grupos_id_in_any"=>[self.id.to_s]}
    buscar = Contacto.search(grupo)
    contactos = buscar.result(distinct: true)
    cantidad = contactos.length
    grupo = Grupo.find(self.id)
    grupo.update_columns(cantidad_contactos: cantidad)
  end

  def actualizar_cgrupo
    cg = ContactosGrupo.where(contacto_id: self.id)
    cg.each do |cg|
      grupo = {"grupos_id_in_any"=>[cg.grupo_id.to_s]}
      buscar = Contacto.search(grupo)
      contactos = buscar.result(distinct: true)
      cantidad = contactos.length
      grupo = Grupo.find(cg.grupo_id)
      grupo.update_columns(cantidad_contactos: cantidad)
    end
  end

  def actualizar_todos_los_grupos
   todos = Grupo.all
#    todos = Grupo.where(user_id: current_user.id)
    todos.each do |cg|
      grupo = {"grupos_id_in_any"=>[cg.id.to_s]}
      buscar = Contacto.search(grupo)
      contactos = buscar.result(distinct: true)
      cantidad = contactos.length
      edita = Grupo.find(cg.id)
#     puts "grupo nombre: #{edita.nombre}"
      edita.update_columns(cantidad_contactos: cantidad)
    end
  end