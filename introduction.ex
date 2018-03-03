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
    # len with accumulator
    def len_acc(list) do
        len_acc(list, 0)
    end
    def len_acc([], acc) do acc end
    def len_acc([h|t], acc) do
        len_acc(t, acc + 1)
    end

    # Sum
    def sum([]) do 0 end
    def sum([h|t]) do
        h + sum(t)
    end

    # Sum with accumulator
    def sum_acc(list) do
        sum_acc(list, 0)
    end
    def sum_acc([], acc) do acc end
    def sum_acc([h|t], acc) do
        sum_acc(t, acc+h)
    end

    # Duplicate
    def duplicate([]) do [] end
    def duplicate([h|t]) do
        [h, h | duplicate(t)]
    end

    # Add function, very clever IMO
    # This will only happen if x is not in the list, because it came to the end and x != h
    def add(x, []) do [x] end
     # If x and one element (the head) was equal, just return a list with x once (not added), and add reccursion will not keep going
    def add(x, [x|t]) do [x | t] end
    def add(x, [h|t]) do
        [h | add(x, t)]
    end
end