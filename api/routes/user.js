import express from "express";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

const router = express.Router();

router.get("/:uuid", async (req, res) => {
  try {
    const { uuid } = req.params;

    const query = await prisma.user.findMany({
      where: {
        uuid,
      },
      include: {
        reports: true,
      },
    });

    return query.length === 0
      ? res.status(404).send({ error: "User not found" })
      : res.status(200).send(query[0]);
  } catch (e) {
    return res.status(500).send({ e });
  }
});

router.post("/", async (req, res) => {
  try {
    const { uuid, name } = req.body;

    const isUser = await prisma.user.count({
      where: {
        uuid,
      },
    });

    if (isUser > 0) {
      return res.status(200).send({ message: "User already exists" });
    }

    const query = await prisma.user.create({
      data: {
        uuid,
        name,
      },
    });

    query.count = await prisma.report.count({
      where: {
        user: {
          uuid,
        },
      },
    });

    return res.status(201).send(query);
  } catch (e) {
    console.log(e);
    return res.status(500).send({ e });
  }
});

export default router;
