all: stop start exec

start:
	docker run -it -d \
		--env TF_NAMESPACE=$$TF_NAMESPACE \
		--env AWS_PROFILE="kh-labs" \
		--env AWS_ACCESS_KEY_ID= "$$AWS_ACCESS_KEY_ID"\
		--env AWS_SECRET_ACCESS_KEY= "$$AWS_SECRET_ACCESS_KEY"\
		--env OWNER=$$OWNER \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v k3s_packer:/output \
		-v $$PWD:/$$(basename $$PWD) \
		-w /$$(basename $$PWD) \
		--name $$(basename $$PWD) \
		--hostname $$(basename $$PWD) \
		bryandollery/terraform-packer-aws-alpine bash

stop:
	docker rm -f $$(basename $$PWD) 2> /dev/null || true

exec:
	docker exec -it $$(basename $$PWD) bash || true

build:
	packer build packer.json
