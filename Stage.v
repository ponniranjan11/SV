module Stage(divisor,dividend,shiftby,stage_quotient_in,quotient,difference,stage_divisor_out);
parameter divisorBITS=8;
parameter dividendBITS=16;
parameter addBITS=divisorBITS+dividendBITS-1;
input [addBITS-1:0]divisor;
input [addBITS-1:0]dividend;
input [addBITS+divisorBITS:0] shiftby;
input [dividendBITS-1:0]stage_quotient_in;
output [dividendBITS-1:0]quotient;
output [addBITS-1:0]stage_divisor_out;
output signed [addBITS-1:0] difference;
wire [addBITS-1:0] difference1;
wire [addBITS-1:0] shiftedvalue;
wire carry;
Shifter S1 (divisor, shiftby,shiftedvalue); 
Adder A1(shiftedvalue,dividend,carry,difference1);
assign quotient=(carry==1'b1)? ((stage_quotient_in<<1)+1'b1):((stage_quotient_in<<1)+1'b0);
assign difference=(carry==1'b1)?difference1:dividend;	
assign stage_divisor_out=divisor; 
endmodule
