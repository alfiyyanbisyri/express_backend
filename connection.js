const mysql = require('mysql')

const db = mysql.createConnection({
    host:"localhost",
    user:"root",
    password:"",
    database:"toko_online"
})

module.exports = db