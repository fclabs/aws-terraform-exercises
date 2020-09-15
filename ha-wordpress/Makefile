.DEFAULT_GOAL := apply

ORDER := s3 cloudfront networking elb database servers
DESTROY_ORDER := servers elb database networking cloudfront s3

init plan apply: $(ORDER)
destroy clean: $(DESTROY_ORDER)

$(ORDER):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: $(ORDER) init plan apply destroy clean