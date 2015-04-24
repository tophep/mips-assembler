#! /bin/bash
#
#  This script can be used to prepare the test environment for a submission
#  for the CS 2506 Assembler project milestone.  It will attempt to build an
#  executable from your tar file submission, but will not run any tests.
#
#  Invoke as:  ./prepM2.sh <name of tar file>
#
#  Last modified:  22:00 March 15 2015
#
#  To use this test script:
#     - untar the distributed testing tar file into a directory; that should
#       include the following files:
#          prepM2.sh    - this script file
#          testM1.sh    - the testing script file
#          compare      - a 64-bit comparison tool used in testing
#          M1TestFiles  - a subdirectory containing the asm and MARS o files
#                         used in the testing
#       We will refer to the top-level directory as the test directory.
#     - Set execute permissions for the first three files listed above.
#     - Put your milestone submission tar file into the test directory.  This
#       script expects the name of the tar file to be given as a parameter.
#     - Execute the command "./prepM2 <student's PID>" and check for errors;
#       if there are any error messages, fix the problem.
#     - Proceed with the script testC4.sh.
#
#  What the script does:
#     - Creates a subdirectory ./build and untars the submission into that
#     - Deletes unwanted files (assemble, *.o) from the build directory
#     - Verifies there's a makefile in the build directory; allowed names are:
#         makefile, Makefile, GNUMakefile
#     - Executes:  make assembler
#     - Verifies existence of executable named "assemble" in build directory
#     - Moves that executable into the parent directory where test files are
#   
#
# Configuration variables:
#
#   Point to directory storing the test files (.o, .asm)
testFilesDir="./M1TestFiles/"
#   Name for log file created by this script
Log="prepLog.txt"
#   Delimiter written at end of log file
Terminus="============================================================"

############################################# fn to check for tar file
#                 param1:  name of file to be checked
isTar() {

   mimeType=`file -b --mime-type $1`
   [[ $mimeType == "application/x-tar" ]]
}

# Verify we have a command-line parameter (tar file name)
   if [[ $# -eq 0 ]]; then
      echo "Please supply tar file name on command line."
      exit 1
   fi

# Verify presence of tar file
   tarFile="$1"
   if [ ! -e $tarFile ]; then
      echo $tarFile "does not exist."
      echo $Terminus >> $Log
      exit 1
   fi

# Verify parameter is really a tar file
  isTar "$tarFile"
  if [[ ! $? -eq 0 ]]; then
     echo "$tarFile is not a valid tar file"
     exit 2
  fi

# Initiate log file
   echo "Executing prepM2.sh on $tarFile" > $Log
   echo >> $Log

# Clean up test directory
   echo "Cleaning up test directory" >> $Log

   # Remove pre-existing assembler executable from test directory
   if [[ -e assemble ]]; then
      rm -f assemble
   fi
   # Remove any old student object files
   rm -f *.o

# Build executable for assembler in a subdirectory
   echo "Creating build subdirectory" >> $Log
   echo >> $Log
   # Create build directory
   if [[ -d build ]]; then
      rm -f build/*
   else
      mkdir build
   fi
   # Extract submission to build directory
   echo "Extracting files to build directory" >> $Log
   tar xvf $tarFile -C ./build >> $Log
   echo >> $Log

   # Move to build directory
   cd ./build
   # Verify we have a makefile
   if [[ ! -e makefile ]] && [[ ! -e Makefile ]] && [[ ! -e GNUmakefile ]]; then
      echo "There is no makefile in the build directory" >> ../$Log
      echo $Terminus >> ../$Log
      exit 2
   fi
   # Verify we have a pledge file
   if [[ ! -e pledge.txt ]]; then
      echo "Missing pledge file" >> ../$Log
   fi
   # Remove extraneous files from build directory
   if [[ -e assemble ]]; then
      echo "Deleting prebuilt assembler" >> ../$Log
      rm -f assemble
   fi
   if [[ -e *.o ]]; then
      rm -f *.o
   fi

   # build the assembler; save output in gccOutput.txt
   echo "Invoking:  make assembler" >> ../$Log
   make assembler >> ../$Log 2>&1
   echo >> ../$Log

   # Verify existence of executable
   if [[ ! -e assemble ]]; then
      # Try default make
      make
      if [[ ! -e assemble ]]; then
         echo "Build failed; the file assemble does not exist" >> ../$Log
         echo $Terminus >> ../$Log
         exit 3
      fi
   fi
   if [[ ! -x assemble ]]; then
      echo "Permissions error; the file assemble is not executable" >> ../$Log
      echo $Terminus >> ../$Log
      exit 4
   fi

   # Move assembler executable to test directory
   mv assemble ..
   # Return to test directory
   cd ..

# Terminate script
echo $Terminus >> $Log
exit 0

