run-docker:
	docker build -t libvncserver-cross-mingw32 .
	@$(eval TEMP_CONTAINER=$(shell docker create -ti --name dummy 'libvncserver-cross-mingw32:latest' bash))
	@docker cp $(TEMP_CONTAINER):/libvncserver.dll ./libvncserver.dll
	@docker cp $(TEMP_CONTAINER):/libvncserver.dll.a ./libvncserver.dll.a
	@bash -c 'docker rm -fv dummy &>/dev/null'

