const db = require("../config/db");

class ProdutoModel {
    static async getAll() {
        const [rows] = await db.query("SELECT * FROM produtos");
        return rows;
    }

    static async getById(id) {
        const [rows] = await db.query("SELECT * FROM produtos WHERE id = ?", [id]);
        return rows[0];
    }

    static async create(data) {
        const { nome, preco, descricao } = data;

        const [result] = await db.query(
            "INSERT INTO produtos (nome, preco, descricao) VALUES (?, ?, ?)",
            [nome, preco, descricao]
        );

        return { id: result.insertId, nome, preco, descricao };
    }

    static async update(id, data) {
        const { nome, preco, descricao } = data;

        await db.query(
            "UPDATE produtos SET nome = ?, preco = ?, descricao = ? WHERE id = ?",
            [nome, preco, descricao, id]
        );

        return { id, nome, preco, descricao };
    }

    static async delete(id) {
        await db.query("DELETE FROM produtos WHERE id = ?", [id]);
        return true;
    }
}

module.exports = ProdutoModel;
