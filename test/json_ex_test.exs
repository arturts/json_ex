defmodule JsonExTest do
  use ExUnit.Case
  doctest JsonEx

  test "parses json correctly" do
    assert JsonEx.parse "[]" == []
    assert JsonEx.parse "{}" == %{}
    assert JsonEx.parse "{\"key\": \"value\"}" == %{"key" => "value"}
    assert JsonEx.parse "[1, 2, 3]" == [1, 2, 3]
    complex = """
    {
      \"key\": [1.1, 2.2],
      \"another\": {
        \"abc\": true
      }
    }
    """
    assert JsonEx.parse complex == %{"key" => [1.1, 2.2], "another" => %{"abc" => true}}
  end
end
