defmodule AppServiceTest do
  use ExUnit.Case
  doctest AppService

  test "greets the world" do
    assert AppService.hello() == :world
  end
end
