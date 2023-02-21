#include "stdio.h"
#include "loragw_hal.h"

int main() {
	printf("%s", lgw_version_info());
	return 0;
}
