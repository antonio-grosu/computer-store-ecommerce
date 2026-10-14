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
        return [(nume, valoare or None) for nume, valoare in self.parametri.items()]

    def string_url(self):
        if self.parametri:
            return self.url + "?" + urlencode(self.parametri)
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


def inregistreaza_accesare(request):
    accesare = Accesare(
        ip_client=request.ip_client,
        url=request.build_absolute_uri(request.path),
        parametri=request.GET.dict(),
    )
    print(accesare)
    return accesare


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
