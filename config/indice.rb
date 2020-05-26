  

  #require 'pdf-reader'
  require 'rubygems'
  require 'pdf-reader'
    #require_relative '/home/sabatinid/.rvm/gems/ruby-2.4.0/pdf-reader-1.1.1'
  require 'open-uri'
  require_relative '/home/sabatinid/.rvm/gems/ruby-2.4.0/gems/pg-0.21.0/lib/pg'
  ##require_relative './home/sabatinid/.rvm/gems/ruby-2.4.0/gems/pg-0.21.0'
  require 'active_record'

  conn = PGconn.connect("localhost", 5432, '', '', "muni", "postgres", "bocaju")
  

  
 # @year_id = params[:year_id]
 # @mes_id  = params[:mes_id]
  parchive = ARGV[0]
  panio = ARGV[1]
  pmes = ARGV[2]
  arch = 0
  archivos = []
  files = ''
  puts parchive
  entro = 0
  siguiente = 0
  dni = ''
  li = '/home/sabatinid/bonosdesueldo/'+panio+'/'+pmes+'/'+parchive
  #puts route
  #Dir.glob(route).each do |file|
    #li=file
  #puts route
  pdf_filename = li#li#'/home/dario/bonos de sueldo/'+@year_id.to_s+'/'+@mes_id.to_s+'/'+@li
  #Empleado.select{:legajo}.each do |emp|
  res  = conn.exec('select * from empleados')#' where id between 1602 and 1774')
  res.each do |emp|
   
   @wordlist = emp['legajo']#current_user.dni
     #### counter va en '0'
    @counter = 0
    c=5
    siguiente = 0
  File.open(pdf_filename, "rb") do |io|      #-- Open file
  reader = PDF::Reader.new(io)        # -- reader now contains ful contents of pdf
  total_page = reader.page_count
  div = total_page/4
  mitad = total_page/2
  tresq = div + mitad
  ini = 1
  fin = 1
  #puts div
 # uncuarto = reader.page(div).text[1610..1625].strip
  #medio = reader.page(mitad).text[1610..1625].strip 
 # tercero = reader.page(tresq).text[1610..1625].strip
  #puts uncuarto
 # puts medio
  #puts tercero
  #puts total_page
  #puts search[1610..1625].strip #8 digitos .strip
  #lectura = PDF::Reader::Turtletext.new(pdf_filename)
  #options = { :y_precision => 7 }
  #lectura_with_options = PDF::Reader::Turtletext.new(pdf_filename,options).text
 # if @wordlist.to_i <= uncuarto.to_i
  #   fin = div
 # end
  #if @wordlist.to_i <= medio.to_i
 #   ini = div
 #   fin = mitad
 # end
 # if @wordlist.to_i <= tercero.to_i
  #  ini = mitad
 #   fin = tresq
 # end
 # if @wordlist.to_i > tercero.to_i
 #   ini = tresq
 #   fin = total_page
 #  end
 #############[10..14]
  reader.pages.each do |page|         # -- since a pdf is defined in pages you have to go through each page to get the content
  @counter = @counter + 1
  pageText = page.text[1600..1900]  
  #c = c-1 1730..1740 
  
   if pageText.include? @wordlist
    entro = 1
    dni = @wordlist
    # BonoIndice.connection.insert("INSERT INTO BONO_INDICES(
      #      anio, mes, dni, pagina, archivo_name)
    #VALUES ('2017', 'junio', '#{@wordlist}', '#{@counter}', '#{@li}')")
    time = Time.now.strftime("%Y-%m-%d")
    #hora = time.
    conn.exec("INSERT INTO BONO_INDICES(
           anio, mes, dni, pagina, archivo_name, created_at, updated_at)
    VALUES ('#{panio}', '#{pmes}', '#{@wordlist}', '#{@counter}', '#{li}', '#{time}', '#{time}')")
    # BonoIndice.select{:anio}.each do |anio|
    # b = BonoIndice.create :anio => '2017', :mes => 'Junio', :dni => @wordlist, :pagina => @counter, :archivo_name => @li
    #, '#{hora}', '#{hora}'
   end
   if entro == 1 && dni == @wordlist
      siguiente = 1
   end
   if entro == 0 && siguiente == 1
    break
   end
   entro = 0
   # break
     
   end
   puts dni
   puts entro
   puts siguiente
   end
   end
  




