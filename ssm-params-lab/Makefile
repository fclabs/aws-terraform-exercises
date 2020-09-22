.DEFAULT_GOAL := apply

ORDER := iam lambda create-ssm-params
DESTROY_ORDER := create-ssm-params lambda iam

init plan apply: $(ORDER)
destroy clean: $(DESTROY_ORDER)

$(ORDER):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: $(ORDER) init plan apply destroy clean