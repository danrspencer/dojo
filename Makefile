
javascript:
	cd languages/javascript && yarn install && yarn test -- --watchAll

elm:
	cd languages/elm && yarn install && yarn elm-package install && yarn test -- --watch

php:
	cd languages/php && php installer && php composer.phar install && brew install watchman && ./phpunit-watcher.sh

java:
	cd languages/java && gradle init && gradle test --continuous

intellij-file-watchers:
	cp ./resources/intellij/watcherTasks.xml ./idea/watcherTasks.xml
