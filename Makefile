RAILS_ENV = test
BUNDLE = RAILS_ENV=${RAILS_ENV} bundle
RSPEC = rspec
APPRAISAL = appraisal

all: test

test: bundler appraisal
	${BUNDLE} exec ${APPRAISAL} ${RSPEC} spec 2>&1

bundler:
	gem install bundler
	${BUNDLE} install ${BUNDLE_OPTIONS}

appraisal:
	${BUNDLE} exec ${APPRAISAL} install
