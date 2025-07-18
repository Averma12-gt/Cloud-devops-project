from flask import Flask, render_template_string

app = Flask(__name__)

@app.route('/')
def home():
    return render_template_string("""
    <!DOCTYPE html>
    <html>
    <head>
        <title>Akash's Cloud DevOps App</title>
        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(to right, #0f2027, #203a43, #2c5364);
                color: white;
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                text-align: center;
                flex-direction: column;
            }
            h1 {
                font-size: 3rem;
                margin-bottom: 1rem;
                animation: fadeIn 2s ease-in-out;
            }
            p {
                font-size: 1.2rem;
                color: #ccc;
            }
            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(-20px); }
                to { opacity: 1; transform: translateY(0); }
            }
        </style>
    </head>
    <body>
        <h1>Welcome to Akash's Cloud DevOps App 🚀</h1>
        <p>Deployed on AWS using Docker, ECS Fargate, and Terraform</p>
    </body>
    </html>
    """)

# ✅ This was missing
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
