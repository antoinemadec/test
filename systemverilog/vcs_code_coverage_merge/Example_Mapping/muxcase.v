module muxcase(sel,mux_in,out);
input [1:0]sel;
input [3:0]mux_in;
output out;
reg out;
always @(sel , mux_in)
begin
case(sel)

2'b00:out=mux_in[0];
2'b01:out=mux_in[1];
2'b10:out=mux_in[2];
2'b11:out=mux_in[3];

endcase
end
endmodule 

