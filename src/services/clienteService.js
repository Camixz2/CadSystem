const ClienteModel = require("../models/clienteModel");

class ClienteService {
    static getAll() {
        return ClienteModel.getAll();
    }

    static getById(id) {
        return ClienteModel.getById(id);
    }

    static create(data) {
        return ClienteModel.create(data);
    }

    static update(id, data) {
        return ClienteModel.update(id, data);
    }

    static delete(id) {
        return ClienteModel.delete(id);
    }
}

module.exports = ClienteService;
