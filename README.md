# Elixir's assert_diff

Simple Elixir's `assert_diff` for strings which fallbacks to `git diff`.

It works ONLY within git repo.

## Installation

  1. Add assert_diff to your list of dependencies in `mix.exs`:

        def deps do
          [{:assert_diff, "~> 0.0.2"}]
        end

  2. Import it to your test case:

        import AssertDiff

  3. Make sure that you have tmp directory: your_app/tmp


  4. Use it:

        test "some test goes here" do
          assert_diff "Cat" == "Dog"
        end
