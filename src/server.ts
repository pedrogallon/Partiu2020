import app from './app'
import { allowedNodeEnvironmentFlags } from 'process';
// import routes from './routes'

app.listen(3333, ()=>{
    console.log("Server started at localhost:3333");
})