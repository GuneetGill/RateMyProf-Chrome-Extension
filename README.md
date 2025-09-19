

# SFU Professor Ratings Extension

## 📌 Overview

This project provides SFU students with quick access to professor ratings while selecting courses. It integrates **RateMyProfessors** data directly into the **SFU course selection site** via a custom Chrome extension. The data pipeline is fully automated, scalable, and powered by AWS cloud infrastructure.

## 🚀 Features

* **Data Collection:**

  * Scraped professor ratings from RateMyProfessors using **Beautiful Soup** and **Selenium**.
  * Stored the cleaned data in an **AWS RDS PostgreSQL** database.

* **Backend Infrastructure:**

  * Designed and deployed a **RESTful API** using **AWS API Gateway** to serve rating data in a user-friendly format.
  * Built an **AWS Lambda** function (running inside a private VPC) to process requests and query the database.
  * Containerized the backend with **Docker** and deployed images to **AWS ECR** for Lambda execution.
  * Infrastructure automated and provisioned using **AWS CDK**.

* **Frontend (Chrome Extension):**

  * Developed a Chrome extension in **JavaScript** that seamlessly integrates into the SFU course selection website.
  * Displays professor ratings in real-time, retrieved from the backend API.

## 🏗️ Architecture

1. **Data Pipeline:**

   * RateMyProfessors → Scraper (Beautiful Soup + Selenium) → AWS RDS (PostgreSQL)

2. **Backend:**

   * AWS API Gateway → AWS Lambda (Dockerized via ECR) → RDS

3. **Frontend:**

   * Chrome Extension → API Gateway → Lambda → RDS

## 🛠️ Tech Stack

* **Languages & Tools:** Python, JavaScript, Docker
* **Web Scraping:** Beautiful Soup, Selenium
* **Cloud Services:**

  * AWS Lambda
  * AWS API Gateway
  * AWS RDS (PostgreSQL)
  * AWS ECR
  * AWS CDK


## 📊 Example Usage

* Search for a course on the SFU course selection site.
* Hover over a professor’s name.
* The extension displays the professor’s average rating, difficulty, and number of reviews directly on the page.

## 🔒 Security & Scalability

* The Lambda function is deployed in a **private VPC** for secure access to RDS.
* Containerized deployment ensures portability and easy scaling.
* AWS CDK provides infrastructure-as-code for reproducibility.

## 📜 License

This project is for educational purposes. Not affiliated with **SFU** or **RateMyProfessors**.

