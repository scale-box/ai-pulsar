IMAGE=fast/pytorch:rocm

build:
	docker build --network host -t $(IMAGE) rocm-pytorch

build-diy:

load:
	date
	docker save $(IMAGE) | zstd > /gfsdata/pytorch-rocm.tar.zst
	date
	for H in 10.11.16.79 10.11.16.80 ; \
	do \
	  echo $$H ; \
	  ssh root@$$H docker rmi $(IMAGE) ; \
	  ssh root@$$H 'zstd -dc /gfsdata/pytorch-rocm.tar.zst | docker load ' ; \
	done
	sudo rm -f /gfsdata/pytorch-rocm.tar.zst
