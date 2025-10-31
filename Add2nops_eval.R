Add2nops_eval<-function(eval.F,late.eval.F,rds.file,output="evalCombined.csv",rdsFilie,mark= c(0,0.5, 0.6, 0.75, 0.85,1), partial = TRUE, negative = FALSE,rule="false"){

require(exams)

# reading input files
# reading initial nops_eval file
eval<-read.table(eval.F,header=T,sep=";",colClasses = "character")
#reading .Rds file with exam metadata
rdsMetaInfo<-readRDS(rds.file)
#read Late grades
LateExam<-read.delim(late.eval.F,colClasses="character")
nstudents<-nrow(LateExam)

indexPoints<-grep(names(eval),pattern="point")
solution.index<-grep(names(eval), pattern="solution")
answer.index<-grep(names(eval), pattern="answer")
Qpoints.index<-grep(names(eval), pattern="points.")
CheckP.index<-grep(names(eval), pattern="check")

examsClasses<-sort(unique(eval$exam))

nquestions<-length(answer.index)
#max points
MaxPoints<-0
for(q in 1:nquestions){
	MaxPoints<-MaxPoints+rdsMetaInfo[[1]][[q]]$metainfo$points
}

ee<- exams_eval(partial=partial, negative=negative, rule=rule)

#a data.frame to add the new values
add.eval.DF<-data.frame(matrix(ncol=ncol(eval),nrow=nrow(LateExam)))
names(add.eval.DF)<-names(eval)

add.eval.DF$registration<-LateExam$registration
add.eval.DF$name<-LateExam$name
add.eval.DF$id<-unlist(lapply(LateExam$name,function(x){sub(x, pattern=" ",replacement="_")}))
add.eval.DF$exam<-LateExam$exam
add.eval.DF$scan<-rep("no scan",nrow(LateExam))
add.eval.DF$scrambling<-LateExam$scrambling

for(s in 1:nstudents){
	ex<-which(examsClasses%in%LateExam$exam[s])
	for(q in 1: nquestions){
		solutionQ<-rdsMetaInfo[[ex]][[q]]$metainfo$solution
		
		if(rdsMetaInfo[[ex]][[q]]$metainfo$type=="schoice"){
				answerQ<-letters[1:length(solutionQ)]%in%LateExam[s,q+4]
		}else{
			answerQ<-letters[1:length(solutionQ)]%in%unlist(strsplit(LateExam[s,q+4],split=""))
			}
		
		add.eval.DF[s,CheckP.index[q]]<-ee$pointsum(answerQ,solutionQ)
		add.eval.DF[s,Qpoints.index[q]]<-add.eval.DF[s,CheckP.index[q]]*rdsMetaInfo[[ex]][[q]]$metainfo$points
		add.eval.DF[s,solution.index[q]]<-paste(as.numeric(rdsMetaInfo[[ex]][[q]]$metainfo$solution),collapse="")
		if(rdsMetaInfo[[ex]][[q]]$metainfo$type=="schoice"){
			add.eval.DF[s,answer.index[q]]<-paste(as.numeric(letters[1:5]%in%LateExam[s,q+4]),collapse="")
		}else{  	
			add.eval.DF[s,answer.index[q]]<-paste(as.numeric(letters[1:5]%in%unlist(strsplit(LateExam[s,q+4],split=""))),collapse="")
				}
	}
	add.eval.DF$points[s]<-sum(as.numeric(add.eval.DF[s,Qpoints.index]))
	add.eval.DF$mark[s]<-as.numeric(cut(x=add.eval.DF$points[s]/MaxPoints,breaks=mark,labels=5:1))
}

evalCombined<-rbind(eval,add.eval.DF)
write.table(evalCombined,file=output,quote=F,row.names=F,sep=";")
print(paste0("File \'", output,"\' written to the working environment"))

add.eval.DF
}


