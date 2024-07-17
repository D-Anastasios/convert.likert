library(testthat)
library(convert.likert)

test_that("transform_column transforms correctly basen on mappings", {
    column = column <- c("Strongly Disagree", "Agree", "Strongly Agree")
    mapping = list("Strongly Disagree" = 1, "Disagree" = 2, "Agree" = 3, "Strongly Agree" = 4)
    transformed = transform_column(column, mapping)
    expect_equal(transformed, c(1, 3, 4))
})

test_that("transform_likert transforms columns correctly based on custom mappings", {
    df <- data.frame(
        id = 1:3,
        agreement = c("Strongly Disagree", "Agree", "Strongly Agree"),
        stringsAsFactors = FALSE
    )
    mapping <- list("Strongly Disagree" = 1, "Disagree" = 2, "Agree" = 3, "Strongly Agree" = 4)
    custom_mappings <- list(mappings = list(agreement_test = mapping))
    transformed_df <- transform_likert(df, variables = "agreement", mapping_name = "agreement_test", custom_mappings = custom_mappings)
    expect_equal(transformed_df$agreement, c(1, 3, 4))
})

test_that("transform_likert transforms columns correctly based on internal mappings", {
    df <- data.frame(
        id = 1:4,
        agreement = c("Strongly Disagree", "Agree", "Strongly Agree", "Not Sure"),
        stringsAsFactors = FALSE
    )

    transformed_df <- transform_likert(df, variables = "agreement", mapping_name = "agreement_Snaith_RSE")
    expect_equal(transformed_df$agreement, c(1, 3, 4, NA))
    # Note that we expect a warning since "Not Sure" is not in the mapping
})


test_that("transform_likert_multiple works correctly", {
    df <- data.frame(
        id = 1:10,
        scale1 = sample(c("Never", "Rarely", "Sometimes", "Often", "Very often"), 10, replace = TRUE),
        scale2 = sample(c("Strongly Disagree", "Disagree", "Neither Agree nor Disagree", "Agree", "Strongly Agree"), 10, replace = TRUE)
    )
    variable_mapping_list <- list(
        frequency_ADHD = c("scale1"),
        agreement_TAS = c("scale2")
    )
    transformed_df <- transform_likert_multiple(df, variable_mapping_list)
    expect_true(all(transformed_df$scale1 %in% 1:5))
    expect_true(all(transformed_df$scale2 %in% 1:5))
})
