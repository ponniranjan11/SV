
module Divider_Pipelined_TB();
parameter divisorBITS=8;
parameter dividendBITS=16;
parameter NumTests=1000;
localparam addBITS=divisorBITS+dividendBITS-1; // parameterizing 
reg[divisorBITS-1:0] divisor;
reg [dividendBITS-1:0] dividend;
reg clock;
wire [dividendBITS-1:0] quotient;
wire [addBITS-1:0]remainder;
 integer i,j,k;
reg [dividendBITS-1:0]expected_quotient;
reg [addBITS-1:0]expected_remainder;
reg [divisorBITS+dividendBITS-1:0]InputStream[NumTests-1:0];
reg [addBITS+dividendBITS-1:0]OutputStream[NumTests-1:0];
integer input_count;
integer output_count;
reg [dividendBITS-1:0]Expected_Quotient;
reg [addBITS-1:0]Expected_Remainder;


Divider Q1 (.divisor(divisor), .dividend(dividend),.quotient_final(quotient),.remainder(remainder), .clock(clock)); // divider module instantiation


initial
begin  
fork 
begin
for (i=0;i<=NumTests;i=i+1)
begin
@(negedge clock);
divisor= $random;
dividend=$random;
InputStream[input_count]={divisor,dividend};
input_count=input_count+1;
end
end
begin
repeat(17) @(posedge clock);OutputStream[output_count]={remainder,quotient};output_count=output_count+1;
for (j=0;j<=NumTests;j=j+1)
begin
@(posedge clock);
OutputStream[output_count]={remainder,quotient};
output_count=output_count+1;
end
end

join

for(k=0;k<=NumTests;k=k+1)
begin
$display("divisor=%d,dividend=%d,Expected_Quotient=%d,Expected_Remainder=%d,remainder=%d,quotient=%d,Status=%s",InputStream[k][23:16],InputStream[k][15:0],InputStream[k][15:0]/InputStream[k][23:16],InputStream[k][15:0]%InputStream[k][23:16],OutputStream[k][38:16],OutputStream[k][15:0],(InputStream[k][15:0]/InputStream[k][23:16]===OutputStream[k][15:0])&&(InputStream[k][15:0]%InputStream[k][23:16]===OutputStream[k][38:16])?"PASS":"FAIL");

end 

end 

initial
begin
clock=1'b0; 
output_count='b0;
input_count='b0;
end 
always  #5 clock= ~clock;
endmodule 