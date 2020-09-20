.DEFAULT_GOAL := apply

ORDER := networking kms server_vault server_client
DESTROY_ORDER := server_vault server_client kms networking

init plan apply: $(ORDER)
destroy clean: $(DESTROY_ORDER)

$(ORDER):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: $(ORDER) init plan apply destroy clean