# 🚀 ETL System for CPA (Cost Per Acquisition) Calculation

[![Python](https://img.shields.io/badge/python-3.12-blue.svg)](https://www.python.org/downloads/)
[![Tests](https://img.shields.io/badge/tests-44%20passed-success.svg)](https://github.com/pytest-dev/pytest)
[![Coverage](https://img.shields.io/badge/coverage-74%25-green.svg)](https://github.com/nedbat/coveragepy)
[![Docker](https://img.shields.io/badge/docker-ready-blue.svg)](https://www.docker.com/)

## 📋 Description

ETL system for automated processing of advertising spend and conversion data, calculating CPA (Cost Per Acquisition) and saving results to PostgreSQL.

### ✨ Key Features:
- ✅ **ETL Process**: Extract, transform and load data
- ✅ **CPA Calculation**: Automatic calculation of cost per acquisition
- ✅ **Scheduler**: Automatic data updates every 30 minutes
- ✅ **Rate Limiting**: API limit management (80 requests/day with 20% reserve)
- ✅ **Docker**: Full containerization of the app and DB
- ✅ **Testing**: 44 tests with 74% coverage
- ✅ **Logging**: Detailed logs of all operations (Loguru)

---

## ⚡ Quick Start

### 🐳 Docker

**Requirements**: Docker and Docker Compose

```bash
# 1️⃣ Clone the repository
git clone <repository-url>
cd test-task-salesbrush

# 2️⃣ Start everything with one command
make docker-up

# 3️⃣ Run tests
make docker-test

# 4️⃣ Run ETL once
make docker-run

# 5️⃣ Start the scheduler (Ctrl+C to stop)
make docker-scheduler
```


---

### 💻 Local Installation with Poetry

**Requirements**: Python 3.12+, Poetry, PostgreSQL

```bash
# 1️⃣ Clone the repository
git clone <repository-url>
cd test-task-salesbrush

# 2️⃣ Install Poetry (if not installed)
curl -sSL https://install.python-poetry.org | python3 -

# 3️⃣ Install dependencies
make install
# or
poetry install

# 4️⃣ Configure PostgreSQL and create .env
cp .env.example .env
# Edit .env with your DB settings

# 5️⃣ Run tests
make test

# 6️⃣ Run ETL
make run

# 7️⃣ Start the scheduler
make scheduler
```

---

### 🐍 Local Installation with venv

**Requirements**: Python 3.12+, PostgreSQL

```bash
# 1️⃣ Clone the repository
git clone <repository-url>
cd test-task-salesbrush

# 2️⃣ Create a virtual environment
python3.12 -m venv .venv
source .venv/bin/activate  # macOS/Linux
# or
.venv\Scripts\activate  # Windows

# 3️⃣ Upgrade pip and install Poetry
pip install --upgrade pip
pip install poetry

# 4️⃣ Install dependencies via Poetry
poetry install

# 5️⃣ Configure PostgreSQL and create .env
cp .env.example .env
# Edit .env with your DB settings

# 6️⃣ Run tests
poetry run pytest

# 7️⃣ Run ETL
poetry run python run.py

# 8️⃣ Start the scheduler
poetry run python run.py --scheduler
```

---

## 🎯 Quick Testing

### Docker

```bash
# Full testing cycle in Docker
make docker-up              # Start containers
make docker-test            # Run all 44 tests
make docker-run             # One-time data load
make docker-logs            # View logs

# Check data in DB
make docker-db-shell
# In psql:
SELECT * FROM daily_stats ORDER BY date, campaign_id;
\q
```

### Locally

```bash
# Full testing cycle locally
make test                   # Run tests
make test-coverage          # Tests with coverage report
make run                    # One-time data load
tail -f logs/etl.log        # View logs
```

---

## 📚 All Makefile Commands

### 🐳 Docker Commands

| Command | Description |
|---------|-------------|
| `make docker-up` | 🚀 Start containers (app + postgres) |
| `make docker-down` | ⛔ Stop containers |
| `make docker-restart` | 🔄 Restart containers |
| `make docker-build` | 🔨 Rebuild Docker images |
| `make docker-clean` | 🗑️ Remove containers and volumes |
| `make docker-test` | ✅ Run tests in Docker |
| `make docker-test-coverage` | 📊 Tests with code coverage |
| `make docker-run` | ▶️ Run ETL once |
| `make docker-scheduler` | ⏰ Start scheduler (interactive) |
| `make docker-shell` | 🖥️ Open bash in container |
| `make docker-db-shell` | 🗄️ Connect to PostgreSQL |
| `make docker-logs` | 📝 Show application logs |

### 💻 Local Commands

| Command | Description |
|---------|-------------|
| `make install` | 📦 Install dependencies (Poetry) |
| `make test` | ✅ Run tests |
| `make test-verbose` | 📋 Tests with verbose output |
| `make test-coverage` | 📊 Tests + HTML coverage report |
| `make run` | ▶️ Run ETL once |
| `make scheduler` | ⏰ Start scheduler |
| `make format` | ✨ Auto-format code (ruff) |
| `make lint` | 🔍 Check code style |
| `make typecheck` | 🔎 Type checking (mypy) |
| `make clean` | 🗑️ Clean cache and temp files |

---

## 🎮 Operating Modes

### 1️⃣ One-time load of all data

```bash
# Docker
make docker-run

# Locally
poetry run python run.py
```

**Result**: Loads all data from `data/`, calculates CPA, saves to DB.

---

### 2️⃣ Load for a specific period

```bash
# Docker
docker exec salesbrush-app poetry run python run.py --start-date 2025-06-04 --end-date 2025-06-05

# Locally
poetry run python run.py --start-date 2025-06-04 --end-date 2025-06-05
```

**Result**: Filters data by date before saving.

---

### 3️⃣ Scheduler (automatic updates)

```bash
# Docker (interactive)
make docker-scheduler

# Locally
poetry run python run.py --scheduler
```

**What the scheduler does:**
- ⏰ Updates data every 30 minutes (configurable)
- 📅 Checks the last 7 days for missing data
- 🚦 Respects API limits: max 80 requests/day (20% reserve)
- 🔄 Automatically skips update when limit is reached
- 📝 Logs all operations

**Stop**: Press `Ctrl+C`

---

## ⚙️ Configuration

### .env File

```bash
# Database
POSTGRES_DB=salesbrush_test
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_HOST=localhost        # or 'postgres' in Docker
POSTGRES_PORT=5432

# API limits
API_DAILY_LIMIT=100            # Maximum requests per day
API_SAFETY_MARGIN=0.2          # Safety reserve (20%)

# Scheduler
UPDATE_INTERVAL_MINUTES=30     # Data update interval
MAX_RETRIES=3                  # Retries on error
RETRY_DELAY_SECONDS=60         # Delay between retries
```

**Notes:**
- In Docker use `POSTGRES_HOST=postgres` (service name)
- Locally use `POSTGRES_HOST=localhost`
- Effective API limit = 100 * (1 - 0.2) = 80 requests/day

---

## 🧪 Testing

### Run all tests

```bash
# Docker
make docker-test

# Locally
make test
```

### With code coverage

```bash
# Docker
make docker-test-coverage

# Locally
make test-coverage
# Open htmlcov/index.html in your browser
```

### Test structure

```
tests/
├── test_calculator.py        # 12 tests - CPA calculation, data merging
├── test_data_loader.py        # 7 tests - JSON loading
├── test_etl_service.py        # 7 tests - ETL process
├── test_etl_integration.py    # 3 tests - integration tests
├── test_rate_limiter.py       # 8 tests - API limits
└── test_schemas.py            # 7 tests - Pydantic validation
```

**Total: 44 tests | Coverage: 74% | Minimum required: 70%** ✅

---


## 📊 Example Output

### Input Data

**data/fb_spend.json**:
```json
[
  {"date": "2025-06-04", "campaign_id": "CAMP-123", "spend": 37.50},
  {"date": "2025-06-04", "campaign_id": "CAMP-456", "spend": 19.90}
]
```

**data/network_conv.json**:
```json
[
  {"date": "2025-06-04", "campaign_id": "CAMP-123", "conversions": 14},
  {"date": "2025-06-04", "campaign_id": "CAMP-456", "conversions": 3}
]
```

### Program Output

```
================================================================================
📊 DATA PROCESSING SUMMARY
================================================================================

✅ Records processed: 2
💰 Total spend: $57.40
🎯 Total conversions: 17
📈 Records with CPA: 2
💵 Average CPA: $4.66

--------------------------------------------------------------------------------
Date         Campaign ID     Spend        Conv     CPA
--------------------------------------------------------------------------------
2025-06-04 CAMP-123        $37.50       14       $2.68
2025-06-04 CAMP-456        $19.90       3        $6.63
================================================================================
```


---

## 📝 Logging

All operations are logged to `logs/etl.log` with file rotation.

```bash
# View logs
tail -f logs/etl.log

# In Docker
make docker-logs
# or
docker logs -f salesbrush-app
```

**Log format**: `YYYY-MM-DD HH:MM:SS | LEVEL | module:function - Message`

---

## 🏗️ Project Architecture

```
src/
├── database/              # 🗄️ SQLAlchemy ORM and DB connection
│   ├── db.py             # Database class, sessions
│   └── models.py         # DailyStats model
├── schemas/              # ✅ Pydantic validation schemas
│   ├── spend.py          # Spend schema
│   ├── conversion.py     # Conversion schema
│   └── merged.py         # Merged data schema
├── services/             # 🔧 Business logic
│   ├── calculator.py     # CPA calculator and data merging
│   ├── data_loader.py    # JSON file loading
│   ├── etl_service.py    # Main ETL process
│   ├── rate_limiter.py   # Rate limiting for API
│   └── scheduler.py      # Scheduler (APScheduler)
├── settings/             # ⚙️ Configuration (Pydantic Settings)
│   ├── api.py            # API limit settings
│   ├── database.py       # PostgreSQL settings
│   └── scheduler.py      # Scheduler settings
└── utils/                # 🛠️ Utilities
    └── logger.py         # Loguru setup
```

---

## 🔧 Development

### Install pre-commit hooks

```bash
make pre-commit-install
```

### Check code before committing

```bash
make format        # Auto-format (ruff)
make lint          # Style check
make typecheck     # Type checking (mypy)
make test          # Run tests
```

### Development Workflow

1. **Make your code changes**
2. **Run checks**:
   ```bash
   make format && make lint && make typecheck && make test
   ```
3. **Test in Docker**:
   ```bash
   make docker-build && make docker-test
   ```
4. **Commit your changes**

---

## 📦 Dependencies

### Main

- **Python 3.12+**
- **SQLAlchemy 2.0+** - ORM for PostgreSQL
- **Pydantic 2.0+** - Data and settings validation
- **APScheduler 3.11+** - Task scheduler
- **Loguru** - Convenient logging
- **Typer** - CLI interface
- **psycopg2-binary** - PostgreSQL driver

### Development

- **pytest** - Testing framework
- **pytest-cov** - Code coverage
- **ruff** - Fast linter and formatter
- **mypy** - Type checking
- **pre-commit** - Git hooks

## 🚀 What I Would Improve With +2 Days

- Async: Rewrite ETL with asyncio + httpx for parallel data loading
- Task queue: Add Celery + Redis for processing large data volumes
- Caching: Redis for caching intermediate results and speeding up repeated requests
- DB migrations: Alembic for versioning the database schema
- Metrics: Prometheus + Grafana for performance and business metrics monitoring
- Data export: Automatic generation of CSV/Excel reports on schedule

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

## 📞 Contacts
To contact the author of the project, write to email dmitriybirilko@gmail.com
