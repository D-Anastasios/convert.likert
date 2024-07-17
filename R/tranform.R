#' Transform a Single Column
#'
#' This function transforms a single column based on a given mapping.
#'
#' @param column The column to be transformed.
#' @param mapping The mapping to be used for transformation.
#' @param unmapped_action The action to take for unmapped values.
#' @importFrom purrr map
#' @importFrom glue glue
#' @importFrom magrittr %>%
#' @return A transformed column.
#' @export
transform_column <- function(column, mapping, unmapped_action = NA) {
    map(column, function(x) {
        if (!is.null(mapping[[x]])) {
            return(mapping[[x]])
        } else {
            warning(glue("The response '{x}' is not present in the mapping. Setting as {unmapped_action}."))
            return(unmapped_action)
        }
    }) %>% unlist() # so it can be of the simplest type
}

#' Transform Likert Columns
#'
#' This function transforms multiple columns using the same Likert scale mapping.
#'
#' @param data The dataframe containing the columns to be transformed.
#' @param variables The columns to be transformed.
#' @param mapping_name The name of the mapping to be used.
#' @param custom_mappings A list of custom mappings. If NULL, the default mappings are loaded.
#' @param unmapped_action The action to take for unmapped values.
#' @return A dataframe with transformed columns.
#' @importFrom dplyr mutate across all_of
#' @importFrom glue glue
#' @importFrom magrittr %>%
#' @export
transform_likert <- function(data, variables, mapping_name, custom_mappings = NULL, unmapped_action = NA) {

    # Load mappings based on the presence of a custom mapping file
    mappings = get_mappings(custom_mappings)

    # Check if the mapping name is in the mapping
    if (!mapping_name %in% names(mappings$mappings)) {
        stop(glue("The mapping {mapping_name} is not present in the mappings."))
    }

    # assign the mapping
    mapping <- mappings$mappings[[mapping_name]]

    # transform the columns
    data = data %>%
        mutate(across(all_of(variables), ~ transform_column(., mapping, unmapped_action = unmapped_action)))

    return(data)
}

#' Transform Multiple Likert Columns
#'
#' This function transforms multiple columns using different Likert scale mappings.
#'
#' @param data The dataframe containing the columns to be transformed.
#' @param variable_mapping_list A list mapping variable names to their respective mappings.
#' @param custom_mappings A list of custom mappings. If NULL, the default mappings are loaded.
#' @param unmapped_action The action to take for unmapped values.
#' @return A dataframe with transformed columns.
#' @importFrom dplyr mutate
#' @importFrom glue glue
#' @importFrom magrittr %>%
#' @export
transform_likert_multiple <- function(data, variable_mapping_list, custom_mappings = NULL, unmapped_action = NA) {

    # Load mappings based on the presence of a custom mapping file
    mappings = get_mappings(custom_mappings)

    # iterate over the variable mappings
    for (mapping_name in names(variable_mapping_list)) {
        variables = variable_mapping_list[[mapping_name]]

        # Check if the variables are in the data
        if (!all(variables %in% names(data))) {
            stop(glue("One or more variables specified for {mapping_name} are not present in the data."))
        }

        # Check if the mapping name is in the mapping
        if (!mapping_name %in% names(mappings$mappings)) {
            stop(glue("The mapping {mapping_name} is not present in the mappings."))
        }

        # assign the mapping
        mapping = mappings$mappings[[mapping_name]]

        # transform the columns
        data = transform_likert(data, variables, mapping_name, mappings, unmapped_action = unmapped_action)
    }
    return(data)
}
