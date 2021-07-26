os = /usr/local/bin/openscad
im = /usr/local/bin/magick
opts =
imgs = PN1_3_narrow_fins.png PN2_3_broad_fins.png PN3_5_narrow_fins.png

.PHONY: all
all: $(imgs)

%.png: ../../%.scad
	$(os) $(opts) --camera=0,0,0,52.2,0,168.5,700 --imgsize=2048,2046 \
				  -o $@ $<
	$(im) mogrify -transparent "rgb(255, 255, 229)" $@
	$(im) mogrify -trim $@

.PHONY: clean
clean:
	-rm $(imgs) 2> /dev/null || true
