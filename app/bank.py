from flask import Blueprint, render_template, g, request, redirect, url_for

from app.db import get_db

from app.auth import login_required

# Blueprint for bank routes
bp = Blueprint('bank', __name__, url_prefix='/banking')

# Route for the bank home page
@bp.route('/')
@login_required
def bank_index():
    return render_template('bank/index.html')

@bp.route('/banks')
@login_required
def banks():
    db = get_db()
    banks = db.execute(
        'SELECT bank.name, bank.id as bank_id, account.id as account_id FROM account '
        'JOIN bank ON account.bank_id = bank.id '
        'WHERE account.user_id = ?',
        (g.user['id'],)
    ).fetchall()

    return render_template('bank/banks.html', banks=banks)

@bp.route('/accounts<string:bank_name>')
@login_required
def accounts(bank_name):
    db = get_db()
    accounts = db.execute(
        'SELECT account.id, account.name, account.balance, bank.name AS bank_name '
        'FROM account JOIN bank ON account.bank_id = bank.id '
        'WHERE account.user_id = ? and bank.name = ?',
        (g.user['id'], bank_name)
    ).fetchall()
    return render_template('bank/accounts.html', accounts=accounts)

