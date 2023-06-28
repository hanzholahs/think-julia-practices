"""
This is based on Think Julia book by Ben Lauwens and Allen Downey
- Chapter 4 Case Study: Interface Design

Development Plan
----------------
 1. Write small program with no function definition
 2. Once it works, encapsulate it into a function
 3. Generalise by adding appropriate parameters
 4. Repeat steps 1-3, while trying to refactor code


Glossary
--------
 - Precondition: a requirement that should be satisfied by the caller before a function starts
 - Postcondition: a requirement that should be satisfied by the function before it ends.
 - Encapsulation: the process of transforming a sequence of statements into a function definition
 - Generalisation: the process of replacing unnecessarily specific with something appropriately general (e.g. parameters)
 - Interface: a description of how a function is used, including the name and descriptions of the arguments and return value
 - Refactoring: the process of rearranging a program to improve interfaces and facilitate code re-use
"""


using ThinkJulia

# using turtle
@svg begin
    🐢 = Turtle()
    for i ∈ 1:4
        forward(🐢, 100)
        turn(🐢, -90)
    end
end


# drawing functions
function draw(shape, params)
    """
    draw(shape, t, params)

    Draw shape.

    `shape` : a function that control the turtle
    `t`     : a turtle
    `params`: parameters of the `shape function`
    """
    @svg begin
        t = Turtle()
        shape(t, params...)
    end
end

function polyline(t, n, d, angle)
    """Draw n line segments with a given length and angle."""
    for i ∈ 1:n
        forward(t, d)
        turn(t, - angle)
    end
end

function polygon(t, n, d)
    """Draw an n-shaped polygon with a given length."""
    polyline(t, n, d, 360 / n)
    # for i ∈ 1:n
        # forward(t, d)
        # turn(t, - 360 / n)
    # end
end

function square(t, d)
    """Draw a square with a given length."""
    polygon(t, 4, d)
end

function circle(t, r)
    """Draw a circle with a given radius."""
    n = trunc(2 * r * π) + 3
    d = 2 * r * π / n
    polygon(t, n, d)
end

function arc(t, r, angle)
    """Draw an arc with a given radius and angle."""
    d = 2 * π * r * angle / 360
    n = trunc(d / 3) + 1
    polyline(t, n, d / n, angle / n)
end


# draw shapes
draw(polyline, [3, 100, 120])

draw(polygon, [7, 120])

draw(square, 120)

draw(circle, 60)

draw(arc, [100, 180])

draw(arc, [100, 300])



# Exercises
function pies(t, n, r)
    α₁ = 360 / n
    α₂ = (180 - α₁) / 2
    s = 2 * sin(α₁/2/180*π) * r
    
    turn(t, -90)
    turn(t, α₁)
    for i ∈ 1:n
        forward(t, r)
        turn(t, (180 - α₂))
        forward(t, s)
        turn(t, (180 - α₂))
        forward(t, r)
        turn(t, 180)
    end
end

draw(pies, [5, 50])
draw(pies, [7, 50])
draw(pies, [8, 50])
draw(pies, [10, 50])