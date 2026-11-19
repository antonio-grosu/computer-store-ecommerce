import csv

from django.contrib import admin
from django.http import HttpResponse
from django.urls import reverse_lazy
from django.utils.html import format_html

from .models import Brand, Categorie, Produs, Promotie, ServiciuAditional, SpecificatieTehnica
from django.contrib.auth.models import User, Permission, Group


admin.site.site_title = "Computer Store admin"
admin.site.site_header = "Administrare Computer Store"
admin.site.index_title = "Panou de administrare al magazinului"
admin.site.site_url = reverse_lazy("index")



try:
    user = User.objects.get(username='antonio')
except User.DoesNotExist:
    raise Exception(f'Nu exista userul "{'antonio'}".')

permisiune = Permission.objects.get(content_type__app_label="store", codename="promoveaza_brand")

grup, _ = Group.objects.get_or_create(name="GRUP test")
grup.permissions.add(permisiune)

user.groups.add(grup)
user.user_permissions.add(permisiune)

class SpecificatieTehnicaInline(admin.TabularInline):
    model = SpecificatieTehnica
    extra = 1


@admin.register(Produs)
class ProdusAdmin(admin.ModelAdmin):
    list_display = ["nume", "categorie_colorata", "brand", "tara_brand", "pret", "stoc", "stare"]
    list_select_related = ["categorie", "brand"]
    list_filter = ["categorie", "brand", "stare", "transport_gratuit"]
    search_fields = ["nume", "descriere"]
    search_help_text = "Cauta in numele si descrierea produselor, de exemplu: ryzen sau ddr5."
    ordering = ["-pret"]
    list_per_page = 5
    readonly_fields = ["data_adaugare"]
    fieldsets = [
        ("Date generale", {
            "fields": ["nume", "categorie", "brand", "pret", "stoc", "stare", "garantie_luni", "data_adaugare"],
        }),
        ("Detalii suplimentare", {
            "classes": ["collapse"],
            "fields": ["descriere", "imagine", "taguri", "culori_disponibile", "greutate_kg", "transport_gratuit"],
        }),
    ]
    inlines = [SpecificatieTehnicaInline]
    actions = ["exporta_csv", "seteaza_transport_gratuit"]

    @admin.display(description="Categorie", ordering="categorie__nume")
    def categorie_colorata(self, obj):
        return format_html(
            '<strong style="color: {}">{}</strong>',
            obj.categorie.culoare,
            obj.categorie.nume,
        )

    @admin.display(description="Tara brandului", ordering="brand__tara_origine")
    def tara_brand(self, obj):
        return obj.brand.tara_origine

    @admin.action(description="Exporta produsele selectate in CSV")
    def exporta_csv(self, request, queryset):
        raspuns = HttpResponse(content_type="text/csv; charset=utf-8")
        raspuns["Content-Disposition"] = 'attachment; filename="produse.csv"'
        scriitor = csv.writer(raspuns)
        scriitor.writerow(["id", "nume", "categorie", "brand", "pret", "stoc", "stare", "taguri"])
        for produs in queryset.select_related("categorie", "brand"):
            scriitor.writerow([
                produs.id,
                produs.nume,
                produs.categorie.nume,
                produs.brand.nume,
                produs.pret,
                produs.stoc,
                produs.get_stare_display(),
                ",".join(produs.taguri),
            ])
        return raspuns

    @admin.action(description="Seteaza transport gratuit pentru produsele selectate")
    def seteaza_transport_gratuit(self, request, queryset):
        actualizate = queryset.update(transport_gratuit=True)
        self.message_user(request, f"Transport gratuit setat pentru {actualizate} produs(e).")


@admin.register(SpecificatieTehnica)
class SpecificatieTehnicaAdmin(admin.ModelAdmin):
    list_select_related = ["produs"]
    search_fields = ["nume_specificatie", "valoare"]
    search_help_text = "Cauta dupa numele sau valoarea specificatiei, de exemplu: soclu sau AM5."


@admin.register(Categorie)
class CategorieAdmin(admin.ModelAdmin):
    search_fields = ["nume", "descriere"]
    search_help_text = "Cauta in numele si descrierea categoriilor."


@admin.register(Brand)
class BrandAdmin(admin.ModelAdmin):
    fields = ["nume", "site_web", "tara_origine", "an_infiintare"]
    search_fields = ["nume", "tara_origine"]
    search_help_text = "Cauta dupa numele brandului sau tara de origine, de exemplu: SUA."


@admin.register(Promotie)
class PromotieAdmin(admin.ModelAdmin):
    filter_horizontal = ["produse"]
    search_fields = ["nume", "descriere"]
    search_help_text = "Cauta in numele si descrierea promotiilor."


@admin.register(ServiciuAditional)
class ServiciuAditionalAdmin(admin.ModelAdmin):
    filter_horizontal = ["categorii"]
    search_fields = ["nume", "descriere"]
    search_help_text = "Cauta in numele si descrierea serviciilor."
