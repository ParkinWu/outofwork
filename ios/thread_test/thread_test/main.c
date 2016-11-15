//
//  main.c
//  thread_test
//
//  Created by parkinwu on 2016/9/26.
//  Copyright © 2016年 parkinwu. All rights reserved.
//

#include <stdio.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <sys/socket.h>
#include <strings.h>
#include <unistd.h>

typedef struct sockaddr SA;

int open_clientfd(char *hostname, int port) {
    int clientfd;
    struct hostent * host;
    struct sockaddr_in serveraddr;
    
    // 创建 socket 描述符
    if ((clientfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
        return -1;
    }
    
    // 检查 DNS
    if ((host = gethostbyname(hostname)) == NULL) {
        return -2;
    }
    // 将结构体清零
    bzero((char *)&serveraddr, sizeof(serveraddr));
    serveraddr.sin_family = AF_INET;
    serveraddr.sin_port = htons(port);
    
    bcopy((char *)host->h_addr_list[0],
          (char *)&serveraddr.sin_addr, host->h_length);
    
    
    if (connect(clientfd, (SA *)&serveraddr, sizeof(serveraddr)) < 0) {
        return -1;
    }
    
    return clientfd;
    
}

int open_listenfd(int port) {
    int listenfd = 0, optval = 1;
    struct sockaddr_in serveraddr;
    
    if ((listenfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
        return -1;
    }
    if (setsockopt(listenfd, SOL_SOCKET, SO_REUSEADDR, &optval, sizeof(int)) < 0) {
        return -1;
    }
    
    bzero(&serveraddr, sizeof(serveraddr));
    serveraddr.sin_port = htons(port);
    serveraddr.sin_family = AF_INET;
    serveraddr.sin_addr.s_addr = htonl(INADDR_ANY);
    if (bind(listenfd, (SA *)&serveraddr, sizeof(serveraddr)) < 0) {
        return -1;
    }
    
    if (listen(listenfd, 0) < 0) {
        return -1;
    }
    
    
    return listenfd;
}

//ssize_t rio_writen(int fd, void * usrbuf, size_t n) {
//    size_t nleft = n;
//    size_t nwriten = 0;
//    char *buf = usrbuf;
//    while (nleft > 0) {
//        if ((nwriten = write(fd, buf, nleft)) <= 0) {
//            
//        }
//    }
//    
//}

int main(int argc, const char * argv[]) {
    
    
    
    struct sockaddr_in clientaddr;
    unsigned int clientlen = 0;
    int listenfd = open_listenfd(3000);
    
    
    
    
    while (1) {

        char buf[3096], body[1024];
        
        int acceptedfd = accept(listenfd, (SA *)&clientaddr, &clientlen);
        
        
        sprintf(body, "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><title>my web server</title></head><body><h1> 第一个网页</h1></body></html>");
        
        sprintf(buf, "HTTP/1.0 OK\r\n");
//        send(acceptedfd, buf, strlen(buf), 0);
        sprintf(buf, "Content-Type: text/html\r\n");
        sprintf(buf, "Content-Length: %ld\r\n\r\n", (long)strlen(body));
        sprintf(buf, "%s", body);
        
        size_t nwriten = 0;
        size_t nleft = strlen(buf);
        char * pbuf = buf;
        
        while ((nwriten = write(acceptedfd, pbuf, nleft)) > 0) {
            pbuf += nwriten;
            nleft -= nwriten;
        }
        shutdown(acceptedfd, SHUT_WR);
        

    }
    
    
//    struct hostent * host =  gethostbyname("www.ctrip.com");
//    if (host == NULL) {
//        return 0;
//    }
//    for (char **pp = host->h_aliases; *pp != NULL; pp++) {
//        printf("alias: %s\n", *pp);
//    }
//    
//    struct in_addr ina;
//    
//    for (char **pp = host->h_addr_list; *pp != NULL; pp++) {
//        ina.s_addr = (unsigned int)*pp;
//        printf("ip: %s\n", inet_ntoa(ina));
//    }
   
    
    
    
//    struct in_addr inp;
//    char *cp = "127.0.0.1";
//    int res = inet_aton(cp, &inp);
//    if (res != 1) {
//        printf("%d", res);
//    }
//    
//    printf("0x%o\n", inp.s_addr);
//    
//    
//    struct in_addr inp1;
//    inp1.s_addr = 0xef000001;
//    
//    printf("%s\n", inet_ntoa(inp1));
    
}
