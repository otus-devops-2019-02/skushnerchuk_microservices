export USER_NAME = drcoyote
# Список папок, в которые заглядываем при сборке всех образов
export SOURCES = src/post-py src/comment src/ui \
								 monitoring/prometheus \
								 monitoring/percona_exporter \
								 monitoring/cloud_prober \
								 monitoring/alertmanager
# Список образов, которые заливаем в репозитарий
export IMAGES = ${USER_NAME}/prometheus ${USER_NAME}/percona-exporter \
								${USER_NAME}/cloud-prober ${USER_NAME}/alertmanager \
								${USER_NAME}/post ${USER_NAME}/ui ${USER_NAME}/comment

# По умолчанию и собираем и выливаем в репозитарий
all: build_images push_images
build_all: build_images
push_all: push_images

build_images:
	for i in $(SOURCES); do cd $$i; bash docker_build.sh; cd -; done

push_images:
	for i in $(IMAGES); do docker push $$i; done

build:
	cd ${src}; bash docker_build.sh;

push:
	docker push ${USER_NAME}/${image};
