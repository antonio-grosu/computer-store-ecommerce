from datetime import date

from django.conf import settings
from django.db.models import Count

from .models import Categorie


def date_firma(request):
    firma = settings.DATE_FIRMA
    return {
        "firma": firma,
        "copyright": f"© {firma['an_infiintare']} - {date.today().year} {firma['nume']}. "
                     "Toate drepturile rezervate.",
    }


def categorii_meniu(request):
    return {
        "categorii_meniu": Categorie.objects.annotate(numar_produse=Count("produse"))
        .filter(numar_produse__gt=0)
        .order_by("ordine_afisare", "nume"),
    }
