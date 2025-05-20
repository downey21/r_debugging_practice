
# -*- coding: utf-8 -*-

rm(list = ls())

find_index_close_to_mean <- function(vec) {

    if (!is.numeric(vec) || length(vec) == 0) {
        stop("Input must be a non-empty numeric vector.")
    }

    mean_value <- mean(vec)
    abs_difference_vec <- abs(vec - mean_value)
    index <- which.min(abs_difference_vec)

    close_value_to_mean <- vec[index]

    index_vec <- which(vec == close_value_to_mean)

    if (length(index_vec) == 0) {
        stop("Something Wrong!")
    }

    return(index_vec)
}

vec1 <- c(1, 2, 3, 4, 5)
find_index_close_to_mean(vec1)

vec2 <- c(1, 3, 3, 5)
find_index_close_to_mean(vec2)

vec3 <- c(1, 2, 3, 4, 5, NA)
find_index_close_to_mean(vec3)

# Case1: Manually identify the bug in interactive mode
vec <- vec3

if (!is.numeric(vec) || length(vec) == 0) {
    stop("Input must be a non-empty numeric vector.")
}

mean_value <- mean(vec)
abs_difference_vec <- abs(vec - mean_value)
index <- which.min(abs_difference_vec)

close_value_to_mean <- vec[index]

index_vec <- which(vec == close_value_to_mean)

if (length(index_vec) == 0) {
    stop("Something Wrong!")
}

# Case2: Use debug(), undebug()
debug(find_index_close_to_mean)
find_index_close_to_mean(vec3)
undebug(find_index_close_to_mean)

find_index_close_to_mean_debug <- function(vec) {

    if (!is.numeric(vec) || length(vec) == 0) {
        stop("Input must be a non-empty numeric vector.")
    }

    mean_value <- mean(vec, na.rm = TRUE)
    abs_difference_vec <- abs(vec - mean_value)
    index <- which.min(abs_difference_vec)

    close_value_to_mean <- vec[index]

    index_vec <- which(vec == close_value_to_mean)

    if (length(index_vec) == 0) {
        stop("Something Wrong!")
    }

    return(index_vec)
}

find_index_close_to_mean_debug(vec3)

# Case3: Use browser()
find_index_close_to_mean_debugging <- function(vec) {

    if (!is.numeric(vec) || length(vec) == 0) {
        stop("Input must be a non-empty numeric vector.")
    }

    browser()

    mean_value <- mean(vec)
    abs_difference_vec <- abs(vec - mean_value)
    index <- which.min(abs_difference_vec)

    close_value_to_mean <- vec[index]

    index_vec <- which(vec == close_value_to_mean)

    if (length(index_vec) == 0) {
        stop("Something Wrong!")
    }

    return(index_vec)
}

find_index_close_to_mean_debugging(vec3)
