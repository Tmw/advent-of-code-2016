defmodule Day11 do
  @moduledoc """
  - [x] The first floor contains a thulium generator, a thulium-compatible microchip, a plutonium generator, and a strontium generator.
  - [x] The second floor contains a plutonium-compatible microchip and a strontium-compatible microchip.
  - [x] The third floor contains a promethium generator, a promethium-compatible microchip, a ruthenium generator, and a ruthenium-compatible microchip.
  - [x] The fourth floor contains nothing relevant.
  """
  def solve do
    state = get_initial_state()
    search([state])
  end

  # Breadth First Search
  def search(current, visited \\ MapSet.new())
  def search([], _visited), do: :end_not_found

  def search([current | rest] = _open, discovered) do
    cond do
      State.is_end?(current) ->
        # NOTE: For part A it should find it 31 hops in.
        {:found, current}

      MapSet.member?(discovered, current.hash) ->
        # seen this node already in a previous pass
        # ignore and continue with the tail of the open nodes.
        search(rest, discovered)

      true ->
        # new node; grab all its successors (connected nodes) and
        # drop the ones we for sure already saw.
        new_successors =
          current
          |> State.valid_next_states()
          |> Enum.reject(&MapSet.member?(discovered, &1.hash))

        # then add the current not to the list of discovered nodes
        # and recurse with the new list comprised of rest + successors
        discovered = MapSet.put(discovered, current.hash)
        search(rest ++ new_successors, discovered)
    end
  end

  def get_initial_state(part \\ :part_b)

  def get_initial_state(:part_a) do
    # hardcoded the initial state since parsing the input is not the challanging
    # part of this puzzle..
    %State{
      elevator_location: 0,
      floors: [
        Floor.new([
          %Generator{identifier: :thulium},
          %Microchip{identifier: :thulium},
          %Generator{identifier: :plutonium}
        ]),
        Floor.new([
          %Microchip{identifier: :plutonium},
          %Microchip{identifier: :strontium}
        ]),
        Floor.new([
          %Generator{identifier: :promethium},
          %Microchip{identifier: :promethium},
          %Generator{identifier: :ruthenium},
          %Microchip{identifier: :ruthenium}
        ]),
        Floor.new([])
      ]
    }
  end

  def get_initial_state(:part_b) do
    # hardcoded the initial state since parsing the input is not the challanging
    # part of this puzzle..
    %State{
      elevator_location: 0,
      floors: [
        Floor.new([
          %Generator{identifier: :thulium},
          %Microchip{identifier: :thulium},
          %Generator{identifier: :plutonium},
          %Generator{identifier: :strontium},
          %Microchip{identifier: :elerium},
          %Generator{identifier: :elerium},
          %Microchip{identifier: :dilithium},
          %Generator{identifier: :dilithium}
        ]),
        Floor.new([
          %Microchip{identifier: :plutonium},
          %Microchip{identifier: :strontium}
        ]),
        Floor.new([
          %Generator{identifier: :promethium},
          %Microchip{identifier: :promethium},
          %Generator{identifier: :ruthenium},
          %Microchip{identifier: :ruthenium}
        ]),
        Floor.new([])
      ]
    }
  end
end
