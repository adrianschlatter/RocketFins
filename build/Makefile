os = /usr/local/bin/openscad
opts =
stls = PN1_3_narrow_fins.stl PN2_3_broad_fins.stl PN3_5_narrow_fins.stl

.PHONY: all
all: $(stls)

%.stl: ../%.scad
	$(os) $(opts) -o $@ $<


.PHONY: clean
clean:
	-rm $(stls) 2> /dev/null || true
