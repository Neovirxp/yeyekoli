##################################################################
#### Docker Commands
##################################################################

start:
	docker-compose up -d yeyekoli_api

restart:
	docker-compose restart yeyekoli_api

restart.postgres:
	docker-compose restart postgres

stop:
	docker-compose stop yeyekoli_api

stop.postgres:
	docker-compose stop postgres

logs:
	docker-compose logs -f yeyekoli_api

logs.postgres:
	docker-compose logs -f postgres

shell:
	docker-compose run --rm yeyekoli_api sh

shell.postgres:
	docker-compose run --rm postgres bash

shell.test:
	ENV=test docker-compose run --rm yeyekoli_api sh

##################################################################
#### Development Commands
##################################################################

seeds:
	docker-compose run --rm --no-deps yeyekoli_api sh -c "mix run priv/repo/seeds.exs"

gettext:
	docker-compose run --rm --no-deps yeyekoli_api sh -c "mix gettext.extract && mix gettext.merge priv/gettext"

routes:
	docker-compose run --rm  yeyekoli_api sh -c "mix phx.routes"

credo:
	ENV=test docker-compose run --rm --no-deps yeyekoli_api sh -c "mix credo"

credo.all:
	ENV=test docker-compose run --rm --no-deps yeyekoli_api sh -c "mix credo -a"

test:
	ENV=test docker-compose run --rm  yeyekoli_api sh -c "mix test"

test.file:
	ENV=test docker-compose run --rm  yeyekoli_api sh -c "mix test test/${file}"

coverage:
	ENV=test docker-compose run --rm yeyekoli_api sh -c "mix coveralls.html"

coverage.show:
	command -v sensible-browser &> /dev/null \
	&& sensible-browser ./src/cover/excoveralls.html \
	|| open ./src/cover/excoveralls.html

deps.update:
	docker-compose run --rm yeyekoli_api sh -c "mix deps.clean --unused && mix deps.get && mix deps.compile"

ecto.reset:
	docker-compose run --rm yeyekoli_api sh -c "mix ecto.reset"

ecto.setup:
	docker-compose run --rm yeyekoli_api sh -c "mix ecto.setup"
	make seeds

ecto.migrate:
	docker-compose run --rm yeyekoli_api sh -c "mix ecto.migrate"

ecto.rollback:
	docker-compose run --rm yeyekoli_api sh -c "mix ecto.rollback"

ecto.gen.migration:
	docker-compose run --rm yeyekoli_api sh -c "mix ecto.gen.migration ${file}"

update:
	make deps.update ecto.setup

##################################################################
#### CI/CD Commands
##################################################################

check.all:
	ENV=test docker-compose run --rm -T yeyekoli_api sh -c "sh /scripts/run-checks.sh"

build.release:
	rm -rf ./src/_build/prod/rel
	ENV=prod docker-compose run --rm -T --no-deps yeyekoli_api sh -c "mix deps.get && mix deps.compile \
			&& mix release --no-tar --env=prod"

##################################################################
#### Bootstrap Commands
##################################################################

bootstrap:
	docker-compose run --rm -T --no-deps yeyekoli_api sh -c "mix deps.get && mix deps.compile"
	make ecto.setup

reset:
	docker-compose run --rm --no-deps yeyekoli_api sh -c "rm -rf /app/src/deps/* /app/src/_build/dev/*"
	docker-compose stop
	docker-compose rm -f
