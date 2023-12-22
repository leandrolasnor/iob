all: prepare run

prepare:
	docker compose up backend -d
	docker compose exec backend bundle exec rake db:migrate:reset
	docker compose exec backend bundle exec rake db:seed

run:
	docker compose exec backend foreman start
yarn:
  yarn --cwd ./reacting install
