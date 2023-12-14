all: prepare run
 
prepare:
	docker compose up db api -d
	docker compose exec api bundle exec rake db:migrate:reset
	docker compose exec api bundle exec rake db:seed

run:
	docker compose exec api foreman start