defmodule Tetris do
  @moduledoc """
  Tetris game engine.

  This module is the entry point of the game. It provides a `play/2` function
  that takes a list of inputs and returns the final state of the game grid.

  The state of the game is represented by a `Grid` struct that contains the
  current state of the game grid. The inputs are represented by a list of
  `Input` structs that contain the tetromino and the column where it should be
  placed.

  The game engine processes the inputs and updates the game grid accordingly.

  The engine doesn't handle the input/output operations. It's up to the caller
  to read the inputs and write the outputs.

  The game works in a non cascading mode, meaning that when a row is cleared,
  the rows above it are not moved down. The engine doens't support an ability to
  move the tetrominoes left or right or rotate them.
  """

  alias Tetris.{Grid, Tetromino, Engine}

  defmodule Input do
    defstruct [:tetromino, :column]

    @type t :: %__MODULE__{
            tetromino: Tetromino.t(),
            column: non_neg_integer()
          }

    def new(tetromino, column) do
      %__MODULE__{tetromino: tetromino, column: column}
    end
  end

  def play(inputs, grid \\ Grid.new()) do
    Enum.reduce(inputs, grid, fn input, grid ->
      Engine.process(grid, input)
    end)
  end
end
