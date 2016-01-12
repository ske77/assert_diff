defmodule AssertDiff do

  defmacro assert_diff({operator, meta, [left, right]} = expr) when operator == :== do
    _expr = Macro.escape(expr)
    call = {operator, meta, [Macro.var(:left, __MODULE__), Macro.var(:right, __MODULE__)]}
    quote do
      try do
        left  = unquote(left)
        right = unquote(right)

        File.write("a", left)
        File.write("b", right)

        { output, 1} = System.cmd("git", ["diff", "--color", "--no-index", "a", "b"])

        output = output
          |> String.split("\n")
          |> Enum.slice(4..-1)
          |> Enum.join("\n")

        assert unquote(call), message: "\nassert diff failed:\n\n" <> output
      after
        File.rm("a")
        File.rm("b")
      end
    end
  end
end
