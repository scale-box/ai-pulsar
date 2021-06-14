# docker exec -t scalebox_server1_1 java -cp job-server.jar org.openccf.PipelineParser3  http://oauth2:xxFj4vrtfxk6vwGUXgTA@git.local/csst/duose.git#master:clusters.yaml

import:
#	docker exec -t scalebox_server1_1 java -cp job-server.jar org.openccf.PipelineParser3  /pipelines/ai-pulsar/clusters.yaml
	docker exec -t scalebox_server1_1 java -cp job-server.jar org.openccf.PipelineParser3  /pipelines/ai-pulsar/pipeline.yaml
# multi-cluster deployments, code sync
	make sync-dist

up-app:
	docker exec -t scalebox_database_1 psql -Uopenccf -c "UPDATE t_pipeline SET status='RUNNING'"

sync:
	# rsync -av --exclude '.git' . openccf@10.255.128.1:/home/openccf/scalebox/pipelines/ai-pulsar
	rsync -av --exclude '.git' -e 'ssh -o "ProxyCommand ssh -A 10.255.128.1 -W %h:%p"' . root@223.193.33.31:/root/scalebox/pipelines/ai-pulsar
	date

# From default to c419
sync-dist:
#	ssh root@223.193.33.31 sudo chown -R fast /fast/gateway/code
	cd /gfsdata/gateway/code && rsync -av . root@223.193.33.31:/gfsdata/gateway/code

ssh:
	ssh -J 10.255.128.1 root@223.193.33.31