class NotifiesController < ApplicationController
  before_action :authenticate_user!
  require 'carrierwave'
  require 'carrierwave/orm/activerecord'

  require "mini_magick"

  # require 'httmultiparty'

  require 'net/http/post/multipart'
	require 'net/http'
	require 'openssl'
	require 'uri'
  require 'json'
	AUTH_SITE = 'https://notify-bot.line.me'
	API_SITE  = 'https://notify-api.line.me'

	CLIENT_ID     = $liensettings["client_id"]
	CLIENT_SECRET = $liensettings["client_secret"]
	CALLBACK      = File.join($liensettings["callback"], "oauth/callback")
  def index
    @notifies = Notify.all
    if params[:error]
			flash[:danger] = params[:error] + " / " + params[:error_description]
		end
  end

  def new
	  @notify = Notify.new
		@students = Student.all
	end

  def create
    @notify = Notify.new(notify_params)
    if(@notify.save)
      students = @notify.students
      if (!students.nil?)
        students.each do |s|
          contacts = s.contacts
          if (!contacts.nil?)
            contacts.each do |c|
              if (c.notify_demand and (!c.line_token.nil? and !c.line_token.empty?))
                send_message(c.line_token, c.name + "您好：" + @notify.message, @notify)
              end
            end
          end
        end
      end
      redirect_to notifies_path
    else
		  flash[:error] = @notify.errors.full_messages
		  render :new
	  end	

  end	
  
  
  def send_message (token, message, notify)
		res = msg(token, message ,notify)

		case res
		when Net::HTTPSuccess
			@result = "successful"
		else
			j = JSON.parse(res.body)
			@result = "[status:#{j["status"]}] #{j["message"]}"
		end
	end

  def msg(token, message, notify)
    url = URI.parse(File.join(API_SITE, 'api/notify'))
    if (!notify.image.current_path.nil?)
      File.open(notify.image.current_path) do |i|
        req = Net::HTTP::Post::Multipart.new(
          url.path, 
          {"message" => message,"imageFile" => UploadIO.new(i, "image/png", notify.image_identifier)},
          {"Authorization" => "Bearer #{token}"}
        )
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.start { |h|
          h.request(req)
        }
      end
    else
      url = URI.parse(File.join(API_SITE, 'api/notify'))
      req = Net::HTTP::Post.new(url.path)
      req.content_type = "application/x-www-form-urlencoded"
      req['Authorization'] = "Bearer #{token}"
      req.set_form_data({
        "message" => message
      })

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      http.start { |h|
        h.request(req)
      }

    end
	end
  private
    def notify_params
      params.require(:notify).permit(:message, :image, :student_ids => [])
    end
end
