defmodule AssertDiff do

  defp random_hex do
    :crypto.strong_rand_bytes(8)
    |> :erlang.bitstring_to_list
    |> Enum.map(fn (x) -> :erlang.integer_to_binary(x, 16) end)
    |> Enum.join
  end

  defmacro assert_diff({operator, meta, [left, right]} = expr) when operator == :== do
    _expr = Macro.escape(expr)
    call = {operator, meta, [Macro.var(:left, __MODULE__), Macro.var(:right, __MODULE__)]}

    working_directory = System.cwd <> "/"

    a_path = working_directory <> random_hex
    b_path = working_directory <> random_hex

    quote do
      left  = unquote(left)
      right = unquote(right)

      a_path = unquote(a_path)
      b_path = unquote(b_path)

      File.open(a_path, [:write], fn(f) -> IO.write(f, left) end)
      File.open(b_path, [:write], fn(f) -> IO.write(f, right) end)

      { output, 1} = System.cmd("git", ["diff", "--color", "--no-index", a_path, b_path])

      File.rm!(a_path)
      File.rm!(b_path)

      output = output
                |> String.split("\n")
                |> Enum.slice(4..-1)
                |> Enum.join("\n")

      assert unquote(call), message: "\nassert diff failed:\n\n" <> output
    end
  end


end
