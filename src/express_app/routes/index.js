var processEnv = require('dotenv').config()
var express = require('express');
var router = express.Router();
var path = require('path');
var mysql = require('mysql')
var logger = require('log4js').getLogger("index");

router.get('/ejs/index', function(req, res) {
    res.render('index');
});

router.get('/html/index', function(req, res) {
    res.sendFile(path.join(__dirname+'/../views/index.html'));
});

if (processEnv.error) {
	logger.error("DOT ENV FAILED TO LOAD VARIABLES: " + processEnv.error)
	throw processEnv.error
}

var mysqlPool = mysql.createPool({
  connectionLimit : 100,
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: 'testdb'
})

router.get('/api', function (req, res) {
	mysqlPool.getConnection(function(err, connection) {
		if (err) {
			logger.error(' Error getting mysql_pool connection: ' + err);
			connection.release()
		} else {
			logger.info("GET:/api - Connected to MySQL DB!");
			connection.query('SELECT * FROM test_table', function(err, results) {
				if (err) {
					logger.error(' Error executing SELECT query: ' + err);
					connection.release()
				}
				res.setHeader('Content-Type', 'application/json');
				res.send(results)
			})
		}
	})
})

router.post('/api', function (req, res) {
	var postData  = req.body;
	mysqlPool.getConnection(function(err, connection) {
		if (err) {
			logger.error('Error getting mysql_pool connection: ' + err);
			connection.release()
		} else {
			logger.info("POST:/api - Connected to MySQL DB!");
			connection.query('INSERT IGNORE INTO test_table SET ?', postData, function (error, results, fields) {
				if (err) {
					logger.error(' Error executing INSERT query: ' + err);
					connection.release()
				}
				res.setHeader('Content-Type', 'application/json');
				res.send(results)
			})
		}
	})
})

router.put('/api', function (req, res) {
	var deleteData  = req.body;
	mysqlPool.getConnection(function(err, connection) {
		if (err) {
			logger.error('Error getting mysql_pool connection: ' + err);
			connection.release()
		} else {
			logger.info("PUT:/api - Connected to MySQL DB!");
			   connection.query('UPDATE `test_table` SET `name`=?,`comments`=? where `id`=?', [req.body.name, req.body.comments, req.body.id], function (error, results, fields) {
				if (err) {
					logger.error('Error executing UPDATE query: ' + err);
					connection.release()
				}
				res.setHeader('Content-Type', 'application/json');
				res.send(results)
			})
		}
	})
})

router.delete('/api', function (req, res) {
	var deleteData  = req.body;
	mysqlPool.getConnection(function(err, connection) {
		if (err) {
			logger.error('Error getting mysql_pool connection: ' + err);
			connection.release()
		} else {
			logger.info("DELETE:/api - Connected to MySQL DB!");
			connection.query('DELETE FROM `test_table` WHERE `id`=?', [req.body.id], function (error, results, fields) {
				if (err) {
					logger.error('Error executing DELETE query: ' + err);
					connection.release()
				}
				res.setHeader('Content-Type', 'application/json');
				res.send(results)
			})
		}
	})
})

module.exports = router;
