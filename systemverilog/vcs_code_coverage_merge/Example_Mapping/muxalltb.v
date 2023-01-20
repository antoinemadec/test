module top();
wire out_if,out_case;
reg [1:0]sel;
reg [3:0]muxin;

mux4by1if mux_if_inst(.sel(sel),.mux_in(muxin),.out(out_if),.out1(out_case));

initial

begin 
sel =0; muxin=4'b0001;

#5 sel = 2;  muxin = 4'b1010;
#5 sel = 0;  muxin = 4'b1110;

end
endmodule

