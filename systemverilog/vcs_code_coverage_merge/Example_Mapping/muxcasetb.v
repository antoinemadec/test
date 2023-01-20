module tb();
wire out_case;
reg [1:0]sel;
reg [3:0]muxin;

muxcase mux_case_inst(.sel(sel),.mux_in(muxin),.out(out_case));

initial

begin 

sel =0; muxin=4'b0011;
#5 sel =1 ; muxin =4'b0110;

#5 sel = 3;  muxin = 4'b0101;

end
endmodule

