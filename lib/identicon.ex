defmodule Identicon do
  @moduledoc """
    This module generates an identicon based on a input string
  """

  @doc """
    Identicon generation entry point
  """
  def main(input) do
    input
    |> create_number_list
    |> create_image_struct
  end

  @doc """
    Creates a list of 16 bytes in numeric format (0 to 255).
  """
  def create_number_list(input_string) do
    input_string
    |> :erlang.md5
    |> :binary.bin_to_list
  end

  @doc """
    Creates a Identicon.Image struct.
    colors consist of a list of [red, green, blue]-values ranging from 0 to 255.
    values consist of grid values.
  """
  def create_image_struct(numeric_byte_list) do
    [red, green, blue | _tail ] = numeric_byte_list
    colors = [red, green, blue]
    grid = build_grid(numeric_byte_list)
    %Identicon.Image{colors: colors, grid: grid}
  end

  @doc """
    Creates a grid from a numeric list.
    The first and second value is reversed and appended to the list
  """
  def build_grid(number_list) do
    chunks = Enum.chunk(number_list, 3)
    for chunk <- chunks do
      [first, second, _tail] = chunk
      chunk ++ [second, first]
    end
  end
end
