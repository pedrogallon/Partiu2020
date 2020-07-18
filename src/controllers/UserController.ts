import { Request, Response } from 'express'

class UserController {
    public async get(req: Request, res: Response): Promise<Response> {
        return res.send("fala pora ;usersz")
    }
}

export default new UserController();