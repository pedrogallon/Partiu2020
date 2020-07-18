import express, { Application, Request, Response, NextFunction } from 'express'
import cors from 'cors'
import mysql from 'mysql'

import routes from './routes'


class App {
    public express: Application
    public db?: mysql.Connection
    public constructor() {
        this.express = express();
        this.middlewares();
        // this.db = this.database();
        this.routes();
    }

    private middlewares() {
        this.express.use(express.json())
        this.express.use(cors())
    }

    private database() {
        // return mysql.createConnection({
        //     host: 'localhost',
        //     user: 'root',
        //     password: '',
        //     database: 'partiu2020'
        // });


        // mongoose.connect('mysql://localhost:3306/Partiu2020')
    }

    private routes() {
        this.express.use(routes)
    }
}

export default new App().express


