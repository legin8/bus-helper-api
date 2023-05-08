import { Router } from "express";
const router = Router();

import { getService, getServices, createService, updateService, deleteService } from "../controllers/services.js";

router.route("/").get(getServices).post(createService);
router.route("/:code").put(updateService).delete(deleteService).get(getService);

export default router;