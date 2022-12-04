from flask import Flask, redirect, url_for, render_template, request
# from requests import request

import data as db

app = Flask(__name__)

customerID = 1

@app.route("/")
def index():
    return render_template("Index.html")

@app.route("/aboutUs")
def aboutUs():
    return render_template("aboutUs.html")

@app.route("/contactUs")
def contactUs():
    return render_template("contactUs.html")

@app.route("/help")
def help():
    return render_template("help.html")

@app.route("/Customer_login")
def Customer_login():
    return render_template("Customer_login.html")


@app.route("/Customer_login_input", methods=['POST'])
def Customer_login_input():
    global customerID
    customerID = int(request.form['custID'])
    password = request.form['password']

    return render_template("dashboard.html")


@app.route("/Customer_log_reg")
def Customer_log_reg():
    return render_template("Customer_log_reg.html")

@app.route("/Customer_register")
def Customer_register():
    return render_template("Customer_register.html")

@app.route("/Employee_login")
def Employee_login():
    return render_template("Employee_login.html")

@app.route("/Employee_log_reg")
def Employee_log_reg():
    return render_template("Employee_log_reg.html")

@app.route("/Employee_register")
def Employee_register():
    return render_template("Employee_register.html")


@app.route("/Employee_register_input", methods=['POST'])
def Employee_register_input():
    empName = request.form['empName']
    Street = request.form['Street']
    Area = request.form["Area"]
    City = request.form["City"]
    Pincode = request.form["Pincode"]
    PhoneNo = request.form["custPhoneNo"]
    db.addEmployee(empName, Street, Area, City, Pincode, PhoneNo)

    return render_template("Index.html")

@app.route("/Employee_Dashboard")
def Employee_Dashboard():
    return render_template('Employee_Dashboard.html')

@app.route("/Employee_Manager")
def Employee_manager():
    return render_template('Employee_Manager.html')

@app.route("/Manager_login")
def Mnager_login():
    return render_template('Manager_login.html')

@app.route("/Manager_Dashboard")
def Manager_Dashboard():
    return render_template('Manager_Dashboard.html')

@app.route("/dashboard")
def dashboard():
    return render_template("dashboard.html")

@app.route("/account")
def account():
    return render_template("account.html", SA_Account =  db.Account(customerID, "savings")[0], SA_IFSC = db.Account(customerID, "savings")[1], SA_Balance = db.Account(customerID, "savings")[2], CA_Account = db.Account(customerID, "current")[0], CA_IFSC = db.Account(customerID, "current")[1], CA_Balance = db.Account(customerID, "current")[2])

@app.route("/payments")
def payment():
    return render_template("payments.html")


@app.route("/payments_input", methods=['POST'])
def payments_input():
    sendAccNo = request.form['sendAccNo']
    recAccNo = request.form['recAccNo']
    recIFSC = request.form['recIFSC']
    amount = request.form["amount"]
    db.addTransaction(sendAccNo, recAccNo, amount)

    return render_template("dashboard.html")

@app.route("/FD")
def FD():
    return render_template('FD.html')

@app.route("/FDHistory")
def FDHistory():
    return render_template('FDHistory.html', list = db.showFDHistory(customerID))

@app.route("/Loan")
def Loan():
    return render_template('Loan.html')

@app.route("/loanHistory")
def loanHistory():
    return render_template('loanHistory.html', list = db.showloanHistory(customerID))

@app.route("/transactionHistory")
def transactionHistory():
    return render_template('transactionHistory.html', list = db.showTransactionHistory(customerID))

@app.route("/card")
def card():
    return render_template("card.html")

@app.route("/employee_view_customers")
def employee_view_customers():
    return render_template("employee_view_customers.html", list = db.showEmployee_View_Cust())

@app.route("/manager_view_customers")
def manager_view_customers():
    return render_template("manager_view_customers.html", list = db.showManager_View_Cust())

@app.route("/manager_view_employees")
def manager_view_employees():
    return render_template("manager_view_employees.html", list = db.showManager_View_Employee())

# @app.route("/Savings_Account_Details")
# def Savings_Account_Details():
#     return render_template("Savings_Account_Details.html", an = "1", bal = "2", ifsc = "3", minbal = "4", ir = "5")

# @app.route("/Current_Account_Details")
# def Current_Account_Details():
#     return render_template("Current_Account_Details.html", an = "1", bal = "2", ifsc = "3", ol = "5")

@app.route("/credit_Card_Details")
def credit_Card_Details():
    return render_template("credit_Card_Details.html", cn = db.card(customerID, "credit")[0], ed = db.card(customerID, "credit")[1], cvv = db.card(customerID, "credit")[2], spl = db.card(customerID, "credit")[3], bal = db.card(customerID, "credit")[4])

@app.route("/debit_Card_Details")
def debit_Card_Details():
    return render_template("debit_Card_Details.html", cn = db.card(customerID, "credit")[0], ed = db.card(customerID, "debit")[1], cvv = db.card(customerID, "debit")[2], spl = db.card(customerID, "debit")[3], bal = db.card(customerID, "debit")[4])


if __name__ == "__main__":
    app.run(debug=True)