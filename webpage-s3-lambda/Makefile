.DEFAULT_GOAL := apply

ORDER := iam lambda api s3_site
DESTROY_ORDER :=  s3_site  api  lambda iam

init plan apply: $(ORDER)
destroy clean: $(DESTROY_ORDER)

$(ORDER):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: $(ORDER) init plan apply destroy clean