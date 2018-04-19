.PHONY: clean
.PHONY: all


help:
	@echo "without PHONY, no way to call all twice, since file 'all' exist after first call"
	@echo "all:	call PHONY target 'all'"
	@echo "clean:	call PHONY target 'clean'"


all:
	@echo all
	touch all

clean:
	@echo clean
	rm all
