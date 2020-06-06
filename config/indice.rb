

  require 'rubygems'
  require 'pdf-reader'
  require 'open-uri'
  require_relative '/home/sabatinid/.rvm/gems/ruby-2.4.0/gems/pg-0.21.0/lib/pg'
  require 'active_record'

  conn = PGconn.connect("localhost", 5432, '', '', "muni", "postgres", "bocaju")

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

  pdf_filename = li

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

 #############[10..14]
  reader.pages.each do |page|         # -- since a pdf is defined in pages you have to go through each page to get the content
  @counter = @counter + 1
  pageText = page.text[1600..1900]
  #c = c-1 1730..1740

   if pageText.include? @wordlist
    entro = 1
    dni = @wordlist

    time = Time.now.strftime("%Y-%m-%d")
    #hora = time.
    conn.exec("INSERT INTO BONO_INDICES(
           anio, mes, dni, pagina, archivo_name, created_at, updated_at)
    VALUES ('#{panio}', '#{pmes}', '#{@wordlist}', '#{@counter}', '#{li}', '#{time}', '#{time}')")

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
