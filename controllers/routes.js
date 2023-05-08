import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

export const getRoutes = async (req, res) => {
  try {
    const routes = await prisma.route.findMany({
      include: {
        services: true,
      },
    });

    if (routes.length === 0) {
      return res.status(200).json({ msg: "No routes found" });
    }

    return res.json({ data: routes });
  } catch (err) {
    return res.status(500).json({
      msg: err.message,
    });
  }
};

export const createRoute = async (req, res) => {
  try {
    const { number, name, key } = req.body;

    await prisma.route.create({
      data: { number, name, key },
    });

    const newRoutes = await prisma.route.findMany({
      include: {
        services: true,
      },
    });

    return res.status(201).json({
      msg: "Route successfully created",
      data: newRoutes,
    });
  } catch (err) {
    return res.status(500).json({
      msg: err.message,
    });
  }
};

export const updateRoute = async (req, res) => {
  try {
    const { number } = req.params;
    const { name, key } = req.body;

    let route = await prisma.route.findUnique({
      where: { number: String(number) },
    });

    if (!route) {
      return res
        .status(201)
        .json({ msg: `No route with the number: ${number} found` });
    }

    route = await prisma.route.update({
      where: { number: String(number) },
      data: { name, key },
    });

    return res.json({
      msg: `Route with the number: ${number} successfully updated`,
      data: route,
    });
  } catch (err) {
    return res.status(500).json({
      msg: err.message,
    });
  }
};

export const deleteRoute = async (req, res) => {
  try {
    const { number } = req.params;

    const route = await prisma.route.findUnique({
      where: { number: String(number) },
    });

    if (!route) {
      return res
        .status(200)
        .json({ msg: `No route with the number: ${number} found` });
    }

    await prisma.route.delete({
      where: { number: String(number) },
    });

    return res.json({
      msg: `Route with the number: ${number} successfully deleted`,
    });
  } catch (err) {
    return res.status(500).json({
      msg: err.message,
    });
  }
};

export const getRoute = async (req, res) => {
  try {
    const { number } = req.params;

    const route = await prisma.route.findUnique({
      where: { number: String(number) },
    });

    if (!route) {
      return res
        .status(200)
        .json({ msg: `No route with the number: ${number} found` });
    }

    return res.json({
      data: route,
    });
  } catch (err) {
    return res.status(500).json({
      msg: err.message,
    });
  }
};