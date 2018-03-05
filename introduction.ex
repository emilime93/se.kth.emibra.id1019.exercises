defmodule Intro do
    
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
    def nth(1, [h|_]) do h end
    def nth(n, [_|t]) do
        nth(n-1, t)
    end

    # len
    def len([]) do 0 end
    def len([_|t]) do
        1 + len(t)
    end
    # len with accumulator
    def len_acc(list) do
        len_acc(list, 0)
    end
    def len_acc([], acc) do acc end
    def len_acc([_|t], acc) do
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
    # And in the oter case, if x and h are not equal, the reccursion will build a list with h and add (x, t)
    def add(x, [h|t]) do
        [h | add(x, t)]
    end

    # Remove all occurrences if x from list
    def remove(_, []) do [] end
    def remove(x, [x|t]) do
        remove(x, t)
    end
    def remove(x, [h|t]) do
        [h | remove(x, t)]
    end
    
    # Unique
    def unique([]) do [] end
    def unique([h|t]) do
        [h | unique(remove(h, t))]
    end

    # Pack
    # Test data: [:a,:a,:b,:c,:b,:a,:c]
    def pack([]) do [] end
    def pack([h|t]) do
        [create_n_list(h, num_occ(h, t)+1) | pack(remove(h, t))]
    end

    # Helper to "Pack"
    # creates a list with n number of x
    def create_n_list(x, 1) do [x] end
    def create_n_list(x, n) do
        [x | create_n_list(x, n-1)]
    end

    # Helper to "Pack"
    # Returns the number of occurrences of x in list
    def num_occ(_, []) do 0 end
    def num_occ(x, [x|t]) do
        1 + num_occ(x, t)
    end
    def num_occ(x, [_|t]) do
        num_occ(x, t)
    end

    # Reverse, this is naive and is 0(n^2)
    def reverse([]) do [] end
    def reverse([h|t]) do
        reverse(t) ++ [h]
    end

    # Better revese, which is O(n)
    def reverse_good(list) do reverse_good(list, []) end
    def reverse_good([], r) do r end
    def reverse_good([h|t], r) do
        reverse_good(t, [h]++r)
    end

    # insert function that inserts a element into the right place in a list
    def insert(ele, []) do [ele] end
    def insert(ele, [h|t]) do
        if ele < h do
            [ele] ++ [h|t]
        else
            [h|insert(ele, t)]
        end
    end

    # Insertion Sort function that uses the insert function above
    def insertion_sort(list) do insertion_sort([], list) end

    def insertion_sort(list, []) do list end
    def insertion_sort([],[]) do [] end
    def insertion_sort([], [h|t]) do
        insertion_sort(insert(h, []), t)
    end
    def insertion_sort(list, [h|t]) do
        insertion_sort(insert(h, list), t)
    end

    # Merge sort
    def merge_sort([]) do [] end
    def merge_sort([h]) do [h] end
    def merge_sort(list) do
        {l1, l2} = msplit(list)
        merge(merge_sort(l1), merge_sort(l2))
    end

    # Split/1 helper function
    def msplit([]) do [] end
    def msplit(list) do
        msplit(list, [], [])
    end
    # split/2
    def msplit([h|t], l1, l2) do
        msplit(t, [h] ++ l2, l1)
    end
    def msplit([], l1, l2) do
        {l1, l2}
    end

    def merge([], l2) do l2 end
    def merge(l1, []) do l1 end
    def merge([h1|t1], [h2|t2]) do
        if h1 < h2 do
            [h1] ++ merge(t1, [h2|t2])
        else
            [h2] ++ merge([h1|t1], t2)
        end
    end

    def qsort([p|l]) do
        {l1, l2} = partition(p, l, [], [])
        small = qsort(l1)
        large = qsort(l2)
        append(small ,[p|large])
    end
end