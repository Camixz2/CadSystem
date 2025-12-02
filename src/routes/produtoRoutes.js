const express = require("express");
const ProdutoController = require("../controllers/produtoController");

const router = express.Router();

router.get("/", ProdutoController.getAll);
router.get("/:id", ProdutoController.getById);
router.post("/", ProdutoController.create);
router.put("/:id", ProdutoController.update);
router.delete("/:id", ProdutoController.delete);

module.exports = router;
