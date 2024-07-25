test_that("22 rows", {
  # x_n is number of rows of read-in dataframe
  expect_equal(x_n, 22)
})

test_that("data has column 'type'", {
  # x_nms is names of columns in read-in dataframe
  ans1 <- ("type" %in% x_nms)
  expect_true(ans1)
})

test_that("data has column 'cortisol'", {
  # x_nms is names of columns in read-in dataframe
  ans1 <- ("cortisol" %in% x_nms)
  expect_true(ans1)
})
