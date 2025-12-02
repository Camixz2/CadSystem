const express = require("express");
const cors = require("cors");
const clienteRoutes = require("./src/routes/clienteRoutes");
const produtoRoutes = require("./src/routes/produtoRoutes");

const app = express();
app.use(cors());
app.use(express.json());

app.use("/clientes", clienteRoutes);
app.use("/produtos", produtoRoutes);

app.listen(3000, "0.0.0.0", () => {

    console.log("Servidor rodando em http://localhost:3000");
});
