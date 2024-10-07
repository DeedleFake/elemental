defmodule Elemental.Games do
  @moduledoc """
  A game of Elemental. Tracks board state, takes turns, and checks win
  conditions.
  """

  defdelegate child_spec(spec), to: Elemental.Games.Supervisor

  defdelegate start_game(), to: Elemental.Games.Supervisor
end
