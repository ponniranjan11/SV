

module Register(register_divisor_in,register_dividend_in,register_quotient_in,register_divisor_out,register_dividend_out,register_quotient_out,clock);
parameter divisorBITS=8;
parameter dividendBITS=16;
parameter addBITS=divisorBITS+dividendBITS-1;
input [addBITS-1:0]register_dividend_in;
input [addBITS-1:0]register_divisor_in;
input [dividendBITS-1:0]register_quotient_in;
input clock;
output reg [22:0]register_dividend_out;
output reg [22:0]register_divisor_out;
output reg[15:0] register_quotient_out;
always@(posedge clock)     
begin
register_dividend_out<=register_dividend_in; 
register_divisor_out<=register_divisor_in;
register_quotient_out<=register_quotient_in;
end
endmodule
