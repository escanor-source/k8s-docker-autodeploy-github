# 🚀 K3s Auto-Deploy Platform

Automatische CI/CD-pipeline met ondersteuning voor meerdere technologieën via K3s & GitHub Actions.

## ✅ Status

![Build Status](https://github.com/escanor-source/k8s-docker-autodeploy-github/actions/workflows/deploy.yml/badge.svg)

## 🔧 Features

- GitHub Actions CI/CD met Docker en K3s
- Multi-arch Docker builds (AMD64/ARM64)
- Dynamische tests per applicatie (Laravel, Flask, enz.)
- Automatisch deployment op eigen K3s cluster
- Self-hosted ARM64 GitHub Actions runner
- Deployment status via `kubectl rollout status`

## 🧪 Test Framework

Tests worden automatisch gedetecteerd en uitgevoerd:
- `tests/test_app.py` → generieke test
- `tests/test_laravel.py` → Laravel-specifiek

## 📁 Voorbeeldbestanden per klant

- `Dockerfile`
- `deployment.yaml`
- `tests/test_*.py`

---

