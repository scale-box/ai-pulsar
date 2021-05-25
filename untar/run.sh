#!/bin/bash

cd /input
tar xf $1 --strip-components 2 -C /output
