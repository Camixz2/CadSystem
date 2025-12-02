const ProdutoModel = require("../models/produtoModel");

class ProdutoService {
    static getAll() {
        return ProdutoModel.getAll();
    }

    static getById(id) {
        return ProdutoModel.getById(id);
    }

    static create(data) {
        return ProdutoModel.create(data);
    }

    static update(id, data) {
        return ProdutoModel.update(id, data);
    }

    static delete(id) {
        return ProdutoModel.delete(id);
    }
}

module.exports = ProdutoService;
