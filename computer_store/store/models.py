from django.contrib.postgres.fields import ArrayField
from django.core.validators import FileExtensionValidator, MaxValueValidator, RegexValidator
from django.db import models
from django.db.models import F, Q


class Categorie(models.Model):
    nume = models.CharField(
        max_length=50,
        unique=True,
        error_messages={"unique": "Exista deja o categorie cu acest nume."},
    )
    descriere = models.TextField()
    culoare = models.CharField(
        max_length=7,
        default="#2a9d8f",
        validators=[RegexValidator(r"^#[0-9a-fA-F]{6}$")],
        error_messages={"invalid": "Culoarea trebuie sa fie un cod hex, de exemplu #2a9d8f."},
        help_text="Cod hex, de exemplu #2a9d8f. Se foloseste la stilizarea categoriei pe site.",
    )
    sigla = models.FileField(
        upload_to="categorii/",
        validators=[FileExtensionValidator(["svg", "png", "jpg", "jpeg", "webp"])],
        error_messages={"invalid_extension": "Sigla trebuie sa fie un fisier SVG, PNG, JPG sau WEBP."},
        help_text="Imaginea afisata langa numele categoriei.",
    )
    ordine_afisare = models.PositiveSmallIntegerField(
        default=0,
        help_text="Categoriile cu numar mai mic apar primele in meniuri si liste.",
    )

    class Meta:
        verbose_name = "categorie"
        verbose_name_plural = "categorii"
        ordering = ["ordine_afisare", "nume"]

    def __str__(self):
        return self.nume


class Brand(models.Model):
    nume = models.CharField(
        max_length=50,
        unique=True,
        error_messages={"unique": "Exista deja un brand cu acest nume."},
    )
    tara_origine = models.CharField(max_length=50, null=True, blank=True)
    an_infiintare = models.PositiveSmallIntegerField(null=True, blank=True)
    site_web = models.URLField(null=True, blank=True)

    class Meta:
        verbose_name = "brand"
        verbose_name_plural = "branduri"
        ordering = ["nume"]

    def __str__(self):
        return self.nume


class Produs(models.Model):
    class Stare(models.TextChoices):
        NOU = "nou", "Nou"
        RESIGILAT = "resigilat", "Resigilat"
        RECONDITIONAT = "reconditionat", "Reconditionat"

    nume = models.CharField(
        max_length=100,
        unique=True,
        error_messages={"unique": "Exista deja un produs cu acest nume."},
    )
    descriere = models.TextField(null=True, blank=True)
    pret = models.DecimalField(max_digits=10, decimal_places=2)
    stoc = models.PositiveIntegerField(default=0)
    garantie_luni = models.PositiveSmallIntegerField(
        default=24,
        validators=[MaxValueValidator(60)],
        error_messages={"max_value": "Garantia poate fi de cel mult 60 de luni."},
        help_text="Minim 24 de luni pentru produsele noi, maxim 60.",
    )
    data_adaugare = models.DateTimeField(auto_now_add=True)
    stare = models.CharField(max_length=15, choices=Stare.choices, default=Stare.NOU)
    transport_gratuit = models.BooleanField(default=False)
    greutate_kg = models.FloatField(
        null=True,
        blank=True,
        help_text="Greutatea cu tot cu ambalaj, folosita la calculul costului de transport.",
    )
    culori_disponibile = ArrayField(
        models.CharField(max_length=30),
        default=list,
        blank=True,
        help_text="Culorile separate prin virgula, de exemplu: negru,alb. Se poate lasa gol.",
    )
    categorie = models.ForeignKey(Categorie, on_delete=models.PROTECT, related_name="produse")
    brand = models.ForeignKey(Brand, on_delete=models.PROTECT, related_name="produse")

    class Meta:
        verbose_name = "produs"
        verbose_name_plural = "produse"
        ordering = ["nume"]
        indexes = [
            models.Index(fields=["pret"]),
            models.Index(fields=["data_adaugare"]),
            models.Index(fields=["stare"]),
        ]
        constraints = [
            models.CheckConstraint(
                condition=Q(pret__gt=0),
                name="produs_pret_pozitiv",
                violation_error_message="Pretul trebuie sa fie mai mare decat 0.",
            ),
            models.CheckConstraint(
                condition=~Q(stare="nou") | Q(garantie_luni__gte=24),
                name="produs_nou_garantie_minima",
                violation_error_message="Produsele noi au garantie de minim 24 de luni.",
            ),
            models.CheckConstraint(
                condition=Q(greutate_kg__isnull=True) | Q(greutate_kg__gt=0),
                name="produs_greutate_pozitiva",
                violation_error_message="Greutatea trebuie sa fie mai mare decat 0.",
            ),
        ]

    def __str__(self):
        return f"{self.nume} ({self.pret} lei)"


class SpecificatieTehnica(models.Model):
    produs = models.ForeignKey(Produs, on_delete=models.CASCADE, related_name="specificatii")
    nume_specificatie = models.CharField(max_length=50)
    valoare = models.CharField(max_length=100)
    evidentiata = models.BooleanField(
        default=False,
        help_text="Specificatiile evidentiate apar pe cardul produsului din lista de produse.",
    )

    class Meta:
        verbose_name = "specificatie tehnica"
        verbose_name_plural = "specificatii tehnice"
        ordering = ["produs", "nume_specificatie"]
        constraints = [
            models.UniqueConstraint(
                fields=["produs", "nume_specificatie"],
                name="specificatie_unica_per_produs",
                violation_error_message="Produsul are deja o specificatie cu acest nume.",
            ),
        ]

    def __str__(self):
        return f"{self.produs.nume} - {self.nume_specificatie}: {self.valoare}"


class Promotie(models.Model):
    nume = models.CharField(max_length=100)
    descriere = models.TextField(null=True, blank=True)
    procent_reducere = models.PositiveSmallIntegerField(
        help_text="Reducerea aplicata produselor incluse, intre 1 si 90.",
    )
    data_inceput = models.DateField()
    data_sfarsit = models.DateField(help_text="Ultima zi in care promotia este activa.")
    produse = models.ManyToManyField(Produs, related_name="promotii")

    class Meta:
        verbose_name = "promotie"
        verbose_name_plural = "promotii"
        ordering = ["-data_inceput"]
        indexes = [models.Index(fields=["data_inceput", "data_sfarsit"])]
        constraints = [
            models.CheckConstraint(
                condition=Q(procent_reducere__gte=1, procent_reducere__lte=90),
                name="promotie_procent_valid",
                violation_error_message="Reducerea trebuie sa fie intre 1%% si 90%%.",
            ),
            models.CheckConstraint(
                condition=Q(data_sfarsit__gte=F("data_inceput")),
                name="promotie_perioada_valida",
                violation_error_message="Data de sfarsit nu poate fi inainte de data de inceput.",
            ),
        ]

    def __str__(self):
        return f"{self.nume} (-{self.procent_reducere}%)"


class ServiciuAditional(models.Model):
    nume = models.CharField(
        max_length=100,
        unique=True,
        error_messages={"unique": "Exista deja un serviciu cu acest nume."},
    )
    descriere = models.TextField(null=True, blank=True)
    pret = models.DecimalField(
        max_digits=8,
        decimal_places=2,
        help_text="0 pentru serviciile gratuite.",
    )
    durata_zile = models.PositiveSmallIntegerField(
        default=1,
        help_text="In cate zile lucratoare este efectuat serviciul.",
    )
    la_domiciliu = models.BooleanField(default=False)
    categorii = models.ManyToManyField(Categorie, related_name="servicii")

    class Meta:
        verbose_name = "serviciu aditional"
        verbose_name_plural = "servicii aditionale"
        ordering = ["nume"]
        constraints = [
            models.CheckConstraint(
                condition=Q(pret__gte=0),
                name="serviciu_pret_nenegativ",
                violation_error_message="Pretul nu poate fi negativ.",
            ),
        ]

    def __str__(self):
        return f"{self.nume} ({self.pret} lei)"
