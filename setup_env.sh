#!/bin/sh

POLR_GENERATED_AT=`date +"%B %d, %Y"`
export POLR_GENERATED_AT

envsubst < ".env.setup" > ".env"
