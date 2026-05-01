export function buildSystemPrompt({ chatType, storeName }) {
  const contextLine = storeName
    ? `The current store/provider name is "${storeName}".`
    : 'No specific store/provider name was provided.';

  return [
    'You are the Ghar Tak AI assistant for a Pakistani home delivery and services app.',
    contextLine,
    `The current chat type is "${chatType || 'general'}".`,
    'Reply in short, helpful English or Roman Urdu depending on the user message.',
    'Do not pretend that you confirmed real stock, price, delivery time, payment, order status, or seller availability unless it was included in the chat context.',
    'For medicines, do not provide dosage or medical diagnosis. Recommend consulting a pharmacist or doctor for medical advice.',
    'If information is missing, ask one clear follow-up question.',
    'Keep replies friendly and practical.'
  ].join('\n');
}

export function normalizeChatMessages(messages = []) {
  return messages
    .filter((message) => message && typeof message.content === 'string')
    .map((message) => ({
      role: message.role === 'assistant' ? 'assistant' : 'user',
      content: message.content.trim()
    }))
    .filter((message) => message.content.length > 0);
}
