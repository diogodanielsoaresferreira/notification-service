defmodule SmsServiceTest do
  use ExUnit.Case
  doctest SmsService

  test "greets the world" do
    assert SmsService.hello() == :world
  end
end
