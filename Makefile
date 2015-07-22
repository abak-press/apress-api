RAILS_ENV = test
BUNDLE = RAILS_ENV=${RAILS_ENV} bundle
RSPEC = rspec
APPRAISAL = appraisal

define DATABASE_YML
test:
  adapter: postgresql
  database: docker
  username: docker
  host: localhost
  min_messages: warning
endef
export DATABASE_YML

all: test

test: configs bundler appraisal
	${BUNDLE} exec ${APPRAISAL} ${RSPEC} spec 2>&1

configs:
	@echo "$${DATABASE_YML}" > spec/internal/config/database.yml

bundler:
	gem install bundler
	${BUNDLE} install ${BUNDLE_OPTIONS}

appraisal:
	${BUNDLE} exec ${APPRAISAL} install
