// content.js
// Injects professor ratings into SFU course page

// Adjust selector to match professor names on SFU page
const professorElements = document.querySelectorAll(".prof-name, .instructor");

professorElements.forEach((el) => {
  const professorName = el.innerText.trim();
  if (!professorName) return;  // Skip empty names

  // Send professor name to background.js for API lookup
  chrome.runtime.sendMessage(
    { type: "FETCH_PROFESSOR_BY_NAME", name: professorName },
    (response) => {
      if (!response) return;

      if (response.success && response.data) {
        const prof = response.data;

        // Create a small info bubble next to professor name
        const info = document.createElement("span");
        info.className = "prof-rating";
        info.innerHTML = `
          ⭐ ${prof.rating || "N/A"} 
          (${prof.number_of_ratings || 0} ratings) | 
          Difficulty: ${prof.difficulty ?? "N/A"} | 
          Would Take Again: ${prof.would_take_again ?? "N/A"}
        `;
        el.insertAdjacentElement("afterend", info);
      } else {
        console.warn(`No rating found for ${professorName}`);
      }
    }
  );
});
