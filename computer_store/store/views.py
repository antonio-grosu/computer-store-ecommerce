

# Create your views here.
from django.shortcuts import render
# Create your views here.
def exemplu_template(request):
     return render(request,"exemplu_template.html",
                   
        {
            "titlu_tab":"Titlu fereastra",
            "titlu_articol":"Titlu afisat",
            "continut_articol":"Continut text"
        }
    )

def exemplu_template2(request):
     return render(request,"template2.html")

def info(request):
     return render(request, "info.html")
    
def index(request):
     return render(request,"exemplu_template.html",
                   
        {
            "titlu_tab":"Titlu fereastra",
            "titlu_articol":"Titlu afisat",
            "continut_articol":"Continut text"
        }
    )