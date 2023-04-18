library(tidyverse)

datos_covid_isciii_raw <-
  read_csv("https://cnecovid.isciii.es/covid19/resources/casos_hosp_uci_def_sexo_edad_provres.csv", 
           na = "NC")

datos_covid_isciii_madrid <-
  datos_covid_isciii_raw |> 
  drop_na(sexo) |> 
  filter( provincia_iso == "M",
          fecha <= "2020-12-31")|> 
  select(fecha, sexo, grupo_edad, num_casos) |> 
  summarise(num_casos = sum(num_casos), .by = c(fecha,sexo))

write_csv(datos_covid_isciii_madrid, file = "./datos_madrid-csv")
