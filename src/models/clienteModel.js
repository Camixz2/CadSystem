const db = require("../config/db");

class ClienteModel {
    static async getAll() {
        const [rows] = await db.query("SELECT * FROM clientes");
        return rows;
    }

    static async getById(id) {
        const [rows] = await db.query("SELECT * FROM clientes WHERE id = ?", [id]);
        return rows[0];
    }

    static async create(data) {
        const { nome, sobrenome, email, idade, foto } = data;

        const [result] = await db.query(
            "INSERT INTO clientes (nome, sobrenome, email, idade, foto) VALUES (?, ?, ?, ?, ?)",
            [nome, sobrenome, email, idade, foto]
        );

        return { id: result.insertId, nome, sobrenome, email, idade, foto };
    }

    static async update(id, data) {
        const { nome, sobrenome, email, idade, foto } = data;

        await db.query(
            "UPDATE clientes SET nome = ?, sobrenome = ?, email = ?, idade = ?, foto = ? WHERE id = ?",
            [nome, sobrenome, email, idade, foto, id]
        );

        return { id, nome, sobrenome, email, idade, foto };
    }

    static async delete(id) {
        await db.query("DELETE FROM clientes WHERE id = ?", [id]);
        return true;
    }
}

module.exports = ClienteModel;
