"""
This is based on Think Julia book by Ben Lauwens and Allen Downey
- Chapter 10 Arrays
- Chapter 11 Dictionaries
- Chapter 12 Tuples

Notes
-----
 1. If a global variable refers to a mutable value, you can modify the value without declaring the variable global.


Tips on Working with Arrays
---------------------------
 1. Read the documentation and test the array function, before using it. Most of array functions modify the argument.
 2. Pick an idiom and stick with it.
 3. Make copies to avoid aliasing.

Tips on Working with Big Datasets
---------------------------------
 1. Usa a fraction of the actual input while gradually scaling up.
 2. Check summaries and types, e.g., the number of items in a dictionary.
 3. Write self-checks (sanity and consistency checks)
 4. Format the output for scaffolding

Glossary
--------
 - Reduce Operation: A processing pattern that traverses a sequence and accumulates the elements into a single result.
 - Map Operation: A processing pattern that traverses a sequence and performs an operation on each element.
 - Filter Operation: A processing pattern that traverses a sequence and selects the elements that satisfy some criterion.
 - Scaffolding: Code that is used during program development but is not part of the final version.
 - Mapping: A relationship in which each element of one set corresponds to an element of another set.
 - Hash Function: A function used by a hash table to compute the location for a key.
 - Lookup: A dictionary operation that takes a key and finds the corresponding value.
 - Reverse Lookup: A dictionary operation that takes a value and finds one or more keys that map to it.
 - Memo: A computed value stored to avoid unnecessary future computation.
 - Declaration: A statement like global that tells the interpreter something about a variable.
"""


# ARRAYS ----- ----- ----- ----- ----- 

# Arrays is a sequence of values
[10, 20, 30, 40]
["hello", "world"]
[[1,2], [2,3]]
[1, "a", true]

cheeses = ["Cheddar", "Edam", "Gouda"]
numbers = [42, 123]
empty = []

print(cheeses)
print(numbers)
print(empty)

print(typeof(cheeses))
print(typeof(numbers))
print(typeof(empty))


# Arrays are mutable
numbers[2] = 10;

print(numbers)
print(10 ∈ numbers)


# Traversing an array
for cheese in cheeses
    println(cheese)
end

for i ∈ 1:length(numbers) # discouraged approach
    println(numbers[i])
end

for i ∈ eachindex(numbers)
    numbers[i] *= 2
    println(numbers[i])
end

print(numbers)


# Slicing an array
chars = ['a', 'b', 'c', 'f']
print(chars[1:3])
print(chars[3:end])
print(chars[:])

chars[1:2] = ['x', 'y']
print(chars)


# Functions for arrays
append!(chars, ['a', 'b'])
push!(chars, 'z')
insert!(chars, 2, 's')

pop!(chars)
popfirst!(chars)
splice!(chars, 2)

deleteat!(chars, 2)

sort(chars)
sort!(chars)


# Map, Filter, and Reduce
function addall(t) # reduce operation
    total = 0
    for x ∈ t
        total += x
    end
    total
end

addall([1, 2, 3, 4, 5])

function capitalizeall(t) # map operation
    res = []
    for s ∈ t
        push!(res, uppercase(s))
    end
    res
end

capitalizeall(['a', 'b', 'c', 'd'])

function onlyupper(t) # filter operation
    res = []
    for s ∈ t
        if s == uppercase(s)
            push!(res, s)
        end
    end
    res
end

onlyupper(['A', 'b', 'C', 'd'])


# Objects and values
a = "banana"
b = "banana"
c = a

a == b
a == c

a ≡ b
a ≡ c

a === b
a === c

a = [1, 2, 3]
b = [1, 2, 3]
c = a

a == b
a == c

a ≡ b
a ≡ c

a === b
a === c

a[1] = 9
a
c


# Functions that modifies array
t1 = [1, 2, 3, 4]
t2 = push!(t1, 3)
print(t1)
print(t2)
print(t1 ≡ t2)

t1 = [1, 2, 3, 4]
t2 = vcat(t1, 3)
print(t1)
print(t2)
print(t1 ≡ t2)

function tail(t) # it doesn't modify array
    t[2:end]
end

t3 = tail(t2)
t2
t3

t3[3] = 100
t2
t3



# DICTIONARIES ----- ----- ----- ----- ----- 

# A dictionary represents a mapping from keys to values
eng2sp = Dict()
eng2sp["one"] = "uno"
eng2sp

eng2sp = Dict(
    "one" => "uno",
    "two" => "dos",
    "three" => "tres"
)

length(eng2sp)
keys(eng2sp)
values(eng2sp)

"one" ∈ keys(eng2sp)


# A dictionary for counting
function countfreq(s)
    d = Dict()
    for c in s
        if lowercase(c) ∉ keys(d)
            d[lowercase(c)] = 1
        else
            d[lowercase(c)] += 1
        end
    end
    d
end

freqdist = countfreq("BrontosaurusBermanfaat")

get(freqdist, 'z', nothing)

# Looping over a dictionary
for key ∈ sort(collect(keys(freqdist)))
    println("$key: $(freqdist[key])")
end

for (key, value) ∈ freqdist
    println("$key => $(value)")
end

# Reverse lookup on a dictionary
function reverselookup(d, v)
    for k ∈ keys(d)
        if d[k] == v
            return k            
        end
    end
    error("LookupError")
end

reverselookup(eng2sp, "uno")
reverselookup(eng2sp, "dos")
reverselookup(eng2sp, "cuatro")

findall(isequal(2), freqdist)

# Invert a dictionary
function invert(d)
    inverse = Dict()
    for k in keys(d)
        val = d[k]
        if val ∉ keys(inverse)
            inverse[val] = [k]
        else
            push!(inverse[val], k)
        end
    end
    inverse
end

invert(freqdist)


# Memoization using dictionary
known = Dict(0=>0, 1=>1)

function fibonacci(n)
    if n ∈ keys(known)
        return known[n]
    end
    res = fibonacci(n-1) + fibonacci(n-2)
    known[n] = res
    res
end

fibonacci(20)

callcount = []
function callthat()
    push!(callcount, 1)
end

for i ∈ 1:10
    callthat()
end

sum(callcount)