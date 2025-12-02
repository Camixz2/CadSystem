const ProdutoService = require("../services/produtoService");

class ProdutoController {
    static async getAll(req, res) {
        const data = await ProdutoService.getAll();
        res.json(data);
    }

    static async getById(req, res) {
        const data = await ProdutoService.getById(req.params.id);
        res.json(data);
    }

    static async create(req, res) {
        const data = await ProdutoService.create(req.body);
        res.status(201).json(data);
    }

    static async update(req, res) {
        const data = await ProdutoService.update(req.params.id, req.body);
        res.json(data);
    }

    static async delete(req, res) {
        await ProdutoService.delete(req.params.id);
        res.json({ message: "Produto removido" });
    }
}

module.exports = ProdutoController;
