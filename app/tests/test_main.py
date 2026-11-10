from fastapi.testclient import TestClient

from app.main import app

client = TestClient(app)


def test_health():
    r = client.get("/health")
    assert r.status_code == 200
    assert r.json() == {"status": "ok"}


def test_create_task():
    r = client.post("/tasks", json={"title": "learn devops"})
    assert r.status_code == 201
    assert r.json()["title"] == "learn devops"


def test_list_tasks():
    client.post("/tasks", json={"title": "second task"})
    r = client.get("/tasks")
    assert r.status_code == 200
    assert len(r.json()) >= 1
