'''
File Overview: 
Scrapes professor information from RateMyProfessors.com using multithreading.
Reads all professor links from the database, scrapes each profile page,
and updates the prof_info table with name, rating, department, etc.
'''
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import concurrent.futures
import requests
from bs4 import BeautifulSoup
from database import database

def main():
    print("[init] Initializing database connection pool...")
    database.initialize_connection_pool()

    print("[init] Fetching professor links from database...")
    webpage_links = database.get_links()
    print(f"[init] Found {len(webpage_links)} professor links to scrape")

    with concurrent.futures.ThreadPoolExecutor(max_workers=5) as executor:
        futures = {executor.submit(scrape_and_save, link): link for link in webpage_links}

        for future in concurrent.futures.as_completed(futures):
            link = futures[future]
            try:
                future.result()
            except Exception as e:
                print(f"[error] Thread failed for {link}: {e}")

    print("[done] All professors scraped.")


def scrape_and_save(link):
    """Scrapes a single professor page and saves to database."""
    scraped_data = get_data(link)
    if scraped_data:
        database.save_data_prof_info_table(scraped_data)
        print(f"[saved] {scraped_data['prof_name']} (ID: {scraped_data['prof_id']})")
    else:
        print(f"[skip] No data returned for {link}")


def get_data(url):
    """
    Scrapes a professor's RateMyProfessors page and returns a dict of their info.
    All selectors verified against current live HTML (April 2026).
    """
    prof_id = url.rstrip('/').split('/')[-1]

    # Default values
    prof_name = ''
    rating = 0.0
    number_of_ratings = 0
    department = ''
    would_take_again = ''
    difficulty = 0.0
    top_tags = []

    try:
        headers = {
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) '
                          'AppleWebKit/537.36 (KHTML, like Gecko) '
                          'Chrome/120.0.0.0 Safari/537.36'
        }
        page = requests.get(url, headers=headers, timeout=10)

        if page.status_code != 200:
            print(f"[warn] Got status {page.status_code} for {url}")
            return None

        soup = BeautifulSoup(page.content, "html.parser")

        # --- Professor Name ---
        # <h1 class="NameTitle__NameWrapper-dowf0z-2 cSXRap">
        name_element = soup.find('h1', class_=lambda c: c and 'NameTitle__NameWrapper' in c)
        if name_element:
            # The h1 contains a nested button (bookmark icon) — get text only from the span
            name_span = name_element.find('span', class_=lambda c: c and 'NameWrapper' in c)
            if name_span:
                prof_name = name_span.get_text(strip=True)
            else:
                # Fallback: get all text but strip button text
                for btn in name_element.find_all('button'):
                    btn.decompose()
                prof_name = name_element.get_text(strip=True)

        # --- Overall Rating ---
        # <div class="RatingValue__Numerator-qw8sqy-2 duhvlP">3.2</div>
        rating_element = soup.find('div', class_=lambda c: c and 'RatingValue__Numerator' in c)
        if rating_element:
            try:
                rating = float(rating_element.get_text(strip=True))
            except ValueError:
                pass

        # --- Number of Ratings ---
        # <a href="#ratingsList">135&nbsp;ratings</a>
        ratings_count_element = soup.find('a', href='#ratingsList')
        if ratings_count_element:
            try:
                number_of_ratings = int(ratings_count_element.get_text(strip=True).split()[0])
            except (ValueError, IndexError):
                pass

        # --- Department ---
        # <b>Criminal Justice department</b> inside NameTitle__Title
        dept_container = soup.find('div', class_=lambda c: c and 'NameTitle__Title' in c)
        if dept_container:
            bold = dept_container.find('b')
            if bold:
                department = bold.get_text(strip=True).replace(' department', '').strip()

        # --- Would Take Again & Difficulty ---
        # Both are in <div class="FeedbackItem__FeedbackNumber-uof32n-1 ecFgca">
        # First = Would Take Again (%), Second = Difficulty
        feedback_numbers = soup.find_all('div', class_=lambda c: c and 'FeedbackItem__FeedbackNumber' in c)
        if len(feedback_numbers) >= 1:
            would_take_again = feedback_numbers[0].get_text(strip=True)  # e.g. "57%"
        if len(feedback_numbers) >= 2:
            try:
                difficulty = float(feedback_numbers[1].get_text(strip=True))
            except ValueError:
                pass

        # --- Top Tags ---
        # <div class="TeacherTags__TagsContainer-sc-16vmh1y-0 cgUwDc">
        #   <span class="Tag-bs9vf4-0 hHOVKF">Amazing lectures</span>
        tags_container = soup.find('div', class_=lambda c: c and 'TeacherTags__TagsContainer' in c)
        if tags_container:
            top_tags = [
                tag.get_text(strip=True)
                for tag in tags_container.find_all('span', class_=lambda c: c and 'Tag-' in c)
            ]

    except requests.exceptions.Timeout:
        print(f"[timeout] Request timed out for {url}")
        return None
    except Exception as e:
        print(f"[error] Failed to scrape {url}: {e}")
        return None

    return {
        "prof_id": int(prof_id),
        "link": url,
        "prof_name": prof_name,
        "department": department,
        "rating": rating,
        "number_of_ratings": number_of_ratings,
        "would_take_again": would_take_again,
        "difficulty": difficulty,
        "top_tags": top_tags
    }


if __name__ == "__main__":
    print("=== Starting professor data scraper ===")
    main()
    database.close_pool()
    print("=== Scraper finished ===")