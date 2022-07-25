import express from "express";
import cors from "cors";
import docs from "./routes/docs.js";
import user from "./routes/user.js";
import map from "./routes/map.js";

const port = process.env.PORT || 3333;

const app = express();
app.use(cors());
app.use(express.json({ extended: true }));

app.use("/docs", docs);
app.use("/user", user);
app.use("/reports", map);

app.listen(port, () => {
  console.log(`listening at port: ${port}`);
});
