defmodule Tetris.Engine do
  @moduledoc """
  A module for processing game logic.

  This module contains the game engine that processes the inputs and updates the
  game grid accordingly.

  In a nutshell, the engine takes a grid and an input, and returns the updated
  grid after dropping the tetromino and clearing the rows.
  """

  alias Tetris.{Grid, Tetromino, Input}

  @spec process(Grid.t(), Input.t()) :: Grid.t()
  def process(grid, input) do
    tetromino =
      input.tetromino
      |> Tetromino.shift(input.column)
      |> Tetromino.elevate(Grid.height(grid))

    {:ok, grid} = Grid.drop(grid, tetromino)
    Grid.clear_rows(grid)
  end
end
