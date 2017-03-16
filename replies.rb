require 'net/http'
require 'uri'
require 'json'
require_relative 'hyperoslo_extensions'

module CvBot
  module Replies

    def show_welcome_message
      reply_with_text(I18n.t('show_welcome_message.hello_user', name: user['first_name']))
      simulate_typing 1

      reply_with_text(I18n.t('show_welcome_message.happy_you_found_me'))
      reply_with_text(I18n.t('show_welcome_message.im_ylecuyer_personal_bot'))
      simulate_typing 1

      reply_with_attachment_id(ENV['PROFILE_PIC_ATTACHMENT_ID'])
      
      @postback.reply(attachment:{
          type:"template",
          payload:{
            template_type:"button",
            text: I18n.t('show_welcome_message.want_to_know_more'),
            buttons:[
              {
                type:"postback",
                title: I18n.t('show_welcome_message.i_want_to_know_more'),
                payload:"SAY_MORE"
              }
            ]
          }
        })
    end

    def show_say_more
      reply_with_text(I18n.t('show_say_more.what_i_am'))
      simulate_typing 1
      reply_with_text(I18n.t('show_say_more.what_i_want'))
      simulate_typing 1
      message_with_menu_link(I18n.t('show_say_more.lets_view_my_cv'), true)
    end

    def show_main_menu
      @postback.reply(attachment: {
        type: "template",
        payload: {
          template_type: "list",
          top_element_style: "compact",
          elements: [
            {
              title: I18n.t('show_main_menu.work_experience'),
              image_url: "http://theheureka.com/wp-content/uploads/2013/09/developers.jpg",
              buttons: [
                title: I18n.t(:details),
                type: "postback",
                payload: "WORK_EXPERIENCE"
              ]
            },
            {
              title: I18n.t('show_main_menu.studies'),
              image_url: "https://greenpandatreehouse.com/wp-content/uploads/gpt21.jpg",
              buttons: [
                title: I18n.t(:details),
                type: "postback",
                payload: "STUDIES"
              ]
            },
            {
              title: I18n.t('show_main_menu.language'),
              image_url: "http://www.prestigenetwork.com/wp-content/uploads/2015/10/beeplugin_languages.png",
              buttons: [
                title: I18n.t(:details),
                type: "postback",
                payload: "LANGUAGE"
              ]
            },
            {
              title: I18n.t('show_main_menu.side_projects'),
              image_url: "https://vsolutionsbe.files.wordpress.com/2016/01/github-logo.jpg?w=600",
              buttons: [
                title: I18n.t(:details),
                type: "postback",
                payload: "SIDE_PROJECTS"
              ]
            }
          ]
        }
      })
    end

    def show_freelance_details
      reply_with_text(I18n.t('show_freelance_details.sysadmin'))
      simulate_typing 2
      reply_with_text(I18n.t('show_freelance_details.backend'))
      simulate_typing 1
      message_with_menu_link(I18n.t('show_freelance_details.and_more'))
    end

    def show_bots_details
      reply_with_text(I18n.t('show_bots_details.startup'))
      simulate_typing 2
      reply_with_text('https://www.facebook.com/Messenger-Bot-de-Bogota-394425994244888/?ref=bookmarks')
      message_with_menu_link(I18n.t('show_bots_details.facebook'))
    end

    def show_studies_menu
      @postback.reply(attachment: {
        type: "template",
        payload: {
          template_type: "list",
          top_element_style: "compact",
          elements: [
            {
              title: I18n.t('show_studies_menu.uniandes'),
              subtitle: I18n.t('show_studies_menu.uniandes_from_to'),
              image_url: "https://media.licdn.com/mpr/mpr/shrink_200_200/AAEAAQAAAAAAAAuwAAAAJDhlMDE0MmNjLTc2ZmYtNDVhYS1hODg2LWE2Nzk2M2MxMjg0MA.png",
              buttons: [
                title: I18n.t(:details),
                type: "postback",
                payload: "UNIANDES"
              ]
            },
            {
              title: I18n.t('show_studies_menu.emse'),
              subtitle: I18n.t('show_studies_menu.emse_from_to'),
              image_url: "https://media.licdn.com/mpr/mpr/shrink_200_200/AAEAAQAAAAAAAAj5AAAAJGJjNGNhMjY4LTBlNzctNDlkYS05OTVjLWEwMTEyOWI2OTMwZg.png",
              buttons: [
                title: I18n.t(:details),
                type: "postback",
                payload: "EMSE"
              ]
            }
          ]
        }
      })
    end

    def show_uniandes_details
      reply_with_text(I18n.t('show_uniandes_details.double_diploma'))
      message_with_menu_link(I18n.t('show_uniandes_details.learnt_spanish'))
    end

    def show_emse_details
      message_with_menu_link(I18n.t('show_emse_details.default'))
    end

    def show_languages_details
      @postback.reply(attachment: {
        type: "template",
        payload: {
          template_type: "list",
          top_element_style: "compact",
          elements: [
            {
              title: I18n.t('show_languages_details.french'),
              subtitle: I18n.t('show_languages_details.french_level'),
              image_url: "https://github.com/hjnilsson/country-flags/blob/master/png250px/fr.png?raw=true",
            },
            {
              title: I18n.t('show_languages_details.spanish'),
              subtitle: I18n.t('show_languages_details.spanish_level'),
              image_url: "https://github.com/hjnilsson/country-flags/blob/master/png250px/es.png?raw=true",
            },
            {
              title: I18n.t('show_languages_details.english'),
              subtitle: I18n.t('show_languages_details.english_level'),
              image_url: "https://github.com/hjnilsson/country-flags/blob/master/png250px/gb.png?raw=true",
            }
          ]
        }
      })

      message_with_menu_link(I18n.t('show_languages_details.i_do_speak'))
    end 

    def show_work_experience_menu
      @postback.reply(attachment: {
        type: "template",
        payload: {
          template_type: "list",
          top_element_style: "compact",
          elements: [
            {
              title: I18n.t('show_work_experience_menu.french_embassy'),
              subtitle: I18n.t('show_work_experience_menu.french_embassy_from_to'),
              image_url: "https://media.licdn.com/mpr/mpr/shrink_200_200/AAEAAQAAAAAAAAg6AAAAJGMyYTIwMmU0LTk3N2QtNGZkNy1hZDEzLTM1Y2E0YWFiMWJhMQ.png",
              buttons: [
                title: I18n.t(:details),
                type: "postback",
                payload: "MAE"
              ]
            },
            {
              title: I18n.t('show_work_experience_menu.klee_group'),
              subtitle: I18n.t('show_work_experience_menu.klee_group_from_to'),
              image_url: "https://media.licdn.com/mpr/mpr/shrink_100_100/p/1/000/022/354/10c40b3.png",
              buttons: [
                title: I18n.t(:details),
                type: "postback",
                payload: "KLEEGROUP"
              ]
            }
          ]
        }
      })
    end

    def show_mae_details
      reply_with_text(I18n.t('show_mae_details.worked_in_french_embassy'))
      simulate_typing 1
      
      reply_with_text(I18n.t('show_mae_details.principal_work'))
      simulate_typing 1
      
      reply_with_text(I18n.t('show_mae_details.attendize'))
      simulate_typing 1

      reply_with_attachment_id(ENV['MAE_PRESIDENT_ATTACHMENT_ID'])

      message_with_menu_link(I18n.t('show_mae_details.french_president'))
    end

    def show_kleegroup_details
      reply_with_text(I18n.t('show_kleegroup_details.klee_group_base'))
      simulate_typing 1

      message_with_menu_link(I18n.t('show_kleegroup_details.archimed_elise'))
    end

    def show_side_projects_menu
      @postback.reply(attachment: {
        type: "template",
        payload: {
          template_type: "list",
          top_element_style: "compact",
          elements: [
            {
              title: I18n.t('show_side_projects_menu.bicimapa'),
              subtitle: I18n.t('show_side_projects_menu.bicimapa_from_to'),
              image_url: "https://fb-s-b-a.akamaihd.net/h-ak-xpa1/v/t1.0-1/p200x200/1375053_216163291891768_635848089_n.png?oh=4911f4eadf89d6e933b74846ed81f430&oe=596F04D0&__gda__=1495612644_4b7d9af2586ec82d4bbb80a9ff7193f0",
              buttons: [
                title: I18n.t(:details),
                type: "postback",
                payload: "BICIMAPA"
              ]
            },
            {
              title: I18n.t('show_side_projects_menu.messenger_bot_bgta'),
              subtitle: I18n.t('show_side_projects_menu.messenger_bot_bgta_from_to'),
              image_url: "https://fb-s-b-a.akamaihd.net/h-ak-xlt1/v/t1.0-1/p200x200/16729271_394428357577985_6707155126020391208_n.png?oh=771541b6d01414f6a693c8233046a41b&oe=595BC580&__gda__=1495951526_0c1944ff167ae6fb4568968a2c87f095",
              buttons: [
                title: I18n.t(:details),
                type: "postback",
                payload: "BOTS"
              ]
            },
            {
              title: I18n.t('show_side_projects_menu.freelance'),
              image_url: "https://lavca.org/wp-content/uploads/2016/12/freelance-1024x683.jpg",
              buttons: [
                title: I18n.t(:details),
                type: "postback",
                payload: "FREELANCE"
              ]
            }
          ]
        }
      })
    end

    def show_bicimapa_details
      reply_with_text(I18n.t('show_bicimapa_details.main_developer'))
      simulate_typing 1

      reply_with_text(I18n.t('show_bicimapa_details.what_is_bicimapa'))

      reply_with_attachment_id(ENV['BICIMAPA_MAIN_SCREEN_ATTACHMENT_ID'])
      simulate_typing 2

      reply_with_text(I18n.t('show_bicimapa_details.no_more_app'))
      reply_with_text("https://m.me/bicimapa")
      simulate_typing 1

      message_with_menu_link(I18n.t('show_bicimapa_details.win_win_situation'))
    end

  end
end
