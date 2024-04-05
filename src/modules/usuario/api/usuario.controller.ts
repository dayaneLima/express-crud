import { Request, Response } from "express";

export default class UsuarioController {

    async listar(req: Request, res: Response) {    
        return res.status(200).json([]);
    }
}