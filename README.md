# 🚀 ETL Система для расчёта CPA (Cost Per Acquisition)

[![Python](https://img.shields.io/badge/python-3.12-blue.svg)](https://www.python.org/downloads/)
[![Tests](https://img.shields.io/badge/tests-44%20passed-success.svg)](https://github.com/pytest-dev/pytest)
[![Coverage](https://img.shields.io/badge/coverage-74%25-green.svg)](https://github.com/nedbat/coveragepy)
[![Docker](https://img.shields.io/badge/docker-ready-blue.svg)](https://www.docker.com/)

## 📋 Описание

ETL система для автоматической обработки данных о рекламных расходах и конверсиях с расчётом CPA (Cost Per Acquisition) и сохранением в PostgreSQL.

### ✨ Основные возможности:
- ✅ **ETL процесс**: Загрузка, трансформация и сохранение данных
- ✅ **Расчёт CPA**: Автоматический расчёт стоимости привлечения клиента
- ✅ **Планировщик**: Автоматическое обновление данных каждые 30 минут
- ✅ **Rate Limiting**: Управление лимитами API (80 запросов/день с резервом 20%)
- ✅ **Docker**: Полная контейнеризация приложения и БД
- ✅ **Тестирование**: 44 теста с покрытием 74%
- ✅ **Логирование**: Детальные логи всех операций (Loguru)

---

## ⚡ Быстрый старт

### 🐳 Docker

**Требования**: Docker и Docker Compose

```bash
# 1️⃣ Клонировать репозиторий
git clone <repository-url>
cd test-task-salesbrush

# 2️⃣ Запустить всё одной командой
make docker-up

# 3️⃣ Запустить тесты
make docker-test

# 4️⃣ Запустить ETL один раз
make docker-run

# 5️⃣ Запустить планировщик (Ctrl+C для остановки)
make docker-scheduler
```


---

### 💻 Локальная установка с Poetry

**Требования**: Python 3.12+, Poetry, PostgreSQL

```bash
# 1️⃣ Клонировать репозиторий
git clone <repository-url>
cd test-task-salesbrush

# 2️⃣ Установить Poetry (если нет)
curl -sSL https://install.python-poetry.org | python3 -

# 3️⃣ Установить зависимости
make install
# или
poetry install

# 4️⃣ Настроить PostgreSQL и создать .env
cp .env.example .env
# Отредактируйте .env с вашими настройками БД

# 5️⃣ Запустить тесты
make test

# 6️⃣ Запустить ETL
make run

# 7️⃣ Запустить планировщик
make scheduler
```

---

### 🐍 Локальная установка с venv

**Требования**: Python 3.12+, PostgreSQL

```bash
# 1️⃣ Клонировать репозиторий
git clone <repository-url>
cd test-task-salesbrush

# 2️⃣ Создать виртуальное окружение
python3.12 -m venv .venv
source .venv/bin/activate  # macOS/Linux
# или
.venv\Scripts\activate  # Windows

# 3️⃣ Обновить pip и установить Poetry
pip install --upgrade pip
pip install poetry

# 4️⃣ Установить зависимости через Poetry
poetry install

# 5️⃣ Настроить PostgreSQL и создать .env
cp .env.example .env
# Отредактируйте .env с вашими настройками БД

# 6️⃣ Запустить тесты
poetry run pytest

# 7️⃣ Запустить ETL
poetry run python run.py

# 8️⃣ Запустить планировщик
poetry run python run.py --scheduler
```

---

## 🎯 Быстрое тестирование

### Docker

```bash
# Полный цикл тестирования в Docker
make docker-up              # Запустить контейнеры
make docker-test            # Запустить все 44 теста
make docker-run             # Разовая загрузка данных
make docker-logs            # Посмотреть логи

# Проверить данные в БД
make docker-db-shell
# В psql:
SELECT * FROM daily_stats ORDER BY date, campaign_id;
\q
```

### Локально

```bash
# Полный цикл тестирования локально
make test                   # Запустить тесты
make test-coverage          # Тесты с отчётом покрытия
make run                    # Разовая загрузка данных
tail -f logs/etl.log        # Посмотреть логи
```

---

## 📚 Все команды Makefile

### 🐳 Docker команды

| Команда | Описание |
|---------|----------|
| `make docker-up` | 🚀 Запустить контейнеры (app + postgres) |
| `make docker-down` | ⛔ Остановить контейнеры |
| `make docker-restart` | 🔄 Перезапустить контейнеры |
| `make docker-build` | 🔨 Пересобрать Docker образы |
| `make docker-clean` | 🗑️ Удалить контейнеры и volumes |
| `make docker-test` | ✅ Запустить тесты в Docker |
| `make docker-test-coverage` | 📊 ��есты с покрытием кода |
| `make docker-run` | ▶️ Запустить ETL один раз |
| `make docker-scheduler` | ⏰ Запустить планировщик (интерактивно) |
| `make docker-shell` | 🖥️ Открыть bash в контейнере |
| `make docker-db-shell` | 🗄️ Подключиться к PostgreSQL |
| `make docker-logs` | 📝 Показать логи приложения |

### 💻 Локальные команды

| Команда | Описание |
|---------|----------|
| `make install` | 📦 Установить зависимости (Poetry) |
| `make test` | ✅ Запустить тесты |
| `make test-verbose` | 📋 Тесты с подробным выводом |
| `make test-coverage` | 📊 Тесты + HTML отчёт покрытия |
| `make run` | ▶️ Запустить ETL один раз |
| `make scheduler` | ⏰ Запустить планировщик |
| `make format` | ✨ Автоформатирование кода (ruff) |
| `make lint` | 🔍 Проверка стиля кода |
| `make typecheck` | 🔎 Проверка типов (mypy) |
| `make clean` | 🗑️ Очистить кеш и временные файлы |

---

## 🎮 Режимы работы

### 1️⃣ Разовая загрузка всех данных

```bash
# Docker
make docker-run

# Локально
poetry run python run.py
```

**Результат**: Загружает все данные из `data/`, рассчитывает CPA, сохраняет в БД.

---

### 2️⃣ Загрузка за конкретный период

```bash
# Docker
docker exec salesbrush-app poetry run python run.py --start-date 2025-06-04 --end-date 2025-06-05

# Локально
poetry run python run.py --start-date 2025-06-04 --end-date 2025-06-05
```

**Результат**: Фильтрует данные по датам перед сохранением.

---

### 3️⃣ Планировщик (автоматическое обновление)

```bash
# Docker (интерактивно)
make docker-scheduler

# Локально
poetry run python run.py --scheduler
```

**Что делает планировщик:**
- ⏰ Обновляет данные каждые 30 минут (настраивается)
- 📅 Проверяет последние 7 дней на отсутствующие данные
- 🚦 Соблюдает лимиты API: макс. 80 запросов/день (20% резерв)
- 🔄 Автоматически пропускает обновление при достижении лимита
- 📝 Логирует все операции

**Остановка**: Нажмите `Ctrl+C`

---

## ⚙️ Конфигурация

### Файл .env

```bash
# База данных
POSTGRES_DB=salesbrush_test
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_HOST=localhost        # или 'postgres' в Docker
POSTGRES_PORT=5432

# API лимиты
API_DAILY_LIMIT=100            # Максимум запросов в день
API_SAFETY_MARGIN=0.2          # Резерв безопасности (20%)

# Планировщик
UPDATE_INTERVAL_MINUTES=30     # Интервал обновления данных
MAX_RETRIES=3                  # Попыток при ошибке
RETRY_DELAY_SECONDS=60         # Задержка между попытками
```

**Примечания:**
- В Docker используйте `POSTGRES_HOST=postgres` (имя сервиса)
- Локально используйте `POSTGRES_HOST=localhost`
- Эффективный лимит API = 100 * (1 - 0.2) = 80 запросов/день

---

## 🧪 Тестирование

### Запуск всех тестов

```bash
# Docker
make docker-test

# Локально
make test
```

### С покрытием кода

```bash
# Docker
make docker-test-coverage

# Локально
make test-coverage
# Откройте htmlcov/index.html в браузере
```

### Структура тестов

```
tests/
├── test_calculator.py        # 12 тестов - расчёт CPA, слияние данных
├── test_data_loader.py        # 7 тестов - загрузка JSON
├── test_etl_service.py        # 7 тестов - ETL процесс
├── test_etl_integration.py    # 3 теста - интеграционные
├── test_rate_limiter.py       # 8 тестов - лимиты API
└── test_schemas.py            # 7 тестов - Pydantic валидация
```

**Итого: 44 теста | Покрытие: 74% | Минимум требуется: 70%** ✅

---


## 📊 Пример работы

### Входные данные

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

### Вывод программы

```
================================================================================
📊 РЕЗЮМЕ ОБРАБОТКИ ДАННЫХ
================================================================================

✅ Обработано записей: 2
💰 Общие расходы: $57.40
🎯 Общие конверсии: 17
📈 Записей с CPA: 2
💵 Средний CPA: $4.66

--------------------------------------------------------------------------------
Дата         Campaign ID     Spend        Conv     CPA
--------------------------------------------------------------------------------
2025-06-04 CAMP-123        $37.50       14       $2.68
2025-06-04 CAMP-456        $19.90       3        $6.63
================================================================================
```


---

## 📝 Логирование

Все операции логируются в `logs/etl.log` с ротацией файлов.

```bash
# Просмотр логов
tail -f logs/etl.log

# В Docker
make docker-logs
# или
docker logs -f salesbrush-app
```

**Формат логов**: `YYYY-MM-DD HH:MM:SS | LEVEL | module:function - Message`

---

## 🏗️ Архитектура проекта

```
src/
├── database/              # 🗄️ SQLAlchemy ORM и подключение к БД
│   ├── db.py             # Database класс, сессии
│   └── models.py         # Модель DailyStats
├── schemas/              # ✅ Pydantic схемы валидации
│   ├── spend.py          # Схема расходов
│   ├── conversion.py     # Схема конверсий
│   └── merged.py         # Схема объединённых данных
├── services/             # 🔧 Бизнес-логика
│   ├── calculator.py     # Калькулятор CPA и слияние данных
│   ├── data_loader.py    # Загрузка JSON файлов
│   ├── etl_service.py    # Основной ETL процесс
│   ├── rate_limiter.py   # Rate limiting для API
│   └── scheduler.py      # Планировщик (APScheduler)
├── settings/             # ⚙️ Конфигурация (Pydantic Settings)
│   ├── api.py            # Настройки API лимитов
│   ├── database.py       # Настройки PostgreSQL
│   └── scheduler.py      # Настройки планировщика
└── utils/                # 🛠️ Утилиты
    └── logger.py         # Настройка Loguru
```

---

## 🔧 Разработка

### Установка pre-commit хуков

```bash
make pre-commit-install
```

### Проверка кода перед коммитом

```bash
make format        # Автоформатирование (ruff)
make lint          # Проверка стиля
make typecheck     # Проверка типов (mypy)
make test          # Запуск тестов
```

### Workflow разработки

1. **Внесите изменения в код**
2. **Запустите проверки**:
   ```bash
   make format && make lint && make typecheck && make test
   ```
3. **Протестируйте в Docker**:
   ```bash
   make docker-build && make docker-test
   ```
4. **Закоммитьте изменения**

---

## 📦 Зависимости

### Основные

- **Python 3.12+**
- **SQLAlchemy 2.0+** - ORM для PostgreSQL
- **Pydantic 2.0+** - Валидация данных и настроек
- **APScheduler 3.11+** - Планировщик задач
- **Loguru** - Удобное логирование
- **Typer** - CLI интерфейс
- **psycopg2-binary** - PostgreSQL драйвер

### Для разработки

- **pytest** - Фреймворк тестирования
- **pytest-cov** - Покрытие кода
- **ruff** - Быстрый линтер и форматтер
- **mypy** - Проверка типов
- **pre-commit** - Git хуки

## 🚀 Что бы я улучшил за +2 дня

- Асинхронность: Переписать ETL на asyncio + httpx для параллельной загрузки данных
- Очередь задач: Добавить Celery + Redis для обработки больших объёмов данных
- Кеширование: Redis для кеширования промежуточных результатов и ускорения повторных запросов
- Миграции БД: Alembic для версионирования схемы базы данных
- Метрики: Prometheus + Grafana для мониторинга производительности и бизнес-метрик
- Экспорт данных: Автоматическая генерация CSV/Excel отчётов по расписанию

---

## 📄 Лицензия

Этот проект лицензирован под [MIT License](LICENSE).

---

## 📞 Контакты
To contact the author of the project, write to email dmitriybirilko@gmail.com
