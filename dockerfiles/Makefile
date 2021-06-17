IMAGE=hub.cstcloud.cn/fast/pytorch:rocm

build:
	docker build --network host -t $(IMAGE) rocm-pytorch

build-diy:
	docker build --network host -f rocm-pytorch/Dockerfile.diy -t $(IMAGE) rocm-pytorch

build-runtime:
	docker build --network host -f rocm-pytorch/Dockerfile.rocm-runtime -t hub.cstcloud.cn/fast/pytorch:rocm-4.0.1-runtime rocm-pytorch

push:
	docker push $(IMAGE)

transfer:
	docker save $(IMAGE) | zstd | pv | ssh node2 'zstd -d | docker load'

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

run:
	docker run -it --rm hub.cstcloud.cn/fast/pytorch:rocm-4.0.1-runtime
