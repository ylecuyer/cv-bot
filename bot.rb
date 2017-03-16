require 'facebook/messenger'
require 'i18n'
require_relative 'replies'

I18n.load_path = Dir['i18n/*.yml']
I18n.available_locales = [:fr, :en, :es]

include Facebook::Messenger

module CvBot
  class Bot

    include CvBot::Replies

    def initialize
      Facebook::Messenger::Bot.on :postback do |postback|
        @postback = postback
        reply
      end
    end

    private

    def reply
      set_locale

      case @postback.payload
      when 'SIDE_PROJECTS'
       show_side_projects_menu
      when 'FREELANCE'
       show_freelance_details
      when 'BOTS'
       show_bots_details
      when 'BICIMAPA'
       show_bicimapa_details
      when 'KLEEGROUP'
       show_kleegroup_details
      when 'MAE'
       show_mae_details
      when 'WORK_EXPERIENCE'
        show_work_experience_menu
      when 'LANGUAGE'
        show_languages_details
      when 'EMSE'
        show_emse_details
      when 'UNIANDES'
        show_uniandes_details
      when 'STUDIES'
        show_studies_menu
      when 'SAY_MORE'
        show_say_more
      when 'MENU'
        show_main_menu
      when 'GET_STARTED'
        show_welcome_message
      end


    end

    def user
      JSON.parse(Net::HTTP.get(URI.parse("https://graph.facebook.com/v2.8/#{@postback.sender["id"]}?access_token=#{ENV['ACCESS_TOKEN']}")))
    end

    def set_locale
      begin
        I18n.locale = user["locale"].split('_')[0]
      rescue
        I18n.locale = :en
      end
      I18n.locale = :es
    end
  end
end

cv_bot = CvBot::Bot.new
