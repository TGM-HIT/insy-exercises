from django.shortcuts import render

def index(request):
    ctx = {
        'recipes': [
            {
                'name': 'Spaghetti Carbonara',
                'type': 'food',
                'instructions': '... to be continued ...',
                'ingredients': [
                    {
                        'name':'Spaghetti',
                        'quantity': 400,
                        'unit': 'g'
                    },
                    {
                        'name':'Eggs',
                        'quantity': 2,
                    },
                    {
                        'name': 'Guanciale',
                        'quantity': 170,
                        'unit': 'g'
                    },
                    {
                        'name': 'Pecorino',
                        'quantity': 100,
                        'unit': 'g'
                    },
                    {
                        'name':'Rosemary',
                        'quantity': 1,
                        'unit': 'tsp'
                    }
                ]
            },
            {
                'name': 'Gin Tonic',
                'type': 'drink',
                'ingredients': [
                    {
                        'name':'Gin',
                        'quantity': 4,
                        'unit': 'cl'
                    },
                    {
                        'name':'Tonic',
                        'quantity': 200,
                        'unit': 'ml'
                    }
                ]
            }
        ]
    }
    return render(request, 'backend/index.html', ctx)