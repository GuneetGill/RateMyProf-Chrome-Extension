// background.js
// Handles API calls to the FastAPI backend

chrome.runtime.onMessage.addListener(async (message, sender, sendResponse) => {
  if (message.type === "FETCH_PROFESSOR_BY_NAME") {
    const { name } = message;

    try {
      // Call FastAPI backend with professor name
      const apiUrl = `http://127.0.0.1:8000/search_professor_name/${encodeURIComponent(name)}`;
      const response = await fetch(apiUrl);

      if (!response.ok) {
        throw new Error(`API returned ${response.status}`);
      }

      const data = await response.json();
      sendResponse({ success: true, data });
    } catch (error) {
      console.error(`Error fetching data for ${name}:`, error);
      sendResponse({ success: false, error: error.message });
    }

    return true; // Keeps sendResponse alive for async call
  }
});
