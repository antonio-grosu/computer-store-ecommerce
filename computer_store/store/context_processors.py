from datetime import date

from django.conf import settings


def date_firma(request):
    firma = settings.DATE_FIRMA
    return {
        "firma": firma,
        "copyright": f"© {firma['an_infiintare']} - {date.today().year} {firma['nume']}. "
                     "Toate drepturile rezervate.",
    }
