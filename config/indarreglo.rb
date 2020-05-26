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
  arreglo = []
  files = ''
  puts parchive
  entro = 0
  siguiente = 0
  dni = ''
  li = '/home/sabatinid/bonosdesueldo/'+panio+'/'+pmes+'/'+parchive
  @counter = 0
  #puts route
  #Dir.glob(route).each do |file|
    #li=file
  #puts route
  arreglo[0] = 'vacio'
  pdf_filename = li#li#'/home/dario/bonos de sueldo/'+@year_id.to_s+'/'+@mes_id.to_s+'/'+@li
  #Empleado.select{:legajo}.each do |emp|
  File.open(pdf_filename, "rb") do |io|      #-- Open file
  reader = PDF::Reader.new(io)        # -- reader now contains ful contents of pdf
  reader.pages.each do |page|         # -- since a pdf is defined in pages you have to go through each page to get the content
  @counter = @counter + 1
  arreglo[@counter] = page.text[1600..1900]
  end
  end
   
  res  = conn.exec('select * from empleados')#' where id between 1602 and 1774')
  res.each do |emp|
   
   @wordlist = emp['legajo']#current_user.dni
     #### counter va en '0'
   @counter = -1
    c=5
    siguiente = 0
  #File.open(pdf_filename, "rb") do |io|      #-- Open file
  #reader = PDF::Reader.new(io)        # -- reader now contains ful contents of pdf
  #total_page = reader.page_count
  #div = total_page/4
  #mitad = total_page/2
  #tresq = div + mitad
  #ini = 1
  #fin = 1
 
 #############[10..14]
  arreglo.each do |arre|         # -- since a pdf is defined in pages you have to go through each page to get the content
  @counter = @counter + 1
  #arreglo[@counter-1] = page.text[1600..1900]  
  #c = c-1 1730..1740 
  puts arre
   if arre.include? @wordlist
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
    #arreglo.delete_at(@counter)
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
   
   end
   #end
  