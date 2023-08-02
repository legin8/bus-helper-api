import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

export const getStops = async (req, res) => {
  try {
    const stops = await prisma.stop.findMany();

    if (stops.length === 0) {
      return res.status(200).json({
        msg: "No stops found",
      });
    }

    return res.json({ data: stops });
  } catch (err) {
    return res.status(500).json({
      msg: err.message,
    });
  }
};

export const createStop = async (req, res) => {
  try {
    const { code, name, lat, long } = req.body;

    const { userId } = req.user;

    const user = await prisma.user.findUnique({ where: { userId: Number(userId) } });

    if (user.role !== "ADMIN_USER") {
      return res.status(403).json({
        msg: "Not authorized to access this route",
      });
    }

    await prisma.stop.create({
      data: { code, name, lat, long },
    });

    const newStops = await prisma.stop.findMany();

    return res.status(201).json({
      msg: "Stop successfully created",
      data: newStops,
    });
  } catch (err) {
    return res.status(500).json({
      msg: err.message,
    });
  }
};

export const updateStop = async (req, res) => {
  try {
    const { code } = req.params;
    const { name, lat, long } = req.body;

    const { userId } = req.user;

    const user = await prisma.user.findUnique({ where: { userId: Number(userId) } });

    if (user.role !== "ADMIN_USER") {
      return res.status(403).json({
        msg: "Not authorized to access this route",
      });
    }

    let stop = await prisma.stop.findUnique({
      where: { code: String(code) },
    });

    if (!stop) {
      return res.status(201).json({ msg: `No stop with the code: ${code} found` });
    }

    stop = await prisma.stop.update({
      where: { code: String(code) },
      data: { name, lat, long },
    });

    return res.json({
      msg: `Stop with the code: ${code} successfully updated`,
      data: stop,
    });
  } catch (err) {
    return res.status(500).json({
      msg: err.message,
      update: "failed",
    });
  }
};

export const deleteStop = async (req, res) => {
  try {
    const { code } = req.params;

    const { userId } = req.user;

    const user = await prisma.user.findUnique({ where: { userId: Number(userId) } });

    if (user.role !== "ADMIN_USER") {
      return res.status(403).json({
        msg: "Not authorized to access this route",
      });
    }

    const stop = await prisma.stop.findUnique({
      where: { code: String(code) },
    });

    if (!stop) {
      return res.status(200).json({ msg: `No stop with the code: ${code} found` });
    }

    await prisma.stop.delete({
      where: { code: String(code) },
    });

    return res.json({
      msg: `Stop with the code: ${code} successfully deleted`,
    });
  } catch (err) {
    return res.status(500).json({
      msg: err.message,
    });
  }
};

export const getStop = async (req, res) => {
  try {
    const { code } = req.params;

    const stop = await prisma.stop.findUnique({
      where: { code: String(code) },
    });

    if (!stop) {
      return res.status(200).json({ msg: `No stop with the code: ${code} found` });
    }

    return res.json({
      data: stop,
    });
  } catch (err) {
    return res.status(500).json({
      msg: err.message,
    });
  }
};
