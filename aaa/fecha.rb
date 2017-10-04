ahora = Time.now
#ahora = Time.new(2017-08-31)
# ahora = Time.new(2017,  1, 26)
# ahora = Time.new(2017,  1, 27)
# ahora = Time.new(2017,  1, 28)
# ahora = Time.new(2017,  1, 29)
# ahora = Time.new(2017,  1, 30)
# ahora = Time.new(2017,  1, 31)
# ahora = Time.new(2017,  3, 29)
# ahora = Time.new(2017,  3, 30)
# ahora = Time.new(2017,  3, 31)
# ahora = Time.new(2017,  5, 29)
# ahora = Time.new(2017,  5, 30)
# ahora = Time.new(2017,  5, 31)
# ahora = Time.new(2017,  8, 29)
# ahora = Time.new(2017,  8, 30)
# ahora = Time.new(2017,  8, 31)
# ahora = Time.new(2017, 10, 29)
# ahora = Time.new(2017, 10, 30)
# ahora = Time.new(2017, 12, 24)

# ahora es f_vencimiento
#
dia = ahora.strftime('%d')
mes = ahora.strftime('%m')
anno = ahora.strftime('%Y')

#final = anno + mes + dia
#final = "#{anno}#{mes}#{dia}".strftime('%Y%m%d')
final = Time.new(anno, mes, dia)

unmes = ahora + (31*24*60*60)
unmes = ahora + (29*24*60*60) if mes == "01" && dia == "30" 
unmes = ahora + (28*24*60*60) if mes == "01" && dia == "31" 
unmes = ahora + (30*24*60*60) if mes == "01" && dia == "29" || ((mes == "03" || mes == "05" || mes == "08" || mes == "10") && dia == "31") 

# un mes es la nueva f_vencimiento

unmes = unmes + (24*60*60)


#puts "eldia #{dia}"
#puts "elmes #{mes}"
#puts "an no #{anno}"
#puts "final #{final}"
#puts "ahora #{ahora}"
#puts "unmes #{unmes}"


