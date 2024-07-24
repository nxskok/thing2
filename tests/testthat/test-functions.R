test_that("right number of rows", {
  x <- read_raw()
  n <- nrow(x)
  expect_equal(n, 22)
})

test_that("columns called type and cortisol", {
  x <- read_raw()
  nms <- names(x)
  ans1 <- "type" %in% nms
  ans2 <- "cortisol" %in% nms
  ans <- (ans1 & ans2)
  expect_true(ans)
})
