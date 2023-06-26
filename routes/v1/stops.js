import { Router } from "express";
const router = Router();

import {
  getStop,
  getStops,
  createStop,
  updateStop,
  deleteStop,
} from "../../controllers/v1/stops.js";

router.route("/").get(getStops).post(createStop);
router.route("/:code").put(updateStop).delete(deleteStop).get(getStop);

export default router;
