defmodule Tetris.Tetromino do
  @moduledoc """
  The tetrominoes are represented as a sequence of bits where each bit
  represents a cell in the shape.

  The masks are aligned to the left hand side (most significant bits) of the
  integer and padded to 16 bits to simplify the work with binaries/bitstrings
  further on.

  For example the `q` tetromino is represented as:

      1100000000000000
      1100000000000000

  Whereas the `i` tetromino shifted by 1 column is:

      0111100000000000
  """
  import Bitwise

  defstruct [:mask]

  @type t :: %__MODULE__{mask: integer}

  @callback new() :: t()

  defmacro __using__(binary_mask) do
    quote do
      Module.put_attribute(
        __MODULE__,
        :mask,
        Tetris.Tetromino.new(unquote(binary_mask))
      )

      @behaviour Tetris.Tetromino

      @impl Tetris.Tetromino
      def new(), do: @mask
    end
  end

  @spec new() :: t
  def new(), do: %Tetris.Tetromino{mask: 0}

  @spec new(String.t()) :: t
  def new(binary_mask) do
    int_mask = Tetris.Mask.parse(binary_mask)

    %Tetris.Tetromino{mask: int_mask}
  end

  @doc "Shifts the tetromino by `column` columns."
  @spec shift(t, integer) :: t
  def shift(%Tetris.Tetromino{mask: mask}, column),
    do: %Tetris.Tetromino{mask: mask >>> column}

  @doc "Elevates the tetromino by `rows` rows."
  @spec elevate(t, integer) :: t
  def elevate(%Tetris.Tetromino{mask: mask}, rows),
    do: %Tetris.Tetromino{mask: mask <<< (rows * 16)}

  defguardp has_space(mask, rows) when ((1 <<< (rows * 16)) - 1 &&& mask) == 0

  @doc """
  Drops the tetromino by `rows` rows.

  If there is no space to drop the tetromino, it returns `{:error, :no_space}`.
  """
  @spec drop(t, integer) :: {:ok, t} | {:error, :no_space}
  def drop(%Tetris.Tetromino{mask: mask}, rows) when has_space(mask, rows),
    do: {:ok, %Tetris.Tetromino{mask: mask >>> (rows * 16)}}

  def drop(_tetromino, _rows), do: {:error, :no_space}

  defimpl String.Chars do
    def to_string(%Tetris.Tetromino{mask: mask}),
      do: Tetris.Mask.to_string(mask)
  end
end
