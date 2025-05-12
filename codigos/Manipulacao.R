options(scipen = 50)
library(pacman)
p_load(sf, openxlsx, dplyr, readr)

# Baixando os dados

dados_cnefe <- read.csv("Dados/12_AC.csv", sep = ";")
setores <- read.xlsx("Dados/Agregados_por_setores_basico_BR.xlsx")
malha <- read_sf("Dados/Malhas_Acre/AC_setores_CD2022.shp")

# Filtrando as bases
dados_cnefe$COD_SETOR <- substr(dados_cnefe$COD_SETOR, 1, 15)
setores_cnefe <- unique(dados_cnefe$COD_SETOR)
dados_cnefe <- filter(dados_cnefe, COD_ESPECIE == 1)
setores <- setores %>% filter(CD_UF == 12)
setores <- setores %>% filter(CD_UF == 12 & v0001 > 0 & v0002 > 0 )
malha$CD_SETOR <- as.numeric(malha$CD_SETOR)
setores <- left_join(setores, malha[c(1,30)], by = "CD_SETOR")
setores$CD_SETOR <- as.factor(setores$CD_SETOR)

write_rds(dados_cnefe, "Dados/domicilios.rds")
write_rds(setores, "Dados/setores.rds")

