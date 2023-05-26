import { Router } from "express";
const router = Router();

import { getRoute, getRoutes, createRoute, updateRoute, deleteRoute } from "../controllers/routes.js";

router.route("/").get(getRoutes).post(createRoute);
router.route("/:title").put(updateRoute).delete(deleteRoute).get(getRoute);

export default router;