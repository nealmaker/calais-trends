library("tidycensus")
library("tidyverse")
census_api_key("b36deef891c23309a738155f5c2eddfda2ad5ac3", install = T)

v21 <- load_variables(2021, "acs5", cache = TRUE)
View(v21)

cars <- lapply(seq(2011, 2021, by = 5), function(i){
  get_acs(geography = "county subdivision", year = i, output = "wide",
          table = "B08201", state = "VT", county = "Washington") %>% 
    filter(GEOID == "5002311350") %>% 
    mutate(year = i)
})
cars <- do.call(rbind, cars)
