#! /bin/bash
#
#  This script can be used to execute tests for a submission for the CS 2506
#  Assembler Milestone 1.  The script prepC4.sh should be executed first in
#  order to create the proper setup and build the student's executable.
#
#  Invoke as:  ./testM1.sh <PID>
#
#  Last modified:  22:00 March 15 2015
#
#  To use this test script:
#     - Watch for error messages from this script or gcc or runtime errors
#     - If none, look at the file testing.summary.txt
#
#  What the script does:
#     - Verifies the presence of a command-line parameter (student's PID)
#     - cd's to the test directory ($testRoot/$PID)
#     - Verifies existence of executable named assemble in the test directory
#     - Creates two text files (PID.testing.txt and PID.summary.txt) to contain
#       the results of testing
#     - Iterates through the list of asm files for testing:
#         - verifies existence of .asm and corresponding reference (.o) file
#         - runs assembler on .asm file, yielding student .o file
#         - verifies existence of student .o file
#         - calls compare to score the test
#     - Executes assembler with -symbols flag on one test case
#     - Generates final results file PID.summary.txt
#
   
# Configuration variables:
#
#   point to the directory holding the test files
testFilesDir="./M1TestFiles"

#   delimiter written at end of log files
Terminus="============================================================"

# set results file names
   resultsLog=testing_details.txt
   summaryLog=testing_summary.txt

# prep results files
   echo "Detailed results from executing testM1" > $resultsLog

# verify existence of student executable
   if [[ ! -x assemble ]]; then
      echo "Could not find student executable:  assemble" >> $resultsLog
      echo "Did you run prepM1 first?" >> $resultsLog
      spid=$1
      mv prepLog.txt $spid.txt
      exit 3
   fi

# perform testing

for asmFile in $testFilesDir/*.asm
do
   asmToProcess=$asmFile
   rootName=${asmToProcess%.*}
   refObjectFile=$rootName"_MARS.o"
   stuObjectFile="stu_"${rootName##*/}".o"
   
   if [[ ! -e $refObjectFile ]]; then
      echo "Missing $refObjectFile, skipping $asmToProcess"
      continue
   fi

   echo "Beginning test case $asmToProcess" >> $resultsLog
   # write-protect test files
   chmod a-w $asmToProcess
   chmod a-w $refObjectFile

   # run assembler on current test file
   echo "Running assembler on $asmToProcess" >> $resultsLog
   ./assemble $asmToProcess $stuObjectFile >> $resultsLog

   # remove write-protection from test files
   chmod u+w $asmToProcess
   chmod u+w $refObjectFile

   # verify existence of a nonempty student object file
   if [ ! -s $stuObjectFile ]; then
      echo "The object file $stuObjectFile was not produced or is empty" >> $resultsLog
      echo >> $resultsLog
      continue
   fi

   # run comparator
   echo "Running compare on $stuObjectFile and $refObjectFile" >> $resultsLog
   ./compare $stuObjectFile $refObjectFile >> $resultsLog
   echo >> $resultsLog
done

# complete summary file
   echo "Summary results from executing testM1" > $summaryLog
   # write scores to summary file
   echo >> $summaryLog
   grep Score $resultsLog >> $summaryLog
   echo $Terminus >> $summaryLog
   echo >> $summaryLog

   # write prep log into summary
   echo "Results from prep log" >> $summaryLog
   cat prepLog.txt >> $summaryLog
   echo >> $summaryLog

   # write test result details to summary file
   cat $resultsLog >> $summaryLog

   # rename summary log using student's PID
   if [[ $# -ne 0 ]]; then
      spid=$1
      mv $summaryLog $spid.txt
   fi

# terminate script
exit 0

