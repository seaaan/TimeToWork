library(ggmap)
library(dplyr)

WORK_ADDRESS <- "1100 Eastlake Ave E, Seattle, WA 98109"

# want to calculate the trip for commute times on a Monday
# enter the next Monday here: 
monday_morning <- "2017-06-26 07:45:00"
monday_evening <- "2017-06-26 17:00:00"

# ask google for the route
get_route <- function(origin, destination, departure) {
    route(from = origin, 
        to = destination, output = "all",
        mode = "transit", alternatives = TRUE, 
        inject = paste0("departure_time=", departure))
}

# convert a useful time to seconds since 1970-01-01 00:00:00
convert_date_to_stupid <- function(date) {
    as.POSIXct(date) %>% 
        unclass()
}

# extract the duration of the trips from the geocode object
durations <- function(geocode) {
    n <- length(geocode$routes)
    # can also do $value instead of $text and get seconds
    sapply(1:n, function(i) geocode$routes[[i]]$legs[[1]]$duration$text)
}

# extract the departure times from the geocode object
departure_times <- function(geocode) {
    n <- length(geocode$routes)
    # can also do $value instead of $text and get seconds
    sapply(1:n, function(i) geocode$routes[[i]]$legs[[1]]$departure_time$text)
}

transit_times <- function(address) {
    # calculate routes ----------------------------------------------------
    to_work <- get_route(address, WORK_ADDRESS, 
        convert_date_to_stupid(monday_morning)) 
    
    from_work <- get_route(WORK_ADDRESS, address, 
        convert_date_to_stupid(monday_evening)) 
    
    # print summaries of length of time ------------------------------------
    to <- paste0(c("TO WORK:", durations(to_work)), collapse = " ")
    #departure_times(to_work)
 #   print(to)
    
    from <- paste0(c("FROM WORK:", durations(from_work)), collapse = " ")
 #   print(from)
    #departure_times(from_work)

    # this return the to and from work geocode objects in case you want to
    # do something with them
 #   invisible(list(to_work, from_work))
    list(to = to, from = from)
}
