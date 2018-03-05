defmodule Deriv do

    @type literal() :: {:const, number()}
                    | {:const, atom()}
                    | {:var, atom()}
    @type expr() :: {:add, expr(), expr()}
                    | {:mul, expr(), expr()}
                    | literal()

    def start() do
        f = {:add, {:mul, {:const, 2}, {:var, :x}}, {:const, 3}}
        deriv(f, :x)
    end

    def deriv({:const, _}, _) do
        {:const, 0}
    end

    def deriv({:var, v}, v) do
        {:const, 1}
    end

    def deriv({:var, y}, _) do
        {:var, y}
    end

    def deriv({:mul, e1, e2}, v) do
        {:add, {:mul, deriv(e1, v), e2}, {:mul, e1, deriv(e2, v)}}
    end

    def deriv({:add, e1, e2}, v) do
        {:add, deriv(e1, v), deriv(e2, v)}
    end


end
