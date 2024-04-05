import express from "express";
import UsuarioController from "./api/usuario.controller";

const router = express.Router();
router.get("/", (req, res) => (new UsuarioController).listar(req, res));

export default router;
