require 'rubygems'
require 'nokogiri'
require 'open-uri'

def scrapper
  return page = Nokogiri::HTML(URI.open('https://coinmarketcap.com/all/views/all'))
end

def crypto(page)
  arr_name = []
  arr_value = []
  final_arr = []
  temp_hash = {}

  crypto_name = page.xpath('//tr//td[3]') # récupère tout le HTML 
  crypto_value = page.xpath('//tr//td[5]')

  crypto_name.each{ |name| 
    arr_name << name.text      # tri le HTML et récupère la partie text
  }
  crypto_value.each{ |price|
    arr_value << price.text
  }

  i = 0
  loop do
  temp_hash = { arr_name[i] => arr_value[i] }
  break if arr_value[i] == nil
  final_arr << temp_hash
  i += 1
  end

  return final_arr
end


# print crypto(scrapper)
# puts