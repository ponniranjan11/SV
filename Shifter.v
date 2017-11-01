

module Shifter(divisor,shiftby,shiftedvalue);
parameter divisorBITS=8;
parameter dividendBITS=16;
parameter shiftBITS=divisorBITS+dividendBITS-1;
input [shiftBITS-1:0]divisor;
input [31:0]shiftby;
output [shiftBITS-1:0]shiftedvalue;

assign shiftedvalue=divisor<<shiftby; 

endmodule 


