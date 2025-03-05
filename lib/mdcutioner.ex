defmodule Mdcutioner do
  @doc """
  very simple example that works just for a single line of code:

  md_code = ```elixir
  defmodule Mathmaticious do
    def add(a, b) do
      a + b
    end
  end
  ```

  Maria.Ollama.MDCutioner.md_parse(md_code) |> execute will output a new module

  """

  def md_parse(markdown) do
    {:ok, parsed, _} = EarmarkParser.as_ast(markdown)

    parsed
    |> Enum.map(fn {_tag, _, [{"code", [{"class", "elixir"}], [content], _}], _} -> content end)
    |> Enum.at(0)
  end

  def execute(code) do
    Code.eval_string(code)
  end

  def example do
    """
    ```elixir
    defmodule Mathmaticious do
      def add(a, b) do
        a + b
      end
    end
    ```
    """
    |> md_parse()
    |> execute()
  end
end
