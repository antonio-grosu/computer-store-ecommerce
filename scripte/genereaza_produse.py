import argparse
import random
from datetime import datetime, timedelta

AMD = {5: ["7600", "9600"], 7: ["7700", "9700"], 9: ["7900", "7950", "9900", "9950"]}
INTEL = {
    3: ["12100", "13100", "14100"],
    5: ["12400", "13400", "13600", "14400", "14600"],
    7: ["12700", "13700", "14700"],
    9: ["12900", "13900", "14900"],
}

PLACI_VIDEO = [
    ("GeForce RTX 4060", 8, "GDDR6", 1400),
    ("GeForce RTX 4060 Ti", 8, "GDDR6", 1900),
    ("GeForce RTX 4070", 12, "GDDR6X", 2900),
    ("GeForce RTX 4070 Super", 12, "GDDR6X", 3300),
    ("GeForce RTX 4080 Super", 16, "GDDR6X", 5600),
    ("GeForce RTX 4090", 24, "GDDR6X", 9800),
    ("Radeon RX 7600", 8, "GDDR6", 1300),
    ("Radeon RX 7700 XT", 12, "GDDR6", 2100),
    ("Radeon RX 7800 XT", 16, "GDDR6", 2600),
    ("Radeon RX 7900 XTX", 24, "GDDR6", 4900),
]
GAME_ASUS = {"Dual": 1.0, "Prime": 1.0, "TUF Gaming": 1.08, "ROG Strix": 1.2}

SSD = [
    ("Samsung 990 Pro", "Samsung", "PCIe 4.0 NVMe", 7450, 450),
    ("Samsung 990 EVO Plus", "Samsung", "PCIe 4.0 NVMe", 7250, 380),
    ("Samsung 870 EVO", "Samsung", "SATA III", 560, 380),
    ("Samsung 870 QVO", "Samsung", "SATA III", 560, 300),
    ("Kingston KC3000", "Kingston", "PCIe 4.0 NVMe", 7000, 400),
    ("Kingston NV3", "Kingston", "PCIe 4.0 NVMe", 6000, 270),
    ("Kingston A400", "Kingston", "SATA III", 500, 230),
]
CAPACITATI = {"500GB": 0.5, "1TB": 1, "2TB": 2, "4TB": 4}

PERIFERICE = [
    ("G305 Lightspeed", "Mouse", 180, True, ["gaming"]),
    ("G502 Hero", "Mouse", 230, False, ["gaming"]),
    ("G Pro X Superlight 2", "Mouse", 690, True, ["gaming", "esports"]),
    ("MX Master 3S", "Mouse", 480, True, ["office"]),
    ("Pebble 2 M350s", "Mouse", 110, True, ["office", "buget"]),
    ("G213 Prodigy", "Tastatura", 220, False, ["gaming", "rgb", "buget"]),
    ("G915 TKL", "Tastatura", 990, True, ["gaming", "rgb"]),
    ("MX Keys S", "Tastatura", 520, True, ["office"]),
    ("G435", "Casti", 300, True, ["gaming"]),
    ("G733", "Casti", 520, True, ["gaming", "rgb"]),
    ("Brio 500", "Camera web", 560, False, ["office", "streaming"]),
    ("G Yeti GX", "Microfon", 690, False, ["streaming"]),
]


def procesor():
    if random.random() < 0.5:
        clasa = random.choice(list(AMD))
        nume = f"AMD Ryzen {clasa} {random.choice(AMD[clasa])}{random.choice(['', 'X'])}"
        brand, soclu = "AMD", "AM5"
        nuclee = {5: 6, 7: 8, 9: random.choice([12, 16])}[clasa]
    else:
        clasa = random.choice(list(INTEL))
        nume = f"Intel Core i{clasa}-{random.choice(INTEL[clasa])}{random.choice(['', 'F', 'K', 'KF'])}"
        brand, soclu = "Intel", "LGA1700"
        nuclee = {3: 4, 5: 10, 7: 20, 9: 24}[clasa]
    taguri = [soclu.lower(), "gaming" if clasa >= 5 else "office"]
    if clasa == 9:
        taguri.append("high-end")
    elif clasa <= 5:
        taguri.append("buget")
    if nuclee >= 12:
        taguri.append("editare-video")
    utilizare = random.choice(["jocuri", "birou", "editare video", "streaming"])
    return dict(
        nume=nume, categorie="Procesoare", brand=brand,
        baza_pret={3: 500, 5: 950, 7: 1700, 9: 2700}[clasa],
        greutate=round(random.uniform(0.1, 0.3), 2), taguri=taguri, culori=[],
        descriere=f"Procesor {brand} cu {nuclee} nuclee, potrivit pentru {utilizare}.",
        specificatii=[
            ("Nuclee", str(nuclee), True),
            ("Frecventa maxima", f"{random.uniform(4.2, 5.8):.1f} GHz", True),
            ("Soclu", soclu, False),
        ],
    )


def placa_video():
    chip, memorie, tip_memorie, baza = random.choice(PLACI_VIDEO)
    gama = random.choice(list(GAME_ASUS))
    rezolutie = "4k" if baza > 4500 else "1440p" if baza > 2000 else "1080p"
    taguri = ["gaming", rezolutie]
    if chip.startswith("GeForce"):
        taguri.append("ray-tracing")
    if baza < 2000:
        taguri.append("buget")
    return dict(
        nume=f"ASUS {gama} {chip}", categorie="Placi video", brand="ASUS",
        baza_pret=baza * GAME_ASUS[gama],
        greutate=round(random.uniform(0.7, 2.4), 2), taguri=taguri,
        culori=random.choice([["negru"], ["alb"], ["negru", "alb"]]),
        descriere=f"Placa video pentru jocuri in {rezolutie}, cu {memorie} GB memorie {tip_memorie}.",
        specificatii=[
            ("Memorie video", f"{memorie} GB {tip_memorie}", True),
            ("Interfata", "PCIe 4.0 x16", False),
            ("Ventilatoare", str(random.choice([2, 3])), False),
        ],
    )


def memorie_ram():
    tip = random.choice(["DDR4", "DDR5"])
    frecventa = random.choice([3200, 3600] if tip == "DDR4" else [5200, 5600, 6000, 6400])
    capacitate = random.choice([16, 32, 64])
    if random.random() < 0.7:
        serie = random.choice(["Fury Beast", "Fury Beast RGB", "Fury Renegade"])
        brand, nume = "Kingston", f"Kingston {serie} {capacitate}GB {tip} {frecventa}MHz"
    else:
        serie = ""
        brand, nume = "Samsung", f"Samsung {capacitate}GB {tip} {frecventa}MHz"
    taguri = [tip.lower(), "gaming" if frecventa >= 3600 else "upgrade"]
    if "RGB" in serie:
        taguri.append("rgb")
    latente = [16, 18] if tip == "DDR4" else [30, 32, 36, 40]
    return dict(
        nume=nume, categorie="Memorii RAM", brand=brand,
        baza_pret=capacitate * (4 if tip == "DDR4" else 6) + frecventa / 40,
        greutate=round(random.uniform(0.05, 0.15), 2), taguri=taguri,
        culori=random.choice([["negru"], ["alb"], ["negru", "alb"]]),
        descriere=f"Kit de memorie {tip} de {capacitate} GB, la {frecventa} MHz.",
        specificatii=[
            ("Capacitate", f"{capacitate} GB (2 x {capacitate // 2} GB)", True),
            ("Frecventa", f"{frecventa} MHz", True),
            ("Latenta", f"CL{random.choice(latente)}", False),
        ],
    )


def stocare():
    model, brand, interfata, viteza, pret_tb = random.choice(SSD)
    capacitate, tb = random.choice(list(CAPACITATI.items()))
    baza = pret_tb * tb + 60
    nvme = "NVMe" in interfata
    taguri = ["nvme" if nvme else "sata"]
    if viteza >= 6000:
        taguri.append("gaming")
    if not nvme:
        taguri.append("upgrade")
    if baza < 400:
        taguri.append("buget")
    capacitate_text = capacitate.replace("GB", " GB").replace("TB", " TB")
    return dict(
        nume=f"{model} {capacitate}", categorie="Stocare", brand=brand, baza_pret=baza,
        greutate=round(random.uniform(0.01, 0.03) if nvme else random.uniform(0.05, 0.07), 2),
        taguri=taguri, culori=[],
        descriere=f"SSD {interfata} de {capacitate_text}, cu viteze de citire de pana la {viteza} MB/s.",
        specificatii=[
            ("Capacitate", capacitate_text, True),
            ("Interfata", interfata, True),
            ("Viteza citire", f"{viteza} MB/s", False),
        ],
    )


def periferic():
    model, tip, baza, wireless, taguri = random.choice(PERIFERICE)
    return dict(
        nume=f"Logitech {model}", categorie="Periferice", brand="Logitech", baza_pret=baza,
        greutate=round(random.uniform(0.08, 0.9), 2),
        taguri=taguri + (["wireless"] if wireless else []),
        culori=random.sample(["negru", "alb", "roz", "albastru"], random.randint(1, 3)),
        descriere=f"{tip} Logitech {model}, {'fara fir' if wireless else 'cu fir'}.",
        specificatii=[
            ("Tip", tip, True),
            ("Conexiune", "Wireless" if wireless else "USB, cu fir", True),
        ],
    )


GENERATOARE = [procesor, placa_video, memorie_ram, stocare, periferic]


def produs_aleator(acum):
    produs = random.choice(GENERATOARE)()
    stare = random.choices(["nou", "resigilat", "reconditionat"], weights=[70, 15, 15])[0]
    pret = int(produs["baza_pret"] * (1 if stare == "nou" else 0.8) * random.uniform(0.9, 1.15))
    produs.update(
        stare=stare,
        garantie_luni=random.choice([24, 36, 60]) if stare == "nou" else random.choice([6, 12, 24]),
        pret=f"{pret}.99",
        stoc=random.randint(0, 4) if random.random() < 0.25 else random.randint(5, 60),
        transport_gratuit=pret >= 1000 or random.random() < 0.2,
        data_adaugare=acum - timedelta(days=random.randint(0, 365), minutes=random.randint(0, 1439)),
    )
    if random.random() < 0.15:
        produs["descriere"] = None
    return produs


def text_sql(valoare):
    if valoare is None:
        return "NULL"
    return "'" + str(valoare).replace("'", "''") + "'"


def vector_sql(valori):
    if not valori:
        return "'{}'::varchar[]"
    return "ARRAY[" + ", ".join(text_sql(v) for v in valori) + "]::varchar[]"


def bool_sql(valoare):
    return "true" if valoare else "false"


def comanda_insert(produs):
    valori = ", ".join([
        text_sql(produs["nume"]),
        text_sql(produs["descriere"]),
        produs["pret"],
        str(produs["stoc"]),
        str(produs["garantie_luni"]),
        text_sql(produs["data_adaugare"].isoformat(sep=" ", timespec="seconds")),
        text_sql(produs["stare"]),
        bool_sql(produs["transport_gratuit"]),
        str(produs["greutate"]),
        vector_sql(produs["culori"]),
        vector_sql(produs["taguri"]),
        f"(SELECT id FROM store_categorie WHERE nume = {text_sql(produs['categorie'])})",
        f"(SELECT id FROM store_brand WHERE nume = {text_sql(produs['brand'])})",
    ])
    specificatii = ", ".join(
        f"({text_sql(nume)}, {text_sql(valoare)}, {bool_sql(evidentiata)})"
        for nume, valoare, evidentiata in produs["specificatii"]
    )
    return (
        "WITH produs_nou AS (\n"
        "    INSERT INTO store_produs (nume, descriere, pret, stoc, garantie_luni, data_adaugare, stare,\n"
        "        transport_gratuit, greutate_kg, culori_disponibile, taguri, categorie_id, brand_id)\n"
        f"    VALUES ({valori})\n"
        "    ON CONFLICT (nume) DO NOTHING\n"
        "    RETURNING id\n"
        ")\n"
        "INSERT INTO store_specificatietehnica (produs_id, nume_specificatie, valoare, evidentiata)\n"
        "SELECT produs_nou.id, s.nume, s.valoare, s.evidentiata\n"
        f"FROM produs_nou, (VALUES {specificatii}) AS s (nume, valoare, evidentiata);\n"
    )


def main():
    parser = argparse.ArgumentParser(
        description="Genereaza comenzi INSERT cu produse aleatoare, dar valide, pentru tabelul store_produs.",
    )
    parser.add_argument("numar", type=int, nargs="?", default=40, help="cate produse se genereaza (implicit 40)")
    parser.add_argument("--seed", type=int, help="seed pentru generatorul aleator, ca rezultatul sa poata fi reprodus")
    args = parser.parse_args()

    random.seed(args.seed)
    acum = datetime.now().astimezone()
    produse = {}
    for _ in range(args.numar * 100):
        if len(produse) == args.numar:
            break
        produs = produs_aleator(acum)
        produse.setdefault(produs["nume"], produs)

    print("BEGIN;\n")
    for produs in produse.values():
        print(comanda_insert(produs))
    print("COMMIT;")


if __name__ == "__main__":
    main()
