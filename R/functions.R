#' Read raw data
#'
#' Read raw (wider) data from (by default) a URL, reformat it longer, remove
#' missings and translate numbered groups to birth types
#'
#' @param my_url Input url of wide data (optional)
#' @returns a tidy (longer) version of the wide data with missings removed
#' @examples
#' read_raw()
#'
read_raw <- function(my_url = "http://ritsokiguess.site/datafiles/births_wide.csv") {
  births_wide <- read_csv(my_url)
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
