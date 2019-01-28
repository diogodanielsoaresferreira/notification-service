defmodule SmsService.Sms do

  @sender_number "+12526801302"

  def send_notification(title, message, address) do
   	message = ExTwilio.Message.create(to: "+351#{address}", from: @sender_number, body: title <> ": " <>message)
  end
end