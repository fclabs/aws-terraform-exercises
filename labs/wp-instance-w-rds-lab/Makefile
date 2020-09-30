.DEFAULT_GOAL := apply

ORDER := networking database server
DESTROY_ORDER := server database networking

init plan apply: $(ORDER)
destroy clean: $(DESTROY_ORDER)

$(ORDER):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: $(ORDER) init plan apply destroy clean