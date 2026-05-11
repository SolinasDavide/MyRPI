#include <stdio.h>
#include <stdlib.h>
#include <ifaddrs.h>
#include <netdb.h>
#include <sys/socket.h>
#include <netpacket/packet.h>
#include <arpa/inet.h>

int main() {
    struct ifaddrs *ifaddr, *ifa;
    char host[NI_MAXHOST];

    // Ottiene la lista delle interfacce di rete
    if (getifaddrs(&ifaddr) == -1) {
        perror("getifaddrs");
        exit(EXIT_FAILURE);
    }

    printf("=== INFO DI RETE RASPBERRY PI ===\n\n");

    // Cicla attraverso le interfacce
    for (ifa = ifaddr; ifa != NULL; ifa = ifa->ifa_next) {
        if (ifa->ifa_addr == NULL) continue;

        int family = ifa->ifa_addr->sa_family;

        // Se è un indirizzo IP (IPv4)
        if (family == AF_INET) {
            int s = getnameinfo(ifa->ifa_addr, sizeof(struct sockaddr_in),
                               host, NI_MAXHOST, NULL, 0, NI_NUMERICHOST);
            if (s == 0) {
                printf("Interfaccia: %s\n", ifa->ifa_name);
                printf("  -> IP Address:  %s\n", host);
            }
        } 
        // Se è un indirizzo fisico (MAC Address)
        else if (family == AF_PACKET) {
            struct sockaddr_ll *s = (struct sockaddr_ll *)ifa->ifa_addr;
            printf("  -> MAC Address: ");
            for (int i = 0; i < s->sll_halen; i++) {
                printf("%02x%c", s->sll_addr[i], (i + 1 == s->sll_halen) ? '\n' : ':');
            }
            printf("----------------------------------\n");
        }
    }

    freeifaddrs(ifaddr);
    printf("\nPremi Invio per chiudere...");
    getchar(); 
    return 0;
}