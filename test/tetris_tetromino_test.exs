defmodule Tetris.TetrominoTest do
  use ExUnit.Case, async: true

  alias Tetris.Tetromino

  test "shape definitions" do
    assert "1111000000000000" == to_string(Tetromino.I.new())

    assert String.trim("""
           0100000000000000
           0100000000000000
           1100000000000000
           """) == to_string(Tetromino.J.new())

    assert String.trim("""
           1100000000000000
           1100000000000000
           """) == to_string(Tetromino.Q.new())
  end

  test "shift tetrominoes by N columns" do
    assert String.trim("""
           0110000000000000
           0110000000000000
           """) == to_string(Tetromino.shift(Tetromino.Q.new(), 1))

    assert String.trim("""
           0000000001000000
           0000000001000000
           0000000011000000
           """) == to_string(Tetromino.shift(Tetromino.J.new(), 8))
  end

  test "drop tetromino by N rows" do
    {:ok, tetromino} =
      Tetromino.drop(
        Tetromino.new("""
        0110000000000000
        0110000000000000
        0000000000000000
        """),
        1
      )

    assert String.trim("""
           0110000000000000
           0110000000000000
           """) == to_string(tetromino)

    {:ok, tetromino} =
      Tetromino.drop(
        Tetromino.new("""
        0110000000000000
        0110000000000000
        0000000000000000
        0000000000000000
        0000000000000000
        """),
        3
      )

    assert String.trim("""
           0110000000000000
           0110000000000000
           """) == to_string(tetromino)
  end

  test "drop when bottom reached" do
    {:error, :no_space} =
      Tetromino.drop(
        Tetromino.new("""
        0110000000000000
        0110000000000000
        """),
        1
      )

    {:error, :no_space} =
      Tetromino.drop(
        Tetromino.new("""
        0110000000000000
        """),
        3
      )
  end

  test "elevate by 1" do
    tetromino =
      Tetromino.elevate(
        Tetromino.new("""
        0001100000000000
        0000110000000000
        """),
        1
      )

    assert String.trim("""
           0001100000000000
           0000110000000000
           0000000000000000
           """) == to_string(tetromino)
  end
end
