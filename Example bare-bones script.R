#installing package, see manual about other dependencies besides R Packages
#only need to install the package once per machine
install.packages("exams", dependencies = TRUE,type="source")


#loading the package
library(exams)

#installing examples
exams_skeleton(markup = "markdown", writer = c("exams2html", "exams2pdf", "exams2moodle"))

#visualing in a webpage a single question file
exams2html("./exercises/ttest.Rmd")


#creating an exam list with the question you want on the exam
#This example uses the questions in the exercises folder. 
#You need to create your own questions, see manual section 3
myexam <- list(
	"tstat2.Rmd",
	"ttest.Rmd",
	"relfreq.Rmd",
	"anova.Rmd",
	"cholesky.Rmd"
)


# Creating the exam pdf (two versions of it). More deatls in the manual

set.seed(403) #to make sure you could repeat these exact permutations
ex1 <- exams2nops(myexam, n = 2,
									dir = "nops_pdf", name = "Exam1", date = "2015-07-29",
									points = c(1, 1, 1, 2, 2), showpoints = TRUE,logo="uwm.png",blank=0,
									institution="UW-Milwaukee",title="BIOSCI 465, Biostatistics exam I",
									usepackage = "float",samepage = TRUE)

#scanning the exams. Assumes the pdf with the scan is in a folder called scans, available in the R session working directory
nops_scan(dir="scans")

#creating a register file, which is necessary for exam evaluation.
#See manual for details.
#This function is not part of the package. You need to do source(creaeteRegister.R), assumig the function file is saved in the
#R session working environment, to load the code
createRegister(PawsF="Paws Download.csv", resgisterOut="Exam-2025-10-23.csv")

#Exam evaluation. See manual for details
ev1 <- nops_eval(
	register = "Exam-2025-10-23.csv",
	solutions = "Exam_I.rds",
	scans = Sys.glob("scans/nops_scan_20251013182655.zip"),
	eval = exams_eval(partial = TRUE, negative = FALSE,rule="false"),
	interactive = FALSE)

#example of using functon nops_fix to fix problems with scans in a iteractive way. See manual for details
nops_fix("scans/nops_scan_20251012115937.zip",exam=34,field="answers",display="interactive")


#using nops_fix to find single choice (schoice) questions where the scan detected more than one answer
#Needs to exclude questions that were multiple correct answer possible (mchoice questions)
#See manual for details
nops_fix("scans/nops_scan_20251012115937.zip",check="schoice",answer=c(1:12,15:31))

#using nops_fix to find questions where the scan detected no answer (missing)
nops_fix("scans/nops_scan_20251012115937.zip",check="missing")

#Runing Rmarkdown file to get diagnostic reports
#first intall these packages (you only need to install once for a given machine)
install.packages(c("DT","kableExtra"))

#Follow manual instructions on how to run the "RMarkdown script markdown for evaluation.Rmd" script in RStudio

#Importing grades to Canvas. See manual for details
#This function is not part of the package. You need to do source(import2Canvas.R), assumig the function file is saved in the
#R session working environment, to load the code
import2Canvas(PawsF="Paws Download.csv",
							EvalResults="Results table.txt",
							CanvasDownload="2025-11-03T1154_Grades-BIO_SCI_465_examI.csv",
							outputF="grades to upload.csv")

