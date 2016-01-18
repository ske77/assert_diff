defmodule AssertDiff do

  defp random_hex do
    :crypto.strong_rand_bytes(8)
    |> :erlang.bitstring_to_list
    |> Enum.map(fn (x) -> :erlang.integer_to_binary(x, 16) end)
    |> Enum.join
  end

  defmacro assert_diff({operator, meta, [left, right]} = expr) when operator == :== do
    working_directory = System.cwd <> "/tmp/"

    a_path = working_directory <> random_hex
    b_path = working_directory <> random_hex

    quote do
      left  = unquote(left)
      right = unquote(right)

      a_path = unquote(a_path)
      b_path = unquote(b_path)

      File.open(a_path, [:write], fn(f) -> IO.write(f, left) end)
      File.open(b_path, [:write], fn(f) -> IO.write(f, right) end)

      case System.cmd("git", ["diff", "--color", "--no-index", a_path, b_path]) do
        { output, 1 } ->

          output = output
                   |> String.split("\n")
                   |> Enum.slice(4..-1)
                   |> Enum.join("\n")

          assert false, message: "\nassert diff failed:\n\n" <> output

        { "", 0 } -> :ok
      end

      File.rm!(a_path)
      File.rm!(b_path)

    end
  end


end
