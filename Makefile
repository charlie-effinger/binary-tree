# grader: I built this file.  -0
FFLAGS = -Wall -g
GOAL = fortran
DATA = test1.data

$(GOAL): $(GOAL).f
	f95 $(FFLAGS) -o $@ $^

test: $(GOAL)
	$(GOAL) < $(DATA)

clean:
	rm -f $(GOAL)
