from django.contrib import admin

from .models import Brand, Categorie, Produs, Promotie, ServiciuAditional, SpecificatieTehnica


class SpecificatieTehnicaInline(admin.TabularInline):
    model = SpecificatieTehnica
    extra = 1


@admin.register(Produs)
class ProdusAdmin(admin.ModelAdmin):
    readonly_fields = ["data_adaugare"]
    inlines = [SpecificatieTehnicaInline]


@admin.register(SpecificatieTehnica)
class SpecificatieTehnicaAdmin(admin.ModelAdmin):
    list_select_related = ["produs"]


@admin.register(Promotie)
class PromotieAdmin(admin.ModelAdmin):
    filter_horizontal = ["produse"]


@admin.register(ServiciuAditional)
class ServiciuAditionalAdmin(admin.ModelAdmin):
    filter_horizontal = ["categorii"]


admin.site.register([Categorie, Brand])
