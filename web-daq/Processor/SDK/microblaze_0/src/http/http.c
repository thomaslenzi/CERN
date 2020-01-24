#include "http.h"

#include "mfs_config.h"

#include <string.h>

void http_echo(struct tcp_pcb* tpcb, struct client_request* request) {

	char response[RESPONSE_SIZE];
    unsigned int responseSize;
	char stringBuffer[30];

    strcpy(response, "HTTP/1.1 200 OK\r\n");
    strcat(response, "Content-type: text/html\r\n");
    sprintf(stringBuffer, "Content-length: %d\r\n", request->bodyLength);
    strcat(response, stringBuffer);
	strcat(response, "Connection: keep-alive\r\n\r\n");
    strcat(response, request->bodyContent);
    responseSize = strlen(response);

	tcp_write(tpcb, response, responseSize, 1);
}

int http_get(struct tcp_pcb* tpcb, struct client_request* request) {

	char responseBuffer[RESPONSE_SIZE];
	char stringBuffer[30];
	char* extension;
	unsigned int headerLength;
	unsigned int fileLength;
	unsigned int bytesRead;
	unsigned int readTotal;
    int fd;

    /* Open file */
    if (strcmp(request->path, "/") == 0) fd = mfs_file_open("index.html", MFS_MODE_READ);
    else fd = mfs_file_open(request->path, MFS_MODE_READ);

	if (fd == -1) return 404; // Could not open file

	/* Get the file length */
    fileLength = mfs_file_lseek(fd, 0, MFS_SEEK_END);

    /* Get the file extension */
    extension = strchr(request->path, '.');
    ++extension;

    /* Format header */
    strcpy(responseBuffer, "HTTP/1.1 200 OK\r\n");

    /* Extension of the file */
    strcat(responseBuffer, "Content-type: ");
    if(strcmp(extension, "jpg") == 0) strcat(responseBuffer, "image/jpeg");
    else if(strcmp(extension, "gif") == 0) strcat(responseBuffer, "image/gif");
    else if(strcmp(extension, "pdf") == 0) strcat(responseBuffer, "application/pdf");
    else strcat(responseBuffer, "text/html");
    strcat(responseBuffer, "\r\n");

    /* Format header next */
    sprintf(stringBuffer, "Content-length: %d\r\n", fileLength);
    strcat(responseBuffer, stringBuffer);
	strcat(responseBuffer, "Connection: keep-alive\r\n\r\n");
	headerLength = strlen(responseBuffer);

	/* Send header and file */
	bytesRead = mfs_file_read(fd, (char*) (responseBuffer + headerLength), RESPONSE_SIZE - headerLength);
	tcp_write(tpcb, responseBuffer, headerLength + bytesRead, 1);
	readTotal = bytesRead;

	/* Send remaining of file */
	while(readTotal < fileLength) {
		bytesRead = mfs_file_read(fd, responseBuffer, RESPONSE_SIZE);
		tcp_write(tpcb, responseBuffer, bytesRead, 1);
		readTotal += bytesRead;
	}

	/* Close the file being sent */
	mfs_file_close(fd);

	return 200;
}

void http_404(struct tcp_pcb* tpcb, struct client_request* request) {
	char responseBuffer[RESPONSE_SIZE];
	unsigned int responseLength;

    /* Format response */
    strcpy(responseBuffer, "HTTP/1.1 404 Not Found\r\n");
    strcat(responseBuffer, "Content-type: text/html\r\n");
    strcat(responseBuffer, "Content-length: 11\r\n");
	strcat(responseBuffer, "Connection: keep-alive\r\n\r\n");
	strcat(responseBuffer, "Not Found\r\n");
	responseLength = strlen(responseBuffer);

	tcp_write(tpcb, responseBuffer, responseLength, 1);
}

void http_500(struct tcp_pcb* tpcb, struct client_request* request) {
	char responseBuffer[RESPONSE_SIZE];
	unsigned int responseLength;

    /* Format response */
    strcpy(responseBuffer, "HTTP/1.1 500 Internal Server Error\r\n");
    strcat(responseBuffer, "Content-type: text/html\r\n");
    strcat(responseBuffer, "Content-length: 23\r\n");
	strcat(responseBuffer, "Connection: keep-alive\r\n\r\n");
	strcat(responseBuffer, "Internal Server Error\r\n");
	responseLength = strlen(responseBuffer);

	tcp_write(tpcb, responseBuffer, responseLength, 1);
}
