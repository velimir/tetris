defmodule Mix.Tasks.Tetris.Play do
  @moduledoc """
  Play tetris according to the given inputs. Writes the final grid height to the
  standard output for every line.

  The input is taken from the standard input, where each line is a
  comma-separated list of inputs.

  Each line of the input file is a comma-separated list. Each entry in the list
  is a single letter (from the set above) and a single-digit integer. The
  integer represents the left-most column of the grid that the shape occupies,
  starting from zero.

  Input example:

      I0,I4,Q8
      I0,I4,Q8,I0,I4
      L0,J2,L4,J6,Q8

  Usage:

      mix tetris.play < input.txt
  """

  alias Tetris.{Input, Tetromino}

  use Mix.Task

  @shortdoc "Produces the final grid height for each game"

  def run(_) do
    IO.stream(:stdio, :line)
    |> Stream.map(&line_to_inputs/1)
    |> Enum.each(fn input ->
      grid = Tetris.play(input)
      IO.puts(Tetris.Grid.height(grid))
    end)
  end

  defp line_to_inputs(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> Enum.map(fn input ->
      [shape, column] = String.split(input, "", trim: true)

      Input.new(
        Module.concat(Tetromino, shape).new(),
        String.to_integer(column)
      )
    end)
  end
end
