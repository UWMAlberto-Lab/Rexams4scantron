import2Canvas<-function(PawsF="Paws Download.csv",EvalResults="Results table.txt", CanvasDownload="2025-11-03T1154_Grades-BIO_SCI_465_examII.csv",
												outputF="grades to upload.csv"){

CanvasGradeDownload<-read.csv(CanvasDownload)
ncolCanvasGrades<-ncol(CanvasGradeDownload)
CanvasGradeDownload$mergeID<-as.numeric(gsub(pattern="[^0-9]",x=CanvasGradeDownload$SIS.User.ID,replacement=""))

PAWSroster<-read.csv(PawsF,header=T)
PAWSroster<-PAWSroster[seq(1,nrow(PAWSroster),2),c("ID","Campus.ID","Name")]

Grades<-read.delim(EvalResults)


subTemp<-gsub(pattern="[^0-9]",x=PAWSroster$Campus.ID,replacement="")
if(!all(nchar(subTemp)==9)){"Warning some student numbers are not 9 digits long"}
PAWSroster$Campus.ID.7dig<-as.numeric(substr(subTemp,3,9))

Grade.AND.PAWS<-merge(x=PAWSroster, y=Grades[,1:4],by.x="Campus.ID.7dig",by.y="registration",all.x=T)

temp2<-merge(x=CanvasGradeDownload,y=Grade.AND.PAWS,by.x="mergeID",by.y="ID",all.x=T)
export<-temp2[,2:(ncolCanvasGrades+1)]
export[,ncolCanvasGrades]<-temp2$Points
export$Student<-paste0('"',export$Student,'"')
write.table(export,file=outputF,row.names=F,quote=F,sep=",")

}
