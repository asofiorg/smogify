import express from "express";
import docs from "./routes/docs.js";
import user from "./routes/user.js";
import map from "./routes/map.js";

const app = express();

app.use("/docs", docs);
app.use("/user", user);
app.use("/reports", map);

app.use(express.json({ extended: true }));

app.listen(8080, () => console.log("started!"));
