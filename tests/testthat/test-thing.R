test_that("22 rows", {
  # x_n is number of rows of read-in dataframe
  expect_equal(x_n, 22)
})

test_that("right columns", {
  # x_nms is names of columns in read-in dataframe
  ans1 <- ("type" %in% x_nms)
  ans2 <- ("cortisol" %in% x_nms)
  ans <- (ans1 & ans2)
  expect_true(ans)
})
