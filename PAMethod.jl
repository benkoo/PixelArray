struct Dim
    lower::Float64
    upper::Float64
    resolution::Int
end


function make_mat(f::Function, xdim::Dim, ydim::Dim, tol::Float64)
    rows = xdim.resolution
    cols = ydim.resolution
    result = Matrix{T}(rows, cols)
    xstep = (xdim.upper - xdim.lower) / xdim.resolution
    ystep = (ydim.upper - ydim.lower) / ydim.resolution
    
    for i in 1 : rows
        for j in 1 : cols
        xval = xdim.lower + (i - 0.5)*xstep
        yval = ydim.lower + (j - 0.5)*ystep
        result[i, j] = abs( f(xval, yval) ) < tol
        end
    end
    return result
end

dim = Dim(-1.2, 1.2, 50)
M1 = make_mat((x,y) -> y - x^2, dim, dim, .05)
M2 = make_mat((y,z) -> y + z^2 - 1, dim, dim, .05)

using UnicodePlots
spy(M1)
spy(M2)
spy(M1*M2)