#!/bin/bash
set -e

while [[ $# -gt 0 ]]; do
  case $1 in
    --basedir) 
      DIR="$2"
      shift
      shift
      ;;
    *)
      echo "Unknown commandline arguments: $1 -> $2"
      exit 1
  esac
done

if [ ! -d "${DIR}/verification/work" ]; then
  mkdir ${DIR}/verification/work
fi

rm -rf ${DIR}/verification/work/*

cd ${DIR}/verification/work

git clone https://github.com/YosysHQ/riscv-formal.git
mkdir riscv-formal/cores/riscv-z0
cp ${DIR}/verification/checks.cfg riscv-formal/cores/riscv-z0/
cp ${DIR}/verification/wrapper.sv riscv-formal/cores/riscv-z0/
cp ${DIR}/verification/disasm.py riscv-formal/cores/riscv-z0/

sv2v -w riscv-formal/cores/riscv-z0/cpu.v \
      ${DIR}/verilog/tb/configure.sv \
      ${DIR}/verilog/constants.sv \
      ${DIR}/verilog/functions.sv \
      ${DIR}/verilog/wires.sv \
      ${DIR}/verilog/alu.sv \
      ${DIR}/verilog/agu.sv \
      ${DIR}/verilog/bcu.sv \
      ${DIR}/verilog/lsu.sv \
      ${DIR}/verilog/csr_alu.sv \
      ${DIR}/verilog/div.sv \
      ${DIR}/verilog/mul.sv \
      ${DIR}/verilog/predecoder.sv \
      ${DIR}/verilog/postdecoder.sv \
      ${DIR}/verilog/register.sv \
      ${DIR}/verilog/csr.sv \
      ${DIR}/verilog/compress.sv \
      ${DIR}/verilog/fetchbuffer.sv \
      ${DIR}/verilog/forwarding.sv \
      ${DIR}/verilog/fetch_stage.sv \
      ${DIR}/verilog/execute_stage.sv \
      ${DIR}/verilog/arbiter.sv \
      ${DIR}/verilog/pmp.sv \
      ${DIR}/verilog/cpu.sv

start=`date +%s`

cd riscv-formal/cores/riscv-z0
rm -rf checks
python3 ../../checks/genchecks.py
make -C checks -j$(nproc)

end=`date +%s`
echo Execution time was `expr $end - $start` seconds.
