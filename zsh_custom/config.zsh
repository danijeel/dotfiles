
export GOPATH=$HOME/go
export PATH=/Users/dln/.composer/vendor/bin:$PATH
export PATH=$GOPATH/bin:$PATH
export PATH=$HOME/dotfiles/bin:$PATH
export PATH=/usr/local/Cellar/bison/3.0.4/bin:$PATH
export PATH=/Users/dln/.node/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export COMPOSER_HOME=$HOME/.composer
export COMPOSER_CACHE_DIR=$COMPOSER_HOME/cache

export EDITOR=nano
export AWS_ACC=***REMOVED***

alias cgs="clear; git status"
alias lla="ls -la"
alias pa="php artisan"
alias puf="phpunit --verbose --debug --filter="
alias g="git"
alias nah="git reset --hard; git clean -df"
alias compsoer="composer"


#plugins=(git z zsh-autosuggestions)

docker_up() {
	local name=$(uname -s)
	case $name in
		'Darwin' )
			open --hide --background -a Docker
			;;
		'Linux' )
			# noop
			;;
		*)
		echo 'Cant start docker daemon'
	esac
}
drc() {
	echo "\nRemoving docker containers\n";
	for i in $(docker ps -aq); do docker rm -f $i; done
}
dri() {
	echo "\nRemoving docker images\n";
	for i in $(docker images -q); do docker rmi $i; done
}
drn() {
	echo "\nRemove all docket networks\n";
	docker network prune --force
}
inteleon() {
	ssh -i ~/.ssh/amazon.pem ubuntu@$*
}
aws_login() {
	eval ${$(aws ecr get-login --no-include-email)}
}
flushdns() {
	sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder
	local green=$(tput setaf 2)
	local reset=$(tput sgr0)
	echo -e "${green}\n dns flushed ${reset}"
}
composer_install() {
	docker run --rm -ti \
	-v $(pwd):/tmp/source \
	--workdir '/tmp/source' \
	-v $COMPOSER_CACHE_DIR:/root/.composer/cache \
	$AWS_ACC/php-utilities:latest \
	bash -c "composer install --working-dir=/tmp/source --ignore-platform-reqs --no-suggest"
}
c0mposer() {
	docker run --rm -ti \
	-v $(pwd):/tmp/source \
	--workdir '/tmp/source' \
	-v $COMPOSER_CACHE_DIR:/tmp/.composer/cache \
	$AWS_ACC/php-utilities:latest \
	composer $*
}
json_pretty() {
	# npm install -g underscore-cli
	underscore print --outfmt pretty
}
alias jsonp=json_pretty
alias jsonpretty=json_pretty
alias dps='docker ps -a'
alias dia="docker images -a"

docker_env() {
	docker inspect $* | jq '.[0].Config.Env'
}
code() {
	if [[ $# = 0 ]]
	then
		open -a "Visual Studio Code" -n
	else
		[[ $1 = /* ]] && F="$1" || F="$PWD/${1#./}"
		open -a "Visual Studio Code" -n --args "$F"
	fi
}
enter_base() {
	docker exec -it $(docker ps --filter='name=base' | awk 'NR>1 {print $1; exit}') bash
}
myip() {
	local ip=$(http ifconfig.co/json | jq '.ip')
	echo $ip | sed 's/^.\(.*\).$/\1/' | pbcopy
}
dbash() {
	if [[ $# = 0  ]]; then
		echo "No container id given"; exit 1;
	fi
	docker exec -it $1 bash
}
source <(awless completion zsh)
