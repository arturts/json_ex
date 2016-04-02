defmodule JsonEx do
  @spec parse(binary) :: List
  def parse(str) do
    {:ok, tokens, _} = str |> to_char_list |> :json_lexer.string
    {:ok, list}      = :json_parser.parse(tokens)
    list
  end
end
