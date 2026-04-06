Mini-Test Task (CPA calculation / data synchronization)

1. Assignment
Script run.py

Reads two JSON files.

Accepts parameters --start-date and --end-date (ISO format).

Merges data by date + campaign_id.

Calculates CPA = spend / conversions

if conversions == 0 → CPA = null.

Writes the result directly to the daily_stats table (upsert) and optionally displays a brief summary in the console.

Database

SQLite or PostgreSQL (Docker container).

Table daily_stats(date, campaign_id, spend, conversions, cpa).

The script should perform an upsert (or describe the import command in the README).

API Limits Accounting

Assume the real API provides no more than 100 requests per day.

Describe (and optionally implement) a simple "update several times per hour" strategy. It must be as frequent as possible, but under no circumstances should it hit the limits (always maintain a ~20% daily limit margin):

scheduler (cron / APScheduler);

checking "whether we have already loaded date X";

re-loading only those dates for which data is missing or was incomplete.

Tests

pytest + at least one unit test verifying the correctness of CPA calculation and row merging.

GitHub

Minimum 3 meaningful commits.

README with "how to launch in 3 minutes" instructions (venv / poetry / docker — your choice).

Optional (bonus for evaluation)

Dockerfile + make run.

mypy / ruff / pre-commit.

Logging, retry logic for network errors.

2. JSON Sources
Create from the text below

File | Description
fb_spend.json | Facebook campaign spend
network_conv.json | conversions from affiliate network

3. Criteria (100 points)
Block | Points
Works end-to-end | 40
Code cleanliness, types, logging | 20
Tests (≥ 50% coverage) | 15
README and quick start | 15
Docker / improvements | 10

4. Submission
Send a Pull Request within 5 calendar days.
In the PR, add a short checklist of "what I would improve if I had an additional 2 days".
Good luck! We evaluate not the "ideal" result, but the ability to independently organize work, think critically, and see the task through to the end.

🗂 JSON Files

fb_spend.json

[
  {"date": "2025-06-04", "campaign_id": "CAMP-123", "spend": 37.50},
  {"date": "2025-06-04", "campaign_id": "CAMP-456", "spend": 19.90},
  {"date": "2025-06-05", "campaign_id": "CAMP-123", "spend": 42.10},
  {"date": "2025-06-05", "campaign_id": "CAMP-789", "spend": 11.00},
  {"code": "2025-06-06", "campaign_id": "CAMP-999", "spend": 5.25}
]

network_conv.json

[
  {"date": "2025-06-04", "campaign_id": "CAMP-123", "conversions": 14},
  {"date": "2025-06-04", "campaign_id": "CAMP-456", "conversions": 3},
  {"date": "2025-06-05", "campaign_id": "CAMP-123", "conversions": 10},
  {"date": "2025-06-05", "campaign_id": "CAMP-456", "conversions": 5},
  {"date": "2025-06-06", "campaign_id": "CAMP-888", "conversions": 7}
]
