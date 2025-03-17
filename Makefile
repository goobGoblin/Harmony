build:
	docker-compose build

# Permission user development in /dev/kvm
run:
	docker-compose run --rm  --user root development_flutter bash

# Run image flutter development
# run:
# 	docker-compose run --rm development_flutter bash