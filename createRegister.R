createRegister<-function(PawsF, resgisterOut="registration for nops_eval.csv"){
	
PAWSroster<-read.csv(PawsF)
PAWSroster<-PAWSroster[seq(1,nrow(PAWSroster),2),c("Campus.ID","Name")]
	

# Creating the 7 digit number from the Panther ID field (removing the first two digits (99)
subTemp<-gsub(pattern="[^0-9]",x=PAWSroster$Campus.ID,replacement="")
if(!all(nchar(subTemp)==9)){"Warning some student numbers are not 9 digits long"}
PAWSroster$Campus.ID.7dig<-as.numeric(substr(subTemp,3,9))

# Changing Name field order to given" followed by "family"
nameM<-matrix(unlist(strsplit(PAWSroster$Name,split=",")),byrow=T,nrow=nrow(PAWSroster))
idM<-matrix(unlist(strsplit(PAWSroster$Name,split=",")),byrow=T,nrow=nrow(PAWSroster))

registrationDF<-data.frame(registration=PAWSroster$Campus.ID.7dig,
			  								  name=apply(nameM,1,function(x)paste(x[2],x[1])),
													id=gsub(apply(nameM,1,function(x)paste(x[2],x[1],collapse=" ")),pattern=" ",replacement="_")
													)
write.table(registrationDF,file=resgisterOut, sep=";", quote=F,row.names=F)
print("Registration file for nops_eval written to working directory")

}

