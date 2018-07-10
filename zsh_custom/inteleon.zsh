# private enviornment variables
source $HOME/.secrets


composer_install() {
	docker run --rm -ti \
	-v $(pwd):/tmp/source \
	--workdir '/tmp/source' \
	-v $COMPOSER_CACHE_DIR:/var/run/composer/cache \
	$AWS_ACC/php-utilities:latest \
	bash -c "composer install --working-dir=/tmp/source --ignore-platform-reqs --no-suggest"
}
c0mposer() {
	docker run --rm -ti \
	-v $(pwd):/tmp/source \
	--workdir '/tmp/source' \
	-v $COMPOSER_CACHE_DIR:/var/run/composer/cache \
	$AWS_ACC/php-utilities:latest \
	composer $*
}
php_security_checker() {
	docker run --rm -ti \
	-v $(pwd):/tmp \
	$AWS_ACC/php-utilities:latest \
	security-checker security:check /tmp/composer.lock
}

inteleon() {
	ssh -i $INT_PEM $INT_USR@$*
}
swarm_prod() {
	docker --tls -H $INT_SWARM_PRODUCTION $*
}
swarm_staging() {
	docker --tls -H $INT_SWARM_STAGING $*
}