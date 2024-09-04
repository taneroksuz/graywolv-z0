# WOLV Z0 CPU

Wolv Z1 CPU is 2-stage scalar processor.

## SPECIFICATIONS

### Architecture
- RV32-IMC
- Fast and slow option for multiplication unit
- Slow division unit
- Physical Memory Protection
- Core Local Interrupt Controller
### Memory
- Neumann architecture
- Unified Tightly Integrated Memory
### Peripheral
- UART
- Baudrate 115200
- Start Bit
- Stop Bit
- 8 Data Bits
- No Parity Bit

## TOOLS

The installation scripts of necessary tools are located in directory **tools**. These scripts need **root** permission in order to install packages and tools for simulation and testcase generation. Please run these scripts in directory **tools** locally.

## USAGE

1. Cloning the repository:
```console
git clone --recurse-submodules https://github.com/taneroksuz/wolv-z0.git
```

2. Execute scripts in directory **tools** to install necessary tools for compilation and simulation:
```console
cd tools
./riscv.sh
./verilator.sh
```

3. Compile some benchmarks:
```console
make compile
```

4. Compiled executable files are located in **riscv** and dumped files are located in **dump**. Select some executable from the directory **riscv** and copy them into this directory **sim/input**:
```console
cp riscv/coremark.riscv sim/input/
```

5. Run simulation:
```console
make simulate
```

6. Run simulation with <u>debug</u> feature:
```console
make simulate DUMP=1
```

7. Run simulation with <u>short period of time</u> (e.g 1us, default 10ms):
```console
make simulate MAXTIME=1000
```

8. The simulation results together with <u>debug</u> informations are located in **sim/output**.

## BENCHMARKS

### Coremark Benchmark
| Cycles | Iteration/s/MHz | Iteration |
| ------ | --------------- | --------- |
| 339800 |            2.94 |        10 |
