module divider_pipelinetB();
parameter CLOCK_CYCLE  = 10;
parameter CLOCK_WIDTH  = CLOCK_CYCLE/2;
parameter IDLE_CLOCKS  = 2;
parameter FALSE = 1'b0;
parameter TRUE = 1'b1;
parameter divisorBITS=8;
parameter dividendBITS=16;
parameter testcases=2000;
parameter addBITS=divisorBITS+dividendBITS-1; 
typedef struct packed{
logic[divisorBITS-1:0] divisor;
logic [dividendBITS-1:0] dividend;
} ip_structure;
reg clock;
typedef struct packed{
logic [dividendBITS-1:0] quotient;
logic [addBITS-1:0]remainder;
} op_structure;
 integer i,j,k;

logic[23:0]inQueue[$];
logic[38:0]outQueue[$];

ip_structure ip;
op_structure op;



Divider d1 (.divisor(ip.divisor), .dividend(ip.dividend),.quotient_final(op.quotient),.remainder(op.remainder), .clock(clock)); 

initial
begin
clock = FALSE;
forever #CLOCK_WIDTH clock = ~clock;
end


initial
begin  
fork 
begin
for (i=0;i<=testcases;i=i+1)
begin
@(negedge clock); ip = {{$random},{$random}}; inQueue.push_back(ip);

end
end
begin

repeat(dividendBITS+2) @(posedge clock);outQueue.push_back({op.quotient,op.remainder});

for (j=1;j<=testcases;j=j+1)
begin
@(posedge clock); outQueue.push_back({op.quotient,op.remainder});


end
end

join

foreach(inQueue[k])
begin
$display("dividend=%d, divisor=%d, op_Q=%d, op_R=%d,expexted_Q=%d, expected_R=%d, outcome=%s\n",inQueue[k][15:0],inQueue[k][23:16],outQueue[k][38:23],outQueue[k][22:0],inQueue[k][15:0]/inQueue[k][23:16],inQueue[k][15:0]%inQueue[k][23:16],((inQueue[k][15:0]/inQueue[k][23:16] === outQueue[k][38:23]) && ((inQueue[k][15:0]%inQueue[k][23:16])) === outQueue[k][22:0]) ? "Passed":"Failed");

end 

end 

endmodule
