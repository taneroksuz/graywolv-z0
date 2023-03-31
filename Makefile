default: none

export VERILATOR ?= /opt/verilator/bin/verilator
export SYSTEMC ?= /opt/systemc
export RISCVDV ?= /opt/riscv-dv
export RISCV ?= /opt/rv32imc/bin/riscv32-unknown-elf-
export MARCH ?= rv32imc_zicsr_zifencei
export MABI ?= ilp32
export ITER ?= 10
export CSMITH ?= /opt/csmith
export GCC ?= /usr/bin/gcc
export PYTHON ?= /usr/bin/python3
export SERIAL ?= /dev/ttyUSB0
export BASEDIR ?= $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
export PLATFORM ?= tb# tb vivado quartus
export PROGRAM ?= dhrystone# aapg bootloader compliance coremark csmith dhrystone isa riscv-dv sram timer
export AAPG ?= aapg
export MAXTIME ?= 10000000
export OFFSET ?= 0x100000
export WAVE ?= off# "on" for saving dump file

generate:
	soft/compile.sh

simulate:
	sim/run.sh

send:
	serial/transfer.sh

all: generate simulate
