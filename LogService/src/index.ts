import express, { Express, Request, Response } from 'express';
import dotenv from 'dotenv';
import path from "path"

dotenv.config();

const app: Express = express();
const port = process.env.PORT || 9090;



app.get('/api/log-service', (req: Request, res: Response) => {
  const { type,message } = req.query

  if(type == undefined || message == undefined) return res.json({ status: "error",msg: "error args query" })

  console.log(`${new Date().toLocaleTimeString()} [${type}] ${message}`);
  

  res.json({
    status: "success",
    msg: "Success"
  })
});

app.listen(port, () => {
  console.log(`⚡️[server]: Server is running at http://localhost:${port}`);
});

