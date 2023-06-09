import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

export const getAgencys = async (req, res) => {
  try {
    const agencys = await prisma.agency.findMany({
      include: {
        routes: true,
      },
    });

    if (agencys.length === 0) {
      return res.status(200).json({
        msg: "No agencys found",
      });
    }

    return res.json({ data: agencys });
  } catch (err) {
    return res.status(500).json({
      msg: err.message,
    });
  }
};

export const createAgency = async (req, res) => {
  try {
    const { code, region, url, phone } = req.body;

    const { id } = req.user;

    const user = await prisma.user.findUnique({ where: { id: Number(id) } });

    if (user.role !== "ADMIN_USER") {
      return res.status(403).json({
        msg: "Not authorized to access this route",
      });
    }

    await prisma.agency.create({
      data: { code, region, url, phone, userId: id },
    });

    const newAgencys = await prisma.agency.findMany({
      include: {
        routes: true,
      },
    });

    return res.status(201).json({
      msg: "Agency successfully created",
      data: newAgencys,
    });
  } catch (err) {
    return res.status(500).json({
      msg: err.message,
    });
  }
};

export const updateAgency = async (req, res) => {
  try {
    const { code } = req.params;
    const { region, url, phone } = req.body;

    const { id } = req.user;

    const user = await prisma.user.findUnique({ where: { id: Number(id) } });

    if (user.role !== "ADMIN_USER") {
      return res.status(403).json({
        msg: "Not authorized to access this route",
      });
    }

    let agency = await prisma.agency.findUnique({
      where: { code: String(code) },
    });

    if (!agency) {
      return res.status(201).json({ msg: `No agency with the code: ${code} found` });
    }

    agency = await prisma.agency.update({
      where: { code: String(code) },
      data: { region, url, phone },
    });

    return res.json({
      msg: `Agency with the code: ${code} successfully updated`,
      data: agency,
    });
  } catch (err) {
    return res.status(500).json({
      msg: err.message,
    });
  }
};

export const deleteAgency = async (req, res) => {
  try {
    const { code } = req.params;

    const { id } = req.user;

    const user = await prisma.user.findUnique({ where: { id: Number(id) } });

    if (user.role !== "ADMIN_USER") {
      return res.status(403).json({
        msg: "Not authorized to access this route",
      });
    }

    const agency = await prisma.agency.findUnique({
      where: { code: String(code) },
    });

    if (!agency) {
      return res.status(200).json({ msg: `No agency with the code: ${code} found` });
    }

    await prisma.agency.delete({
      where: { code: String(code) },
    });

    return res.json({
      msg: `Agency with the code: ${code} successfully deleted`,
    });
  } catch (err) {
    return res.status(500).json({
      msg: err.message,
    });
  }
};

export const getAgency = async (req, res) => {
  try {
    const { code } = req.params;

    const agency = await prisma.agency.findUnique({
      where: { code: String(code) },
    });

    if (!agency) {
      return res.status(200).json({ msg: `No agency with the code: ${code} found` });
    }

    return res.json({
      data: agency,
    });
  } catch (err) {
    return res.status(500).json({
      msg: err.message,
    });
  }
};
