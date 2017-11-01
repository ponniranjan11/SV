
module Divider(divisor,dividend,quotient_final,remainder,clock);
parameter divisorBITS=8;
parameter dividendBITS=16;
parameter addBITS=divisorBITS+dividendBITS-1;
input clock;
input [divisorBITS-1:0] divisor;
input [dividendBITS-1:0] dividend;
output [dividendBITS-1:0]quotient_final;
wire [dividendBITS-1:0]quotient[dividendBITS-1:0];
wire [dividendBITS-1:0]quotient_temp[dividendBITS-1:0];
output [addBITS-1:0]remainder;
wire [addBITS-1:0] difference[dividendBITS-1:0];
genvar i;
wire [addBITS-1:0] divisor_int [dividendBITS-1:0];
wire [addBITS-1:0] dividend_int [dividendBITS-1:0];	
wire [addBITS-1:0] stage_divisor_int_out [dividendBITS-1:0];
wire [addBITS-1:0]register_dividend_int_out[dividendBITS-1:0];
wire [addBITS-1:0]register_divisor_int_out[dividendBITS-1:0];
wire [dividendBITS-1:0]register_quotient_int_out[dividendBITS-1:0];
wire [dividendBITS-1:0]stage_quotient_int_in[dividendBITS-1:0];
wire [dividendBITS-1:0]register_quotient_int_in[dividendBITS-1:0];

assign divisor_int[dividendBITS-1]=divisor;
assign dividend_int[dividendBITS-1]=dividend;
assign stage_quotient_int_in[dividendBITS-1] = 'b0;

Stage S1 (divisor_int[dividendBITS-1],dividend_int[dividendBITS-1],dividendBITS-1,stage_quotient_int_in[dividendBITS-1],quotient[dividendBITS-1],difference[dividendBITS-1],stage_divisor_int_out[dividendBITS-1]); // first instance of the stage 
Register R (stage_divisor_int_out[dividendBITS-1],difference[dividendBITS-1],quotient[dividendBITS-1],register_divisor_int_out[dividendBITS-1],register_dividend_int_out[dividendBITS-1],register_quotient_int_out[dividendBITS-1],clock);// first instance of register
generate
for (i=dividendBITS-2;i>=0; i=i-1)
begin
Stage S (register_divisor_int_out[i+1],register_dividend_int_out[i+1],i,register_quotient_int_out[i+1],quotient[i],difference[i],stage_divisor_int_out[i]); // using a generate loop to create instances, connecting each stage appropriately
Register R (stage_divisor_int_out[i],difference[i],quotient[i],register_divisor_int_out[i],register_dividend_int_out[i],register_quotient_int_out[i],clock); // register module instantiation
end
endgenerate 
assign quotient_final=register_quotient_int_out[0]; // final register slice quotient value
assign remainder=register_dividend_int_out[0]; // final register slice quotient value
endmodule





