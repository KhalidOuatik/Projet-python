import os
import requests
import time

FLASK_IP = os.environ.get("FLASK_IP", "127.0.0.1")
GRAFANA_IP = os.environ.get("GRAFANA_IP", "127.0.0.1")
PROMETHEUS_IP = os.environ.get("PROMETHEUS_IP", "127.0.0.1")

# Helper pour attendre qu'un service soit up
def wait_for_service(url, timeout=60):
    for _ in range(timeout):
        try:
            r = requests.get(url, timeout=2)
            if r.status_code == 200:
                return True
        except Exception:
            pass
        time.sleep(1)
    return False

def test_flask_root():
    url = f"http://{FLASK_IP}:5000/"
    assert wait_for_service(url), f"Flask root endpoint KO: {url}"
    print("[OK] / (Flask)")

def test_flask_metrics():
    url = f"http://{FLASK_IP}:5000/metrics"
    assert wait_for_service(url), f"Flask /metrics KO: {url}"
    print("[OK] /metrics (Flask)")

def test_flask_bmi():
    url = f"http://{FLASK_IP}:5000/bmi"
    data = {"height": 180, "weight": 75}
    for _ in range(10):
        try:
            r = requests.post(url, json=data, timeout=2)
            if r.status_code == 200:
                print("[OK] /bmi (Flask)")
                return
        except Exception:
            pass
        time.sleep(1)
    raise Exception(f"Flask /bmi KO: {url}")

def test_grafana_login():
    url = f"http://{GRAFANA_IP}:3000/login"
    assert wait_for_service(url), f"Grafana login KO: {url}"
    print("[OK] /login (Grafana)")

def test_prometheus_ui():
    url = f"http://{PROMETHEUS_IP}:9090/graph"
    assert wait_for_service(url), f"Prometheus UI KO: {url}"
    print("[OK] /graph (Prometheus)")

def test_prometheus_targets():
    url = f"http://{PROMETHEUS_IP}:9090/api/v1/targets"
    for _ in range(30):
        try:
            r = requests.get(url, timeout=2)
            if r.status_code == 200 and 'data' in r.json():
                print("[OK] /api/v1/targets (Prometheus)")
                return
        except Exception:
            pass
        time.sleep(1)
    raise Exception(f"Prometheus targets KO: {url}")

if __name__ == '__main__':
    test_flask_root()
    test_flask_metrics()
    test_flask_bmi()
    test_grafana_login()
    test_prometheus_ui()
    test_prometheus_targets()
    print("\nTous les tests d'intégration sont OK !")
