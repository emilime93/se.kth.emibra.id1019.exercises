defmodule Introduction do
    
    # Product with addition
    def product(0, _) do 0 end
    def product(m, n) do
        n + product(m - 1, n)
    end

    # Product with addition, case
    def case_product(m, n) do
        case m do
            0 ->
                0
            _ ->
                product(m-1, n) + n            
        end
    end

    #Exponential function
    def exp(_, 0) do 1 end
    def exp(x, y) do
        product(x, exp(x, y-1))
    end
end