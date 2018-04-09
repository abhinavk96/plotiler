#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int main ()

{
	
	int t = fork();
	if (t==0) {
	system("ls -a");
	}
	else {
		printf("Thanks!");
	}
}
