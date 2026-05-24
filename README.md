# Scriptum - Book Database Interface

Περιβάλλον διεπαφής για τη βάση δεδομένων Scriptum (bookdb). Απλή Flask web εφαρμογή για διαχείριση βιβλίων, συγγραφέων, χρηστών και κριτικών.

## Τεχνολογίες

- Python 3.x + Flask
- MySQL 8.0
- HTML5 + CSS3

## Απαιτήσεις

- Python 3.8+
- MySQL Server 8.0+

## Οδηγίες Εγκατάστασης

### 1. Εισαγωγή Βάσης Δεδομένων

Εγκαταστήστε το MySQL και τρέξτε:

```bash
mysql -u root -p < Scriptum_dbdump.sql
```

### 2. Εγκατάσταση Python Πακέτων

```bash
pip install -r requirements.txt
```

### 3. Ρύθμιση Σύνδεσης

Επεξεργαστείτε το `config.py` και βάλτε το MySQL password σας:

```python
DB_PASSWORD = 'your_mysql_password'
```

### 4. Εκτέλεση

```bash
python app.py
```

Ανοίξτε το browser στο: **http://localhost:5000**

## Λειτουργίες

- Προβολή και προσθήκη βιβλίων, συγγραφέων, χρηστών
- Γραφή και προβολή κριτικών
- Δημιουργία λιστών ανάγνωσης
- Δημιουργία reading challenges

## Δομή Project

```
db/
├── app.py                   # Flask εφαρμογή
├── config.py                # Ρυθμίσεις database
├── requirements.txt         # Python dependencies
├── Scriptum_dbdump.sql     # Database schema & data
├── README.md
└── templates/              # HTML templates
    ├── base.html
    ├── index.html
    ├── books.html
    ├── authors.html
    ├── users.html
    ├── reviews.html
    ├── booklists.html
    ├── booklist_details.html
    ├── challenges.html
    ├── add_book.html
    ├── add_author.html
    ├── add_user.html
    ├── add_review.html
    ├── add_booklist.html
    └── add_challenge.html
```

## Troubleshooting

**"Access denied for user"** → Ελέγξτε το password στο `config.py`

**"Unknown database 'bookdb'"** → Τρέξτε το `Scriptum_dbdump.sql`

**"Port 5000 already in use"** → Αλλάξτε το port στο `app.py`

---

Database Systems Project - 2026
