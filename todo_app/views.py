from django.http import HttpResponseRedirect
from django.shortcuts import render
from django.urls import reverse
from todo_app.forms import TodoForm
from todo_app.models import Todo
from django.views.generic import ListView, DeleteView, CreateView, UpdateView

# Create your views here.
class TodoListView(ListView):
    model = Todo
    template_name = "bootstrap/todo_list.html"
    context_object_name = "todos"

    
    def get_queryset(self):
        todos = Todo.objects.all()
        return todos
    

    
class TodoDeleteView(DeleteView):
    model= Todo

    def get_success_url(self):
        return reverse("todo-list")
     
       

class TodoCreateView(CreateView):
    model = Todo
    template_name = "bootstrap/todo_create.html"
    form_class = TodoForm

    def get_success_url(self):
        return reverse("todo-list")
    

    
class TodoUpdateView(UpdateView):
    model = Todo
    template_name = "bootstrap/todo_update.html"
    form_class = TodoForm

    def get_success_url(self):
        return reverse("todo-list")


    

# def todo_update(request, id):
#     if request.method == "GET":
#         todo = Todo.objects.get(id=id)
#         return render(
#             request,
#             "bootstrap/todo_update.html",
#             {"todo": todo},
#         )
#     else:
#         todo = Todo.objects.get(id=id)
#         todo.title = request.POST["title"]
#         todo.save()
#         return HttpResponseRedirect("/")

