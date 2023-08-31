# These options require OpenScad snapshot
OPENSCAD="/Applications/OpenSCAD Snapshot.app/Contents/MacOS/OpenSCAD" --enable=fast-csg --enable=lazy-union

# This will work with the stable openscad
# OPENSCAD="/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"

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

# Remove generated STL files
clean:
	rm -f $(STL_TARGETS)

# Prevent make from treating clean as a file target
.PHONY: clean


export-cs:
	$(OPENSCAD) --render -o stl/export_cs.stl export_cs.scad

export-thumb15:
	$(OPENSCAD) --render -o stl/cs_thumb15.stl Choc_Chicago_Steno_Thumb.scad
