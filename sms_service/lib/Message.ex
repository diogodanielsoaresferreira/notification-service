defmodule SmsService.Message do
  @derive [Poison.Encoder]
  defstruct [:address, :message, :title]
end