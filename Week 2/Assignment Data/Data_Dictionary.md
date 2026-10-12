# Fatura Tablosu (Invoice Table)

| Sütun Adı             | Veri Tipi     | Açıklama                                                |
|-----------------------|---------------|----------------------------------------------------------|
| invoice_id            | INT           | Fatura kimlik numarası. Her fatura için benzersizdir.    |
| customer_id           | INT           | Müşteri kimlik numarası. Her müşteri için benzersizdir.  |
| invoice_date          | TIMESTAMP     | Fatura tarihi ve saati.                                  |
| billing_adress        | VARCHAR(50)   | Fatura adresi.                                           |
| billing_city          | VARCHAR(20)   | Fatura şehri.                                            |
| billing_state         | VARCHAR(10)   | Fatura ili.                                              |
| billing_country       | VARCHAR(15)   | Fatura ülkesi.                                           |
| billing_postal_code   | VARCHAR(20)   | Fatura posta kodu.                                       |
| total                 | FLOAT         | Fatura toplam tutarı.                                    |

---

# Invoice Table

| Column Name             | Data Type     | Description                                                |
|-----------------------|---------------|----------------------------------------------------------|
| invoice_id            | INT           | Invoice ID. Unique for each invoice.    |
| customer_id           | INT           | Customer ID. Unique for each customer.  |
| invoice_date          | TIMESTAMP     | Invoice date and time.                                  |
| billing_address        | VARCHAR(50)   | Billing address.                                           |
| billing_city          | VARCHAR(20)   | Billing city.                                            |
| billing_state         | VARCHAR(10)   | Billing state.                                              |
| billing_country       | VARCHAR(15)   | Billing country.                                           |
| billing_postal_code   | VARCHAR(20)   | Billing ZIP code.                                       |
| total                 | FLOAT         | Total invoice amount.                                    |

