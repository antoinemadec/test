module mux4by1if(sel,mux_in,out,out1);
input [1:0]sel;
input [3:0]mux_in;
output out,out1;
reg out,out1;
muxcase muxcase_inst(sel,mux_in,out1);
always @ (sel , mux_in)
begin 
if (sel==0)
out = mux_in[0];
else if (sel==1)
out = mux_in[1];
else if (sel==2)
out = mux_in[2];
else if(sel==3)
out = mux_in[3];
else 
out = 1'b0;
end 
endmodule

