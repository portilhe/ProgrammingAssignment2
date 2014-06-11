## This two fucntions can be used together to create a "matrix" type object
## where its inverse can be stored once and retrieved later, therefore saving
## potentially expensive computations

## This function creates the special object "matrix", which is a list with 
## four functions that can be used to get/set the values of the matrix and its
## inverse

makeCacheMatrix <- function(x = matrix()) {
	i <- NULL
	get <- function() x
	set <- function(y) {
		x <<- y
		i <<- NULL
	}
	getInv <- function() i
	setInv <- function(inv) i <<- inv
	list(get = get, set = set, getInv = getInv, setInv = setInv)
}


## This function computes the inverse of a special "matrix" object using solve
## But storing the value of the inverse in the object. Hence, if called twice
## on the same unchanged object, it will reuse the value computed in the first
## call

cacheSolve <- function(x, ...) {
	i <- x$getInv()
	if(!is.null(i)) {
		message("getting cached inverse")
		return(i)
	}
	x_data <- x$get()
	inv <- solve(x_data, ...)
	x$setInv(inv)
	inv
}
