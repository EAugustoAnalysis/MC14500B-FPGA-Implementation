# MC14500B FPGA Implementation
__Motivation:__

This project was a fun learning project. I read about the Motorola MC14500B on Hackaday, and fell in love with the idea of a 1-bit processor that was so easily described using a few logic gates while remaining powerful enough to implement an educational computer on. I originally had a fun project planned for this where I hooked up a bunch of these in parallel and used them in a SIMD configuration, but I figured out that the inout nature of the data port wasn't compatible with the version of Yosys used on the TinyFPGA. I could've moved this to Quartus and a bigger board, but I had gotten bored. I thought I'd just release the project as is.

This processor was written using APIO's  synthesis and simulation toolchain. It was written in one night, so don't expect the signals to match up perfectly, but I tried to stay as true to the original documentation and patent as possible. If the testbench looks terrible, it's because it is. I basically wrote the testbench to test the pathing and routing and trusted that the LU instructions were written correctly. If I go back and rewrite this in Silice, I'll do a better testbench.

I've included a few resources related to the design, TinyFPGA development, and prior work on this topic by other developers.

__Files:__
* mc14500b.v - Contains logic and info
* mc14500b_tb.v - Bad testbench

__Missing:__

I didn't include a few of the features required to build a system around the MC14500B. I wanted to make this an "instantiate and go" type project where if anyone wants to do something fun like build a WDR-1 on an FPGA, they can just plop it into whatever architecture they want. See the ICU Handbook for more info on system implementation ideas:

If you're looking for a bit more of a serious implementation, I'd check out the linurs source below for their block-based FPGA implementation, assembler, and simulator.

 The following are required for any implementation, as the processor lacks them:
* MC14516B or equivalent Program Counter - Just a normal 4 bit binary counter, easily implemented in verilog, traditionally for complex implementations you string a few together
* 4 bit Program nemory - Memory that stores instructions and has 4 bit addressing and 4+ bit data
* Some kind of branch handler - The jmp and rtn instructions don't do much without a memory branch handler

__Resources:__

Testbenching: 
* Verilog inout port testing - https://electronics.stackexchange.com/questions/556859/verilog-testbench-for-inout

MC14500B stuff:
* Hackaday Inspiration - https://hackaday.com/2020/02/01/what-everyone-else-did-with-eight-bits-the-germans-did-with-only-one/
* MC14500B Industrial Control Unit Handbook (great for signals diagrams, systems ideas, and instructions) - http://www.bitsavers.org/components/motorola/14500/MC14500B_Industrial_Control_Unit_Handbook_1977.pdf
* Industrial Control Unit MC14500B (catalog advert with instruction listing) - www.brouhaha.com/~eric/retrocomputing/motorola/mc14500b/mc14500brev3.pdf
* US Patent - https://patents.google.com/patent/US4153942
* Ken Shirriff's reverse engineering project - http://www.righto.com/2021/02/a-one-bit-processor-explained-reverse.html
* MC14516B Program Counter - https://www.onsemi.com/pdf/datasheet/mc14516b-d.pdf

Other Examples of MC14500B Implementations (not necessarily used as resources here, but I wanted to honor prior work):
* Another example, logic block based FPGA implementation, simulator, discrete design, resource for learning, assembler - https://www.linurs.org/mc14500.html
* Excellent resources, discrete logic design - https://hackaday.io/project/181025-reimplementing-a-1-bit-cpu

TinyFPGA Stuff (I never implemented this on the FPGA as intended, just wanted to put this all in one place):
* TinyFPGA BX User guide - https://tinyfpga.com/bx/guide.html
* TinyFPGA PLL guide - https://discourse.tinyfpga.com/t/i-i-am-using-tinyfpga-bx-for-the-first-time-i-have-questions/1080/3
* Implied ram - https://discourse.tinyfpga.com/t/how-to-add-ram-to-a-tinyfpga-bx-design-managed-by-atom/1326
