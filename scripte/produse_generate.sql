BEGIN;

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('AMD Ryzen 9 7900', 'Procesor AMD cu 16 nuclee, potrivit pentru streaming.', 2844.99, 11, 24, '2026-04-02 22:53:59+02:00', 'nou', true, 0.25, '{}'::varchar[], ARRAY['am5', 'gaming', 'high-end', 'editare-video']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Procesoare'), (SELECT id FROM store_brand WHERE nume = 'AMD'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Nuclee', '16', true), ('Frecventa maxima', '5.1 GHz', true), ('Soclu', 'AM5', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Kingston NV3 2TB', NULL, 686.99, 52, 36, '2026-10-10 11:39:59+02:00', 'nou', false, 0.01, '{}'::varchar[], ARRAY['nvme', 'gaming']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Stocare'), (SELECT id FROM store_brand WHERE nume = 'Kingston'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Capacitate', '2 TB', true), ('Interfata', 'PCIe 4.0 NVMe', true), ('Viteza citire', '6000 MB/s', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Logitech Pebble 2 M350s', 'Mouse Logitech Pebble 2 M350s, fara fir.', 118.99, 10, 36, '2026-01-23 04:21:59+02:00', 'nou', false, 0.32, ARRAY['roz']::varchar[], ARRAY['office', 'buget', 'wireless']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Periferice'), (SELECT id FROM store_brand WHERE nume = 'Logitech'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Tip', 'Mouse', true), ('Conexiune', 'Wireless', true)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('AMD Ryzen 9 9950X', 'Procesor AMD cu 16 nuclee, potrivit pentru streaming.', 2973.99, 1, 60, '2026-10-24 05:25:59+02:00', 'nou', true, 0.21, '{}'::varchar[], ARRAY['am5', 'gaming', 'high-end', 'editare-video']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Procesoare'), (SELECT id FROM store_brand WHERE nume = 'AMD'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Nuclee', '16', true), ('Frecventa maxima', '5.8 GHz', true), ('Soclu', 'AM5', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Intel Core i9-13900F', 'Procesor Intel cu 24 nuclee, potrivit pentru streaming.', 2902.99, 39, 60, '2026-07-13 04:10:59+02:00', 'nou', true, 0.28, '{}'::varchar[], ARRAY['lga1700', 'gaming', 'high-end', 'editare-video']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Procesoare'), (SELECT id FROM store_brand WHERE nume = 'Intel'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Nuclee', '24', true), ('Frecventa maxima', '5.6 GHz', true), ('Soclu', 'LGA1700', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Kingston Fury Beast RGB 32GB DDR5 6400MHz', 'Kit de memorie DDR5 de 32 GB, la 6400 MHz.', 318.99, 21, 12, '2026-03-25 05:49:59+02:00', 'resigilat', false, 0.05, ARRAY['negru']::varchar[], ARRAY['ddr5', 'gaming', 'rgb']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Memorii RAM'), (SELECT id FROM store_brand WHERE nume = 'Kingston'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Capacitate', '32 GB (2 x 16 GB)', true), ('Frecventa', '6400 MHz', true), ('Latenta', 'CL40', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Kingston A400 4TB', 'SSD SATA III de 4 TB, cu viteze de citire de pana la 500 MB/s.', 868.99, 56, 12, '2025-12-01 05:41:59+02:00', 'reconditionat', true, 0.06, '{}'::varchar[], ARRAY['sata', 'upgrade']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Stocare'), (SELECT id FROM store_brand WHERE nume = 'Kingston'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Capacitate', '4 TB', true), ('Interfata', 'SATA III', true), ('Viteza citire', '500 MB/s', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('ASUS ROG Strix Radeon RX 7600', 'Placa video pentru jocuri in 1080p, cu 8 GB memorie GDDR6.', 1238.99, 31, 6, '2026-09-05 07:56:59+02:00', 'reconditionat', true, 2.3, ARRAY['negru', 'alb']::varchar[], ARRAY['gaming', '1080p', 'buget']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Placi video'), (SELECT id FROM store_brand WHERE nume = 'ASUS'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Memorie video', '8 GB GDDR6', true), ('Interfata', 'PCIe 4.0 x16', false), ('Ventilatoare', '3', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Kingston NV3 1TB', 'SSD PCIe 4.0 NVMe de 1 TB, cu viteze de citire de pana la 6000 MB/s.', 307.99, 37, 60, '2026-04-19 00:27:59+02:00', 'nou', false, 0.02, '{}'::varchar[], ARRAY['nvme', 'gaming', 'buget']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Stocare'), (SELECT id FROM store_brand WHERE nume = 'Kingston'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Capacitate', '1 TB', true), ('Interfata', 'PCIe 4.0 NVMe', true), ('Viteza citire', '6000 MB/s', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('ASUS TUF Gaming Radeon RX 7900 XTX', 'Placa video pentru jocuri in 4k, cu 24 GB memorie GDDR6.', 5023.99, 29, 24, '2026-10-12 21:31:59+02:00', 'nou', true, 1.56, ARRAY['alb']::varchar[], ARRAY['gaming', '4k']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Placi video'), (SELECT id FROM store_brand WHERE nume = 'ASUS'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Memorie video', '24 GB GDDR6', true), ('Interfata', 'PCIe 4.0 x16', false), ('Ventilatoare', '2', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Kingston Fury Renegade 64GB DDR4 3200MHz', 'Kit de memorie DDR4 de 64 GB, la 3200 MHz.', 341.99, 14, 60, '2026-08-05 08:28:59+02:00', 'nou', false, 0.08, ARRAY['alb']::varchar[], ARRAY['ddr4', 'upgrade']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Memorii RAM'), (SELECT id FROM store_brand WHERE nume = 'Kingston'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Capacitate', '64 GB (2 x 32 GB)', true), ('Frecventa', '3200 MHz', true), ('Latenta', 'CL16', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Kingston KC3000 1TB', 'SSD PCIe 4.0 NVMe de 1 TB, cu viteze de citire de pana la 7000 MB/s.', 459.99, 16, 24, '2026-02-13 21:38:59+02:00', 'nou', true, 0.02, '{}'::varchar[], ARRAY['nvme', 'gaming']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Stocare'), (SELECT id FROM store_brand WHERE nume = 'Kingston'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Capacitate', '1 TB', true), ('Interfata', 'PCIe 4.0 NVMe', true), ('Viteza citire', '7000 MB/s', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('ASUS Dual Radeon RX 7700 XT', 'Placa video pentru jocuri in 1440p, cu 12 GB memorie GDDR6.', 1729.99, 1, 6, '2026-05-03 13:58:59+02:00', 'resigilat', true, 0.92, ARRAY['negru', 'alb']::varchar[], ARRAY['gaming', '1440p']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Placi video'), (SELECT id FROM store_brand WHERE nume = 'ASUS'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Memorie video', '12 GB GDDR6', true), ('Interfata', 'PCIe 4.0 x16', false), ('Ventilatoare', '2', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Kingston A400 500GB', 'SSD SATA III de 500 GB, cu viteze de citire de pana la 500 MB/s.', 165.99, 54, 36, '2026-06-24 07:19:59+02:00', 'nou', false, 0.06, '{}'::varchar[], ARRAY['sata', 'upgrade', 'buget']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Stocare'), (SELECT id FROM store_brand WHERE nume = 'Kingston'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Capacitate', '500 GB', true), ('Interfata', 'SATA III', true), ('Viteza citire', '500 MB/s', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Logitech MX Keys S', 'Tastatura Logitech MX Keys S, fara fir.', 591.99, 31, 36, '2025-12-10 17:03:59+02:00', 'nou', false, 0.44, ARRAY['roz', 'negru', 'albastru']::varchar[], ARRAY['office', 'wireless']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Periferice'), (SELECT id FROM store_brand WHERE nume = 'Logitech'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Tip', 'Tastatura', true), ('Conexiune', 'Wireless', true)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Kingston Fury Renegade 64GB DDR4 3600MHz', NULL, 360.99, 41, 24, '2026-02-07 18:45:59+02:00', 'nou', false, 0.07, ARRAY['negru', 'alb']::varchar[], ARRAY['ddr4', 'gaming']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Memorii RAM'), (SELECT id FROM store_brand WHERE nume = 'Kingston'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Capacitate', '64 GB (2 x 32 GB)', true), ('Frecventa', '3600 MHz', true), ('Latenta', 'CL18', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Kingston Fury Beast 16GB DDR4 3600MHz', 'Kit de memorie DDR4 de 16 GB, la 3600 MHz.', 142.99, 58, 36, '2026-06-10 17:46:59+02:00', 'nou', true, 0.13, ARRAY['negru', 'alb']::varchar[], ARRAY['ddr4', 'gaming']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Memorii RAM'), (SELECT id FROM store_brand WHERE nume = 'Kingston'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Capacitate', '16 GB (2 x 8 GB)', true), ('Frecventa', '3600 MHz', true), ('Latenta', 'CL16', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('AMD Ryzen 7 9700', 'Procesor AMD cu 8 nuclee, potrivit pentru jocuri.', 1768.99, 34, 36, '2026-01-12 01:55:59+02:00', 'nou', true, 0.15, '{}'::varchar[], ARRAY['am5', 'gaming']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Procesoare'), (SELECT id FROM store_brand WHERE nume = 'AMD'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Nuclee', '8', true), ('Frecventa maxima', '4.7 GHz', true), ('Soclu', 'AM5', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Logitech G305 Lightspeed', 'Mouse Logitech G305 Lightspeed, fara fir.', 206.99, 60, 24, '2026-07-13 10:00:59+02:00', 'nou', false, 0.84, ARRAY['alb', 'roz']::varchar[], ARRAY['gaming', 'wireless']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Periferice'), (SELECT id FROM store_brand WHERE nume = 'Logitech'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Tip', 'Mouse', true), ('Conexiune', 'Wireless', true)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Kingston Fury Beast RGB 16GB DDR4 3600MHz', 'Kit de memorie DDR4 de 16 GB, la 3600 MHz.', 120.99, 26, 6, '2026-10-21 19:26:59+02:00', 'resigilat', true, 0.08, ARRAY['negru']::varchar[], ARRAY['ddr4', 'gaming', 'rgb']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Memorii RAM'), (SELECT id FROM store_brand WHERE nume = 'Kingston'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Capacitate', '16 GB (2 x 8 GB)', true), ('Frecventa', '3600 MHz', true), ('Latenta', 'CL18', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('AMD Ryzen 5 9600X', 'Procesor AMD cu 6 nuclee, potrivit pentru streaming.', 911.99, 54, 36, '2026-02-14 22:18:59+02:00', 'nou', true, 0.22, '{}'::varchar[], ARRAY['am5', 'gaming', 'buget']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Procesoare'), (SELECT id FROM store_brand WHERE nume = 'AMD'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Nuclee', '6', true), ('Frecventa maxima', '4.8 GHz', true), ('Soclu', 'AM5', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Logitech Brio 500', NULL, 542.99, 25, 36, '2026-01-02 03:01:59+02:00', 'nou', true, 0.54, ARRAY['alb', 'negru']::varchar[], ARRAY['office', 'streaming']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Periferice'), (SELECT id FROM store_brand WHERE nume = 'Logitech'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Tip', 'Camera web', true), ('Conexiune', 'USB, cu fir', true)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('ASUS Dual Radeon RX 7800 XT', 'Placa video pentru jocuri in 1440p, cu 16 GB memorie GDDR6.', 2678.99, 47, 60, '2026-11-13 01:51:59+02:00', 'nou', true, 1.81, ARRAY['negru', 'alb']::varchar[], ARRAY['gaming', '1440p']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Placi video'), (SELECT id FROM store_brand WHERE nume = 'ASUS'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Memorie video', '16 GB GDDR6', true), ('Interfata', 'PCIe 4.0 x16', false), ('Ventilatoare', '3', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Samsung 990 Pro 1TB', 'SSD PCIe 4.0 NVMe de 1 TB, cu viteze de citire de pana la 7450 MB/s.', 461.99, 28, 12, '2026-07-22 04:06:59+02:00', 'reconditionat', false, 0.02, '{}'::varchar[], ARRAY['nvme', 'gaming']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Stocare'), (SELECT id FROM store_brand WHERE nume = 'Samsung'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Capacitate', '1 TB', true), ('Interfata', 'PCIe 4.0 NVMe', true), ('Viteza citire', '7450 MB/s', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Kingston Fury Beast RGB 32GB DDR4 3600MHz', 'Kit de memorie DDR4 de 32 GB, la 3600 MHz.', 230.99, 5, 24, '2026-02-23 23:18:59+02:00', 'nou', false, 0.1, ARRAY['alb']::varchar[], ARRAY['ddr4', 'gaming', 'rgb']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Memorii RAM'), (SELECT id FROM store_brand WHERE nume = 'Kingston'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Capacitate', '32 GB (2 x 16 GB)', true), ('Frecventa', '3600 MHz', true), ('Latenta', 'CL18', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Intel Core i3-13100K', 'Procesor Intel cu 4 nuclee, potrivit pentru editare video.', 361.99, 49, 6, '2026-01-29 21:45:59+02:00', 'reconditionat', false, 0.13, '{}'::varchar[], ARRAY['lga1700', 'office', 'buget']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Procesoare'), (SELECT id FROM store_brand WHERE nume = 'Intel'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Nuclee', '4', true), ('Frecventa maxima', '5.4 GHz', true), ('Soclu', 'LGA1700', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('ASUS TUF Gaming GeForce RTX 4080 Super', 'Placa video pentru jocuri in 4k, cu 16 GB memorie GDDR6X.', 4582.99, 59, 24, '2026-01-12 01:10:59+02:00', 'reconditionat', true, 1.62, ARRAY['alb']::varchar[], ARRAY['gaming', '4k', 'ray-tracing']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Placi video'), (SELECT id FROM store_brand WHERE nume = 'ASUS'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Memorie video', '16 GB GDDR6X', true), ('Interfata', 'PCIe 4.0 x16', false), ('Ventilatoare', '2', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Samsung 870 EVO 1TB', 'SSD SATA III de 1 TB, cu viteze de citire de pana la 560 MB/s.', 430.99, 0, 24, '2025-11-23 01:19:59+02:00', 'nou', false, 0.06, '{}'::varchar[], ARRAY['sata', 'upgrade']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Stocare'), (SELECT id FROM store_brand WHERE nume = 'Samsung'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Capacitate', '1 TB', true), ('Interfata', 'SATA III', true), ('Viteza citire', '560 MB/s', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Kingston Fury Beast 32GB DDR4 3600MHz', 'Kit de memorie DDR4 de 32 GB, la 3600 MHz.', 213.99, 51, 24, '2026-07-07 02:13:59+02:00', 'nou', true, 0.11, ARRAY['negru']::varchar[], ARRAY['ddr4', 'gaming']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Memorii RAM'), (SELECT id FROM store_brand WHERE nume = 'Kingston'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Capacitate', '32 GB (2 x 16 GB)', true), ('Frecventa', '3600 MHz', true), ('Latenta', 'CL16', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('AMD Ryzen 7 7700', 'Procesor AMD cu 8 nuclee, potrivit pentru streaming.', 1944.99, 21, 36, '2025-12-15 15:34:59+02:00', 'nou', true, 0.28, '{}'::varchar[], ARRAY['am5', 'gaming']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Procesoare'), (SELECT id FROM store_brand WHERE nume = 'AMD'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Nuclee', '8', true), ('Frecventa maxima', '4.8 GHz', true), ('Soclu', 'AM5', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Kingston KC3000 2TB', 'SSD PCIe 4.0 NVMe de 2 TB, cu viteze de citire de pana la 7000 MB/s.', 732.99, 16, 12, '2026-03-26 15:46:59+02:00', 'reconditionat', true, 0.02, '{}'::varchar[], ARRAY['nvme', 'gaming']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Stocare'), (SELECT id FROM store_brand WHERE nume = 'Kingston'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Capacitate', '2 TB', true), ('Interfata', 'PCIe 4.0 NVMe', true), ('Viteza citire', '7000 MB/s', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Kingston Fury Beast 64GB DDR5 6400MHz', 'Kit de memorie DDR5 de 64 GB, la 6400 MHz.', 534.99, 58, 24, '2026-07-07 18:19:59+02:00', 'nou', false, 0.09, ARRAY['negru', 'alb']::varchar[], ARRAY['ddr5', 'gaming']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Memorii RAM'), (SELECT id FROM store_brand WHERE nume = 'Kingston'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Capacitate', '64 GB (2 x 32 GB)', true), ('Frecventa', '6400 MHz', true), ('Latenta', 'CL32', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Kingston Fury Beast RGB 64GB DDR5 6000MHz', 'Kit de memorie DDR5 de 64 GB, la 6000 MHz.', 498.99, 21, 36, '2026-03-25 16:29:59+02:00', 'nou', false, 0.14, ARRAY['alb']::varchar[], ARRAY['ddr5', 'gaming', 'rgb']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Memorii RAM'), (SELECT id FROM store_brand WHERE nume = 'Kingston'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Capacitate', '64 GB (2 x 32 GB)', true), ('Frecventa', '6000 MHz', true), ('Latenta', 'CL30', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Logitech G Yeti GX', 'Microfon Logitech G Yeti GX, cu fir.', 615.99, 47, 24, '2026-02-19 13:05:59+02:00', 'resigilat', false, 0.41, ARRAY['negru']::varchar[], ARRAY['streaming']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Periferice'), (SELECT id FROM store_brand WHERE nume = 'Logitech'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Tip', 'Microfon', true), ('Conexiune', 'USB, cu fir', true)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Logitech G502 Hero', 'Mouse Logitech G502 Hero, cu fir.', 227.99, 60, 24, '2026-07-10 05:15:59+02:00', 'nou', false, 0.78, ARRAY['roz', 'alb', 'albastru']::varchar[], ARRAY['gaming']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Periferice'), (SELECT id FROM store_brand WHERE nume = 'Logitech'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Tip', 'Mouse', true), ('Conexiune', 'USB, cu fir', true)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Kingston NV3 500GB', 'SSD PCIe 4.0 NVMe de 500 GB, cu viteze de citire de pana la 6000 MB/s.', 141.99, 4, 6, '2026-09-15 05:44:59+02:00', 'reconditionat', false, 0.03, '{}'::varchar[], ARRAY['nvme', 'gaming', 'buget']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Stocare'), (SELECT id FROM store_brand WHERE nume = 'Kingston'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Capacitate', '500 GB', true), ('Interfata', 'PCIe 4.0 NVMe', true), ('Viteza citire', '6000 MB/s', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Kingston Fury Beast RGB 64GB DDR5 5600MHz', NULL, 566.99, 4, 24, '2026-09-01 18:22:59+02:00', 'nou', false, 0.09, ARRAY['negru', 'alb']::varchar[], ARRAY['ddr5', 'gaming', 'rgb']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Memorii RAM'), (SELECT id FROM store_brand WHERE nume = 'Kingston'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Capacitate', '64 GB (2 x 32 GB)', true), ('Frecventa', '5600 MHz', true), ('Latenta', 'CL40', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Intel Core i5-14400KF', NULL, 701.99, 14, 24, '2026-09-05 05:56:59+02:00', 'reconditionat', false, 0.16, '{}'::varchar[], ARRAY['lga1700', 'gaming', 'buget']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Procesoare'), (SELECT id FROM store_brand WHERE nume = 'Intel'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Nuclee', '10', true), ('Frecventa maxima', '5.0 GHz', true), ('Soclu', 'LGA1700', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('AMD Ryzen 7 9700X', 'Procesor AMD cu 8 nuclee, potrivit pentru birou.', 1811.99, 15, 24, '2026-07-18 15:36:59+02:00', 'nou', true, 0.2, '{}'::varchar[], ARRAY['am5', 'gaming']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Procesoare'), (SELECT id FROM store_brand WHERE nume = 'AMD'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Nuclee', '8', true), ('Frecventa maxima', '5.6 GHz', true), ('Soclu', 'AM5', false)) AS s (nume, valoare, evidentiata);

WITH produs_nou AS (
    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,
        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)
    VALUES ('Samsung 990 EVO Plus 2TB', 'SSD PCIe 4.0 NVMe de 2 TB, cu viteze de citire de pana la 7250 MB/s.', 659.99, 28, 12, '2026-06-13 01:48:59+02:00', 'reconditionat', false, 0.01, '{}'::varchar[], ARRAY['nvme', 'gaming']::varchar[], (SELECT id FROM store_categorie WHERE nume = 'Stocare'), (SELECT id FROM store_brand WHERE nume = 'Samsung'))
    ON CONFLICT (nume) DO NOTHING
    RETURNING id
)
INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)
SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata
FROM produs_nou, (VALUES ('Capacitate', '2 TB', true), ('Interfata', 'PCIe 4.0 NVMe', true), ('Viteza citire', '7250 MB/s', false)) AS s (nume, valoare, evidentiata);

COMMIT;
