#' Load Likert Mappings
#' This function loads Likert scale mappings from a specified JSON file.
#'
#' @param file_path The path to the JSON file containing the mappings.
#' @return A list containing the Likert scale mappings.
#' @importFrom jsonlite fromJSON
#' Load default mappings
#' mappings <- load_mappings()
#' print(mappings)
#' @export
load_mappings <- function(file_path = NULL) {
    if (is.null(file_path)) {
        file_path = system.file("extdata", "likert_mappings.json", package = "convert.likert")
    }
    jsonlite::fromJSON(file_path)
}

#' Get Likert Mappings
#'
#' This function loads either the default or custom Likert scale mappings.
#'
#' @param custom_mappings A list of custom mappings. If NULL, the default mappings are loaded.
#' @return A list containing the Likert scale mappings.
#' @importFrom jsonlite fromJSON
#' @export
get_mappings <- function(custom_mappings = NULL) {
    if (is.null(custom_mappings)) {
        mappings <- load_mappings() # load the default mappings
    } else {
        mappings = custom_mappings
    }
    return(mappings)
}
