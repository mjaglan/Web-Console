## Web console

Creating a simple web application with Node, Express and MySQL.
 - MySQL server for data
 - Node-Express Web-Server to create, update, read, and delete the data displayed on the UI as a table.

A simple usecase is to have external automation systems report new data to MySQL server. And see those data updates on the web UI. Great for those who are not required to spend much of their time building dedicated web server and ui.

### How to Run

- Install Vagrant & VirtualBox.

- Go to your terminal.

- Clone this repository.

- Update MySQL password to following two files
  - For `testbed-mysql` MySQL container: [ops/mysql/.credentials](ops/mysql/.credentials)
  - For `testbed` Nodejs container: [src/express_app/.env](src/express_app/.env)

  ```
  NOTE: Defaults are already set in the file -
  USER: root
  DB: testdb
  ```

- To run a vagrant box refer [dev/README.md](dev/). After this step, assuming you're inside the vagrant box.

- `cd /tmp/` and you'll see following directories:
  ```
  vagrant@vagrant-test-bed:/tmp$ ls -l
  drwxr-xr-x 1 vagrant vagrant  128 Jul 29 20:51 ops
  drwxr-xr-x 1 vagrant vagrant  128 Jul 29 20:51 src
  drwxr-xr-x 1 vagrant vagrant   96 Jul 30 04:35 vagrant-shared
  ```
  *tip: most often the permissions for executable files are not set to 755.*

- Run following scripts to setup MySQL DB
  - Setup `testbed-mysql` MySQL container:
	```
	./ops/mysql/run-mysql-server.sh
	```
    Or, if you want to remove all previous docker containers and images also, run this instead -
	```
	./ops/mysql/run-mysql-server.sh rmi
	```

  - Setup `testbed` Nodejs container:
	```
	./ops/node-express/run-node-express-server.sh
	```

- To exit from current container without closing it press following keys 1 or 2 times
    ```
    ctrl + p + q
    ```

### Web UI

- This application inside docker container page can be browsed at following URLs

  ```SERVER SIDE```
  - server side json response @ [http://VAGRANT-BOX-IP:12000/thor/api](http://192.168.10.51:12000/thor/api)
  - server side default error.ejs response @ [http://VAGRANT-BOX-IP:12000/404](http://192.168.10.51:12000/404)
  - server side index.ejs response @ [http://VAGRANT-BOX-IP:12000/thor/ejs/index](http://192.168.10.51:12000/thor/ejs/index)
  - server side index.html response @ [http://VAGRANT-BOX-IP:12000/thor/html/index](http://192.168.10.51:12000/thor/html/index)

  ```CLIENT SIDE```
  - client read-only datatables ui @ [http://VAGRANT-BOX-IP:12000/datatables](http://192.168.10.51:12000/datatables)
  - client editable footable ui @ [http://VAGRANT-BOX-IP:12000/footable](http://192.168.10.51:12000/footable)
    ![footable ui](/docs/images/footable.ui.png)


### Docker Instances
```
$ docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
baeace45220f        testbed             bridge              local
...

$ docker ps
CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS              PORTS                     NAMES
475203aa27f7        mjaglan/expressnode   "/bin/sh -c bash"        5 minutes ago       Up 5 minutes        192.168.10.51:12000->3000/tcp   testbed
146d749c1272        mysql:5.6             "docker-entrypoint.s…"   31 minutes ago      Up 31 minutes       3306/tcp                  testbed-mysql
...
```


### Project Structure ([src/express_app](src/express_app))

```
├── .env
├── app.js
├── bin
│   └── www
├── config
│   └── log4js.json
├── package.json
├── public
│   ├── datatables (client pages)
│   ├── footable (client pages)
│   └── favicon.ico
├── routes
│   └── index.js
└── views
    ├── error.ejs
    ├── index.ejs
    └── index.html
```

- ```.env``` file stores MySQL DB Credentials like this -

	```
	DB_HOST=<mysql-host>
	DB_USER=<mysql-user>
	DB_PASS=<mysql-pwd>
	```

- ```app.js``` file is the entry-point of your application (contains the express core, such as uri parser, modules, database)
- ```bin/``` folder should contain the various configuration startup scripts for your application.
- ```package.json``` file contains all of your dependencies and various details regarding your project (used by npm for dependencies and sharing).
- ```public/``` folder contains all of your front-end code - client static files (CSS, client JavaScript, jQuery, images, fonts, etc.)
- ```routes/``` folder contains all the routes that you have created for your application. Contains the main back-end code (server side), which compute data before calling a template engine (see below) or respond to the client (via json/ xml).
- ```views/``` folder contains all of your server-side views. Contains each page template, see jade template. These files are used by scripts in "route".


## Tools
```
Docker version 18.03.1-ce
Ubuntu 16.04.4 LTS Host OS
```

### References
- [Express.js Project Structure](https://stackoverflow.com/questions/28499964/express-js-project-structure)
- [Creating a basic site with Node.js and Express](https://shapeshed.com/creating-a-basic-site-with-node-and-express/)
- [Docker Official Image packaging for MySQL Community Server](https://github.com/mysql/mysql-docker)
- [MySQL With Node & Express](https://www.terlici.com/2015/08/13/mysql-node-express.html)
- [Render HTML file in ExpressJS](https://codeforgeek.com/2015/01/render-html-file-expressjs/)
- [Express Application Settings](http://expressjs.com/en/api.html#app.settings.table)
- [Setup pooled MySQL connections in Node JS that don’t disconnect](https://fearby.com/article/how-to-setup-pooled-mysql-connections-in-node-js-that-dont-disconnect/)
- [mysqljs Pooling connections](https://github.com/mysqljs/mysql#pooling-connections)
- [Node Logging Basics - log4js](https://www.npmjs.com/package/log4js)
- [ReST API - CURD Operations using Node Express MySQL](https://www.js-tutorials.com/javascript-tutorial/node-js-rest-api-add-edit-delete-record-mysql-using-express/)
- [FooTable - create a table that uses the editing component](https://fooplugins.github.io/FooTable/docs/examples/component/editing.html)
- [Can't create symlinks in virtualbox shared folders - serverfault.com](https://serverfault.com/q/345341)
