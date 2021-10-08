#!/bin/bash

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -i|--input)
      INPUT="$2"
      shift # past argument
      shift # past value
      ;;
    -t|--train_ratio)
      TRAIN_RATIO="$2"
      shift # past argument
      shift # past value
      ;;
    -y|--y_column)
      Y_COLUMN="$2"
      shift # past argument
      shift # past value
      ;;
    *)    # unknown option
      shift # past argument
      ;;
  esac
done

index=$(head -1 "$INPUT" | sed 's/,/\n/g' | nl | awk "\$2 ~ /^$Y_COLUMN$/ {print \$1}")

number_of_lines=$(wc -l <"$INPUT")
TRAIN=$(echo "$number_of_lines * $TRAIN_RATIO / 100" | bc)
TEST=$(echo "$number_of_lines - $TRAIN" | bc)

head -n "$TRAIN" "$INPUT" > "1$INPUT"
tail -n "$TEST" "$INPUT" > "2$INPUT"