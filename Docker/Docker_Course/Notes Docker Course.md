## Docker course

Vroeger:
OS uitzoeken (bijv. Linux Debian distributie), VM regelen, vet veel lezen/research om alles te installeren, VPS (virtual private server)

Config management tools: 
- Chef 
- Ansible

Wat doet docker?
-> Build, ship and run any app, anywhere
- Package app or service into standardized unit
- Alles wat je nodig hebt om het te draaien zit in de image
- Draait altijd hetzelfde

Image vs. Container
- Image is een verzameling van alle benodigdheden
- Container is een draaiende instantie van een image
(Class vs. instance)

VM vs Docker container
  Beiden kunnen resources geisoleerd draaien
- VM start een compleet guest OS draaien voor elke app die je wilt draaien (maken gebruik van een host - guest opzet)
- Docker draait op de docker engine en heeft dan alleen de image nodig
  - daardoor lightweight en weinig ruimte nodig

Docker is gebaseerd op open standards en draaien geisoleerd met beperkte mogelijkheden waardoor relatief veilig

Voordelen van Docker:
1. Snel schaalbaar doordat alles al in image zit
2. Dev team kan snel alles draaien ook bij nieuwe mensen (zie komodo installatie...)
3. Meerdere technologiën te gebruiken omdat het altijd draait
4. Werkt op elke OS
5. Distributie nieuwe versies is gemakkelijker

Docker gebruiken:
cmd: docker run --rm busybox:latest /bin/echo "Hello World"
/bin/echo "Hello World" => commando wat je wilt uitvoeren
busybox:latest => download busybox als lokaal niet beschikbaar en :latest zorgt voor laatste versie
docker run => docker commando
--rm is vlaggetje om container automatisch te verwijderen als je 'm stopt
Alle commandos: docker --help

docker images => alle images

docker zonder --rm => dan docker ps -a --> zie je dat container er nog is

docker run -it --rm busybox:latest
Alles wat je dan in container doet heeft geen effect op image, alleen op de container (instantie van image die draait)

docker images -> docker rmi <image id> gooit hele image weg, systeem schoon :)

docker registry -> two way street met push en pull opties

Docker hub heeft alle images, officiele en user made. Officiele worden bijgehouden door profi partijen en zijn door docker team "geblessed"
Docker Hub is als Github: stukje gratis en public, als je meer wilt en prive moet je dokken (docken hahahaha)

Docker cached alle commandos uit dockerfile. als er tussendoor niets wijzigt dan slaat ie de stap over

.dockerignore zorgt dat files niet naar docker image worden gekopieerd

 volumes:
    - ~/.docker-volumes/mobydock/redis/data:/var/lib/redis/data
    alles wat in de locatie aan de linker kant van : staat wordt gemount in de locatie aan de rechterkant op de container

  ports:
    - '6379:6379' => host:guest, oftewel: waar de container draait:poort op de container

Dockerfile:

- WORKDIR: sets working directory zodat je niet hoeft te referencen naar folder structuur
- COPY file/location-workstation file/location2-dockerimage

Staging server: server with same config as production server

### Debian
Debian is goede linux distrubitie die vaak gebruikt word, is stabiel. Docker zit er nog niet bij en je moet nog wel wat configureren voor je los kan

### Core OS
Nieuwer, heeft docker al meegeleverd out of the box, maar beweegt snel en daardoor minder stabiel.

###CentOS
Vergelijkbaar met Debian

### Snappy Ubuntu Core en Red Hat Atomic
Zijn vrij nieuw, compleet gericht op containers. Voor nu nog te "groen"

Vagrant is een tool die gemakkelijk virtual machines opspinnen

## Setting up SSH
key pair maken: ssh-keygen -t rsa -b 4096
-t: type = rsa
-b encryption level (base) = 4096 bits

select where you want to save the file
!ADD password.

file with .pub is public key. kan gedeeld worden
Private key NOOIT delen

ssh-add, identity toevoegen

ssh into server: ssh username@ip-adres-server (eventueel met extra: mkdir .ssh)

Dan public key uploaden naar server

cat id_rsa.pub | ssh user@ip 'cat >> .ssh/authorized_keys'

permissions ssh folder goed zetten:
ssh user:ip 'chmod 700 .ssh; chmod 640 .ssh/authorized_keys'

Zorgen dat je niet meer met password kan inloggen, alleen met key:
Op server -> sudo nano /etc/ssh/sshd_config
Dan naar PasswordAuthentication yes -> op no zetten
opslaan en ssh herstarten:
sudo systemctl restart ssh

systemd -> systeem om services te starten en stoppen, wordt op vrijwel alle linux distributies meegeleverd
heeft ook wel wat kritiek gehad, zou te complex zijn en te veel willen doen

nginx -> async webserver met focus op concurrency en performance
zit voor web-app en doet daar 'verschillende taken'
is daar een reverse proxy -> ontvangt van buitenwereld opdrachten en kijkt wat er moet gebeuren voordat t verkeer naar je app gaat.
Super sterk in static assets serveren
Kan goed SSL verwerken
URL herschrijven en redirects doen
Virtual hosts doen
Load balancen

SSL certificate

- StartSSL: free but annoying
- SSL Mate: cheap 
- Lets encrypt van Mozilla: https://letsencrypt.org/

SSL is nog niet per definitie afdoende: configuratie moet ook op orde zijn
SSL Labs (google) kan je testje doen  

Scaling:
Horizontal scaling: meer servers erbij
Vertical scaling: meer computionpower erbij

-> analyze if youre bound by CPU, memory, I/O or network.
Determine weakest link first before optimizing

Canary based deployment: deel van de servers krijgt de nieuwe deployment. Mocht alles in de soep lopen dan ben je maar voor een deel de pineut.

Where to go next ­ Planning to scale

Resources voor docker scaling / cluster management

Weave
http://weave.works/
https://github.com/weaveworks/weave#readme
Flannel
https://github.com/coreos/flannel#readme
Docker Swarm
https://www.docker.com/docker­swarm
Kubernetes
http://kubernetes.io/
Mesos and Marathon
http://mesos.apache.org/
https://github.com/mesosphere/marathon#readme
Deis
http://bit.ly/1MKQntQ
^ Please use this link to visit Deis' website because it helps them determine that you originated from this course.
Deis blog post
http://deis.io/digitalocean­deis­deploy­night/
Tutum
https://www.tutum.co/

### Monitoring and metrics

Get the rundown for the Docker stats command
docker status --help
Obtain a list of Docker containers
docker ps
Get the stats of MobyDock
docker stats mobydock_mobydock_1
Get the stats of our application's stack
docker stats mobydock_mobydock_1 mobydock_postgres_1 mobydock_redis_1


Cadvisor (google tooltje) Vet dashboardje maar geen historische gegevens, alleen van kortgeleden tot nu
https://github.com/google/cadvisor

DataDog
Compleet dashboard, alerting alles. Relatief goedkoop
DataDog open source agent
https://github.com/DataDog/dd­agent

UptimeRobot
https://uptimerobot.com
Polls url om te kijken of het nog allemaal up is

### CI/CD pipelines

Managed services:
Travis CI: betaalde service met gratis optie voor open source projecten
Circle CI: vergelijkbaar met travis, maar wordt sneller duur.

Self-hosted:
Jenkins: bekend, veel gebruikt, Netflix gebruikt het ook
Gitlab: github + ci straat in één, maar zelf wel wat inregelen

### Logging

Kan on disk, maar bij horizontal scaling moet je toch centraal gaan.  
Logspout stuurt alles naar één locatie.
Dan beslissen: zelf analyseren of 3rd party?
Papertrail is een optie
Loggly heeft betere gratis versie, maar lagere retentie van logs.
Zelf doen: elastic search, logstash en kibana (ELK stack)
Opzoeken: Nathan Leclaire -> ELK stash zelf doen blog/video

### Central config

Ansible en SaltStack kunnen alle config op alle servers uitvoeren
Idempotent: doet het niet als het al goed zit.
Terraform -> zelfde idee

Docker toolbox: niet op linux draaien, maar gewoon op windows
Windows draait een VM met daarin Docker deamon ipv direct naar docker als je het op linux zou draaien.


# Docker Fundamentals course
VM's vs. Docker
VM's voor isoleren van hele systemen
Docker voor isoleren van hele applicatie

Docker basis structuur: 
Docker server (linux based) (daemon)
Rest API
Docker CLI (server)

Docker CE vs EE. EE heeft ook:
- mogelijkheid om gecertificeerde images en plugins te gebruiken
- Docker DataCenter
- Vunerability scans
- Official support

Docker releases:
Egde: elke maand release, fixes tijdens maand dat ie actief is
Stable: elke 3 maanden, fixes voor 4 maanden na release
for EE: support for 1 jaar
Versioning: 17.3 = 2017, maart

Docker toolbox installeert:  

- Docker CE/EE
- Docker compose
- Docker machine -> helps in creating servers en installing docker on those servers
- Virtual Box -> zorgt voor Linux omgeving waar Docker deamon op gezet kan worden
- Docker QuickStart Terminal
- Kitematic -> grafische tool voor docker CLI

Nieuwere versie van toolbox voor Mac en Windows: Docker for Mac en Docker for Windows
Uses HyperKit(mac) of Hyper-V(windows) in plaats van VirtualBox

Installeert:

- Docker CE/EE
- Docker compose
- Docker machine

Nadeel: hypervisor type-1 kan niet nog een hypervisor type-1 draaien...
Windows/mac versie moet best hoog zijn

Voordeel: docker daemon is lokaal, kan elke terminal gebruiken die je wilt

Windows Subsystem for linux kan nu nog niet de docker natively draaien.

Filemounting gaat bij beide opties (toolbox of for Windows) hetzelfde

Voor nu gaat de VirtualBox performance iets beter. 4Mac of 4Windows is nu qua user experience het beste.

Docker is qua backwards compatibility erg goed

Docker pull -> alleen de diff wordt gedownload

Docker image: filesystem + parameters.
Doesnt have state
image: downloadable, buildable, runnable

Container = draaiende image

Build wordt gedaan door Dockerimage

Containers are immutable: any change to them will be gone when container stops running

Docker Registry = plek waar images kunnen worden opgeslagen. Docker Hub is een voorbeeld van een Docker Registry

Officiele architectuur: Docker Registry -> Docker Repository -> Docker Images -> tag versies

op Docker Hub: officiele repositories -> kan je vertrouwen en wordt ondersteund door Docker

Nieuwe Image: lees readme

Tag's tab: kan je vunerabilities bekijken.

Docker heeft ook een optie "Build Settings", waar je auto build kan doen vanaf bijv. GitHub push.

Webhook support
Bijv.: push code -> kick off CI tasks -> build image -> send webhook -> receive webhook -> pull new image -> restart containers

Official namespace hoeft geen namespace te hebben.

Je kan ook je eigen REPO gebruiken.

Docker Hub:
Eigen images
Free community images

Docker Store:
Official images (free and paid)
Paid trusted images

docker commit vanuit container is andere manier om docker image te maken.
Betere optie is Dockerfile (repeatable, less errors)
Dockerfile is de requirements.txt, Gemfile, package.json van Docker

Docker image is een aantal layers op elkaar. Die layers kunnen vergeleken worden bij install zodat niet alles gedaan hoeft te worden, alleen de delta.

Union file system -> docker manager system regelt dat? Lezen..

Dockerfile:
FROM -> pak baseimage waar je op verder wilt bouwen
slim kleinere image, maar niet zo klein als alpine
alpine (smalles filesize in the end?) was vroeger debian:jessie als baseimage
wheezy older version of debian
onbuild ?
windowsservercore ?

FROM baseimage -> baseimage heeft vaak ook weer een FROM, all the way to "scratch"
FROM baseimage:tag -> pak die versie, zonder tag pak je default "latest"

RUN -> run any script that you could run in OS that you are using.

WORKDIR -> set working dir, which will be default dir for any command from then on.

COPY <source> space <target> -> put source to target. -> je kan niet naar dirs hoger dan je dir voor Dockerfile (geen ../). Rekening mee houden bij plaatsen van Dockerfile root folder...

COPY . . alles van workdir naar docker container kopieren

Docker layers -> denk na over volgorde van commandos, want alleen delta's worden uitgevoerd. Werk wat veel kost, maar niet veel veranderd bovenaan.

LABEL -> key  value -> info aan image toevoegen die je later met command kan opvragen.

CMD -> laaste commando in docker file. Get's executed when container is ran, not build.

docker --help

docker image build -t name_image .
-t -> naam (ipv image id)
. -> bouw huidige directory..

Draait Dockerfile af van boven naar beneden.
Als je t nog een keer doet: cache in action -> alles wat niet veranderd is wordt geskipt.

docker image inspect <naam container>
-> Geeft alle info over image in JSON

docker image build -t name_image:version_tag .
Adding tags does not add more layers

none images : dangling image.

docker image rm <image> -> gooit image weg

docker login -> associate CLI to docker hub.
Linux && MacOS staat in path: ~/.docker/config.json
Windows: %USERPROFILE%/.docker/config.json
Daardoor hoef je niet steeds in te loggen.

Naar dockerhub posten: 
docker image tag <img_name> username/repo:version
dan
docker image push username/repo:version

docker image rm -f (force) image_id

docker pull username/repo:version

docker container run -it -p --rm --name web1 5000:5000 -e FLASK_APP=app.py
container -> managed command (meer flags?)
-it handle linux key-combo's (bijv. ctrl + C) en opent terminal
-p -> port buiten container:binnen container
-e -> environment variable (kan ook meerdere -e flags of zelfs een hele file doen (komt later))
--rm -> verwijderd gestopte containers gelijk
--name -> custom name

docker container ls -> toon alle containers

docker container ls -a -> toon alle containers incl. gestopte.

docker container logs <name>
geeft output 

docker container logs -f <name>
Tailing in real time
ctrl + c kills logtail

docker container stats
-> shows real time metrics of container(s)
ctrl + c kills stats view

--restart on-failure: restarts container automatically if it dies out
--rm -> --restart: remove or restart, not both.

docker container stop <name>: stops container

stop complete docker daemon -> ligt aan OS maar bijv: sudo service docker restart
(containers met restart flag komen dan weer terug zodra daemon er weer is)

check help for more run flags!

"debug mode" direct code changes in server (not docker specific)
bijv: -e FLASK_DEBUG=1

Kill - build - reload is klote met developen..

Wat kan je doen?
Mount source code to container.

docker container run .... -v $PWD of windows complete path to folder of docker file

-v PWD:/app -> alles uit source folder komt in /app folder in container (waar de app ook in gezet wordt volgens Docker file)

-> voor development wil je dat wel, productie niet, daar gewoon inbakken

Je kan zien dat mount werkt door: docker container inspect <naam container> -> mounts sectie

Alpine is lekker klein, maar heeft sommige dingen niet in z'n geheel. Bijv inotify is beetje gek en werkt soms niet helemaal...

Alpine is potentieel beter, maar kan gaatjes hebben...

Bij rebuild, maar geen change? -> kan trollende compiled files in docker container zijn..
oplossing: docker container exec -it <name> bash (of sh), interactive containersessie.
Dan kan je in container rondkijken.

Exec is dus handige manier om te debuggen bij de bron.

ls -la laat zien dat je .pyc files hebt -> gebruikt door interpreter, maar zorgen nu wellicht voor een soort cache..
Verwijderen en opnieuw runnen kan de oplossing zijn.

Als je docker met volume doet en je doet daarna via exec een bestand maken kan de user die de file maakt root zijn ipv je eigen user. Hier kan je omheen door --user flag mee te geven:
docker container exec -it --user "$(id -u):$(id -g)" web1 touch hi.txt
$(id -u) -> username
$(id -g) -> groupid

Je kan gemakkelijk een python interpreter starten om een beetje met nieuwe talen aan te kloten door bijv.:
docker container run -it --rm --name testingpython python:2.7-alpine python

### Docker network linking
Networking is best pittig, hier even versimpeld:
Internal - LAN (local area network)
External - WAN (wide area network)

0.0.0.0:port -> kan iedereen bij binnen LAN
Vanuit buiten niet, want router blockt bepaalde ports
localhost:port ipv 0.0.0.0 is alleen op laptop beschikbaar
Je kan 0.0.0.0:5000 bijv. blootstellen door vanaf router verkeer te forwarden

Docker maakt zelf default al networks aan:
docker network ls
bridge is docker0 network, kan je checken met ifconfig of ipconfig

andere dan bridge die je standaard krijg zijn belangrijk voor daemon

docker network inspect bridge
Default worden containers aan bridge toegevoegd

docker container run --rm -itd -p 6379:6379 --name redis redis:3.2-alpine
-> zie je bij docker network inspect bridge dat container redis is toegevoegd

docker container run --rm -itd -p 9090:9090 --name alpine alpine

docker exec alpine ping 172.17.0.2 (is ip adres van redis, kan je zien met docker exec redis ifconfig)

docker exec redis cat /etc/hosts
docker container ls -> kan je zien dat container hash overeenkomt met hosts

IPV manual ip's kan je docker network automatis dns laten regelen.

docker network create --driver bridge <naam netwerk>

docker container run --rm -itd -p 6379:6379 --name redis --net caseerstenetwerk redis:3.2-alpine

docker container run --rm -itd -p 9000:9000 --name alpine --net caseerstenetwerk alpine

docker network inspect caseerstenetwerk

bridged driver: kan alleen verbinden binnen één docker host, dus alles binnen zelfde docker host draaien.
Ander moet je overlay network gebruiken.

### Persistence
named volume -> docker manages the volume, bijv handig voor DB
docker volume create <name>
bv: docker volume create web2_redis

docker volume ls
docker volume inspect web2_redis

toevoegen flag: -v web2_redis:/data 

docker container run --rm -itd -p 6379:6379 --name redis --net caseerstenetwerk -v web2_redis:/data redis:3.2-alpine

Liever docker container flexibel houden dus geen data persistence op container zelf doen...

### Sharing data between Containers
volume mounting: of source into running container
Named volumes: store data from container to docker host and let docker handle logistics

Nu: hoe tussen containers data delen?
In Dockerfile opnemen VOLUME ["/app/public" (of andere locatie)]

Je kan dan bij opstarten tweede container meegeven: --volume-from <containernaam1>

Je kan dit checken met docker container exec -it <naam container2> sh

### Shrink docker image size
.dockerignore -> kan je net als .gitignore dingen weglaten.

Zet in zelfde folder als Dockerfile. Syntax:
.dockerignore (laat .dockerignore zelf weg)
.git/ (folder)
.foo/* (content ignore, folder wel mee)
**/*.txt (alles met extensie .txt)
!special.txt (special.txt wordt dan wel toegelaten)

Als je start met een * kan je daarna met ! alles whitelisten

Zoeken naar bash script wat je met RUN kan doen, (alpine??)
-> kan je requirements niet meenemen en kan flink schelen.

### Execute script after container start
ENTRYPOINT
Kan je 1 image gebruiken voor meerder projects
Bijv. inlog gegevens etc voor DB

script toevoegen aan workdir

Commandos in dockerfile toevoegen:
COPY script.sh /
RUN chmod +x /script.sh
ENTRYPOINT ["/script.sh"]

Docker default entrypoint: /bin/sh -c

### Clean up after yourself
docker system df -> space on disk by docker
docker image ls -> alles met none is dangling (kan weg)
docker system df -v (verbose output)
docker system info (info docker installation)
docker system prune (delete all that is safe to delete)
docker system prune -f (without asking)
docker system prune -a (alles weg wat niet actief wordt gebruikt)
docker container stop $(docker container ls -a -q) (feed list of active docker containers quitly to stop command)

### Docker Compose
Docker compose API has multiple versions: start with version: 'version nr'

services: (list of services)
docker-compose.yml hoeft niet in zelfde map te zitten als Dockerfiles (kan met meerdere projecten tegelijk werken)

build: <dir>
+
image: 'username/image:version'
= build + push to docker hub

depends_on: -> zorgt voor volgorderlijkheid

docker-compose up --build -d
= up + build + pull(if required) + background

docker-compose restart +optional:<container name>

docker-compose exec <container> <command>

docker-compose run <service> <command>: runs and stops afterwards

docker-compose up <service>: only starts service(plus dependencies if present!!!)

docker-compose -rm -> remove dangling containers

multiple instances of Dockerfile-command feature:
docker-compose.yml copy paste en beetje aanpassen qua naam en evt ports e.d., dan command: toevoegen bijvoorbeeld command: python blablabla

Proberen nooit version 1 te gebruiken van docker-compose

### Dockerizing web app
Dockerfile
.dockerignore
docker-compose.yml
.env

Maar er is meer
Let op met logging: altijd naar stdout, Docker regelt dat het goed op host terecht komt?

Use ENV variables -> seperate environments = seperate .env files

Keep apps stateless
-> store fast moving data with redis
Client side user sessions with cookies
Session side user sessions with Redis

Not docker specific, maar wel handig om te doen met docker

The 12 factor App -> 12 things to make apps easier to maintain and more portable

