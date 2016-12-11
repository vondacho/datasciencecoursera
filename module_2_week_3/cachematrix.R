
## This function takes a matrix x and creates a special "matrix" object that can cache the inverse of x.
## Assumption: The matrix supplied is always an invertible square matrix
makeCacheMatrix <- function(x = matrix()) {
    
    # Validates that m is a square matrix. Returns m if yes else an empty matrix
    validateSquare <- function(m) {
        if (!is.matrix(m)) {
            warning("The supplied data is not a matrix.")
            matrix()
        }
        else if (anyNA(m)) {
            warning("The supplied data is an empty matrix.")
            m
        }
        else if (nrow(m) != ncol(m)) {
            warning("The supplied data is not a square matrix.")
            matrix()
        }
        else m
    }
    
    # Validates that xi is the inverse of x. Returns xi if yes else NULL.
    validateInverse <- function(x, xi) {
        if (!all(round(x %*% xi) == diag(nrow(x)))) {
            warning("The supplied matrix is not the inverse of the internal matrix.")
            NULL
        }
        else xi
    }
    
    x <- validateSquare(x)
    xInversed <- NULL
    
    set <- function(y) {
        x <<- validateSquare(y)
        xInversed <<- NULL
    }
    
    get <- function() x

    setInverse <- function(xi) {
        if (anyNA(x)) {
            error("No internal matrix defined. Use the set() method first to define it.")
        }
        else if (!anyNA(validateSquare(xi))) {
            xInversed <<- validateInverse(x, xi)
        }
    }
    
    getInverse <- function() xInversed
    
    list(set = set, get = get,
         setInverse = setInverse,
         getInverse = getInverse)
}


## This function computes the inverse of the special "matrix" returned by makeCacheMatrix.
## If the inverse has already been calculated (and the matrix has not changed),
## then it retrieves the inverse from the cache.
cacheSolve <- function(cacheMatrix, ...) {
    if (anyNA(cacheMatrix$get())) {
        warning("No internal data defined. Use the set() method first.")
    }
    else {
        xi <- cacheMatrix$getInverse()
        if (!is.null(xi)) {
            message("getting cached data")
            return(xi)
        }
        xi <- solve(cacheMatrix$get(), ...)
        cacheMatrix$setInverse(xi)
        cacheMatrix$getInverse()
    }
}
