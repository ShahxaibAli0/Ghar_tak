import { buildSystemPrompt, normalizeChatMessages } from './prompts.js';

const DEFAULT_BASE_URL = 'https://ollama.com/api';

export class OllamaConfigError extends Error {
  constructor(message) {
    super(message);
    this.name = 'OllamaConfigError';
  }
}

export async function createChatReply({
  chatType,
  storeName,
  messages,
  latestMessage
}) {
  const apiKey = process.env.OLLAMA_API_KEY;
  const model = process.env.OLLAMA_MODEL || 'gpt-oss:20b-cloud';
  const baseUrl = (process.env.OLLAMA_BASE_URL || DEFAULT_BASE_URL).replace(
    /\/$/,
    ''
  );

  if (!apiKey || apiKey === 'your_ollama_api_key_here') {
    throw new OllamaConfigError('OLLAMA_API_KEY is not configured.');
  }

  const normalizedMessages = normalizeChatMessages(
    messages?.length
      ? messages
      : [{ role: 'user', content: latestMessage || '' }]
  );

  if (normalizedMessages.length === 0) {
    throw new Error('At least one non-empty message is required.');
  }

  const response = await fetch(`${baseUrl}/chat`, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${apiKey}`,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      model,
      stream: false,
      messages: [
        {
          role: 'system',
          content: buildSystemPrompt({ chatType, storeName })
        },
        ...normalizedMessages
      ]
    })
  });

  const payload = await response.json().catch(() => null);

  if (!response.ok) {
    const detail =
      payload?.error || payload?.message || `Ollama request failed (${response.status}).`;
    throw new Error(detail);
  }

  const reply = payload?.message?.content || payload?.response || '';
  if (!reply.trim()) {
    throw new Error('Ollama returned an empty reply.');
  }

  return {
    reply: reply.trim(),
    model
  };
}
