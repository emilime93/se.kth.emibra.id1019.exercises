defmodule Listops do

    def take([], _) do [] end
    def take(_, 0) do [] end
    def take([h|t], n) do
        [h] ++ take(t, n-1)
    end

    def drop([], _) do [] end
    def drop(list, 0) do list end
    def drop([_h|t], n) do
        drop(t, n-1)
    end

    def append(list, []) do list end
    def append([], new) do new end
    def append([h|t], new) do
        [h] ++ append(t, new)
    end

    def member([], _) do false end
    def member([h|t], x) do
        if h == x do
            true
        else
            member(t, x)
        end
    end
end
