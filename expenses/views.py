from django.shortcuts import render, HttpResponse, redirect, get_object_or_404
from .models import *
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.utils import timezone
from django.contrib.auth import authenticate, login
from django.http import JsonResponse
from django.db.models import Sum, Value, DecimalField , F, Count
from django.db.models.functions import Coalesce
from .utils import log_action
from django .core.files.storage import FileSystemStorage
import pandas as pd
from django.http import HttpResponse
from decimal import Decimal
from django.db.models import Q
from .utils import notify
from datetime import date
import subprocess
import os
from datetime import datetime
from django.conf import settings
from django.db.models.functions import Coalesce
from django.core.mail import send_mail
from django.conf import settings





def login_user(request):

    if request.method == 'POST':

        try:

            username = request.POST.get('username')
            password = request.POST.get('password')

            if not username or not password:
                raise ValueError("Username and password are required.")

            user = authenticate(
                request,
                username=username,
                password=password
            )

            if user is not None:

                login(request, user)

                log_action(
                    user=user,
                    action="LOGIN",
                    details=f"{user.fullname} logged into the system"
                )

                return JsonResponse({
                    'success': True,
                    'message': 'Login successful'
                })

            else:

                return JsonResponse({
                    'success': False,
                    'message': 'Incorrect username or password'
                })

        except Exception as e:

            return JsonResponse({
                'success': False,
                'message': 'An error occurred during login.',
                'error': str(e)
            })

    return render(request, 'login.html')



def logoutuser(request):
    return render(request, 'login.html')



@login_required
def home(request):
    expenses = ExpenseRequest.objects.all()
    notifications = Notification.objects.filter(user=request.user, read=0).order_by('-timestamp')
    return render(request, 'home.html', {'expenses': expenses, "notifications":notifications})



@login_required
def mark_notification_read(request, pk):
    note = get_object_or_404(Notification, pk=pk, user=request.user)
    note.mark_as_read()
    return redirect("expenses:notifications")  



@login_required
def save_department(request):
    if request.method=="POST":
    
        if 'excel_file' in request.FILES:
            excel_file = request.FILES['excel_file']
            fs = FileSystemStorage()
            filename = fs.save(excel_file.name, excel_file)
            file_path = fs.path(filename)

            
            df = pd.read_excel(file_path)

            for _, row in df.iterrows():
                # department = Department.objects.get(code=row['department_id'])
                Department.objects.create(
                    code=row['code'],
                    name=row['name'],
                    head_of_department=row['head_of_department'],
                    description=row['description'],
                   
                )
            return redirect('expenses:save_department')   

        code=request.POST.get('code')
        name=request.POST.get('name')
        description=request.POST.get('description')
        hod=request.POST.get('hod')
        id=request.POST.get('id')


        if id:
            existing_dep =Department.objects.get(id=id)
            existing_dep.name=name
            existing_dep.description=description
            existing_dep.code=code
            existing_dep.head_of_department=hod
            existing_dep.save()
            log_action(request.user, "Department Edited", existing_dep, details=f"Department '{existing_dep.name}' edited")

        else:
            department=Department(name=name, code=code, description=description, head_of_department=hod)
            department.save()
            log_action(request.user, "Department Saved", department, details=f"Department '{department.name}' saved")

    context={
        'department_list': Department.objects.all()
    }    
    return render(request, 'department.html', context)



@login_required
def download_department_template(request):
   
    columns = ["name", "description", "head_of_department", "code"]
    df = pd.DataFrame(columns=columns)

   
    response = HttpResponse(content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
    response['Content-Disposition'] = 'attachment; filename="department_template.xlsx"'

    with pd.ExcelWriter(response, engine='openpyxl') as writer:
        df.to_excel(writer, index=False, sheet_name='Departments')

    return response


@login_required
def save_category(request):
    if request.method=="POST":
        name=request.POST.get('name')
        description=request.POST.get('description')
        id=request.POST.get('id')
        
        if id:
            existing_cat =ExpenseCategory.objects.get(id=id)
            existing_cat.name=name
            existing_cat.description=description
            existing_cat.save()
            log_action(request.user, "Category Edited", existing_cat, details=f"Expense category '{existing_cat.name}' edited")
        else:    
            category=ExpenseCategory(name=name,  description=description,)
            category.save()
            log_action(request.user, "Category Saved", category, details=f"Expense category '{category.name}' saved")

    context={
        'category_list': ExpenseCategory.objects.all()
    }    
    return render(request, 'category.html', context)



@login_required
def save_user(request):

    user = request.user 
    if user.role == "Head": 
        users = CustomUser.objects.filter(department=user.department) 
    else: 
        users = CustomUser.objects.none()     
    
    
    if request.method == "POST":
    
        if 'excel_file' in request.FILES:
            excel_file = request.FILES['excel_file']
            fs = FileSystemStorage()
            filename = fs.save(excel_file.name, excel_file)
            file_path = fs.path(filename)

           
            df = pd.read_excel(file_path)

            for _, row in df.iterrows():
                department = Department.objects.get(code=row['department_id'])
                CustomUser.objects.create_user(
                    username=row['email'],
                    password=row['password'],
                    fullname=row['fullname'],
                    department=department,
                    role=row['role'],
                    email=row['email'],
                    is_active=row['active']
                )
            return redirect('expenses:save_user')    
        


        fullname = request.POST.get('fullname')
        department_id = request.POST.get('department')
        role = request.POST.get('role')
        email = request.POST.get('email')
        password = request.POST.get('password')
        id=request.POST.get('id')
        is_active=request.POST.get('active')

       
        department = Department.objects.get(id=department_id)

        if id:
            existing_user_entry=CustomUser.objects.get(id=id)
            existing_user_entry.fullname=fullname
            existing_user_entry.department=department
            existing_user_entry.role=role
            existing_user_entry.password=password
            existing_user_entry.email=email
            existing_user_entry.is_active = is_active
            existing_user_entry.save()
            log_action(request.user, "User Edited", existing_user_entry, details=f"User '{existing_user_entry.fullname}'edited")

        
        else:
            user = CustomUser.objects.create_user(
                username=email.replace(" ", ""),  
                password=password,  
                fullname=fullname,
                department=department,
                role=role,
                email=email,
                is_active= is_active
            )
            log_action(request.user, "User Saved", user, details=f"User '{user.fullname}' saved")

        return redirect('expenses:save_user')  

    context = {
        'department_list': Department.objects.all(),
        'user_list': CustomUser.objects.all(),
        # "user_list":users
    }
    return render(request, 'users.html', context)



@login_required
def delete_user(request, id):

    user_to_delete = get_object_or_404(CustomUser, id=id)

    # Prevent deleting yourself
    if request.user == user_to_delete:
        messages.error(request, "You cannot delete your own account.")
        return redirect('expenses:save_user')

    try:
        fullname = user_to_delete.fullname

        user_to_delete.delete()

        log_action(
            request.user,
            "User Deleted",
            user_to_delete,
            details=f"User '{fullname}' deleted"
        )

        messages.success(request, "User deleted successfully.")

    except Exception as e:
        messages.error(request, f"Error deleting user: {e}")

    return redirect('expenses:save_user')    



@login_required
def download_user_template(request):
   
    columns = ["fullname", "email", "password", "role", "department_id", "active"]

 
    df = pd.DataFrame(columns=columns)

 
    response = HttpResponse(content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
    response['Content-Disposition'] = 'attachment; filename="user_template.xlsx"'

    with pd.ExcelWriter(response, engine='openpyxl') as writer:
        df.to_excel(writer, index=False, sheet_name='Users')

    return response





@login_required
def create_expense_request(request):
    user = request.user 
    if user.role == "Staff": 
        expenses = ExpenseRequest.objects.filter(user=user) 
    elif user.role in ["Dean", "Head"]: 
        expenses = ExpenseRequest.objects.filter(department=user.department) 
    elif user.role == "Finance": 
        expenses = ExpenseRequest.objects.filter(Q(status="Approved",) |Q(status="Disbursed")) 

    elif user.role == "Admin": 
        expenses = ExpenseRequest.objects.all() 

    elif user.role == "Dean":  
        expenses = ExpenseRequest.objects.all() 
    

    else: 
        expenses = ExpenseRequest.objects.none()

        
    if request.method == "POST":
        

        try:
           
            name = request.POST.get("name")
            date = request.POST.get("date")
            description = request.POST.get("description")
            total_amount = request.POST.get("total_amount")

            category = ExpenseCategory.objects.get(id=request.POST.get("category"))
            # if not category:
            #     messages.error(request, "Category is required.")
            #     return redirect("expenses:create_expense")


            user= request.user


            department = request.user.department
            if not request.user.department:
                messages.error(request, "User has no department assigned.")
                return redirect("expenses:create_expense")
                    

            today = timezone.now().date()
            budget = DepartmentBudget.objects.filter(
                department=department,
                start_date__lte=today,
                end_date__gte=today
            ).first()

            if not budget: 
                messages.error(request, "No active budget found for this department.") 
                return redirect("expenses:create_expense")

            spent_amount = ExpenseRequest.objects.filter(
            department=department,
            date__gte=budget.start_date,
            date__lte=budget.end_date,
            status__in=['Approved', 'Disbursed']  
            ).aggregate(total=Sum('total_amount'))['total'] or Decimal('0.00')

            spent_amount = Decimal(spent_amount)
            total_amount = Decimal(total_amount)  
            budget_limit = Decimal(budget.budget_amount)

           
            if spent_amount + total_amount > budget_limit:
                messages.error(request, "Request exceeds department budget!")
                return redirect("expenses:create_expense")


            expense_request = ExpenseRequest.objects.create(
                name=name,
                date=date,
                description=description,
                total_amount=total_amount,
                category=category,
                department=department,
                user=user
            )
           
            log_action(request.user, "Expense Request Saved", expense_request, details=f"Expense Request '{expense_request.name}' saved")
            


            
          
            index = 0
            while True:
                desc_key = f"items[{index}][description]"
                amount_key = f"items[{index}][amount]"

                item_desc = request.POST.get(desc_key)
                item_amount = request.POST.get(amount_key)

                if not request.POST.get("items[0][description]"):
                    messages.error(request, "Add at least one expense item.")
                    return redirect("expenses:create_expense")

                if item_desc and item_amount:
                    ExpenseItem.objects.create(
                        request=expense_request,
                        description=item_desc,
                        amount=item_amount
                    )
                    # log_action(request.user, "Expense Items Saved", ExpenseItem, details=f"Department '{ExpenseItem.description}' saved")
                
                else:
                    break 

                index += 1

        #     send_mail(
        #     subject='Expense Request Submitted',

        #     message=f'''
        # Hello {request.user.fullname},

        # Your expense request has been submitted successfully.

        # Expense Title: {expense_request.name}
        # Amount: {expense_request.total_amount}
        # Status: {expense_request.status}

        # Thank you.
        # Expense Management System
        # ''',

        #     from_email=settings.EMAIL_HOST_USER,

        #     recipient_list=[request.user.email],

        #     fail_silently=False,
        # )

            messages.success(request, "Expense Request created successfully!")
            return redirect("expenses:create_expense")
           

        except Exception as e:
            messages.error(request, f"Error saving expense: {e}")
            return redirect("expenses:create_expense") 


    context= {
        "categories": ExpenseCategory.objects.all(),
        "department": Department.objects.all(),
        "users": CustomUser.objects.all(),
        "expenses":ExpenseRequest.objects.all(),
        "approver":CustomUser.objects.filter(role="dean"),
        "expenses": expenses
    }

    return render(request, "expenses.html", context)



@login_required
def expense_detail(request, expense_id):
    user = request.user 
    if user.role == "Staff": 
        expenses = ExpenseRequest.objects.filter(user=user) 
    elif user.role in ["Head", "Dean"]: 
        expenses = ExpenseRequest.objects.filter(department=user.department) 
    elif user.role == "Finance": 
        expenses = ExpenseRequest.objects.filter(status="Approved") 
    else: 
        expenses = ExpenseRequest.objects.none()


    expense_request = get_object_or_404(ExpenseRequest, id=expense_id)
    items = ExpenseItem.objects.filter(request=expense_request)

    context = {
        "expense_request": expense_request,
        "items": items,
    }
    return render(request, "requestdetails.html", context)



@login_required
def add_item(request, expense_id):
    expense_request = get_object_or_404(ExpenseRequest, id=expense_id)

    
    if request.method == "POST" and request.user.role in ["Dean", "Head"]:
        description = request.POST.get("description")
        amount = request.POST.get("amount")

        if description and amount:
            ExpenseItem.objects.create(
                request=expense_request,
                description=description,
                amount=amount
            )
            expense_request.recalculate_total()

        return redirect("expenses:expense_detail", expense_id=expense_id)

    return redirect("expenses:expense_detail", expense_id=expense_id)



@login_required
def delete_item(request, item_id):
    item = get_object_or_404(ExpenseItem, id=item_id)
    expense_id = item.request.id
    expense_request = item.request

    if request.user.role in ["Dean", "Head"]:
        item.delete()
        expense_request.recalculate_total()

    return redirect("expenses:expense_detail", expense_id=expense_id)




@login_required
def cancel_expense_request(request, request_id):
    expense_request = get_object_or_404(ExpenseRequest, id=request_id)

    if expense_request.status != 'Pending':
        messages.error(request, 'This request has already been processed.')
        return redirect('expense_list')

  
    expense_request.cancel()

   
    DepartmentExpenseRequestHistory.objects.create(
        expense_request=expense_request,
        department=expense_request.department,
        status='Cancelled',
        action_taken_by=request.user
    )

    messages.success(request, 'Expense request cancelled successfully!')
    return redirect('expense_list')




@login_required
def approve_expense_request(request, pk):
    expense = get_object_or_404(ExpenseRequest, id=pk)

   
    if request.user.role not in ["Dean", "Head"]:
        messages.error(request, "You are not authorized to approve this request.")
        return redirect("expenses:expense_detail", expense_id=pk)

    if expense.status != "Pending":
        messages.error(request, "This request has already been processed.")
        return redirect("expenses:expense_detail", expense_id=pk)

    if expense.user == request.user:
        messages.error(request, "You cannot approve your own expense request.")
        return redirect("expenses:expense_detail", expense_id=pk)

   
    expense.status = "Approved"
    expense.approved_by = request.user
    expense.approved_at = timezone.now()
    

    expense.recalculate_total()
    expense.save()
    log_action(request.user, "Approved Expense", expense, details=f"Expense '{expense.name}' approved")
    
    send_mail(
    subject='Expense Request Approved',

    message=f'''
    Hello {expense.user.fullname},

    Your expense request has been approved.

    Expense Title: {expense.name}
    Amount: {expense.total_amount}
    Status: {expense.status}

    Approved By: {request.user.fullname}

    Thank you.
    Expense Management System
    ''',

    from_email=settings.EMAIL_HOST_USER,

    recipient_list=[expense.user.email],

    fail_silently=False,
)


   
    DepartmentExpenseRequestHistory.objects.create(
        expense_request=expense,
        department=expense.department,
        status="Approved",
        action_taken_by=request.user
    )

   
    notify(expense.user, f"Your expense request '{expense.name}' has been approved.")

    messages.success(request, "Expense request approved.")
    return redirect("expenses:expense_detail", expense_id=pk)



@login_required
def reject_expense_request(request, pk):
    expense = get_object_or_404(ExpenseRequest, id=pk)

    if request.user.role not in ["Dean", "Head"]:
        messages.error(request, "You are not authorized to reject this request.")
        return redirect("expenses:expense_detail", expense_id=pk)

    if expense.status != "Pending":
        messages.error(request, "This request has already been processed.")
        return redirect("expenses:expense_detail", expense_id=pk)

    if expense.user == request.user:
        messages.error(request, "You cannot reject your own expense request.")
        return redirect("expenses:expense_detail", expense_id=pk)

   
    expense.status = "Rejected"
    expense.rejected_by = request.user
    expense.rejected_at = timezone.now()
    expense.save()
    log_action(request.user, " Expense Rejected", expense, details=f"Expense '{expense.name}' rejected")

    DepartmentExpenseRequestHistory.objects.create(
        expense_request=expense,
        department=expense.department,
        status="Rejected",
        action_taken_by=request.user
    )

    notify(expense.user, f"Your expense request '{expense.name}' has been rejected.")

    send_mail(
    subject='Expense Request Rejected',

    message=f'''
    Hello {expense.user.fullname},

    Your expense request has been rejected.

    Expense Title: {expense.name}
    Amount: {expense.total_amount}
    Status: {expense.status}

    Rejected By: {request.user.fullname}

    Thank you.
    Expense Management System
    ''',

    from_email=settings.EMAIL_HOST_USER,

    recipient_list=[expense.user.email],

    fail_silently=False,
)


    messages.success(request, "Expense request rejected.")
    return redirect("expenses:expense_detail", expense_id=pk)



@login_required
def disburse_expense(request, pk):
    expense = get_object_or_404(ExpenseRequest, id=pk)

    if expense.status != "Approved":
        messages.error(request, "Only approved expenses can be disbursed.")
        return redirect("create_expense")

    if request.method == "POST":
        method = request.POST.get("payment_method")
        ref = request.POST.get("reference_number")
        notes = request.POST.get("notes")

        
        disbursement=ExpenseDisbursement.objects.create(
            expense_request=expense,
            disbursed_by=request.user,
            payment_method=method,
            reference_number=ref,
            notes=notes
        )
        log_action(request.user, "Expense Disbursed", disbursement, details=f"Expense '{disbursement.expense_request}' disbursed")
        notify(expense.user, f"Your expense request '{expense.name}' has been disbursed.")

        
        expense.status = "Disbursed"
        expense.save()

        files = request.FILES.getlist("receipts")
        for file in files:
            ExpenseReceipt.objects.create(disbursement=disbursement, file=file)

        
        expense.status = "Disbursed"
        expense.save()

        messages.success(request, "Expense successfully disbursed.")
        return redirect("expenses:create_expense")

    return render(request, "disburse_expense.html", {"expense": expense})



@login_required
def upload_receipt(request, pk):
    disbursement = get_object_or_404(ExpenseDisbursement, id=pk)

    if request.method == "POST" and request.user.role == "Finance" or request.user.role == "Staff":
        file = request.FILES.get("file")
        if file:
            ExpenseReceipt.objects.create(disbursement=disbursement, file=file)
            messages.success(request, "Receipt uploaded.")
    return redirect("expenses:expense_detail", expense_id=disbursement.expense_request.id)



@login_required
def note(request):
    notifications = Notification.objects.filter(user=request.user).order_by('-timestamp')
    return render(request, "notifications.html", {"notifications": notifications})



@login_required
def save_budget(request):
    if request.method == 'POST':
       
        amount = request.POST.get('amount')
        start_date = request.POST.get('sdate')
        end_date = request.POST.get('edate')
        department=request.POST.get('department')
        id=request.POST.get('id')
        
       
        department=Department.objects.get(code=department)

        if id:
            existing_budget =DepartmentBudget.objects.get(id=id)
            existing_budget.budget_amount=amount
            existing_budget.start_date=start_date
            existing_budget.end_date=end_date
            existing_budget.department=department
            existing_budget.save()
            log_action(request.user, "Budget Edited", existing_budget, details=f"Budget for '{existing_budget.department}' edited")

        else:
            budget = DepartmentBudget(
            
                budget_amount=amount,
                start_date=start_date,
                end_date=end_date,
                department=department,
            )
            
           
            budget.save()
            log_action(request.user, "Budget Saved", budget, details=f"Budget for '{budget.department}' saved")
            
            messages.success(request, 'Budget has been saved successfully and is awaiting approval.')
           
    context= {
       
        "department":Department.objects.all(),
        "budgets":DepartmentBudget.objects.all(),

    }
    
    return render(request, 'budget.html', context)



@login_required
def department_budget_report(request):

    today = timezone.now().date()
    total_budget = DepartmentBudget.objects.aggregate(total=Coalesce(
        Sum(
            'budget_amount',
            output_field=DecimalField()
        ),

        Value(
            0,
            output_field=DecimalField()
        )
        ))['total']


    total_spent = ExpenseRequest.objects.filter(

        status__in=['Approved', 'Disbursed']

    ).aggregate(

        total=Coalesce(
            Sum(
                'total_amount',
                output_field=DecimalField()
            ),

            Value(
                0,
                output_field=DecimalField()
            )
        )

    )['total']

    total_remaining = total_budget - total_spent





    budgets = DepartmentBudget.objects.filter(
        start_date__lte=today,
        end_date__gte=today
    ).select_related('department')

    if request.user.role not in ['Admin', 'Finance', 'Head']:

        budgets = budgets.filter(
            department=request.user.department
        )

    report = []

    for budget in budgets:
        spent = ExpenseRequest.objects.filter(
            department=budget.department,
            status__in=['Approved', 'Disbursed'],  
            date__gte=budget.start_date,
            date__lte=budget.end_date
        ).aggregate(total=Coalesce(Sum('total_amount',output_field=DecimalField()), Value(0, output_field=DecimalField())))['total']

        remaining = budget.budget_amount - spent
        if budget.budget_amount > 0:

            percentage_used = round(
                (spent / budget.budget_amount) * 100,
                1
            )

        else:

            percentage_used = 0

        report.append({
            "department": budget.department.name,
            "budget": budget.budget_amount,
            "spent": spent,
            "remaining": remaining,
            "percentage_used": percentage_used,
            "period": f"{budget.start_date} → {budget.end_date}"
        })

    context = {

    "report": report,

    "total_budget": total_budget,

    "total_spent": total_spent,

    "total_remaining": total_remaining,

}

    return render(request, "budget_report.html", context)



@login_required
def create_notification(user, message):
    Notification.objects.create(user=user, message=message)



@login_required
def index(request):
    return render(request, "index.html")




DB_NAME = settings.DATABASES['default']['NAME']
DB_USER = settings.DATABASES['default']['USER']
BACKUP_FOLDER = "backups"

# SOCKET_PATH = settings.DATABASES['default']['OPTIONS']['unix_socket']  

# # 


import os
import subprocess
from datetime import datetime
from django.conf import settings
from django.http import JsonResponse
from django.contrib.auth.decorators import login_required

DB_NAME = settings.DATABASES['default']['NAME']
DB_USER = settings.DATABASES['default']['USER']
DB_PASSWORD = settings.DATABASES['default']['PASSWORD']
DB_HOST = settings.DATABASES['default']['HOST']
DB_PORT = settings.DATABASES['default']['PORT']

BACKUP_FOLDER = "database_backups"

os.makedirs(BACKUP_FOLDER, exist_ok=True)


@login_required
def backup_database(request):

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")

    backup_file = os.path.join(
        BACKUP_FOLDER,
        f"backup_{timestamp}.sql"
    )

    env = os.environ.copy()
    env["PGPASSWORD"] = DB_PASSWORD

    try:

        result = subprocess.run(
            [
                "pg_dump",
                "--no-owner",
                "--no-privileges",
                "-h", DB_HOST,
                "-p", str(DB_PORT),
                "-U", DB_USER,
                "-F", "c",
                "-f", backup_file,
                DB_NAME
            ],
            env=env,
            stderr=subprocess.PIPE
        )

        if result.returncode == 0:
            return JsonResponse({
                "message": "Backup successful",
                "file": backup_file
            })

        else:
            return JsonResponse({
                "message": result.stderr.decode()
            }, status=500)

    except Exception as e:
        return JsonResponse({
            "message": str(e)
        }, status=500)


@login_required


def restore_database(request):

    files = sorted(os.listdir(BACKUP_FOLDER), reverse=True)

    if not files:
        return JsonResponse({
            "message": "No backup found"
        }, status=404)

    latest_backup = os.path.join(BACKUP_FOLDER, files[0])

    env = os.environ.copy()
    env["PGPASSWORD"] = DB_PASSWORD

    try:

        result = subprocess.run(
            [
                "pg_restore",
                "--clean",
                "--if-exists",
                "--no-owner",
                "--no-privileges",
                "-h", DB_HOST,
                "-p", str(DB_PORT),
                "-U", DB_USER,
                "-d", DB_NAME,
                latest_backup
            ],
            env=env,
            stderr=subprocess.PIPE
        )

        if result.returncode == 0:
            return JsonResponse({
                "message": f"Restored successfully from {files[0]}"
            })

        else:
            return JsonResponse({
                "message": result.stderr.decode()
            }, status=500)

    except Exception as e:
        return JsonResponse({
            "message": str(e)
        }, status=500)
    


@login_required
def expense_report_view(request):
    start_date = request.GET.get("start_date")
    end_date = request.GET.get("end_date")
    department_id = request.GET.get("department")
    category_id = request.GET.get("category")

    expenses = ExpenseRequest.objects.select_related('department', 'category', 'user').all()

   
    if start_date:
        expenses = expenses.filter(date__gte=start_date)
    if end_date:
        expenses = expenses.filter(date__lte=end_date)

    
    if department_id and department_id != "all":
        expenses = expenses.filter(department_id=department_id)

    
    if category_id and category_id != "all":
        expenses = expenses.filter(category_id=category_id)

   
    departments = Department.objects.all()
    categories = ExpenseCategory.objects.all()
    
    approved_count = ExpenseRequest.objects.filter(
    status__in=['Approved', 'Disbursed']        
    ).count()

    pending_count = expenses.filter(
    status='Pending'
    ).count()

    total_amount = expenses.aggregate(

    total=Coalesce(
        Sum(
            'total_amount',
            output_field=DecimalField()
        ),

        Value(
            0,
            output_field=DecimalField()
        )
    )

    )['total']

    context = {
        "expenses": expenses.order_by('-date'),
        "departments": departments,
        "categories": categories,
        "selected_department": department_id,
        "selected_category": category_id,
        "start_date": start_date,
        "end_date": end_date,
        "approved_count": approved_count,
        "pending_count": pending_count,
        "total_amount": total_amount
    }

    return render(request, "expense_report.html", context)



@login_required
def reports_dashboard(request):
    
    start_date = request.GET.get('start_date')
    end_date = request.GET.get('end_date')
    department_id = request.GET.get('department')
    category_id = request.GET.get('category')
    user_id = request.GET.get('user')

    today = date.today()
    if not start_date:
        start_date = date(today.year, 1, 1)
    else:
        start_date = date.fromisoformat(start_date)
    if not end_date:
        end_date = today
    else:
        end_date = date.fromisoformat(end_date)

    expenses = ExpenseRequest.objects.select_related('department', 'category', 'user').all()
    expenses = expenses.filter(date__gte=start_date, date__lte=end_date)

    if department_id and department_id != 'all':
        expenses = expenses.filter(department_id=department_id)
    if category_id and category_id != 'all':
        expenses = expenses.filter(category_id=category_id)
    if user_id and user_id != 'all':
        expenses = expenses.filter(user_id=user_id)

    dept_summary = expenses.values('department__name').annotate(
        total_expense=Sum('total_amount'),
        pending_requests=Count('id', filter=Q(status='Pending')),
        approved_requests=Count('id', filter=Q(status='Approved'))
    )

   
    category_summary = expenses.values('category__name').annotate(
        total_expense=Sum('total_amount')
    )

   
    user_summary = expenses.values('user__fullname').annotate(
        total_expense=Sum('total_amount'),
        pending_requests=Count('id', filter=Q(status='Pending')),
        approved_requests=Count('id', filter=Q(status='Approved'))
    )

  
    departments = Department.objects.all()
    categories = ExpenseCategory.objects.all()
    users = CustomUser.objects.all()

    context = {
        "expenses": expenses,
        "dept_summary": dept_summary,
        "category_summary": category_summary,
        "user_summary": user_summary,
        "departments": departments,
        "categories": categories,
        "users": users,
        "selected_department": department_id,
        "selected_category": category_id,
        "selected_user": user_id,
        "start_date": start_date,
        "end_date": end_date,
    }

    return render(request, "reports_dashboard.html", context)



@login_required
def audit_log_view(request):
    logs = AuditLog.objects.select_related("user", "content_type").order_by("-timestamp")
    return render(request, "audit_log.html", {"logs": logs})


from django.db.models import Sum, Count
from django.utils import timezone
from datetime import timedelta


from datetime import timedelta

from django.db.models import Sum
from django.db.models.functions import TruncMonth
from django.shortcuts import render
from django.utils import timezone

from .models import ExpenseRequest

@login_required
def dashboard(request):

    expenses = ExpenseRequest.objects.all()

    # ---------------- KPIs ----------------
    total_expenses = expenses.aggregate(
        total=Sum('total_amount')
    )['total'] or 0

    total_requests = expenses.count()

    approved = expenses.filter(status="Approved").count()
    pending = expenses.filter(status="Pending").count()
    rejected = expenses.filter(status="Rejected").count()
    disbursed = expenses.filter(status="Disbursed").count()

    # ---------------- Department spending ----------------
    dept_spending = (
    expenses.filter(status__in=["Approved", "Disbursed"])
    .values('department__name')
    .annotate(total=Sum('total_amount'))
    .order_by('-total')
)

    # ---------------- Monthly trend ----------------
    today = timezone.now().date()
    last_6_months = today - timedelta(days=180)

    monthly = (
        expenses.filter(date__gte=last_6_months)
        .annotate(month=TruncMonth('date'))
        .values('month')
        .annotate(total=Sum('total_amount'))
        .order_by('month')
    )

    context = {
        "total_expenses": total_expenses,
        "total_requests": total_requests,

        "approved": approved,
        "pending": pending,
        "rejected": rejected,
        "disbursed": disbursed,

        "dept_spending": list(dept_spending),
        "monthly": list(monthly),
    }

    return render(request, "dashboard.html", context)