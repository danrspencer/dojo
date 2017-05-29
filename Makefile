
javascript:
	cd languages/javascript && yarn install && yarn test -- --watch

typescript:
	@echo TODO

elm:
	cd languages/elm && yarn install && yarn elm-package install && yarn test -- --watch

php:
	@echo TODO

java:

intellij-file-watchers:
	cp ./resources/intellij/watcherTasks.xml ./idea/watcherTasks.xml
