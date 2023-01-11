all: clean comp run1 cov

comp:
	vcs -sverilog test.sv -cm line+tgl -cm_hier hier_file.cfg
	
run1:
	simv -cm line+tgl

cov:
	verdi -cov -covdir simv.vdb

clean:
	\rm -rf *.key work csrc* simv* ucli* simv* novas* verdi* cm* vd*

