module test(a,b,cin,sum,cout);
 input a,b,cin;
 output sum,cout;
 reg ttemp;
 assign {cout,sum}=a+b+cin;
endmodule

module foo(in,out);
 input in;
 output out;
 assign out=in;
 initial
	$display("Inside foo");
endmodule

module bar(bin,bout);
 input bin;
 output bout;
 reg btemp;
 assign bout=bin;
endmodule

module top;
 reg a,b,cin,in,bin;
 wire sum,cout,out,bout;
 test inst(.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout));
 foo foo_inst(.in(in),.out(out));
 bar bar_inst(.bin(bin),.bout(bout));
 initial
 begin
	{a,b,cin,in,bin}=0;
	#50 $finish;
 end	
 always #5 {a,b,cin,in,bin}=$random;
 initial $monitor("a=%0d b=%0d cin=%0d sum=%0d cout=%0d in=%0d out=%0d bin=%0d bout=%0d",a,b,cin,sum,cout,in,out,bin,bout);	
endmodule
