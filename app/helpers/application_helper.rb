module ApplicationHelper

  def parse(content)
    #content.gsub(/(?:^|\W)@(\w+)/, link_to(" @#{'\1'}", '/users/\1'))
    content = content.gsub(/(?:\s|^)(?:#(?!\d+(?:\s|$)))(\w+)(?=\s|$)/i) do |match|
      link_to(match, '#', class: 'hashtags')
    end

    content.gsub(/(?:^|\W)@(\w+)/) do |match|
      link_to(match, user_path(match.gsub('@', '')), class: 'mention')
    end

  end

  def fetch_bg_img
    if user_signed_in?
      '/assets/background_entrada.jpg'
    else
      '/assets/img-1.jpg'
    end
  end

  def distance_of_time_in_words(from_time, to_time = 0, include_seconds = false)
     from_time = from_time.to_time if from_time.respond_to?(:to_time)
     to_time = to_time.to_time if to_time.respond_to?(:to_time)
     distance_in_minutes = (((to_time - from_time).abs)/60).round
     distance_in_seconds = ((to_time - from_time).abs).round
     case distance_in_minutes
       when 0..1
         return (distance_in_minutes == 0) ? 'menos de um minuto' : '1 minuto' unless include_seconds
         case distance_in_seconds
           when 0..4   then 'menos de 5 segundos'
           when 5..9   then 'menos de 10 segundos'
           when 10..19 then 'menos de 20 segundos'
           when 20..59 then 'menos de un minuto'
           else             '1 minuto'
         end
       when 2..45           then "#{distance_in_minutes} minutos"
       when 46..55          then 'menos de 1 hora'
       when 56..69          then 'como 1 hora'
       when 70..89          then 'como 1 hora y media'
       when 90..1439        then "como #{(distance_in_minutes.to_f / 60.0).round} horas"
       when 1440..2879      then '1 dia'
       when 2880..43199     then "#{(distance_in_minutes / 1440).round} dias"
       when 43200..86399    then 'como 1 mes'
       when 86400..525959   then "#{(distance_in_minutes / 43200).round} meses"
       when 525960..1051919 then 'como 1 año'
       else                      "mas de #{(distance_in_minutes / 525960).round} años"
     end
   end

end