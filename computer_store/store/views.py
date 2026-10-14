from collections import Counter
from datetime import datetime
from urllib.parse import urlencode, urlparse

from django.shortcuts import render
from django.urls import reverse


ZILE = ["Luni", "Marti", "Miercuri", "Joi", "Vineri", "Sambata", "Duminica"]
LUNI = [
    "Ianuarie", "Februarie", "Martie", "Aprilie", "Mai", "Iunie",
    "Iulie", "August", "Septembrie", "Octombrie", "Noiembrie", "Decembrie",
]

# %-d is the day of the month without a leading zero (2, not 02)
FORMAT_ZI = "%A, %-d %B %Y"
FORMAT_TIMP = "%H:%M:%S"
FORMAT_DATA_ORA = FORMAT_ZI + ", " + FORMAT_TIMP


def formateaza_data_ro(data, format=FORMAT_DATA_ORA):
    # Romanian names are put in before strftime, so the result does not depend on the
    # system locale. %-d is replaced here too because strftime rejects it on Windows.
    format = (
        format.replace("%A", ZILE[data.weekday()])
        .replace("%B", LUNI[data.month - 1])
        .replace("%-d", str(data.day))
    )
    return data.strftime(format)


class Accesare:
    ultimul_id = 0

    def __init__(self, ip_client, url, parametri=None):
        Accesare.ultimul_id += 1
        self.id = Accesare.ultimul_id
        self.ip_client = ip_client
        self.url = url
        # None as default instead of {}, otherwise every instance would share one dict
        self.parametri = parametri if parametri is not None else {}
        self.data = datetime.now()

    def lista_parametri(self):
        # parametri maps each name to a list of values, since a name can repeat (?iduri=1&iduri=2)
        return [
            (nume, valoare or None)
            for nume, valori in self.parametri.items()
            for valoare in valori
        ]

    def string_url(self):
        if self.parametri:
            return self.url + "?" + urlencode(self.parametri, doseq=True, safe=",")
        return self.url

    def pagina(self):
        # path relative to the app root, e.g. /store/info -> /info
        cale = urlparse(self.url).path
        return "/" + cale.removeprefix(reverse("index"))

    def calculeaza_data(self, tip="", format=FORMAT_DATA_ORA):
        if tip == "zi":
            format = FORMAT_ZI
        elif tip == "timp":
            format = FORMAT_TIMP
        return (
            "<section>"
            "<h2>Data si ora</h2>"
            f"<p>{formateaza_data_ro(self.data, format)}</p>"
            "</section>"
        )

    def __str__(self):
        # calculeaza_data returns HTML, so the console uses the plain text date
        return "\n".join([
            f"id: {self.id}",
            f"ip_client: {self.ip_client}",
            f"string_url: {self.string_url()}",
            f"pagina: {self.pagina()}",
            f"data: {formateaza_data_ro(self.data)}",
            f"lista_parametri: {self.lista_parametri()}",
        ])


# every page access since the server started
accesari = []

PROPRIETATI_ACCESARE = ["id", "ip_client", "url", "parametri", "data"]


def inregistreaza_accesare(request):
    accesare = Accesare(
        ip_client=request.ip_client,
        url=request.build_absolute_uri(request.path),
        parametri=dict(request.GET.lists()),
    )
    accesari.append(accesare)
    print(accesare)
    return accesare


def valoare_tabel(accesare, proprietate):
    if proprietate == "data":
        return formateaza_data_ro(accesare.data)
    if proprietate == "parametri":
        return "; ".join(f"{nume}={valoare}" for nume, valoare in accesare.lista_parametri())
    return getattr(accesare, proprietate)


def citeste_iduri(request, erori):
    # iduri can appear several times, each with a comma separated list: ?iduri=2,3&iduri=5
    dubluri = request.GET.get("dubluri", "false").lower() == "true"
    iduri = []
    for valoare in request.GET.getlist("iduri"):
        for bucata in valoare.split(","):
            bucata = bucata.strip()
            if not bucata:
                continue
            try:
                id_accesare = int(bucata)
            except ValueError:
                erori.append(f'Parametrul iduri contine valoarea "{bucata}", care nu este un numar intreg.')
                continue
            if dubluri or id_accesare not in iduri:
                iduri.append(id_accesare)
    return iduri


def citeste_coloane(request, erori):
    valoare = request.GET["tabel"]
    if valoare == "tot":
        return PROPRIETATI_ACCESARE
    cerute = list(dict.fromkeys(nume.strip() for nume in valoare.split(",") if nume.strip()))
    coloane = [nume for nume in cerute if nume in PROPRIETATI_ACCESARE]
    if not cerute or len(coloane) < len(cerute):
        erori.append("Parametrul tabel primeste valoarea tot sau o lista de proprietati dintre: "
                     + ", ".join(PROPRIETATI_ACCESARE) + ".")
    return coloane


def exemplu_template(request):
    return render(request, "exemplu_template.html",
        {
            "titlu_tab": "Titlu fereastra",
            "titlu_articol": "Titlu afisat",
            "continut_articol": "Continut text"
        }
    )


def exemplu_template2(request):
    return render(request, "template2.html")


def index(request):
    inregistreaza_accesare(request)
    return render(request, "index.html")


def info(request):
    accesare = inregistreaza_accesare(request)
    return render(request, "info.html", {
        "sectiune_data": accesare.calculeaza_data(request.GET.get("data", "")),
    })


def log(request):
    inregistreaza_accesare(request)
    erori = []
    selectie = accesari

    if "iduri" in request.GET:
        dupa_id = {accesare.id: accesare for accesare in accesari}
        iduri = citeste_iduri(request, erori)
        lipsa = [str(id_accesare) for id_accesare in iduri if id_accesare not in dupa_id]
        if lipsa:
            erori.append("Nu exista accesari cu id-urile: " + ", ".join(lipsa) + ".")
        selectie = [dupa_id[id_accesare] for id_accesare in iduri if id_accesare in dupa_id]

    if "ultimele" in request.GET:
        try:
            n = int(request.GET["ultimele"])
        except ValueError:
            n = -1
        if n < 0:
            erori.append("Parametrul ultimele trebuie sa fie un numar intreg, mai mare sau egal cu 0.")
        else:
            if n > len(selectie):
                erori.append(f"Exista doar {len(selectie)} accesari fata de {n} accesari cerute")
            selectie = selectie[max(len(selectie) - n, 0):]

    optiuni = request.GET.getlist("accesari")
    for optiune in optiuni:
        if optiune not in ("nr", "detalii"):
            erori.append(f'Parametrul accesari primeste valoarea nr sau detalii, nu "{optiune}".')

    coloane = citeste_coloane(request, erori) if "tabel" in request.GET else []

    contor = Counter(accesare.pagina() for accesare in accesari)
    maxim, minim = max(contor.values()), min(contor.values())

    return render(request, "log.html", {
        "selectie": selectie,
        "coloane": coloane,
        "randuri": [[valoare_tabel(accesare, nume) for nume in coloane] for accesare in selectie],
        "erori": erori,
        "pagini_maxim": [pagina for pagina, numar in contor.items() if numar == maxim],
        "maxim": maxim,
        "pagini_minim": [pagina for pagina, numar in contor.items() if numar == minim],
        "minim": minim,
        "afiseaza_nr": "nr" in optiuni,
        "numar_accesari": len(accesari),
        "afiseaza_detalii": "detalii" in optiuni,
        "detalii": [(accesare.id, formateaza_data_ro(accesare.data)) for accesare in selectie],
        "parametri": list(request.GET),
    })


def accesare(request, id_accesare):
    inregistreaza_accesare(request)
    id_accesare = int(id_accesare)
    gasita = next((a for a in accesari if a.id == id_accesare), None)
    context = {"id_accesare": id_accesare, "accesare": gasita}
    if gasita:
        context["data"] = formateaza_data_ro(gasita.data)
    return render(request, "accesare.html", context, status=200 if gasita else 404)


def despre(request):
    inregistreaza_accesare(request)
    return render(request, "despre.html")


def istoric(request):
    inregistreaza_accesare(request)
    return render(request, "istoric.html")


def pagina_in_lucru(request, nume_pagina):
    inregistreaza_accesare(request)
    return render(request, "in_lucru.html", {"nume_pagina": nume_pagina})


def produse(request):
    return pagina_in_lucru(request, "Produse")


def configurator(request):
    return pagina_in_lucru(request, "Configurator PC")


def service(request):
    return pagina_in_lucru(request, "Service")


def contact(request):
    return pagina_in_lucru(request, "Contact")


def cos_virtual(request):
    return pagina_in_lucru(request, "Cos virtual")
