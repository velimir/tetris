# Tetris Game

This Elixir project implements a Tetris game engine and provides a Mix task that plays Tetris according to the given inputs, outputting the final grid height for each game.

## Installation

1. **Install Elixir**:
   Follow the [official Elixir installation guide](https://elixir-lang.org/install.html) for your operating system.

2. Install dependencies (if any):

    ```bash
    mix deps.get
    ```

4. Compile the project:

    ```bash
    mix compile
    ```


## Running the Game

To run the game and output the final grid height for each game input, use the following command, where `input.txt` contains the game inputs:

    ```bash
    mix tetris.play < input.txt
    ```

### Example Input Format:

Each line of the input file should be a comma-separated list of tetromino shapes and the column in which they should be placed:

```
I0,I4,Q8
I0,I4,Q8,I0,I4
L0,J2,L4,J6,Q8
```


### Example Usage:

mix tetris.play < input.txt

Example Output:

```
1
0
2
```


## How it Works

### `Tetris` Module

The Tetris module serves as the entry point to the game. It provides a `play/2` function that takes a list of inputs (a list of `Input` structs) and processes them to return the final game grid.

**Inputs**: Each input consists of a tetromino and the column where it should be placed. The `Input.new/2` function can be used to instantiate the inputs.
**Non-cascading Mode**: The game engine doesn't cascade rows when they are cleared. Rows above a cleared row remain in place.
**Input/output Handling**: The Tetris module does not handle input or output. This is managed by the calling module, which, in this case, is the `Mix.Tasks.Tetris.Play` task.

#### `Tetris.Tetromino` Module

This module represents the tetrominoes used in the game. Each tetromino is defined as a sequence of bits, which makes operations like shifting, dropping, and clearing easier to handle.

**Bitwise Operations**: Tetrominoes are manipulated using bitwise operations. Please see the source code for more details.

**Shape Representation**:
The tetromino shapes are represented as binary masks. For instance, the Q tetromino is represented as:

```
1100000000000000
1100000000000000
```

### `Tetris.Grid` Module

This module defines the game grid. The grid is represented as a large integer where each bit represents a cell. The size of the grid is limited to 10 columns (represented by 16 bits per row).
Since the size is fixed to 10 columns it was decided to use a 16-bit integer to represent the grid to simplify the implementation.
