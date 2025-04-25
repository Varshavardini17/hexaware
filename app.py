from flask import Flask,render_template, request, jsonify
from flask_cors import CORS
import pyodbc

app = Flask(__name__,template_folder='login')
CORS(app)

def connect_db():
    try:
        conn = pyodbc.connect(
            'DRIVER={ODBC Driver 17 for SQL Server};'
            'SERVER=localhost;'
            'DATABASE=assetmanage;'
            'Trusted_Connection=yes;'
        )
        print("✅ Connected to the database.")
        return conn
    except Exception as e:
        print("❌ Connection failed:", e)
        return None

@app.route('/')
def home():
    return "Welcome to Asset Management Backend!"

@app.route('/signup', methods=['POST'])
def signup():
    data = request.form
    name = data.get('name')
    email = data.get('email')
    password_input = data.get('password')
    department = data.get('department', 'General')

    conn = connect_db()
    if conn:
        try:
            cursor = conn.cursor()
            cursor.execute(
                "INSERT INTO employees (name, email, password, department) VALUES (?, ?, ?, ?)",
                (name, email, password_input, department)
            )
            conn.commit()
            return jsonify({"message": "Signup successful!"})
        except Exception as e:
            return jsonify({"message": f"Signup failed: {str(e)}"}), 500
        finally:
            conn.close()
    else:
        return jsonify({"message": "Database connection error"}), 500

@app.route('/login', methods=['GET','POST'])
def login():
    if request.method=='GET':
        return render_template('log.html')
    elif request.method=='POST':
        data = request.form
        email = data.get('email')
        password_input = data.get('password')

        conn = connect_db()
        if conn:
            try:
                cursor = conn.cursor()
                cursor.execute(
                    "SELECT employee_id, name, email, department FROM employees WHERE email = ? AND password = ?",
                    (email, password_input))
                user = cursor.fetchone()
                if user:
                    return jsonify({
                        "message": "Login successful!",
                        "id": user[0],
                        "name": user[1],
                        "email": user[2],
                        "department": user[3]
                    })
                else:
                    return jsonify({"message": "Invalid credentials"}), 401
            except Exception as e:
                return jsonify({"message": f"Login failed: {str(e)}"}), 500
            finally:
                conn.close()
        else:
            return jsonify({"message": "Database connection error"}), 500
    

@app.route('/get_assets', methods=['POST'])
def get_assets():
    data = request.get_json()
    employee_id = data.get('employee_id')

    conn = connect_db()
    if conn:
        try:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT name, status, purchase_date
                FROM assets
                WHERE owner_id = ?
            """, (employee_id,))
            rows = cursor.fetchall()
            assets = [{
                "asset_name": row[0],
                "status": row[1],
                "requested_date": row[2].strftime('%Y-%m-%d') if row[2] else ''
            } for row in rows]
            return jsonify({"assets": assets})
        except Exception as e:
            return jsonify({"message": str(e)}), 500
        finally:
            conn.close()
    else:
        return jsonify({"message": "DB connection error"}), 500

@app.route('/emp-dashboard-data', methods=['GET'])
def emp_dashboard_data():
    employee_id = request.args.get('id')
    if not employee_id:
        return jsonify({"message": "Employee ID is required"}), 400

    conn = connect_db()
    if conn:
        try:
            cursor = conn.cursor()

            cursor.execute("""
                SELECT COUNT(*) FROM assets
                WHERE owner_id = ? AND status = 'Allocated'
            """, (employee_id,))
            total_assets = cursor.fetchone()[0] or 0

            cursor.execute("""
                SELECT COUNT(*) FROM assets
                WHERE owner_id = ? AND status = 'Requested'
            """, (employee_id,))
            pending_requests = cursor.fetchone()[0] or 0

            approved_requests = total_assets

            cursor.execute("""
                SELECT TOP 5 asset_id, name, status, purchase_date
                FROM assets
                WHERE owner_id = ? AND status IN ('Requested', 'Allocated')
                ORDER BY purchase_date DESC
            """, (employee_id,))
            rows = cursor.fetchall()

            recent_requests = [{
                "id": row[0],
                "assetName": row[1],
                "status": row[2],
                "requestedDate": row[3].strftime('%B %d, %Y') if row[3] else "N/A"
            } for row in rows]

            return jsonify({
                "totalAssets": total_assets,
                "pendingRequests": pending_requests,
                "approvedRequests": approved_requests,
                "recentRequests": recent_requests
            })

        except Exception as e:
            return jsonify({"message": f"Error: {str(e)}"}), 500
        finally:
            conn.close()
    else:
        return jsonify({"message": "Database connection error"}), 500

@app.route('/request_asset', methods=['POST'])
def request_asset():
    data = request.get_json()
    asset_name = data.get('asset_name')
    category = data.get('category')
    reason = data.get('reason')
    employee_id = data.get('employee_id')

    if not all([asset_name, category, reason, employee_id]):
        return jsonify({"message": "All fields are required"}), 400

    conn = connect_db()
    if conn:
        try:
            cursor = conn.cursor()
            cursor.execute("""
                INSERT INTO assets (name, type, status, owner_id, location)
                VALUES (?, ?, 'Requested', ?, 'Warehouse')
            """, (asset_name, category, employee_id))
            conn.commit()
            return jsonify({"message": "Asset request submitted successfully!"})
        except Exception as e:
            return jsonify({"message": f"Failed to request asset: {str(e)}"}), 500
        finally:
            conn.close()
    else:
        return jsonify({"message": "Database connection error"}), 500

@app.route('/get_allocated_assets', methods=['POST'])
def get_allocated_assets():
    data = request.get_json()
    employee_id = data.get('employee_id')

    conn = connect_db()
    if conn:
        try:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT asset_id, name FROM assets
                WHERE owner_id = ? AND status = 'Allocated'
            """, (employee_id,))
            rows = cursor.fetchall()
            assets = [{"id": row[0], "name": row[1]} for row in rows]
            return jsonify({"assets": assets})
        except Exception as e:
            return jsonify({"message": str(e)}), 500
        finally:
            conn.close()
    else:
        return jsonify({"message": "DB connection error"}), 500

@app.route('/return_asset', methods=['POST'])
def return_asset():
    data = request.get_json()
    asset_id = data.get('asset_id')

    if not asset_id:
        return jsonify({"message": "Asset ID required"}), 400

    conn = connect_db()
    if conn:
        try:
            cursor = conn.cursor()
            cursor.execute("DELETE FROM assets WHERE asset_id = ?", (asset_id,))
            conn.commit()
            return jsonify({"message": "Asset returned and removed from database."})
        except Exception as e:
            return jsonify({"message": f"Return failed: {str(e)}"}), 500
        finally:
            conn.close()
    else:
        return jsonify({"message": "Database connection error"}), 500

if __name__ == '__main__':
    app.run(debug=True)
