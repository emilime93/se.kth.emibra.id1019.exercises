defmodule Sem do

    def semaphore(0) do
        receive do
            :release ->
                semaphore(1)
        end
    end

    def semaphore(n) do
        receive do
            {:request, from} ->
                send(from, :granted)
                semaphore(n - 1)
            :release ->
                semaphore(n + 1)
        end
    end

    def request(semaphore) do
        send(semaphore, {:request, self()})
        receive do
            :granted ->
                :ok
        end
    end

    def release(semaphore) do
        send(semaphore, :release)
    end

    # Spawn > instances of testrun then "charges" of the semaphore to see it in action
    def testrun(sem) do
        case request(sem) do
            :ok ->
                IO.puts "doing things"
                :timer.sleep(5000)
        end
        release(sem)
    end

end
