# kroman-dev's directory
KROMAN_DEV_DIR = $(CURDIR)

# kroman's root directory which contains all kroman projects
KROMAN_ROOT = $(dir $(KROMAN_DEV_DIR))

# kroman web site directory
KROMAN_WEB = $(addsuffix kroman-site, $(KROMAN_ROOT))

# list of all kroman projects directory
KROMAN_ALL_PROJS = $(addsuffix kroman*, $(KROMAN_ROOT))

# list of all normal kroman projects without web site and this dev
KROMAN_PROJS = $(shell cd ..; find $${PWD} -mindepth 1 -maxdepth 1 \
! -name "kroman-site" ! -name "kroman-dev" -name "kroman*")

KROMAN_PROJ_READMES = $(addsuffix /README.md, $(KROMAN_PROJS))
KROMAN_PROJ_README_TPLS = $(addsuffix /README.tpl, $(KROMAN_PROJS))

KROMAN_README_TPL = $(KROMAN_DEV_DIR)/README.tpl

default:
	@echo Default Do Nothing

genreadme: $(KROMAN_PROJ_READMES)

# Todo make it not so big list
$(KROMAN_PROJ_READMES): $(KROMAN_PROJ_README_TPLS)
	./genreadme.sh $@ $(KROMAN_README_TPL)

copyclib:
	@echo Do Nothing

.PHONY: genreadme
