gcc -Q --help=warning | grep -v -e 'available' -e 'bytes' > gcc12.2-status-warnings.txt
gcc -DHAVE_WINSOCK2_H=0 -Wdate-time -D_FORTIFY_SOURCE=2 \
	-g -Wall -Wextra -fstack-protector-strong -grecord-gcc-switches -std=gnu11 -Wbad-function-cast -Wconversion -Wdeclaration-after-statement -Wformat-security -Wformat-signedness -Wlogical-op -Wmissing-declarations -Wmissing-include-dirs -Wmissing-prototypes -Wnested-externs -Woverlength-strings -Wpointer-arith -Wredundant-decls -Wshadow -Wstrict-prototypes -Wsuggest-attribute=const -Wswitch-default -Wwrite-strings -fasynchronous-unwind-tables -Wduplicated-cond -Wnull-dereference -Wduplicated-branches -fstack-clash-protection -Wmultistatement-macros -Wsuggest-attribute=malloc -O2 \
	-g -Wall -Wextra -fstack-protector-strong -grecord-gcc-switches -std=gnu11 -Wbad-function-cast -Wconversion -Wdeclaration-after-statement -Wformat-security -Wformat-signedness -Wlogical-op -Wmissing-declarations -Wmissing-include-dirs -Wmissing-prototypes -Wnested-externs -Woverlength-strings -Wpointer-arith -Wredundant-decls -Wshadow -Wstrict-prototypes -Wsuggest-attribute=const -Wswitch-default -Wwrite-strings -fasynchronous-unwind-tables -Wduplicated-cond -Wnull-dereference -Wduplicated-branches -fstack-clash-protection -Wmultistatement-macros -Wsuggest-attribute=malloc -ggdb3 -O0 \
	-fanalyzer \
	-Q --help=warning > gcc12.2-status-warnings-after-wall-wextra-manual.txt
# Line 1 is CPPFLAGS
# Line 2 is CFLAGS
# Line 3 is Debug CFLAGS
# Line 4 is Analyzer CFLAGS
grep -f gcc12.2-status-warnings.txt gcc12.2-status-warnings-after-wall-wextra-manual.txt | grep 'disabled' > gcc12.2-disabled-warnings-after-wall-wextra-manual.txt

