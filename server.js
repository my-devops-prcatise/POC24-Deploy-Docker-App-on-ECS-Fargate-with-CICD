const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.get('/health', (req, res) => res.status(200).json({ status: 'ok' }));
app.get('/', (req, res) => res.send('Deployed on ECS, done by Devendhar'));

app.listen(port, '0.0.0.0', () => console.log(`Server listening on ${port}`));
