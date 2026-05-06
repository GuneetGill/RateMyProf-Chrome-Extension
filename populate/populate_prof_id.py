'''
File Overview: 
Populate prod_id's and webpage links to table within database.
'''
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

import time
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.common.exceptions import WebDriverException

from database import database


def make_driver():
    """Creates and returns a new Chrome WebDriver instance."""
    print("[init] Launching Chrome WebDriver...")
    chrome_options = Options()
    chrome_options.add_argument("--headless=new")
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-dev-shm-usage")
    chrome_options.add_argument("--disable-gpu")
    # Limit memory usage to prevent tab crashes on large pages
    chrome_options.add_argument("--js-flags=--max-old-space-size=512")
    chrome_options.binary_location = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    driver = webdriver.Chrome(options=chrome_options)
    print("[init] Chrome WebDriver launched successfully")
    return driver


def dismiss_cookie_banner(driver):
    """Dismisses the OneTrust cookie consent banner if it appears."""
    print("  [cookies] Looking for cookie consent banner...")
    try:
        accept_button = WebDriverWait(driver, 8).until(
            EC.element_to_be_clickable((By.XPATH, "//button[contains(text(), 'Accept All Cookies')]"))
        )
        accept_button.click()
        print("  [cookies] Cookie banner dismissed!")
        time.sleep(1)
    except Exception:
        print("  [cookies] No cookie banner found (or already dismissed)")


def close_popup(driver):
    """Closes the RMP signup/promo popup if it appears."""
    print("  [popup] Looking for popup...")
    try:
        close_button = WebDriverWait(driver, 5).until(
            EC.element_to_be_clickable((By.CSS_SELECTOR, "button[aria-label='Close'], button.bx-close"))
        )
        close_button.click()
        print("  [popup] Popup closed successfully!")
        time.sleep(0.5)
    except Exception:
        print("  [popup] No popup found (or already dismissed)")


def extract_ids_from_page(driver):
    """
    Reads the current page source and extracts all valid professor IDs.
    Returns a set of numeric ID strings.
    """
    soup = BeautifulSoup(driver.page_source, 'html.parser')
    professor_cards = soup.find_all('a', href=lambda h: h and '/professor/' in h)
    professor_ids = set()
    for card in professor_cards:
        href = card['href']
        if '/professor/' in href:
            professor_id = href.split('/professor/')[1]
            professor_id = professor_id.split('?')[0].split('#')[0]
            if professor_id.isdigit():
                professor_ids.add(professor_id)
    return professor_ids


def load_profs(driver, url):
    """
    Navigates to a school's professor search page, clicks 'Show More'
    incrementally, collecting IDs as it goes to avoid memory overload.

    Parameters:
    - driver: Selenium WebDriver instance
    - url: RateMyProfessors search URL for a school

    Returns set of professor IDs.
    """
    print(f"\n[load] Navigating to: {url}")
    driver.get(url)

    print("[load] Waiting for professor cards to appear on page...")
    try:
        WebDriverWait(driver, 15).until(
            EC.presence_of_element_located((By.CSS_SELECTOR, "a[href*='/professor/']"))
        )
        print("[load] Professor cards detected on page")
    except Exception as e:
        print(f"[load] ERROR: Professor cards never appeared: {e}")
        return set()

    dismiss_cookie_banner(driver)
    close_popup(driver)

    print("[load] Sleeping 2s for dynamic content to settle...")
    time.sleep(2)

    all_professor_ids = set()
    click_count = 0

    print("[load] Starting to paginate through results...")
    while True:
        # Collect IDs from current state of the page
        current_ids = extract_ids_from_page(driver)
        newly_found = current_ids - all_professor_ids
        all_professor_ids.update(current_ids)
        print(f"  [load] After click #{click_count}: {len(all_professor_ids)} total IDs ({len(newly_found)} new this round)")

        # Try to click Show More
        try:
            button = WebDriverWait(driver, 5).until(
                EC.presence_of_element_located(
                    (By.XPATH, "//button[contains(text(), 'Show More') or contains(text(), 'Load More')]")
                )
            )
            driver.execute_script("arguments[0].scrollIntoView(true);", button)
            time.sleep(0.3)
            driver.execute_script("arguments[0].click();", button)
            click_count += 1
            time.sleep(1.5)  # wait for new cards to render

            # If we're not finding new IDs after several clicks, stop
            if len(newly_found) == 0 and click_count > 3:
                print("  [load] No new IDs found in last round — stopping early")
                break

        except Exception as e:
            print(f"  [load] No more 'Show More' button after {click_count} clicks — done paginating")
            break

    print(f"[load] Finished. Total clicks: {click_count}, Total IDs: {len(all_professor_ids)}")
    return all_professor_ids


'''
Run this script to initially populate the database with professor IDs,
or run again later to pick up any newly added professors.
'''
if __name__ == "__main__":
    print("=== Starting professor scraper ===")

    print("[init] Initializing database connection pool...")
    database.initialize_connection_pool()
    print("[init] Database connection pool ready")

    # All 3 campus school URLs
    school_urls = [
        'https://www.ratemyprofessors.com/search/professors/1482?q=*',
        'https://www.ratemyprofessors.com/search/professors/4267?q=*',
        'https://www.ratemyprofessors.com/search/professors/5788?q=*',
    ]

    print("\n[db] Fetching existing professor IDs from database...")
    current_profs = set(database.get_prof_id())
    print(f"[db] Found {len(current_profs)} existing professors in database")

    for i, url in enumerate(school_urls, 1):
        print(f"\n{'='*50}")
        print(f"[main] Processing school URL {i}/{len(school_urls)}")
        print(f"{'='*50}")

        # Create a fresh driver for each URL to avoid memory buildup crashing Chrome
        driver = make_driver()

        try:
            latest_professor_ids = load_profs(driver, url)
            print(f"[main] Got {len(latest_professor_ids)} professor IDs from page")

            unique_professor_ids = latest_professor_ids - current_profs
            print(f"[main] {len(unique_professor_ids)} are new (not yet in database)")

            if unique_professor_ids:
                print(f"[main] Inserting {len(unique_professor_ids)} new professors into database...")
                database.insert_prof_links(unique_professor_ids)
                print("[main] Insert complete")
                current_profs.update(unique_professor_ids)
            else:
                print("[main] No new professors found for this URL — skipping insert")

        except WebDriverException as e:
            print(f"[main] WebDriver ERROR processing {url}: {e}")
            import traceback
            traceback.print_exc()
        except Exception as e:
            print(f"[main] ERROR processing {url}: {e}")
            import traceback
            traceback.print_exc()
        finally:
            print(f"[main] Closing driver for URL {i}...")
            try:
                driver.quit()
            except Exception:
                print("[main] Driver already dead — skipping quit")

    print("\n[cleanup] Closing database pool...")
    database.close_pool()
    print("=== Scraper finished ===")