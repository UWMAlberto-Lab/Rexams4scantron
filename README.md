**Introduction**

This manual is intended to facilitate the use of the [R package exams](https://www.r-exams.org/ "R exams site") as a replacement tool for scantrons. Note that, beyond creating exams and associated scantrons, the package can be used to create quiz questions that can be uploaded into Canvas (topic not covered here). 
In brief, after you set up your questions in the correct format, the package will produce a PDF with the exam and a scantron (maximum 45 questions). Questions can be single-choice (one correct answer) or multiple-choice (one or more correct answers). You can easily create different versions of the exam and shuffle questions from a larger set of possible answer choices.

Students answer their exam questions on the answer sheet, and the instructor then scans the answer sheets with the department's photocopy machine (so fast). Using functions from the R exams package, the resulting PDF containing scans of all students' answer sheets is analyzed in R . A file containing the answers, the solution keys, and scans of the answer sheets is produced for each student. A text file with the information for all students is also produced. 

Using this output file, I coded a few more exam diagnostic descriptive statistics to mimic the most relevant information provided by the exam center when analyzing scantrons. Below you will find detailed instructions for installing the package and its requirements, a pipeline, and a few notes to ensure your scantrons scan correctly. I will provide some suggestions for exam day, given the differences between this system and the Scantron. I will also provide links to the R package exams webpage, where you can find plenty of additional information. 

Download all the files (green button, then download as a zip), then follow the instructions in the *How to use R package exams as a replacement for scantrons* PDF file.
