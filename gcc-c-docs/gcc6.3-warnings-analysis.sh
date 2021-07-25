gcc -Q --help=warning > gcc6.3-status-warnings.txt
gcc -Wall -Wextra -Wbad-function-cast -Wconversion -Wduplicated-cond -Wmissing-include-dirs -Wmissing-prototypes -Wnull-dereference -Wredundant-decls -Wshadow -Wstrict-prototypes -Q --help=warning > gcc6.3-status-warnings-after-wall-wextra-manual.txt
grep -f gcc6.3-status-warnings.txt gcc6.3-status-warnings-after-wall-wextra-manual.txt | grep 'disabled' > gcc6.3-disabled-warnings-after-wall-wextra-manual.txt

