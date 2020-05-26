class ReciboController < ApplicationController
layout 'dashboard'
before_action :authenticate_user!
def recibo
@year_id = params[:year_id];	
@mes_id  = params[:ymes_id];
route = '/home/sabatinid/'

#@empleado1 = Empleado.find_by_legajo('28893347')
 # puts @empleado1.legajo
if Empleado.where(legajo: current_user.dni).empty?
        flash[:notice] = 'NO es empleado'
end
puts Dir.glob(route)
if Dir.glob(route).empty?
  flash[:notice] = 'hola mensaje'

else
	Dir.glob(route).each do |file|
		@li=file
    puts "file"
end
end
end
def dwl_recibo 
	require 'pdf-reader'
	require 'open-uri'
  
	@year_id = params[:year_id]	
	@mes_id  = params[:mes_id]
	arch = 0
  archivos = []
  files = ''
	route = '/home/sabatinid/bonosdesueldo/'+@year_id.to_s+'/'+@mes_id.to_s+'/*'
	puts route

  if Dir.glob(route).empty?
    flash[:notice] = 'No ha sido cargado el archivo de Bonos de sueldo para el mes y año seleccionado'
    redirect_to :action=> 'recibo'
  else

  Dir.glob(route).each do |file|
		@li=file
	  @page = 3
    @page1 = 0
	
	pdf_filename = @li#'/home/dario/bonos de sueldo/'+@year_id.to_s+'/'+@mes_id.to_s+'/'+@li
    @wordlist = current_user.dni
    #puts @wordlist
    puts @li
    arch = arch + 1
    @counter = 0
	File.open(pdf_filename, "rb") do |io|      #-- Open file
 	reader = PDF::Reader.new(io)        # -- reader now contains ful contents of pdf
  #################################
  #BonoIndice.find_by_anio_and_mes_and_dni_archivo_name(@year_id.to_s, @mes_id.to_s, @wordlist, pdf_filename).each do |ppagina|
  if BonoIndice.where(anio: @year_id.to_s).where(mes: @mes_id.to_s).where(dni: @wordlist).where(archivo_name: pdf_filename).empty?
    flash[:notice] = 'No ha sido cargado el archivo de Bonos de sueldo para el mes y año seleccionado'
    #redirect_to :action=> 'recibo'
    
  else
    
  resulset = BonoIndice.where(anio: @year_id.to_s).where(mes: @mes_id.to_s).where(dni: @wordlist).where(archivo_name: pdf_filename)

  resulset.each do |ppagina|#, "mes == @mes_id.to_s", "dni == @wordlist", "archivo == pdf_filename")
 # @nro_pag = ppagina.pagina
  
  @nro_pag = ppagina.pagina
  puts @nro_pag
  @nombre = @wordlist+'-'+@year_id+'-'+@mes_id+'-'+pdf_filename[-7,3]#@arch.to_s
      archivos[arch-1] = @nombre
      script = 'pdftk A='+"\'"+pdf_filename+"\'"#+'CAT A'+@COUNTER+'OUTPUT'+@wordlist+'.PDF'
      script1 = script+' CAT A'#+@COUNTER
      script2 = script1+@nro_pag.to_s+' OUTPUT '+@nombre+'.pdf'
      system(script2)
  
  end

  ###################################
# 	reader.pages.each do |page|         # -- since a pdf is defined in pages you have to go through each page to get the content
# 	@counter = @counter + 1
# 	pageText = page.text             # -- pageText contains all the text on a single page (only text!)
#  #puts @counter
#   	#@wordlist.each do |singleword|    #  (bunch of stuff specific to my script). But hopefully this example helps.
#   	#singleword.strip!
#   	if pageText.include? @wordlist
#      @page1 = @page
#      @page = @page - 1
#   	 # puts @counter
#   	  @nombre = @wordlist+'-'+@year_id+'-'+@mes_id+'-'+pdf_filename[-7,3]#@arch.to_s
#      archivos[arch-1] = @nombre
#	    script = 'pdftk A='+"\'"+pdf_filename+"\'"#+'CAT A'+@COUNTER+'OUTPUT'+@wordlist+'.PDF'
#      script1 = script+' CAT A'#+@COUNTER
#      script2 = script1+@counter.to_s+' OUTPUT '+@nombre+'.pdf'
#      system(script2)
      
#      #puts @nombre
      
#      break
#    end
    
    #break
#end
end
end
end
if archivos.empty?
  flash[:notice] = 'No ha sido cargado el archivo de Bonos de sueldo para el mes y año seleccionado'
    redirect_to :action=> 'recibo'
   
else
  archivos.each do |archivo|
    files = files+archivo+'.pdf'+' '
  end
  outpdf = @wordlist+'-'+@year_id+'-'+@mes_id+'.pdf'
  
  script3 = 'pdftk '+files+'cat output '+outpdf
  
  system(script3)
  send_file(
             "#{Rails.root}/"+outpdf,#+@nombre+".PDF",
             filename: outpdf,
             type: "application/pdf",
           )
  flash[:notice] = 'Archivo descargado con éxito'
  files = ''
end
#redirect_to :action=> 'recibo'

end
end

def indice
  require 'pdf-reader'
  require 'open-uri'
  @year_id = params[:year_id]
  @mes_id  = params[:mes_id]
  arch = 0
  archivos = []
  files = ''
  route = '/home/sabatinid/bonosdesueldo/2017/Junio/*'
  puts route
   Dir.glob(route).each do |file|
    @li=file
  puts @li
  pdf_filename = @li#'/home/dario/bonos de sueldo/'+@year_id.to_s+'/'+@mes_id.to_s+'/'+@li
  Empleado.select{:legajo}.each do |emp|
  @wordlist = emp.legajo#current_user.dni
  #puts @wordlist    
    @counter = 0
  File.open(pdf_filename, "rb") do |io|      #-- Open file
  reader = PDF::Reader.new(io)        # -- reader now contains ful contents of pdf
 
  reader.pages.each do |page|         # -- since a pdf is defined in pages you have to go through each page to get the content
  @counter = @counter + 1
  pageText = page.text       

   if pageText.include? @wordlist
     # BonoIndice.connection.insert("INSERT INTO BONO_INDICES(
      #      anio, mes, dni, pagina, archivo_name)
    #VALUES ('2017', 'junio', '#{@wordlist}', '#{@counter}', '#{@li}')")
    # BonoIndice.select{:anio}.each do |anio|
     b = BonoIndice.create :anio => '2017', :mes => 'Junio', :dni => @wordlist, :pagina => @counter, :archivo_name => @li
   
   end
   end
   end
   end
  end
  redirect_to :action=> 'recibo'
end



end
