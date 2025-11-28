key2Rexams<-function(Key.in,name,title,institution,logo,date,dir,pdftk=TRUE){
	
require(exams)
require(staplr)
system2(command="mkdir",args="questionDir")
keyM<-read.delim(Key.in)
ChoicesV<-keyM[,1]  #these two would better be input as a table
KeyV<-keyM[,2]


nquestions<-length(ChoicesV)

for(q in 1:nquestions){

	if(nchar(KeyV[q])>1){ KeyTemp<-unlist(strsplit(KeyV[q],split=""))
	type<-"mchoice"}else{
		KeyTemp<-KeyV[q]
		type<-"schoice"
	}	
CorrectA<-which(letters[1:ChoicesV[q]]%in%KeyTemp)
CorrectL<-as.numeric(letters[1:ChoicesV[q]]%in%KeyTemp)		

cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"Question",append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"========",append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"Write question here",append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"Answerlist",append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"----------",append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)

for(c in 1:ChoicesV[q]){
	cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),paste0("* Fake choice ",c),append=T)
	cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
}
  cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
	cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"Solution",append=T)
	cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
	cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"========",append=T)
	cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
	cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
	cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"Fake solution",append=T)
	cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
	cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
	
	cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"Answerlist",append=T)
	cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
	cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"----------",append=T)
	cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
	cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
	
	for(c in 1:ChoicesV[q]){
	if(c%in%CorrectA){
		cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"* True",append=T)
		cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
	}else{
		cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"* False",append=T)
		cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
		}
	}

cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"Meta-information",append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"================",append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),paste0("exname: ","fake.",type,"_",q),append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),paste0("extype: ",type),append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),paste0("exsolution: ",paste0(CorrectL,collapse="")),append=T)
cat(file=paste0("./","questionDir","/","Question.",type,".",q,".Rmd"),"\n",append=T)

}

file.names<-list.files(paste0("./","questionDir"))
matches<-gregexpr("[0-9]+",file.names)

Question.Number <- as.numeric(unlist(regmatches(file.names, matches)))

file.names<-file.names[order(Question.Number)]
file.names<-paste0("./","questionDir","/",file.names)

examL<-as.list(file.names)

exfromkey<- exams2nops(examL, n = 1,
									dir = dir, name = name, date = date,
									points = keyM[,3], showpoints = TRUE,logo=logo,
									institution=institution,title=title,
									blank=0,usepackage="float",samepage = TRUE)

if(pdftk){
	system2(command="rm",args=c("-rf","questionDir"))
	input_pdf_path<-paste0("./",dir,"/",name,"1.pdf")
	ouput_pdf_path<-paste0("./",dir,"/",name,"_answer.sheet.pdf")
	system2(command="pdftk",args=c(input_pdf_path,"cat","1","output",ouput_pdf_path))
  system2(command="rm",args=input_pdf_path)
}

}
