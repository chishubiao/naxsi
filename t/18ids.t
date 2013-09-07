use lib 'lib';
use Test::Nginx::Socket;

plan tests => repeat_each(2) * blocks();
no_root_location();
no_long_string();
$ENV{TEST_NGINX_SERVROOT} = server_root();
run_tests();
__DATA__
=== ID TEST 1.0: Disabled IDs
--- http_config
include /etc/nginx/naxsi_core.rules;
MainRule "str:1999" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1999;
MainRule "str:1998" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1998;
--- config
location / {
         SecRulesEnabled;
         DeniedUrl "/RequestDenied";
         CheckRule "$SQL >= 8" BLOCK;
         CheckRule "$RFI >= 8" BLOCK;
         CheckRule "$TRAVERSAL >= 4" BLOCK;
         CheckRule "$XSS >= 8" BLOCK;
         root $TEST_NGINX_SERVROOT/html/;
         index index.html index.htm;
         BasicRule wl:1999;
}
location /RequestDenied {
         return 412;
}
--- request
GET /?bla=1999
--- error_code: 200
=== ID TEST 1.1: Disabled IDs (fail)
--- http_config
include /etc/nginx/naxsi_core.rules;
MainRule "str:1999" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1999;
MainRule "str:1998" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1998;
--- config
location / {
         SecRulesEnabled;
         DeniedUrl "/RequestDenied";
         CheckRule "$SQL >= 8" BLOCK;
         CheckRule "$RFI >= 8" BLOCK;
         CheckRule "$TRAVERSAL >= 4" BLOCK;
         CheckRule "$XSS >= 8" BLOCK;
         root $TEST_NGINX_SERVROOT/html/;
         index index.html index.htm;
         BasicRule wl:1999;
}
location /RequestDenied {
         return 412;
}
--- request
GET /?bla=1998
--- error_code: 412
=== ID TEST 1.2: Disabled negative IDs
--- http_config
include /etc/nginx/naxsi_core.rules;
MainRule "str:1999" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1999;
MainRule "str:1998" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1998;
--- config
location / {
         SecRulesEnabled;
         DeniedUrl "/RequestDenied";
         CheckRule "$SQL >= 8" BLOCK;
         CheckRule "$RFI >= 8" BLOCK;
         CheckRule "$TRAVERSAL >= 4" BLOCK;
         CheckRule "$XSS >= 8" BLOCK;
         root $TEST_NGINX_SERVROOT/html/;
         index index.html index.htm;
         BasicRule wl:-1999;
}
location /RequestDenied {
         return 412;
}
--- request
GET /?bla=1998
--- error_code: 200
=== ID TEST 1.3: Disabled negative IDs (fail)
--- http_config
include /etc/nginx/naxsi_core.rules;
MainRule "str:1999" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1999;
MainRule "str:1998" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1998;
--- config
location / {
         SecRulesEnabled;
         DeniedUrl "/RequestDenied";
         CheckRule "$SQL >= 8" BLOCK;
         CheckRule "$RFI >= 8" BLOCK;
         CheckRule "$TRAVERSAL >= 4" BLOCK;
         CheckRule "$XSS >= 8" BLOCK;
         root $TEST_NGINX_SERVROOT/html/;
         index index.html index.htm;
         BasicRule wl:-1999;
}
location /RequestDenied {
         return 412;
}
--- request
GET /?bla=1999
--- error_code: 412
=== ID TEST 1.4: Multiple Disabled negative IDs
--- http_config
include /etc/nginx/naxsi_core.rules;
MainRule "str:1999" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1999;
MainRule "str:1998" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1998;
MainRule "str:1997" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1997;
--- config
location / {
         SecRulesEnabled;
         DeniedUrl "/RequestDenied";
         CheckRule "$SQL >= 8" BLOCK;
         CheckRule "$RFI >= 8" BLOCK;
         CheckRule "$TRAVERSAL >= 4" BLOCK;
         CheckRule "$XSS >= 8" BLOCK;
         root $TEST_NGINX_SERVROOT/html/;
         index index.html index.htm;
         BasicRule wl:-1999,-1998;
}
location /RequestDenied {
         return 412;
}
--- request
GET /?bla=1997
--- error_code: 200
=== ID TEST 1.5: Multiple Disabled negative IDs
--- http_config
include /etc/nginx/naxsi_core.rules;
MainRule "str:1999" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1999;
MainRule "str:1998" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1998;
MainRule "str:1997" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1997;
--- config
location / {
         SecRulesEnabled;
         DeniedUrl "/RequestDenied";
         CheckRule "$SQL >= 8" BLOCK;
         CheckRule "$RFI >= 8" BLOCK;
         CheckRule "$TRAVERSAL >= 4" BLOCK;
         CheckRule "$XSS >= 8" BLOCK;
         root $TEST_NGINX_SERVROOT/html/;
         index index.html index.htm;
         BasicRule wl:-1999,-1998;
}
location /RequestDenied {
         return 412;
}
--- request
GET /?bla=1999
--- error_code: 412


=== ID TEST 2.0: BasicRule negative id test
--- http_config
include /etc/nginx/naxsi_core.rules;
MainRule "str:1999" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1999;
MainRule "str:1998" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1998;
MainRule "str:1997" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1997;
--- config
location / {
         SecRulesEnabled;
         DeniedUrl "/RequestDenied";
         CheckRule "$SQL >= 8" BLOCK;
         CheckRule "$RFI >= 8" BLOCK;
         CheckRule "$TRAVERSAL >= 4" BLOCK;
         CheckRule "$XSS >= 8" BLOCK;
         root $TEST_NGINX_SERVROOT/html/;
         index index.html index.htm;
         BasicRule wl:-1999 "mz:$URL:/|$ARGS_VAR:foo";
}
location /RequestDenied {
         return 412;
}
--- request
GET /?foo=1999
--- error_code: 412


=== ID TEST 2.1: BasicRule negative id test (fail)
--- http_config
include /etc/nginx/naxsi_core.rules;
MainRule "str:1999" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1999;
MainRule "str:1998" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1998;
MainRule "str:1997" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1997;
--- config
location / {
         SecRulesEnabled;
         DeniedUrl "/RequestDenied";
         CheckRule "$SQL >= 8" BLOCK;
         CheckRule "$RFI >= 8" BLOCK;
         CheckRule "$TRAVERSAL >= 4" BLOCK;
         CheckRule "$XSS >= 8" BLOCK;
         root $TEST_NGINX_SERVROOT/html/;
         index index.html index.htm;
         BasicRule wl:-1999 "mz:$URL:/|$ARGS_VAR:foo";
}
location /RequestDenied {
         return 412;
}
--- request
GET /?foo=1998
--- error_code: 200


=== ID TEST 2.2: BasicRule negative id test (fail on internal ID)
--- http_config
include /etc/nginx/naxsi_core.rules;
MainRule "str:1999" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1999;
MainRule "str:1998" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1998;
MainRule "str:1997" "msg:foobar test pattern #1" "mz:ARGS" "s:$SQL:42" id:1997;
--- config
location / {
         SecRulesEnabled;
         DeniedUrl "/RequestDenied";
         CheckRule "$SQL >= 8" BLOCK;
         CheckRule "$RFI >= 8" BLOCK;
         CheckRule "$TRAVERSAL >= 4" BLOCK;
         CheckRule "$XSS >= 8" BLOCK;
         root $TEST_NGINX_SERVROOT/html/;
         index index.html index.htm;
	 BasicRule wl:-1999 "mz:$URL:/|$ARGS_VAR:foo";
}
location /RequestDenied {
         return 412;
}
--- request
GET /?foo=a%00a
--- error_code: 412

