defmodule JsonExTest do
  use ExUnit.Case
  doctest JsonEx

  test "lexer returns correct single token" do
    {:ok, [token|_], _} = "\"hello\"" |> to_char_list |> :json_lexer.string
    assert {:string, 1, "\"hello\""} == token

    {:ok, [token|_], _} = "true" |> to_char_list |> :json_lexer.string
    assert {:bool, 1, true} == token

    {:ok, [token|_], _} = "null" |> to_char_list |> :json_lexer.string
    assert {:nil, 1, nil} == token

    {:ok, [token|_], _} = "1" |> to_char_list |> :json_lexer.string
    assert {:int, 1, 1} == token

    {:ok, [token|_], _} = "1.5" |> to_char_list |> :json_lexer.string
    assert {:float, 1, 1.5} == token
  end

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
