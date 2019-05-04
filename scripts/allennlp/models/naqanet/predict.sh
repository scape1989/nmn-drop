#!/usr/bin/env bash

### DATASET PATHS -- should be same across models for same dataset

DATASET_NAME=num/howmanyyards_count_diff
DATASET_DIR=./resources/data/drop_s/${DATASET_NAME}

TRAINFILE=${DATASET_DIR}/drop_dataset_train.json
VALFILE=${DATASET_DIR}/drop_dataset_dev.json

MODEL_TAR='https://s3-us-west-2.amazonaws.com/allennlp/models/naqanet-2019.03.01.tar.gz'
GPU=0

CHECKPOINT_ROOT=./resources/semqa/checkpoints
SERIALIZATION_DIR_ROOT=${CHECKPOINT_ROOT}/drop/${DATASET_NAME}
MODEL_DIR=naqanet
SERIALIZATION_DIR=${SERIALIZATION_DIR_ROOT}/${MODEL_DIR}

OUTPUT_DIR=${SERIALIZATION_DIR}/predictions

mkdir -p ${OUTPUT_DIR}


TESTFILE=${VALFILE}
EVAL_FILE=${OUTPUT_DIR}/dev_eval.txt
PREDICTION_FILE=${OUTPUT_DIR}/dev_predictions.txt

allennlp evaluate --output-file ${EVAL_FILE} \
                  --cuda-device ${GPU} \
                  ${MODEL_TAR} ${TESTFILE}


allennlp predict --output-file ${PREDICTION_FILE} \
                 --predictor 'machine-comprehension' \
                 --cuda-device ${GPU} \
                 --silent \
                 --batch-size 1 \
                 --use-dataset-reader \
                 ${MODEL_TAR} ${TESTFILE}

echo -e "Evaluation file saved at: ${EVAL_FILE}"
echo -e "Predictions file saved at: ${PREDICTION_FILE}"

