defmodule Monitor do

    def monitor(state) do
        receive do
            {:request, from} ->
                updated = critical(state)
                send(from, :ok)
                monitor(updated)
        end
    end
end
