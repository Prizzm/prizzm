#!/bin/bash

export PUSH_DEMO=true
rds
unset PUSH_DEMO
db push
rds
