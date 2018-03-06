defmodule Concurr do

    def hello do
        receive do
            x -> IO.puts("aaa! suprise, a message: #{x}")
            hello
        end
    end

    def listen do
        receive do
            {:ok, contents} ->
                IO.puts("Content: #{contents}")
                listen
            {:easter_egg, msg} ->
                IO.puts("WOLOLOOO")
                listen
            _ ->
                IO.puts "bye"
        end
    end
end
