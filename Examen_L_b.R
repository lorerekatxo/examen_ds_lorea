#EXAMEN 21/05/2021
# LIBRERIAS ---------------------------------------------------------------
library("readxl")
library("dplyr")
library("tidyr")
library("lubridate") #as_date
library("VIM")
library("simputation")
library("missForest")
library("nortest")
library("EnvStats")
library("writexl")
library("naniar")
library("nortest")
library("ggplot2")
library("gridExtra")
library("dummies")
library("fastDummies")
library("BBmisc")
library("discretization")
library("digest")
library("smoothmest")
library("visdat")
library("BBmisc")
library("scales")
library("stats")


# CARGA DE DATOS ----------------------------------------------------------
getwd()
setwd("C:/Users/HP/Desktop/RETO4/DATA SCIENCE/EXAMEN")

DF<-read_excel("SBAnational.xlsx")
# DATA DISCOVERY ----------------------------------------------------------

#TIPOS
str(DF)
#CAMBIO DE TIPOS
DF$ApprovalDate<-as.Date(DF$ApprovalDate)
DF$ApprovalFY<-as.integer(DF$ApprovalFY)
DF$NoEmp<-as.integer(DF$NoEmp)
DF$LoanNr_ChkDgt<-as.character(DF$LoanNr_ChkDgt)
DF$Zip<-as.character(DF$Zip)
DF$NAICS<-as.character(DF$NAICS)
#DF$NewExist<-as.factor(DF$NewExist)

DF$FranchiseCode<-as.factor(DF$FranchiseCode)

DF$UrbanRural<-as.factor(DF$UrbanRural)
DF$RevLineCr<-as.factor(DF$RevLineCr)
DF$LowDoc<-as.factor(DF$LowDoc)
DF$MIS_Status<-as.factor(DF$MIS_Status)
DF$ChgOffDate<-as.Date(DF$ChgOffDate)
DF$disbursementdate<-as.Date(DF$disbursementdate)
DF$DisbursementGross<-as.integer(DF$DisbursementGross)

#
estadísticos<-as.data.frame(summary (DF))
variables_numéricas<-unlist(lapply(DF,is.numeric)) 
df_numéricas<-DF[, unlist(lapply(DF,is.numeric))]

e_n<-as.data.frame(summary(df_numéricas))


# ANONIMIZACION (falta razonar!!!)-----------------------------------------------------------

#La funcion de hasheo que voy a emplear para aplicar el criterio de anonimización va a ser el digest.
#Empleando el algoritmo predeterimando por la función
#md5
#Esta función aunque en ocasiones se haya dicho que es inseguro,todavía es muy utilizado en el ámbito de anonimización.
#Esto procova uan ruptura total de los datos identificativos con los datos personales,para que no se pueda asociar de ninguna
#manera la persona/empresa titular de los datos a analizar.

id<-DF[,1]
id_anon<-as.data.frame(apply(id,1,digest))

colnames(id_anon)<-c("anonimización_con_digest")


