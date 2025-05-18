import requests

def test_homepage():
    response = requests.get("http://localhost:30080")
    assert response.status_code == 200
    assert "GitHub Actions" in response.text
