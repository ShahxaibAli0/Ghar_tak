import 'dotenv/config';
import cors from 'cors';
import express from 'express';

import { createChatReply, OllamaConfigError } from './ollamaClient.js';

const app = express();
const port = Number(process.env.PORT || 3000);

function parseAllowedOrigins() {
  const raw = process.env.ALLOWED_ORIGINS || '*';
  if (raw.trim() === '*') return '*';
  return raw
    .split(',')
    .map((origin) => origin.trim())
    .filter(Boolean);
}

app.use(
  cors({
    origin: parseAllowedOrigins()
  })
);
app.use(express.json({ limit: '1mb' }));

app.get('/health', (_req, res) => {
  res.json({
    ok: true,
    service: 'ghar-tak-backend',
    model: process.env.OLLAMA_MODEL || 'gpt-oss:20b-cloud'
  });
});

app.post('/ai/chat', async (req, res) => {
  try {
    const { chatType, storeName, messages, message } = req.body || {};

    const result = await createChatReply({
      chatType,
      storeName,
      messages,
      latestMessage: message
    });

    res.json({
      ok: true,
      reply: result.reply,
      model: result.model
    });
  } catch (error) {
    const status = error instanceof OllamaConfigError ? 500 : 400;
    res.status(status).json({
      ok: false,
      error: error.message || 'Unable to generate AI reply.'
    });
  }
});

app.use((_req, res) => {
  res.status(404).json({
    ok: false,
    error: 'Route not found.'
  });
});

app.listen(port, () => {
  console.log(`Ghar Tak backend running on port ${port}`);
});
