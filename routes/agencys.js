import { Router } from "express";
const router = Router();

import {
  getAgency,
  getAgencys,
  createAgency,
  updateAgency,
  deleteAgency,
} from "../../controllers/v1/agencys.js";

router.route("/").get(getAgencys).post(createAgency);
router.route("/:code").put(updateAgency).delete(deleteAgency).get(getAgency);

export default router;
