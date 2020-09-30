.DEFAULT_GOAL := apply

ORDER := iam s3 lambda codecommit
DESTROY_ORDER := codecommit lambda s3 iam

init plan apply: $(ORDER)
destroy clean: $(DESTROY_ORDER)

$(ORDER):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: $(ORDER) init plan apply destroy clean
