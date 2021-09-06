////////////////////////////////////////////////////////////////
// MC14500B test bench
// Elias Augusto, 2021
//
// Note: Really bad testing, basically just verifying the
// wiring works, not really checking the logic unit ops reliably
////////////////////////////////////////////////////////////////
`timescale 1ns/10ps

module mc14500b_tb;
localparam NOPO_INST=4'b0000;
localparam LD_INST=4'b0001;
localparam LDC_INST=4'b0010;
localparam AND_INST=4'b0011;
localparam ANDC_INST=4'b0100;
localparam OR_INST=4'b0101;
localparam ORC_INST=4'b0110;
localparam XNOR_INST=4'b0111;
localparam STO_INST=4'b1000;
localparam STOC_INST=4'b1001;
localparam IEN_INST=4'b1010;
localparam OEN_INST=4'b1011;
localparam JMP_INST=4'b1100;
localparam RTN_INST=4'b1101;
localparam SKZ_INST=4'b1110;
localparam NOPF_INST=4'b1111;

reg data_in;
reg [3:0] I_in;
wire RR;
wire bidir;
reg clk;
wire clk_out;
reg rst;
wire write;
wire FLG0;
wire FLGF;
wire RTN;
wire JMP;
wire state_out;
wire SKP;


//Testing of bidirectional ports
assign bidir=write? 1'bz : data_in;

mc14500b UUT(.clk_in(clk),
.rst(rst),
.clk_out(clk_out),
.I(I_in),
.FLGO(FLGO),
.FLGF(FLGF),
.RTN(RTN),
.JMP(JMP),
.data(bidir),
.RR(RR),
.write(write),
.state_out(state_out),
.SKP(SKP)
);

initial begin
//Initialize
clk=0;
rst=0;
end
always begin
clk=~clk;
#20;
end

initial begin
#20;
rst=1;
if(!RTN&&!JMP&&!FLGO&&!FLGF&&!write&&!RR)
$display("Initialized fine");
else
$display("Reset failed");

//Testing NOPO with data input
#20;
$display("NOPO Test, state=%0b",state_out);
data_in=1;
I_in=NOPO_INST;
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
if(!RTN&&!JMP&&FLGO&&!FLGF&&!write&&!RR)
$display("NOPO Works, ignores data");
else
$display("NOPO failed");

//Testing LDC
#20;
$display("LDC test, state=%0b",state_out);
data_in=0;
I_in=LDC_INST;
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
$display("RR=%0b",RR);
if(!RTN&&!JMP&&!FLGO&&!FLGF&&!write&&RR)
$display("LDC works, nop flag gone");
else
$display("LDC failed");

//Testing NOPF
#20;
$display("NOPF test, state=%0b",state_out);
data_in=0;
I_in=NOPF_INST;
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
$display("RR=%0b",RR);
if(!RTN&&!JMP&&!FLGO&&FLGF&&!write&&RR)
$display("NOPF works, RR still active");
else
$display("NOPF failed");

//Testing LD
#20;
$display("LD test, state=%0b",state_out);
data_in=0;
I_in=LD_INST;
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
$display("RR=%0b",RR);
if(!RTN&&!JMP&&!FLGO&&!FLGF&&!write&&!RR)
$display("LD works, nop flag gone");
else
$display("LD failed");

//Testing IEN
#20;
$display("IEN test, state=%0b",state_out);
data_in=1;
I_in=LD_INST;
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
$display("RR=%0b",RR);
data_in=0;
I_in=IEN_INST;
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
$display("bidir=%0b",bidir);
#20;
$display("state=%0b",state_out);
data_in=1;
I_in=LD_INST;
#20;
$display("bidir=%0b",bidir);
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
$display("RR=%0b",RR);
if(!RTN&&!JMP&&!FLGO&&!FLGF&&!write&&!RR)
$display("IEN works");
else
$display("IEN failed");

//Testing ANDC
#20;
$display("ANDC test, state=%0b",state_out);
data_in=1;
I_in=IEN_INST;
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
$display("RR=%0b",RR);
#20;
data_in=1;
I_in=LD_INST;
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
$display("RR=%0b",RR);
#20;
data_in=1;
I_in=ANDC_INST;
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
$display("RR=%0b",RR);
if(!RTN&&!JMP&&!FLGO&&!FLGF&&!write&&!RR)
$display("ANDC works");
else
$display("ANDC failed");

//Just going to assume orc and or and and work, they were written the same
//way

//Testing XNOR
#20;
$display("XNOR test, state=%0b",state_out);
data_in=1;
I_in=LD_INST;
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
$display("RR=%0b",RR);
#20;
data_in=1;
I_in=XNOR_INST;
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
$display("RR=%0b",RR);
if(!RTN&&!JMP&&!FLGO&&!FLGF&&!write&&RR)
$display("XNOR works");
else
$display("XNOR failed");

//Testing RTN JMP
#20;
$display("RTN JMP test, state=%0b",state_out);
data_in=1;
I_in=RTN_INST;
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
$display("RR=%0b",RR);
#20;
data_in=0;
I_in=NOPO_INST;
#20;
$display("state=%0b",state_out);
if(RTN&&!JMP&&!FLGO&&!FLGF&&!write)
$display("RTN flag works");
else
$display("RTN failed");
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
$display("RR=%0b",RR);
if(!RTN&&!JMP&&!FLGO&&!FLGF&&!write)
$display("RTN skip works, RTN flag down");
else
$display("RTN failed");
#20;
data_in=1;
I_in=JMP_INST;
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
$display("RR=%0b",RR);
if(!RTN&&JMP&&!FLGO&&!FLGF&&!write)
$display("JMP works, RTN flag gone");
else
$display("JMP failed");

//Testing SKZ
#20;
$display("SKZ test, state=%0b",state_out);
data_in=0;
I_in=LD_INST;
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
$display("RR=%0b",RR);
#20;
data_in=1;
I_in=SKZ_INST;
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
$display("RR=%0b",RR);
$display("SKP=%0b",SKP);
if(!RTN&&!JMP&&!FLGO&&!FLGF&&!write)
$display("SKZ works, skip signal already confirmed working");
else
$display("SKZ failed");
#20;
data_in=1; //Skipping this
I_in=NOPO_INST;
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);

//Testing STO
#20;
$display("STO test, state=%0b",state_out);
data_in=1;
I_in=LD_INST;
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
$display("RR=%0b",RR);
#20;
data_in=0;
I_in=STO_INST;
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
$display("RR=%0b",RR);
$display("write=%0b",write);
if(!RTN&&!JMP&&!FLGO&&!FLGF&&write&&bidir==RR)
$display("STO works");
else
$display("STO failed");

//Testing OEN
#20;
$display("OEN test, state=%0b",state_out);
data_in=1;
I_in=LD_INST;
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
$display("RR=%0b",RR);
#20;
data_in=0;
I_in=OEN_INST;
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
$display("RR=%0b",RR);
#20;
data_in=0;
I_in=STO_INST;
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
#20;
$display("state=%0b",state_out);
$display("RR=%0b",RR);
$display("write=%0b",write);
if(!RTN&&!JMP&&!FLGO&&!FLGF&&!write)
$display("OEN works according to previous STO test");
else
$display("ONE failed");

$stop;
end


endmodule
