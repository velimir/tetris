defmodule Tetris.Mask do
  @moduledoc """
  A module for working with masks.

  Masks are used to represent tetrominoes as well as the grid.
  """

  @doc """
  Converts an integer to a binary string representation.

  Useful for debugging and testing.
  """
  @spec to_string(integer) :: String.t()
  def to_string(mask) do
    bin_str = Integer.to_string(mask, 2)
    target_width = ceil(String.length(bin_str) / 16) * 16

    bin_str
    |> String.pad_leading(target_width, "0")
    |> String.codepoints()
    |> Enum.chunk_every(16)
    |> Enum.map(&Enum.join(&1))
    |> Enum.join("\n")
  end

  @doc "Parses a binary string representation to an integer."
  @spec parse(String.t()) :: integer
  def parse(binary_mask) do
    binary_mask
    |> String.split("\n")
    |> Enum.map(&String.trim(&1))
    |> Enum.join("")
    |> :erlang.binary_to_integer(2)
  end
end
