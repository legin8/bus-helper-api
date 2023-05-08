import dotenv from "dotenv";
import express, { urlencoded, json } from "express";

import routes from "./routes/routes.js";

dotenv.config();

const app = express();

const BASE_URL = "api";

const PORT = process.env.PORT;

app.use(urlencoded({ extended: false }));
app.use(json());

app.use(`/${BASE_URL}/routes`, routes);

app.listen(PORT, () => {
  console.log(`Server is listening on port ${PORT}`);
});