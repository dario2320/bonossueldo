
  require 'pdf-reader'
  require 'open-uri'
 # @year_id = params[:year_id]
 # @mes_id  = params[:mes_id]
  arch = 0
  archivos = []
  files = ''
  route = '/home/sabatinid/bonos de sueldo/2017/Junio/*'
  #puts route
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




