defmodule Introduction do
    
    # Product with addition
    def product(0, _) do 0 end
    def product(m, n) do
        n + product(m - 1, n)
    end

    # Product with addition, case
    def product_case(m, n) do
        case m do
            0 ->
                0
            _ ->
                product(m-1, n) + n            
        end
    end

    # Exponential function
    def exp(_, 0) do 1 end
    def exp(x, y) do
        product(x, exp(x, y-1))
    end

    # Exponential with case...
    def exp_case(x, y) do
        case y do
            0 ->
                1
            _ ->
                product(x, exp_case(x, y-1))
        end
    end

    # Faster exponential
    def exp_fast(x, 1) do x end
    def exp_fast(x, y) do
        case rem(y, 2) do
            0 ->
                exp_fast(x, div(y,2)) * exp_fast(x, div(y,2))
            1 ->
                exp_fast(x, y-1) * x
        end
    end

    # ================ LISTS ================ #
    # nth element
    def nth(_, []) do nil end
    def nth(1, [h|t]) do h end
    def nth(n, [h|t]) do
        nth(n-1, t)
    end

    # len
    def len([]) do 0 end
    def len([h|t]) do
        1 + len(t)
    end
    # len with acc
    def len_acc([]) do 0 end
    def len_acc(list) do
        len
    end
    def len_acc([h|t], acc) do
        
    end
end