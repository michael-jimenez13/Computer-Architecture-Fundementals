module Mux21(out, in, sel);
input [1:0] in;
input sel;
output out;

reg out;

always@(sel or in[0] or in[1])
begin 
	if(sel)
		out <= in[0]
	else
		out <= in[1]
end

endmodule