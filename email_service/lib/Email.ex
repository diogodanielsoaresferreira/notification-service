defmodule EmailService.Email do
  import Bamboo.Email

  def send_notification(title, message, address) do
    new_email
    |> to(address)
    |> from("chargeit.electricchargingsystem@gmail.com")
    |> subject(title)
    |> text_body(message)
  end
end