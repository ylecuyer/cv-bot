require 'dotenv/load'
require 'json'

greeting_curl = %{curl -s -X POST -H "Content-Type: application/json" -d '{
  "greeting":[
    {
      "locale":"default",
      "text":"Hi! Welcome to my CV Bot, press the 'GET STARTED' button to start our virtual interview!"
    }, {
      "locale":"es_ES",
      "text":"Hola! Bienvenido a mi bot personal, dale clic a 'EMPEZAR' para empezar nuestra entrevista virtual!"
    }, {
      "locale":"es_LA",
      "text":"Hola! Bienvenido a mi bot personal, dale clic a 'EMPEZAR' para empezar nuestra entrevista virtual!"
    }, {
      "locale":"fr_FR",
      "text":"Bonjour! Bienvenue sur mon bot personnel, cliquez sur 'DÉMARRER' pour commencer notre entretient virtuel!"
    }
  ] 
}' "https://graph.facebook.com/v2.6/me/messenger_profile?access_token=#{ENV['ACCESS_TOKEN']}"}

puts 'Setting greeting_text'
puts `#{greeting_curl}`

get_started_cta = %{curl -s -X POST -H "Content-Type: application/json" -d '{ 
  "get_started":{
    "payload":"GET_STARTED"
  }
}' "https://graph.facebook.com/v2.6/me/messenger_profile?access_token=#{ENV['ACCESS_TOKEN']}"}

puts 'Setting GET STARTED CTA'
puts `#{get_started_cta}`

def get_attachment_curl(url)

  %{curl -s -X POST -H "Content-Type: application/json" -d '{
    "message":{
      "attachment":{
        "type":"image", 
        "payload":{
          "url":"#{url}", 
          "is_reusable":true,
        }
      }
    }
  }' "https://graph.facebook.com/v2.6/me/message_attachments?access_token=#{ENV['ACCESS_TOKEN']}"}

end

def get_attachment_id(url)
  json = JSON.parse(`#{get_attachment_curl(url)}`)
  json["attachment_id"]
end

File.open('.env', 'w+') do |f|

  f << "APP_ID=#{ENV['APP_ID']}\n"
  f << "APP_SECRET=#{ENV['APP_SECRET']}\n"
  f << "ACCESS_TOKEN=#{ENV['ACCESS_TOKEN']}\n"
  f << "VERIFY_TOKEN=#{ENV['VERIFY_TOKEN']}\n"
  f << "FIELDS=#{ENV['FIELDS']}\n"
  f << "\n"
  f << "PROFILE_PIC_ATTACHMENT_ID=#{get_attachment_id("http://img4.hostingpics.net/pics/87752220161205114446.jpg")}\n"
  f << "MAE_PRESIDENT_ATTACHMENT_ID=#{get_attachment_id("http://img4.hostingpics.net/pics/156473hollande.jpg")}\n"
  f << "BICIMAPA_MAIN_SCREEN_ATTACHMENT_ID=#{get_attachment_id("https://github.com/bicimapa/bicimapa-assets/blob/master/screenshot_main_page.png?raw=true")}\n"

end

puts '.env file REWRITED'
