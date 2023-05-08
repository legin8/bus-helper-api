import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

export const getServices = async (req, res) => {
  try {
    const services = await prisma.service.findMany();

    if (services.length === 0) {
      return res.status(200).json({ msg: "No services found" });
    }

    return res.json({ data: services });
  } catch (err) {
    return res.status(500).json({
      msg: err.message,
    });
  }
};

export const createService = async (req, res) => {
  try {
    const { code, name, routeNumber, key } = req.body;

    await prisma.service.create({
      data: { code, name, routeNumber, key },
    });

    const newServices = await prisma.service.findMany();

    return res.status(201).json({
      msg: "Service successfully created",
      data: newServices,
    });
  } catch (err) {
    return res.status(500).json({
      msg: err.message,
    });
  }
};

export const updateService = async (req, res) => {
  try {
    const { code } = req.params;
    const { name, routeNumber, key } = req.body;

    let service = await prisma.service.findUnique({
      where: { code: String(code) },
    });

    if (!service) {
      return res
        .status(201)
        .json({ msg: `No service with the code: ${code} found` });
    }

    service = await prisma.service.update({
      where: { code: String(code) },
      data: { name, routeNumber, key },
    });

    return res.json({
      msg: `Service with the code: ${code} successfully updated`,
      data: service,
    });
  } catch (err) {
    return res.status(500).json({
      msg: err.message,
    });
  }
};

export const deleteService = async (req, res) => {
  try {
    const { code } = req.params;

    const service = await prisma.service.findUnique({
      where: { code: String(code) },
    });

    if (!service) {
      return res
        .status(200)
        .json({ msg: `No service with the code: ${code} found` });
    }

    await prisma.service.delete({
      where: { code: String(code) },
    });

    return res.json({
      msg: `Service with the code: ${code} successfully deleted`,
    });
  } catch (err) {
    return res.status(500).json({
      msg: err.message,
    });
  }
};

export const getService = async (req, res) => {
  try {
    const { code } = req.params;

    const service = await prisma.service.findUnique({
      where: { code: String(code) },
    });

    if (!service) {
      return res
        .status(200)
        .json({ msg: `No service with the code: ${code} found` });
    }

    return res.json({
      data: service,
    });
  } catch (err) {
    return res.status(500).json({
      msg: err.message,
    });
  }
};