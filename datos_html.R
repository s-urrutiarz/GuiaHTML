# Limpiado de vriables
rm(list = ls())



# cargar las librerias
library(xml2)
library(rvest)

readHtml <- read_html("paginaweb.html")
textoNoticia <- html_nodes(readHtml,".texto")
print(textoNoticia)
textoNoticia <- html_text(textoNoticia)
print(textoNoticia)

## eliminando cosas raras
textoNoticia <- gsub("\\n","",textoNoticia)
textoNoticia <- gsub("\\r","",textoNoticia)
textoNoticia <- gsub("[.]","",textoNoticia)
textoNoticia <- gsub("[,]","",textoNoticia)
print(textoNoticia)

## dejando todas las palabras en minuscula
textoNoticia <- tolower(textoNoticia)
print(textoNoticia)


# separando palabras
palabrasTexto <- strsplit(textoNoticia," ")[[1]]
print(palabrasTexto)


# palabras a lista 
lista_palabras <- as.list(palabrasTexto)
print(lista_palabras)  

# mostrando repeticiones de cada palabra(metodo eficiente)

lista_palabras <- as.vector(palabrasTexto)
print(lista_palabras) 
df <- data.frame(Estados = lista_palabras)
table(df$Estados)
resumen <- as.list(table (df$Estados))
print(resumen)

####################################################################################
## sacando tabla
####################################################################################

tbleditores <- html_nodes(readHtml,".tabla > table")
tablaleida <- html_table(tbleditores)
tablaleida <- tablaleida[[1]]
print(tablaleida)
View(tablaleida)


# limpiando y adaptando valores precio
print(tablaleida[[2]])
precios_limpios <- gsub("[.]","",tablaleida[[2]])
precios_limpios <- gsub("\\$","",precios_limpios)
precios_limpios <- as.numeric(precios_limpios)
print(precios_limpios)


# sacando promedio y mediana
suma_precios<-0

for(posicionNota in 1:length(precios_limpios)){
  print("==========Nueva suma==========")
  print(paste("Se agrega el precio", precios_limpios[posicionNota]))
  suma_precios <- suma_precios + precios_limpios[posicionNota]
  print(paste("La suma de los precios va en",suma_precios))
}

promedio <- suma_precios/length(precios_limpios)
print(paste("El promedio es:", promedio))
mediana <- median(precios_limpios)
print(paste("La mediana es:", mediana))

# FIN
