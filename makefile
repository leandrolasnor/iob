all: prepare run

prepare:
	docker compose up app -d
	docker compose exec app bundle exec rake db:migrate:reset
	docker compose exec app bundle exec rake db:seed

run:
	docker compose exec app foreman start
