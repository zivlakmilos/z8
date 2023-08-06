#!/usr/bin/env bash

ghdl -e --std=08 --ieee=synopsys -fsynopsys -fexplicit $1
ghdl -r --std=08 --ieee=synopsys -fsynopsys -fexplicit $1 --wave="$1_wave.ghw" --stop-time=1ms
