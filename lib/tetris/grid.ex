defmodule Tetris.Grid do
  @moduledoc """
  The game grid. It is defined as a big integer where each bit represents a cell
  in the grid. Since the grid size is limited to 10 cells, a 16-bit integer per row
  is enough to represent the whole grid. The padding is used to simply the work
  with binaries/bitstrings further on.
  """
  alias Tetris.{Grid, Tetromino}

  import Bitwise

  defstruct [:mask]

  # 1111111111000000
  @full_row <<65472::16>>

  @type t :: %__MODULE__{mask: integer}

  @spec new() :: t()
  def new(), do: %Grid{mask: 0}

  @spec new(String.t()) :: t()
  def new(binary_mask) do
    int_mask = Tetris.Mask.parse(binary_mask)

    %Grid{mask: int_mask}
  end

  @spec height(t) :: integer
  def height(%Grid{mask: 0}), do: 0
  def height(grid), do: ceil(byte_size(:binary.encode_unsigned(grid.mask)) / 2)

  @doc """
  Drops a tetromino on the grid.

  The function will try to drop the tetromino as far down as possible. If the
  tetromino collides with either the bottom of the grid or another tetromino,
  the termino will be added to the furthest possible position.
  """
  @spec drop(t, Tetromino.t) :: {:ok, t} | {:error, :collision}
  def drop(grid, tetromino) do
    with {:ok, tetromino} <- Tetromino.drop(tetromino, 1),
         {:ok, _grid} <- add(grid, tetromino) do
      drop(grid, tetromino)
    else
      {:error, :no_space} ->
        case add(grid, tetromino) do
          {:ok, grid} ->
            {:ok, grid}

          {:error, :collision} ->
            add(grid, Tetromino.elevate(tetromino, 1))
        end

      {:error, :collision} ->
        add(grid, tetromino)
    end
  end

  @doc """
  Tries to add a tetromino to the grid.

  If the tetromino collides with another tetromino, the function will return
  `{:error, :collision}`.
  """
  @spec add(t, Tetromino.t) :: {:ok, t} | {:error, :collision}
  def add(grid, tetromino) do
    tetromino_mask = tetromino.mask
    new_grid_mask = grid.mask ||| tetromino_mask

    # bnot as unsigned integer with a fixed number of bytes
    bytes = byte_size(:binary.encode_unsigned(new_grid_mask))
    neg_grid_mask = bnot(grid.mask) &&& (1 <<< (bytes * 8)) - 1

    case neg_grid_mask &&& new_grid_mask do
      ^tetromino_mask ->
        {:ok, %Grid{mask: new_grid_mask}}

      _ ->
        {:error, :collision}
    end
  end

  @doc """
  Clears full rows from the grid.
  """
  @spec clear_rows(t) :: t
  def clear_rows(%Grid{mask: mask}) do
    encoded_mask =
      case :binary.encode_unsigned(mask) do
        encoded when rem(byte_size(encoded), 2) == 0 ->
          encoded

        encoded ->
          <<0, encoded::binary>>
      end

    mask =
      encoded_mask
      |> clear_rows(<<>>)
      |> :binary.decode_unsigned()

    %Grid{mask: mask}
  end

  defp clear_rows(<<>>, acc), do: acc
  defp clear_rows(<<@full_row, rest::binary>>, acc), do: clear_rows(rest, acc)
  defp clear_rows(<<row::16, rest::binary>>, acc), do: clear_rows(rest, <<acc::binary, row::16>>)

  defimpl String.Chars do
    def to_string(%Grid{mask: mask}),
      do: Tetris.Mask.to_string(mask)
  end
end
