# Vagrant Multi-Machine Setup

## Descrizione
Questo progetto utilizza Vagrant per creare due macchine virtuali (VM) basate su **Ubuntu 22.04 LTS (jammy64)**. 

- La VM **"web"** esegue un server web con un framework di backend (PHP, Flask, Node.js, ecc.) e un gestore di database.
- La VM **"db"** esegue un database MySQL.

Il tutto implementa una rete interna e una rete "host-only". Un'applicazione web si connette al database utilizzando un utente diverso da root, e viene montata automaticamente una cartella condivisa per le pagine del sito.

## Requisiti
- **Vagrant 2.x**
- **VirtualBox**

## Configurazione

### Variabili di Configurazione
Le seguenti variabili sono configurabili nel `Vagrantfile`:
- **BASE_INT_NETWORK**: Rete interna tra le macchine virtuali (`10.10.20`)
- **BASE_HOST_ONLY_NETWORK**: Rete host-only per l'accesso alla VM web dall'host (`192.168.56`)
- **BOX_IMAGE**: Immagine Vagrant da usare (default: `ubuntu/jammy64`)

### IP delle VM
- VM **web.m340**: 
  - Rete interna: `10.10.20.10`
  - Rete host-only: `192.168.56.10`
- VM **db.m340**:
  - Rete interna: `10.10.20.11`

## Provisioning
Lo script di provisioning si occupa di:
- Installare un web server e un framework backend nella VM **web** (PHP).
- Installare **MySQL** nella VM **db**.
- Creare un utente non root per la connessione al database.
- Installare e configurare **Adminer** per la gestione del database tramite interfaccia web.
- Configurare la connessione tra l'applicazione web e il database.

## Montaggio della cartella del sito
La cartella contenente il codice del sito viene automaticamente montata all'interno della VM **web** in `/var/www/html`. Modificando i file locali, questi saranno automaticamente sincronizzati con la macchina virtuale.

## Utilizzo

1. Clonare il repository:
    ```bash
    git clone https://github.com/GhiggiNicolas/Vagrantfile.git
    cd Vagrantfile
    ```

2. Modificare le variabili di configurazione nel `Vagrantfile` se necessario.

3. Avviare le macchine virtuali:
    ```bash
    vagrant up
    ```

4. Accedere alla VM **web** tramite SSH:
    ```bash
    vagrant ssh web
    ```

5. Accedere alla VM **db** tramite SSH:
    ```bash
    vagrant ssh db
    ```

6. L'applicazione web sarà accessibile all'indirizzo:
    ```
    http://192.168.56.10
    ```

7. L'interfaccia di gestione del database (Adminer) sarà accessibile all'indirizzo:
    ```
    http://192.168.56.10/adminer
    ```

## Consegna
Si richiede di includere nel repository GitHub i seguenti elementi:
- `Vagrantfile`
- Script di provisioning
- Codice del sito web

##
Dati accesso a Adminer:
    ```bash
    Utente: webuser
    Password: Password%1
    ```

## Autore
- Nome: **Nicolas Ghiggi**
- Email: **nicolas.ghiggi@samtrevano.ch**
