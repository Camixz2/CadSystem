const ClienteService = require("../services/clienteService");

class ClienteController {
    static async getAll(req, res) {
        const data = await ClienteService.getAll();
        res.json(data);
    }

    static async getById(req, res) {
        const data = await ClienteService.getById(req.params.id);
        res.json(data);
    }

    static async create(req, res) {
        const data = await ClienteService.create(req.body);
        res.status(201).json(data);
    }

    static async update(req, res) {
        const data = await ClienteService.update(req.params.id, req.body);
        res.json(data);
    }

    static async delete(req, res) {
        await ClienteService.delete(req.params.id);
        res.json({ message: "Cliente removido" });
    }
}

module.exports = ClienteController;
