library(testthat)
library(convert.likert)

test_that("Load mappings loads the default JSON file correctly", {
    mappings = load_mappings()
    expect_true("agreement_Snaith_RSE" %in% names(mappings$mappings))
    expect_equal(mappings$mappings$agreement_Snaith_RSE$`Strongly Disagree`, 1)
})


test_that("Get mappings loads the default mappings correctly", {
    mappings = get_mappings()
    expect_true("agreement_Snaith_RSE" %in% names(mappings$mappings))
    expect_equal(mappings$mappings$agreement_Snaith_RSE$`Strongly Disagree`, 1)
})
