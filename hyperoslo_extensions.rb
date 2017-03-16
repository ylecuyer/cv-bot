def reply_with_text(text)
  @postback.reply(text: text)
end

def reply_with_attachment_id(attachment_id)
  @postback.reply(attachment: {
      type: "image",
      payload: {
        attachment_id: attachment_id
      }
    })
end

def reply_with_image(url)
  @postback.reply(attachment:{
    type:"image",
    payload:{
      url: url
    }
  })
end

def typing_on
    Facebook::Messenger::Bot.deliver(
        {
        recipient: @postback.sender, 
            sender_action: 'typing_on'
        },
  access_token: ENV['ACCESS_TOKEN'])
end

def simulate_typing(duration_in_sec)
  typing_on
  sleep duration_in_sec
end

def message_with_menu_link(text, first = false)
    @postback.reply(attachment:{
      type:"template",
      payload:{
        template_type:"button",
        text: text,
        buttons:[
          {
            type:"postback",
            title: if first then I18n.t('view_menu') else I18n.t('back_to_menu') end,
            payload:"MENU"
          }
        ]
      }
    })
end
