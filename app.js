import dotenv from "dotenv";
import express, { urlencoded, json } from "express";
import cors from "cors";
import helmet from "helmet";

import routes from "./routes/v1/routes.js";
import services from "./routes/v1/services.js";
import agencys from "./routes/v1/agencys.js";

dotenv.config();

const app = express();

const BASE_URL = "api";

const CURRENT_VERSION = "v1";

const PORT = process.env.PORT;

app.use(urlencoded({ extended: false }));
app.use(json());

app.use(cors());
app.use(helmet());

app.use(`/${BASE_URL}/${CURRENT_VERSION}/agencys`, agencys);
app.use(`/${BASE_URL}/${CURRENT_VERSION}/routes`, routes);
app.use(`/${BASE_URL}/${CURRENT_VERSION}/services`, services);

app.listen(PORT, () => {
  console.log(`Server is listening on port ${PORT}`);
});
