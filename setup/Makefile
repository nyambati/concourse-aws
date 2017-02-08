ELASTIC_IP = $@[1]
bosh_init:
	./bin/make_manifest_bosh-init.sh

bosh_deploy:
	bosh-init deploy bosh-director.yml

cloud_config:
	./bin/make_cloud_config.sh

update_config:
	bosh update cloud-config aws-cloud.yml

concourse_config:
	./bin/make_manifest_concourse.sh

upload_stemcell:
	bosh upload stemcell https://bosh.io/d/stemcells/bosh-aws-xen-hvm-ubuntu-trusty-go_agent --skip-if-exists
	bosh upload release https://bosh.io/d/github.com/cloudfoundry-incubator/garden-runc-release?v=0.4.0 --skip-if-exists
  bosh upload release https://bosh.io/d/github.com/concourse/concourse?v=1.4.1 --skip-if-exists

concourse_deploy:
	bosh deployment concourse.yml
	bosh deploy

