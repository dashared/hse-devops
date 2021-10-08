#!/bin/bash

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -w|--workers)
      WORKERS="$2"
      shift # past argument
      shift # past value
      ;;
    -c|--column)
      COLUMN="$2"
      shift # past argument
      shift # past value
      ;;
    -o|--output)
      OUTPUT="$2"
      shift # past argument
      shift # past value
      ;;
    *)    # unknown option
      shift # past argument
      ;;
  esac
done

FILE_PATH="dataset.csv"

INDEX=$(head -1 $FILE_PATH | tr ';' '\n' | grep -nx $COLUMN | cut -d':' -f1)

awk -F ";" "NR>1{print \$$INDEX}" $FILE_PATH | parallel -j $WORKERS --progress wget {} -q -P $OUTPUT

