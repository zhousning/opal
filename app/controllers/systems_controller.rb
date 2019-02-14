require 'restclient'
require 'json'

class SystemsController < ApplicationController
  #TODO 暂时将数据存在cookie中，但前台可以查看，有泄漏的风险
  def send_confirm_code
    code = rand(999999).to_s
    time = session[:reg_time]
    count = session[:reg_count]
    if time.nil? || time + 1800 < Time.now
      body = send_work(code, params[:phone])
      if body["status"] == "0"
        time = Time.now
        count = 1
        cookies[:reg_code] = { :value => code, :expires => 10.minute.from_now }
        render :text => 'success'
      else
        render :text => 'error'
      end
    elsif time + 60 <= Time.now && count < 5 
      body = send_work(code, params[:phone])
      if body["status"] == "0"
        time = Time.now
        count += 1
        cookies[:reg_code] = { :value => code, :expires => 10.minute.from_now }
        render :text => 'success'
      else
        render :text => 'error'
      end
    end
  end

  private
    def send_work(value, phone)
      url = 'http://api.jisuapi.com/sms/send'
      content = '尊敬的会员，您的验证码:' + value + '。您正在注册，10分钟内有效。【茶源世界】'
      data = {
        mobile: phone, 
        content: content,
        appkey: 'd52de3f3ebff6184'
      }
      response = RestClient.get url, params: data, :accept => :json
      body = JSON.parse(response.body)
    end
end
