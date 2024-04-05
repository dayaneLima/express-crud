import express from "express";
import usuarioRouter from "../modules/usuario/usuario.router";

const router = (app: express.Router) => {
  app.use("/usuarios", usuarioRouter);
};

export default router;
