#!/bin/bash

# Script Name:                  04_loops.sh
# Author:                       Marcus Nogueira
# Date of latest revision:      10/27/2023
# Purpose:                      Displays running processes, asks the user for a PID, then kills the process with that PID. Starts over at steo 1 until user exits with CTRL+C

# Declaration of variables

# Declaration of functions
kill_process(){
  
  while :
  do
    ps aux
    echo #line break
    read -p "Enter PID: " process_id
    kill -9 $process_id
    read -p "Continue? (y/n): " continue_killing

    if [[ $continue_killing == "n" || $continue_killing == "N" ]]; then
      break
    fi

  done
}

# Main
kill_process
# End