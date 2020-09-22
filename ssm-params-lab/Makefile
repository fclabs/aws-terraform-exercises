.DEFAULT_GOAL := apply

ORDER := setup-lab
DESTROY_ORDER := setup-lab 

init plan apply: $(ORDER)
destroy clean: $(DESTROY_ORDER)

$(ORDER):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: $(ORDER) init plan apply destroy clean