require 'nokogiri'
require 'open-uri'
################################   SCRAPPER   ############################################################
def scrapper
  return page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html")) 
end
###############################   GET CITY ADRESS   ######################################################
def get_city_adress(page)
  # Récuperation des liens de la page de chaque mairie
  all_html_intern_link = page.xpath('//a[@class="lientxt"]')  # all_html_intern_link   =>   <a class="lientxt" href="./95/ableiges.html">ABLEIGES</a> ...
  emails_final_part = []
  all_html_intern_link.each do |href|
    emails_final_part << href['href']          # on récupère la partie du href="...."  =>  emails_final_part   =>   "./95/ableiges.html" ...
  end                                        
  # Recomposition des liens complets
  cities_adress = emails_final_part.map {|href| "http://annuaire-des-mairies.com" + href[1..-1]}
  return cities_adress                                               # cities_adress   =>   "http://annuaire-des-mairies.com/95/ableiges.html" ...
end
##################################   GET CITY NAME   #####################################################
def get_city_name(cities_adress)
    all_commune_names = cities_adress.map {|name| name.gsub('http://annuaire-des-mairies.com/95/', '')}.map {|name| name.gsub('.html', '')}
  # on supprime "http://annuaire-des-mairies.com/95/' + .html"
  #########                                                        all_commune_names   =>   "ableiges", ...
    return all_commune_names.map(&:capitalize)    # on capitalise  all_commune_names   =>   "Ableiges", ...  
  end
##################################   GET CITY EMAIL   ####################################################
def get_city_email(cities_adress)
    # Récuperer l'adresse mail sur chaque page de chaque mairie
    all_emails = []
    cities_adress.each do |link|
      page = Nokogiri::HTML(URI.open("#{link}"))
      scrap_mails = page.xpath('//section[2]/div/table/tbody/tr[4]/td[2]')   # scrap_mails   =>   <td>mairie.wy-dit-joli-village@wanadoo.fr</td>
      all_emails << scrap_mails.text                                         #  all_emails   =>   "mairie.ableiges95@wanadoo.fr"
    end 
    return all_emails
  end 
###################################   THE PROGRAM   #######################################################
def the_program
  # Récupération de l'adresse http de chaque commune
  cities_adress = get_city_adress(scrapper)
  all_commune_names = get_city_name(cities_adress)
  all_emails = get_city_email(cities_adress)
  # Hash avec [nom_de_la_ville, adresse_mail]
  final_arr = []
  temp_hash = {}
  for i in 0...all_commune_names.length
    temp_hash = { all_commune_names[i] => all_emails[i] }
    final_arr << temp_hash
  end
#   print final_arr
#   puts
  return final_arr
end 
###########################################################################################################
the_program