import express from "express";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

const router = express.Router();

router.get("/", async (_, res) => {
  try {
    const query = await prisma.report.findMany();

    return res.status(200).send(query);
  } catch (e) {
    return res.status(500).send({ e });
  }
});

router.post("/", async (req, res) => {
  try {
    const { lat, lng, uuid, smog } = req.body;

    const query = await prisma.report.create({
      data: {
        lat,
        lng,
        smog,
        user: {
          connect: {
            uuid,
          },
        },
      },
    });

    return res.status(201).send(query);
  } catch (e) {
    console.error(e);
    return res.status(500).send({ e });
  }
});

export default router;
