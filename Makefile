# These options require OpenScad snapshot
OPENSCAD="/Applications/OpenSCAD Snapshot.app/Contents/MacOS/OpenSCAD" --enable=manifold --export-format binstl

# This will work with the stable openscad
#OPENSCAD="/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"

SRC_DIR := .
STL_DIR := stl

# Generate a list of source files matching the pattern
EXPORT_SCAD_FILES := $(wildcard $(SRC_DIR)/export_*.scad)

# Generate a list of corresponding STL target files
STL_TARGETS := $(patsubst $(SRC_DIR)/export_%.scad,$(STL_DIR)/%.stl,$(EXPORT_SCAD_FILES))

# Default target
all: $(STL_TARGETS)

# Rule to create keycap files from scad files starting with `export_`
$(STL_DIR)/%.stl: $(SRC_DIR)/export_%.scad $(SRC_DIR)/gen_sprued_keycaps.scad $(SRC_DIR)/Choc_Chicago_Steno.scad $(SRC_DIR)/Choc_Chicago_Steno_Thumb.scad $(SRC_DIR)/Choc_Chicago_Steno_Convex.scad
	$(OPENSCAD) --render -o $@ $<

# Target to generate single key stls
AVAILABLE_KEY_IDS := $(shell perl -n -e'/\["(cs_.*)",/ && print "$$1\n"' < gen_sprued_keycaps.scad)
singles:
	@for id in $(AVAILABLE_KEY_IDS); do \
		$(OPENSCAD) --render -Dkeycap_id=\"$$id\" -o $(STL_DIR)/single_keys/$$id.stl gen_single_keycap.scad; \
	done

# Remove generated STL files
clean:
	rm -f $(STL_TARGETS)

# Prevent make from treating clean as a file target
.PHONY: clean


export-cs:
	$(OPENSCAD) --render -o stl/export_cs.stl export_cs.scad

export-thumb15:
	$(OPENSCAD) --render -o stl/cs_thumb15.stl Choc_Chicago_Steno_Thumb.scad
