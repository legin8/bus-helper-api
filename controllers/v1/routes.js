import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

const routeExample = {
  title: "33",
  locations: "Corstorphine, Caversham, Hub, Wakari",
  key: 1,
};

export const getRoutes = async (req, res) => {
  try {
    const routes = await prisma.route.findMany({
      include: {
        services: true,
      },
    });

    if (routes.length === 0) {
      return res.status(200).json({
        msg: "No routes found",
        example: routeExample,
      });
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
    const { title, locations, key } = req.body;

    await prisma.route.create({
      data: { title, locations, key },
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
    const { title } = req.params;
    const { locations, key } = req.body;

    let route = await prisma.route.findUnique({
      where: { title: String(title) },
    });

    if (!route) {
      return res
        .status(201)
        .json({ msg: `No route with the title: ${title} found` });
    }

    route = await prisma.route.update({
      where: { title: String(title) },
      data: { locations, key },
    });

    return res.json({
      msg: `Route with the title: ${title} successfully updated`,
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
    const { title } = req.params;

    const route = await prisma.route.findUnique({
      where: { title: String(title) },
    });

    if (!route) {
      return res
        .status(200)
        .json({ msg: `No route with the title: ${title} found` });
    }

    await prisma.route.delete({
      where: { title: String(title) },
    });

    return res.json({
      msg: `Route with the title: ${title} successfully deleted`,
    });
  } catch (err) {
    return res.status(500).json({
      msg: err.message,
    });
  }
};

export const getRoute = async (req, res) => {
  try {
    const { title } = req.params;

    const route = await prisma.route.findUnique({
      where: { title: String(title) },
    });

    if (!route) {
      return res
        .status(200)
        .json({ msg: `No route with the title: ${title} found` });
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
