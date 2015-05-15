# A makefile to generate the printing and laser cutting files for
# makerspace signage.

# Folder structure
SRC_DIR = sign_sources
LASERABLES = laserables
PRINTABLES = printable
RASTER_IMAGES = raster

#SRC = $(notdir $(wildcard $(SRC_DIR)/*.svg))
SRC = $(wildcard $(SRC_DIR)/*.svg)
FILENAME = $(notdir $(SRC))
EPS = $(LASERABLES)/$(FILENAME:%.eps:%.svg)
DXF = $(LASERABLES)/$(FILENAME:%.eps:%.dxf)
PDF = $(PRINTABLES)/$(FILENAME:%.eps:%.pdf)
IMG = $(RASTER_IMAGES)/$(FILENAME:%.eps:%.png)

.PHONY : all laser eps print image clean clean-laser clean-image clean-laser

all: laser print

laser : $(DXF)

$(DXF) : $(SRC)
	inkscape $< --export-id=layer1 --export-dxf=$@

eps: $(EPS)

$(EPS) : $(SRC)
	inkscape $< --export-id=layer1 --export-eps=$@

print: $(PDF)

$(PDF): $(SRC)
	inkscape $< --export-id=layer2 --export-pdf=$@
