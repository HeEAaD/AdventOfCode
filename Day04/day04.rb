#!/usr/bin/env ruby

require 'digest'

input = 'bgvyzdsv'

i = 0
s = ''
h = ''
loop do
  s = "#{input}#{i}"
  h = Digest::MD5.hexdigest s
  break if h.start_with?('000000') 
  i += 1
end

puts "#{i} => #{s} => #{h}"