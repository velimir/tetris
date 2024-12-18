defmodule TetrisTest do
  # TODO: make it pretty, remove code duplication
  use ExUnit.Case, async: true

  alias Tetris.{Input, Tetromino, Grid}

  test "I0,I4,Q8" do
    grid =
      Tetris.play([
        %Input{tetromino: Tetromino.I.new(), column: 0},
        %Input{tetromino: Tetromino.I.new(), column: 4},
        %Input{tetromino: Tetromino.Q.new(), column: 8}
      ])

    assert String.trim("""
           0000000011000000
           """) == to_string(grid)

    assert 1 == Grid.height(grid)
  end

  test "T1,Z3,I4" do
    grid =
      Tetris.play([
        %Input{tetromino: Tetromino.T.new(), column: 1},
        %Input{tetromino: Tetromino.Z.new(), column: 3},
        %Input{tetromino: Tetromino.I.new(), column: 4}
      ])

    assert String.trim("""
           0000111100000000
           0001100000000000
           0111110000000000
           0010000000000000
           """) == to_string(grid)

    assert 4 == Grid.height(grid)
  end

  test "Q0,I2,I6,I0,I6,I6,Q2,Q4" do
    grid =
      Tetris.play([
        %Input{tetromino: Tetromino.Q.new(), column: 0},
        %Input{tetromino: Tetromino.I.new(), column: 2},
        %Input{tetromino: Tetromino.I.new(), column: 6},
        %Input{tetromino: Tetromino.I.new(), column: 0},
        %Input{tetromino: Tetromino.I.new(), column: 6},
        %Input{tetromino: Tetromino.I.new(), column: 6},
        %Input{tetromino: Tetromino.Q.new(), column: 2},
        %Input{tetromino: Tetromino.Q.new(), column: 4}
      ])

    assert String.trim("""
           0011000000000000
           0011000000000000
           1100111111000000
           """) == to_string(grid)

    assert 3 == Grid.height(grid)
  end

  test "Q0" do
    grid =
      Tetris.play([
        %Input{tetromino: Tetromino.Q.new(), column: 0}
      ])

    assert String.trim("""
           1100000000000000
           1100000000000000
           """) == to_string(grid)

    assert 2 == Grid.height(grid)
  end

  test "Q0,Q1" do
    grid =
      Tetris.play([
        %Input{tetromino: Tetromino.Q.new(), column: 0},
        %Input{tetromino: Tetromino.Q.new(), column: 1}
      ])

    assert String.trim("""
           0110000000000000
           0110000000000000
           1100000000000000
           1100000000000000
           """) == to_string(grid)

    assert 4 == Grid.height(grid)
  end

  test "Q0,Q2,Q4,Q6,Q8" do
    grid =
      Tetris.play([
        %Input{tetromino: Tetromino.Q.new(), column: 0},
        %Input{tetromino: Tetromino.Q.new(), column: 2},
        %Input{tetromino: Tetromino.Q.new(), column: 4},
        %Input{tetromino: Tetromino.Q.new(), column: 6},
        %Input{tetromino: Tetromino.Q.new(), column: 8}
      ])

    assert String.trim("""
                     0000000000000000
           """) == to_string(grid)

    assert 0 == Grid.height(grid)
  end

  test "Q0,Q2,Q4,Q6,Q8,Q1" do
    grid =
      Tetris.play([
        %Input{tetromino: Tetromino.Q.new(), column: 0},
        %Input{tetromino: Tetromino.Q.new(), column: 2},
        %Input{tetromino: Tetromino.Q.new(), column: 4},
        %Input{tetromino: Tetromino.Q.new(), column: 6},
        %Input{tetromino: Tetromino.Q.new(), column: 8},
        %Input{tetromino: Tetromino.Q.new(), column: 1}
      ])

    assert String.trim("""
           0110000000000000
           0110000000000000
           """) == to_string(grid)

    assert 2 == Grid.height(grid)
  end

  test "Q0,Q2,Q4,Q6,Q8,Q1,Q1" do
    grid =
      Tetris.play([
        %Input{tetromino: Tetromino.Q.new(), column: 0},
        %Input{tetromino: Tetromino.Q.new(), column: 2},
        %Input{tetromino: Tetromino.Q.new(), column: 4},
        %Input{tetromino: Tetromino.Q.new(), column: 6},
        %Input{tetromino: Tetromino.Q.new(), column: 8},
        %Input{tetromino: Tetromino.Q.new(), column: 1},
        %Input{tetromino: Tetromino.Q.new(), column: 1}
      ])

    assert String.trim("""
           0110000000000000
           0110000000000000
           0110000000000000
           0110000000000000
           """) == to_string(grid)

    assert 4 == Grid.height(grid)
  end

  test "I0,I4,Q8,I0,I4" do
    grid =
      Tetris.play([
        %Input{tetromino: Tetromino.I.new(), column: 0},
        %Input{tetromino: Tetromino.I.new(), column: 4},
        %Input{tetromino: Tetromino.Q.new(), column: 8},
        %Input{tetromino: Tetromino.I.new(), column: 0},
        %Input{tetromino: Tetromino.I.new(), column: 4}
      ])

    assert String.trim("""
           0000000000000000
           """) == to_string(grid)

    assert 0 == Grid.height(grid)
  end

  test "L0,J2,L4,J6,Q8" do
    grid =
      Tetris.play([
        %Input{tetromino: Tetromino.L.new(), column: 0},
        %Input{tetromino: Tetromino.J.new(), column: 2},
        %Input{tetromino: Tetromino.L.new(), column: 4},
        %Input{tetromino: Tetromino.J.new(), column: 6},
        %Input{tetromino: Tetromino.Q.new(), column: 8}
      ])

    assert String.trim("""
           1001100100000000
           1001100111000000
           """) == to_string(grid)

    assert 2 == Grid.height(grid)
  end

  test "L0,Z1,Z3,Z5,Z7" do
    grid =
      Tetris.play([
        %Input{tetromino: Tetromino.L.new(), column: 0},
        %Input{tetromino: Tetromino.Z.new(), column: 1},
        %Input{tetromino: Tetromino.Z.new(), column: 3},
        %Input{tetromino: Tetromino.Z.new(), column: 5},
        %Input{tetromino: Tetromino.Z.new(), column: 7}
      ])

    assert String.trim("""
           1000000000000000
           1111111110000000
           """) == to_string(grid)

    assert 2 == Grid.height(grid)
  end

  test "T0,T3" do
    grid =
      Tetris.play([
        %Input{tetromino: Tetromino.T.new(), column: 0},
        %Input{tetromino: Tetromino.T.new(), column: 3}
      ])

    assert String.trim("""
           1111110000000000
           0100100000000000
           """) == to_string(grid)

    assert 2 == Grid.height(grid)
  end

  test "T0,T3,I6,I6" do
    grid =
      Tetris.play([
        %Input{tetromino: Tetromino.T.new(), column: 0},
        %Input{tetromino: Tetromino.T.new(), column: 3},
        %Input{tetromino: Tetromino.I.new(), column: 6},
        %Input{tetromino: Tetromino.I.new(), column: 6}
      ])

    assert String.trim("""
           0100101111000000
           """) == to_string(grid)

    assert 1 == Grid.height(grid)
  end

  test "I0,I6,S4" do
    grid =
      Tetris.play([
        %Input{tetromino: Tetromino.I.new(), column: 0},
        %Input{tetromino: Tetromino.I.new(), column: 6},
        %Input{tetromino: Tetromino.S.new(), column: 4}
      ])

    assert String.trim("""
           0000011000000000
           """) == to_string(grid)

    assert 1 == Grid.height(grid)
  end

  test "L0,J3,L5,J8,T1" do
    grid =
      Tetris.play([
        %Input{tetromino: Tetromino.L.new(), column: 0},
        %Input{tetromino: Tetromino.J.new(), column: 3},
        %Input{tetromino: Tetromino.L.new(), column: 5},
        %Input{tetromino: Tetromino.J.new(), column: 8},
        %Input{tetromino: Tetromino.T.new(), column: 1}
      ])

    assert String.trim("""
           1000110001000000
           1111110001000000
           1111111011000000
           """) == to_string(grid)

    assert 3 == Grid.height(grid)
  end

  test "L0,J3,L5,J8,T1,T6" do
    grid =
      Tetris.play([
        %Input{tetromino: Tetromino.L.new(), column: 0},
        %Input{tetromino: Tetromino.J.new(), column: 3},
        %Input{tetromino: Tetromino.L.new(), column: 5},
        %Input{tetromino: Tetromino.J.new(), column: 8},
        %Input{tetromino: Tetromino.T.new(), column: 1},
        %Input{tetromino: Tetromino.T.new(), column: 6}
      ])

    assert String.trim("""
           1000110001000000
           """) == to_string(grid)

    assert 1 == Grid.height(grid)
  end

  test "L0,J3,L5,J8,T1,T6,J2,L6,T0,T7" do
    grid =
      Tetris.play([
        %Input{tetromino: Tetromino.L.new(), column: 0},
        %Input{tetromino: Tetromino.J.new(), column: 3},
        %Input{tetromino: Tetromino.L.new(), column: 5},
        %Input{tetromino: Tetromino.J.new(), column: 8},
        %Input{tetromino: Tetromino.T.new(), column: 1},
        %Input{tetromino: Tetromino.T.new(), column: 6},
        %Input{tetromino: Tetromino.J.new(), column: 2},
        %Input{tetromino: Tetromino.L.new(), column: 6},
        %Input{tetromino: Tetromino.T.new(), column: 0},
        %Input{tetromino: Tetromino.T.new(), column: 7}
      ])

    assert String.trim("""
           0001001000000000
           1111001111000000
           """) == to_string(grid)

    assert 2 == Grid.height(grid)
  end

  test "L0,J3,L5,J8,T1,T6,J2,L6,T0,T7,Q4" do
    grid =
      Tetris.play([
        %Input{tetromino: Tetromino.L.new(), column: 0},
        %Input{tetromino: Tetromino.J.new(), column: 3},
        %Input{tetromino: Tetromino.L.new(), column: 5},
        %Input{tetromino: Tetromino.J.new(), column: 8},
        %Input{tetromino: Tetromino.T.new(), column: 1},
        %Input{tetromino: Tetromino.T.new(), column: 6},
        %Input{tetromino: Tetromino.J.new(), column: 2},
        %Input{tetromino: Tetromino.L.new(), column: 6},
        %Input{tetromino: Tetromino.T.new(), column: 0},
        %Input{tetromino: Tetromino.T.new(), column: 7},
        %Input{tetromino: Tetromino.Q.new(), column: 4}
      ])

    assert String.trim("""
           0001111000000000
           """) == to_string(grid)

    assert 1 == Grid.height(grid)
  end

  test "S0,S2,S4,S6" do
    grid =
      Tetris.play([
        %Input{tetromino: Tetromino.S.new(), column: 0},
        %Input{tetromino: Tetromino.S.new(), column: 2},
        %Input{tetromino: Tetromino.S.new(), column: 4},
        %Input{tetromino: Tetromino.S.new(), column: 6}
      ])

    assert String.trim("""
           0000000110000000
           0000001100000000
           0000011000000000
           0000110000000000
           0001100000000000
           0011000000000000
           0110000000000000
           1100000000000000
           """) == to_string(grid)

    assert 8 == Grid.height(grid)
  end

  test "S0,S2,S4,S5,Q8,Q8,Q8,Q8,T1,Q1,I0,Q4" do
    grid =
      Tetris.play([
        %Input{tetromino: Tetromino.S.new(), column: 0},
        %Input{tetromino: Tetromino.S.new(), column: 2},
        %Input{tetromino: Tetromino.S.new(), column: 4},
        %Input{tetromino: Tetromino.S.new(), column: 5},
        %Input{tetromino: Tetromino.Q.new(), column: 8},
        %Input{tetromino: Tetromino.Q.new(), column: 8},
        %Input{tetromino: Tetromino.Q.new(), column: 8},
        %Input{tetromino: Tetromino.Q.new(), column: 8},
        %Input{tetromino: Tetromino.T.new(), column: 1},
        %Input{tetromino: Tetromino.Q.new(), column: 1},
        %Input{tetromino: Tetromino.I.new(), column: 0},
        %Input{tetromino: Tetromino.Q.new(), column: 4}
      ])

    assert String.trim("""
           0000110000000000
           0110011011000000
           0110011011000000
           0111110011000000
           0011100011000000
           0011000011000000
           0110000011000000
           1100000011000000
           """) == to_string(grid)

    assert 8 == Grid.height(grid)
  end

  test "L0,J3,L5,J8,T1,T6,S2,Z5,T0,T7" do
    grid =
      Tetris.play([
        %Input{tetromino: Tetromino.L.new(), column: 0},
        %Input{tetromino: Tetromino.J.new(), column: 3},
        %Input{tetromino: Tetromino.L.new(), column: 5},
        %Input{tetromino: Tetromino.J.new(), column: 8},
        %Input{tetromino: Tetromino.T.new(), column: 1},
        %Input{tetromino: Tetromino.T.new(), column: 6},
        %Input{tetromino: Tetromino.S.new(), column: 2},
        %Input{tetromino: Tetromino.Z.new(), column: 5},
        %Input{tetromino: Tetromino.T.new(), column: 0},
        %Input{tetromino: Tetromino.T.new(), column: 7}
      ])

    assert String.trim("""
           0000000000000000
           """) == to_string(grid)

    assert 0 == Grid.height(grid)
  end
end
