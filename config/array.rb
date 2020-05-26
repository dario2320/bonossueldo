#!/usr/bin/ruby
require 'rubygems'
require 'pdf-reader'
require 'open-uri'
require 'pg'
require 'active_record'


arreglo = Array.new(5)
arreglo[0] = 'bienvenido'
arreglo[1] = 'hola'
arreglo[2] = 'que tal'
arreglo[3] = 'Gracias'
#arreglo[1] = 'buen dia'
#arreglo[2] = 'que tal'
#
arreglo.each do |arre|
  
if arre.include? 'hola'
  puts 'no se'
end
end

arreglo.delete_at(2)

arreglo.each do |arre|
  puts arre
end
