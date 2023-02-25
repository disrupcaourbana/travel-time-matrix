#Geração de matrizes de tempo de viagem e distância usando o pacote googleway por meio do API Google Distance

install.packages("googleway") #Instale o pacote googleway

library(googleway) #Execute o pacote googleway

#Defina a pasta/diretório de trabalho
setwd("C:/Users/pedro_jn8sxnf/OneDrive/Documentos/Petrópolis/Matriz de tempo")

install.packages("lubridate") #Instale o pacote lubridate para configuração de data

library (lubridate) #Execute o lubridate

hora=dmy_h("17/02/2022_20") #Defina a hora a ser calculada da matriz de tempo


print(hora) #Verifique se a hora foi inserida corretamente

#Importe os dados da planilha excel com os nomes das localidades ou coordenadas geográficas
#A importação pode ser feita pelo display do rstudio

#Crie uma matriz vazia de distancia/tempo com os nomes das localidades
distancia=matrix(NA, nrow(bairros), nrow(bairros), 
                 dimnames = list(bairros$x, bairros$x)) 
tempo = distancia

#Insira os parâmetros do pacote googleway
#Aperte f1 apos google_distance para mostrar os parametros

api = google_distance(origins = bairros$x[3],
                      destinations = bairros$x[4], 
                      mode="driving",
                      key="SuaChaveAqui")

for (i in 1:nrow(bairros)){
  for (j in 1:nrow(bairros)){
    Sys.sleep(1) # atraso de 1 segundo
    api = google_distance(origins = bairros$x[i],
                          destinations = bairros$x[j], 
                          mode="driving",
                          key="SuaChaveAqui")
    
    # Verificar se a distância é válida antes de atribuir à matriz
    if (length(api[["rows"]][["elements"]][[1]][["distance"]][["value"]])>0) {
      distancia[i,j]=api[["rows"]][["elements"]][[1]][["distance"]][["value"]]
    }
    
    # Verificar se o tempo é válido antes de atribuir à matriz
    if (length(api[["rows"]][["elements"]][[1]][["duration"]][["value"]])>0) {
      tempo[i,j]=api[["rows"]][["elements"]][[1]][["duration"]][["value"]]
    }
  }
}    

#geração de arquivos em formato csv
write.csv2(distancia, "distancia2.csv")
write.csv2(tempo, "tempo2.csv")