import dotenv from "dotenv";
import express, { urlencoded, json } from "express";
import cors from "cors";
import helmet from "helmet";
import compression from "compression";
import cacheRoute from "./middleware/cacheRoute.js";

import auth from "./routes/v1/auth.js";
import authRoute from "./middleware/authRoute.js";
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
app.use(compression());
app.use(cacheRoute);

app.use(`/${BASE_URL}/${CURRENT_VERSION}/auth`, auth);

app.use(`/${BASE_URL}/${CURRENT_VERSION}/agencys`, authRoute, agencys);
app.use(`/${BASE_URL}/${CURRENT_VERSION}/routes`, routes);
app.use(`/${BASE_URL}/${CURRENT_VERSION}/services`, services);

app.get(`/${BASE_URL}/${CURRENT_VERSION}/optimisation`, (req, res) => {
  const text = "See you later, alligator. Bye bye bye, butterfly";
  res.json({ msg: text.repeat(1000) });
});

app.listen(PORT, () => {
  console.log(`Server is listening on port ${PORT}`);
});
