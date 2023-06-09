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
      return res.status(200).json({
        msg: "No routes found",
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
    const { title, agencyCode, locations, key } = req.body;

    const { id } = req.user;

    const user = await prisma.user.findUnique({ where: { id: Number(id) } });

    if (user.role !== "ADMIN_USER") {
      return res.status(403).json({
        msg: "Not authorized to access this route",
      });
    }

    await prisma.route.create({
      data: { title, agencyCode, locations, key },
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
    const { agencyCode, locations, key } = req.body;

    const { id } = req.user;

    const user = await prisma.user.findUnique({ where: { id: Number(id) } });

    if (user.role !== "ADMIN_USER") {
      return res.status(403).json({
        msg: "Not authorized to access this route",
      });
    }

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
      data: { agencyCode, locations, key },
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

    const { id } = req.user;

    const user = await prisma.user.findUnique({ where: { id: Number(id) } });

    if (user.role !== "ADMIN_USER") {
      return res.status(403).json({
        msg: "Not authorized to access this route",
      });
    }

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
