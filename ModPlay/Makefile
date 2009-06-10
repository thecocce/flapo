OUTPUT=test.swf

all: $(OUTPUT)

$(OUTPUT): $(wildcard *.hx)
	haxe compile.hxml
	haxe -as3 as3_src -main Test
	
.PHONY: clean
clean:
	rm -fr $(OUTPUT) *~ as3_src

