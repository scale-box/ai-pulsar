#!/bin/bash

# 等待 1-3秒
sleep $((1 + RANDOM % 3))

cd /input
cp $1 /output/$1_abc
