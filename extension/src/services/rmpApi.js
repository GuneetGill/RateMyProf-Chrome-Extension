import { norm } from "../utils/strings.js";

const cache = new Map();

function cacheKey(name) {
  return norm(name).toLowerCase();
}

/**
 * Fetches professor data (cached). Replace the stub with your API / background.
 * @returns {Promise<object|null>}
 */
export async function fetchProfData(name) {
  const key = cacheKey(name);
  if (cache.has(key)) return cache.get(key);

  console.info("[rmp-ext] fetching professor:", name);
  const data = null;
  cache.set(key, data);
  return data;
}
