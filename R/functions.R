#' Read raw data
#'
#' Read raw (wider) data from (by default) a URL, reformat it longer, remove
#' missings and translate numbered groups to birth types
#'
#' @param my_url Input url of wide data (optional)
#' @return a tidy (longer) version of the wide data with missings removed
#' @export
#' @examples
#' read_raw()
#'
read_raw <- function(my_url = "http://ritsokiguess.site/datafiles/births_wide.csv") {
  births_wide <- read_csv(my_url, show_col_types = FALSE)
  births_wide %>%
    pivot_longer(everything(), names_to = "birth_type", values_to = "cortisol", values_drop_na = TRUE) -> births0
  # make lookup table of birth types
  type_names <- tribble(
    ~number, ~type,
    "Group.1", "c_pre",
    "Group.2", "c_emerg",
    "Group.3", "spont"
  )
  # replace numbered groups by actual birth types
  births0 %>% left_join(type_names, join_by("birth_type" == "number")) %>%
    select(-birth_type)
}

#' Draw a boxplot
#'
#' Draw a boxplot of a dataframe with columns called `type` and `cortisol`
#'
#' @param x input dataframe with the required columns
#' @return a boxplot from ggplot
#' @export
#'
#'
draw_boxplot <- function(x) {
  ggplot(x, aes(x = type, y = cortisol)) + geom_boxplot()
}


#' Run Welch anova
#'
#' Run Welch ANOVA (not assuming equal variances) on a dataframe with columns called `type` and `cortisol`
#'
#' @param x input dataframe with required columns
#' @return the output from Welch ANOVA plus Games-Howell test (in a `list`)
#' @export
#'
run_welch <- function(x) {
  ans1 <- oneway.test(cortisol ~ type, data = x)
  ans2 <- gamesHowellTest(cortisol ~ factor(type), data = x)
  list(ans1, ans2)
}



