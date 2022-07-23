import express from "express";
import swaggerUi from "swagger-ui-express";
import swagger from "../swagger.js";

const router = express.Router();

router.use("/", swaggerUi.serve);
router.get("/", swaggerUi.setup(swagger));

export default router;
