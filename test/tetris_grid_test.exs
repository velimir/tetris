defmodule Tetris.GridTest do
  use ExUnit.Case, async: true

  alias Tetris.{Grid, Tetromino}

  test "add to an empty grid" do
    {:ok, grid} =
      Grid.add(
        Grid.new(),
        Tetromino.new("""
        1100000000000000
        1100000000000000
        """)
      )

    assert String.trim("""
           1100000000000000
           1100000000000000
           """) == to_string(grid)
  end

  test "add to grid with some space for a tetromino" do
    {:ok, grid} =
      Grid.add(
        Grid.new("""
        1100000000000000
        """),
        Tetromino.new("""
        0011000000000000
        0011000000000000
        0000000000000000
        """)
      )

    assert String.trim("""
           0011000000000000
           0011000000000000
           1100000000000000
           """) == to_string(grid)
  end

  test "add to grid with some space for a tetromino, with no elevation" do
    {:ok, grid} =
      Grid.add(
        Grid.new("""
        1100000000000000
        """),
        Tetromino.new("""
        0011000000000000
        0011000000000000
        """)
      )

    assert String.trim("""
           0011000000000000
           1111000000000000
           """) == to_string(grid)
  end

  test "add to grid with some space for a tetromino between occupied cells" do
    {:ok, grid} =
      Grid.add(
        Grid.new("""
        0011001100000000
        """),
        Tetromino.new("""
        0011001100000000
        1100110011000000
        """)
      )

    assert String.trim("""
           0011001100000000
           1111111111000000
           """) == to_string(grid)
  end

  test "simple collision" do
    assert {:error, :collision} ==
             Grid.add(
               Grid.new("""
               1100000000000000
               """),
               Tetromino.new("""
               1111000000000000
               """)
             )
  end

  test "collision with a tetromino highter than a grid" do
    assert {:error, :collision} ==
             Grid.add(
               Grid.new("""
               1100000000000000
               """),
               Tetromino.new("""
               1111000000000000
               1111000000000000
               """)
             )
  end

  test "simple drop" do
    {:ok, grid} =
      Grid.drop(
        Grid.new("""
        1100000000000000
        """),
        Tetromino.new("""
        0011000000000000
        0011000000000000
        0000000000000000
        """)
      )

    assert String.trim("""
           0011000000000000
           1111000000000000
           """) == to_string(grid)
  end

  test "drop between cells" do
    {:ok, grid} =
      Grid.drop(
        Grid.new("""
        1100110000000000
        """),
        Tetromino.new("""
        0011000000000000
        0011000000000000
        0000000000000000
        """)
      )

    assert String.trim("""
           0011000000000000
           1111110000000000
           """) == to_string(grid)
  end

  test "drop into an empty grid" do
    {:ok, grid} =
      Grid.drop(
        Grid.new(),
        Tetromino.new("""
        0011000000000000
        0011000000000000
        0011000000000000
        """)
      )

    assert String.trim("""
           0011000000000000
           0011000000000000
           0011000000000000
           """) == to_string(grid)
  end

  test "drop into an empty grid elevated" do
    {:ok, grid} =
      Grid.drop(
        Grid.new(),
        Tetromino.new("""
        0011000000000000
        0011000000000000
        0000000000000000
        0000000000000000
        0000000000000000
        0000000000000000
        """)
      )

    assert String.trim("""
           0011000000000000
           0011000000000000
           """) == to_string(grid)
  end

  test "drop z on t" do
    {:ok, grid} =
      Grid.drop(
        Grid.new("""
        0111000000000000
        0010000000000000
        """),
        Tetromino.new("""
        0001100000000000
        0000110000000000
        0000000000000000
        0000000000000000
        """)
      )

    assert String.trim("""
           0001100000000000
           0111110000000000
           0010000000000000
           """) == to_string(grid)
  end

  test "clear rows" do
    grid =
      Grid.clear_rows(
        Grid.new("""
        0011000000000000
        0011000000000000
        1111111111000000
        1111111111000000
        1111111111000000
        1111111111000000
        """)
      )

    assert String.trim("""
           0011000000000000
           0011000000000000
           """) == to_string(grid)
  end

  test "clear rows, do not cascade" do
    grid =
      Grid.clear_rows(
        Grid.new("""
        0011000000000000
        0011000000000000
        1111111111000000
        1100111111000000
        1100111111000000
        1111111111000000
        """)
      )

    assert String.trim("""
           0011000000000000
           0011000000000000
           1100111111000000
           1100111111000000
           """) == to_string(grid)
  end
end
