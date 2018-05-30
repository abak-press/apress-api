# v1.20.0

* 2018-05-29 [7910458](../../commit/7910458) - __(Denis Korobicyn)__ Release 1.20.0wq 
* 2018-05-29 [876a71c](../../commit/876a71c) - __(Denis Korobicyn)__ feature: add correct headers on json pagination cache 
https://jira.railsc.ru/browse/ORDERS-1524

# v1.19.2

* 2018-04-16 [243a81f](../../commit/243a81f) - __(Denis Korobicyn)__ feature(callbacks): add inf reapet errors 
https://jira.railsc.ru/browse/ORDERS-1484

* 2018-04-11 [ca1c1f2](../../commit/ca1c1f2) - __(Denis Korobicyn)__ fix(callbacks): add exponential backoff 
https://jira.railsc.ru/browse/ORDERS-1484

# v1.19.1

* 2018-04-10 [bf3b4ce](../../commit/bf3b4ce) - __(Denis Korobicyn)__ chore(dorne): allow only master release 
* 2018-04-06 [553c515](../../commit/553c515) - __(Denis Korobicyn)__ fix(callbacks): add fatal exeptions 
https://jira.railsc.ru/browse/ORDERS-1484

# v1.19.0

* 2018-04-03 [12aa8e0](../../commit/12aa8e0) - __(Denis Korobicyn)__ feature: add callbacks logic 
https://jira.railsc.ru/browse/ORDERS-1484

# v1.18.0

* 2018-01-30 [26a7884](../../commit/26a7884) - __(Dmitry Bochkarev)__ chore: restrict pg version 
http://samson.railsc.ru/projects/pulscen-production/deploys/9785
https://jira.railsc.ru/browse/PC4-21470

https://github.com/abak-press/pulscen/commit/ff1e27f89c45a30bb0479383d864a15a526422fd
https://github.com/abak-press/pulscen/pull/16479

* 2017-12-22 [33d5523](../../commit/33d5523) - __(Dmitry Bochkarev)__ fix(newrelic): не реквайрим устаревший модуль 
https://jira.railsc.ru/browse/PC4-19900

* 2017-12-22 [5132ad7](../../commit/5132ad7) - __(Dmitry Bochkarev)__ fix(new_relic): выпил ::NewRelic::Agent::Instrumentation::Rails3::Errors 
https://jira.railsc.ru/browse/PC4-19900

модуль был удален, использвание методов в коде нет:
https://jira.railsc.ru/browse/PC4-19900?focusedCommentId=146483&page=com.atlassian.jira.plugin.system.issuetabpanels:comment-tabpanel#comment-146483

# v1.17.1

* 2017-09-07 [08c3799](../../commit/08c3799) - __(Denis Korobicyn)__ fix: api tests 

# v1.17.0

* 2017-06-28 [96ff1ea](../../commit/96ff1ea) - __(Denis Korobicyn)__ fix: namespaces for default responses 
https://jira.railsc.ru/browse/PC4-19812

* 2017-04-25 [0cc731e](../../commit/0cc731e) - __(Denis Korobicyn)__ feature: move swagger to apress-documentation 
https://jira.railsc.ru/browse/PC4-19470

# v1.16.1

* 2017-08-02 [9f03ee6](../../commit/9f03ee6) - __(Artem Napolskih)__ fix: rails 4 New Relic support 

# v1.16.0

* 2017-07-31 [2da0e08](../../commit/2da0e08) - __(Artem Napolskih)__ feature: Add tokens controller load hook 

# v1.15.0

* 2017-07-28 [ee55219](../../commit/ee55219) - __(Artem Napolskih)__ feature: no find Client when access_id not given 

# v1.14.0

* 2017-07-18 [df408d2](../../commit/df408d2) - __(Nikolay Kondratyev)__ feat(swagger): add type representing a links object 

# v1.13.0

* 2017-07-13 [10c6c6c](../../commit/10c6c6c) - __(Dmitry Bochkarev)__ fix(drone): неверные отступы в .drone.yml 
при возникновении ошибки ActionController::ParameterMissing
возвращается 400 статус, а не 404

* 2017-07-09 [8ee510c](../../commit/8ee510c) - __(Dmitry Bochkarev)__ fix: 400 статус для ActionController::ParameterMissing 
* 2017-06-27 [98e02cd](../../commit/98e02cd) - __(Semyon Pupkov)__ chore: add rails 4.0 and 4.1 to Appraisals 
* 2017-05-25 [4d746a4](../../commit/4d746a4) - __(JSinx)__ Release 1.12.1 
* 2017-05-25 [ef793b8](../../commit/ef793b8) - __(JSinx)__ fix(client): namespace Apress::Api for model Client 
* 2017-04-21 [db5ac0e](../../commit/db5ac0e) - __(Semyon Pupkov)__ chore: require only necessary files 
* 2017-04-20 [d5a9c5a](../../commit/d5a9c5a) - __(Semyon Pupkov)__ chore: remove support for rails 3.1 and ruby 1.9 

# v1.12.0

* 2017-02-10 [a54b723](../../commit/a54b723) - __(Nikolay Kondratyev)__ feat(gems): update swagger-core dependency 
* 2017-02-21 [45b4bee](../../commit/45b4bee) - __(Andrey Shmelkov)__ feature(pagination): Link, X-Per-Page, X-Page headers 
В метод #pagination_headers добавлена поддержка заголовков X-Page,
X-Per-Page и Link (RFC 5988)

https://jira.railsc.ru/browse/RAD-294

# v1.11.0

* 2017-01-10 [e7048d7](../../commit/e7048d7) - __(Semyon Pupkov)__ feature: render status in body for unproccesable error 

# v1.10.2

* 2017-01-11 [6da5c9c](../../commit/6da5c9c) - __(Semyon Pupkov)__ fix: old UnproccesableError class does not work across alias 
https://github.com/abak-press/apress-api/issues/34

# v1.10.1

* 2016-12-26 [7663d55](../../commit/7663d55) - __(Michail Merkushin)__ fix: Include Newrelic modules for different Rails versions 
https://jira.railsc.ru/browse/PC4-18051

# v1.10.0

* 2016-12-09 [3a4459f](../../commit/3a4459f) - __(Pavel Galkin)__ fix: move UnproccesableError alias to a separate file 
* 2016-12-08 [ef4ece2](../../commit/ef4ece2) - __(Nikolay Kondratyev)__ feat(gems): add swagger-core dependency 
* 2016-12-08 [2f188ce](../../commit/2f188ce) - __(Nikolay Kondratyev)__ feat(rspec): add swagger schema matcher 
* 2016-11-29 [12c2a02](../../commit/12c2a02) - __(Nikolay Kondratyev)__ fix: security definitions 
* 2016-12-07 [eb10a20](../../commit/eb10a20) - __(Pavel Galkin)__ fix: typo in error class 
Сложное слово!

# v1.9.0

* 2016-12-06 [7ea5ec2](../../commit/7ea5ec2) - __(Michail Merkushin)__ chore: Add drone and dip 
* 2016-12-05 [1242c99](../../commit/1242c99) - __(Michail Merkushin)__ feature: Add newrelic tracers 
https://jira.railsc.ru/browse/PC4-18051

# v1.8.3

* 2016-09-21 [c7659b1](../../commit/c7659b1) - __(Semyon Pupkov)__ refactor: remove dependency from migration_comments 
* 2016-09-21 [c157718](../../commit/c157718) - __(Semyon Pupkov)__ chore: add docker-compose 

# v1.8.2

* 2016-09-12 [2f52c26](../../commit/2f52c26) - __(Denis Korobicyn)__ chore: lock rails < 5.0.0 
* 2016-09-12 [cbb16ec](../../commit/cbb16ec) - __(Denis Korobicyn)__ fix: remove asset_path hacks 
https://jira.railsc.ru/browse/PC4-17992

# v1.8.1

* 2016-08-23 [4f83163](../../commit/4f83163) - __(Salahutdinov Dmitry)__ feature: speed up swagger load 
* 2016-08-11 [0adce54](../../commit/0adce54) - __(Salahutdinov Dmitry)__ fix: minor type fix 
* 2016-08-10 [93678e7](../../commit/93678e7) - __(Salahutdinov Dmitry)__ fix: try out swaggered api from any host/port, use hostless path 

# v1.8.0

* 2016-07-13 [59e65ec](../../commit/59e65ec) - __(Denis Korobicyn)__ feature: swagger documentation 

# v1.7.0

* 2016-07-20 [39880d3](../../commit/39880d3) - __(Sergey Kucher)__ feature: ability to handle standard error's descendants for unprocessable 
https://jira.railsc.ru/browse/ORDERS-86

# v1.6.0

* 2016-06-06 [022ec6a](../../commit/022ec6a) - __(Denis Korobicyn)__ feature: unproccessable method 

# v1.5.0

* 2016-05-06 [c8935c8](../../commit/c8935c8) - __(Denis Korobicyn)__ feature: paginating params preprocessing 

# v1.4.0

* 2016-04-29 [1635272](../../commit/1635272) - __(Denis Korobicyn)__ feature: json paginating_cache helper 
https://jira.railsc.ru/browse/PC4-17107

* 2016-04-22 [966ac22](../../commit/966ac22) - __(Denis Korobicyn)__ feature: removed cache stubs 
https://jira.railsc.ru/browse/PC4-17107

# v1.3.0

* 2016-04-25 [faf3bde](../../commit/faf3bde) - __(Michail Merkushin)__ feature: Allways find current_api_client 

# v1.2.0

* 2016-03-28 [20d6676](../../commit/20d6676) - __(Salahutdinov Dmitry)__ feature: пагинация в заголовках 
https://jira.railsc.ru/browse/PC4-16460

# v1.1.0

* 2016-03-14 [cb8f200](../../commit/cb8f200) - __(Denis Korobitcin)__ feature: added caching module 
https://jira.railsc.ru/browse/PC4-16800

# v1.0.0

* 2016-01-10 [464b9c8](../../commit/464b9c8) - __(Michail Merkushin)__ feature: not always return 200 when ajax 
https://jira.railsc.ru/browse/PC4-16378

# v0.2.1

* 2015-12-16 [d5d46a6](../../commit/d5d46a6) - __(Michail Merkushin)__ feature: make AuthService#access_id as public meth 
https://jira.railsc.ru/browse/PC4-16202

# v0.2.0

* 2015-11-18 [4b336ed](../../commit/4b336ed) - __(Denis Korobitcin)__ feature(api-rescue): render_json method 

# v0.1.0

* 2015-09-17 [b09a647](../../commit/b09a647) - __(Sergey Kucher)__ chore: move match_json_schema from barmen pc4-15522 

# v0.0.2

* 2015-08-12 [a1f5e0d](../../commit/a1f5e0d) - __(Michail Merkushin)__ feature: respond with 403 on Pundit errors 
https://jira.railsc.ru/browse/PC4-15338

# v0.0.1

* 2015-08-06 [cf77643](../../commit/cf77643) - __(bibendi)__ move column device_id to gem api-application 
* 2015-08-05 [eba14a6](../../commit/eba14a6) - __(bibendi)__ fix: add lazy load hook on client and small fixes 
https://jira.railsc.ru/browse/PC4-15271

* 2015-07-22 [015c863](../../commit/015c863) - __(bibendi)__ Initial commit 
* 2015-07-17 [dcee43c](../../commit/dcee43c) - __(Artem Napolskih)__ Initial commit 
