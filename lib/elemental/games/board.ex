defmodule Elemental.Games.Board do
  @empty :array.new(6, default: :array.new(6, default: :empty))

  defstruct pieces: @empty
end
