#!/usr/bin/env python3
"""Quick Hardening Check"""
import requests
import subprocess

print('🛡️ QUICK HARDENING CHECK\n')

# Services
print('=== SERVICES ===')
try:
    r = requests.get('http://localhost:8765/api/status', timeout=5)
    print(f'✅ Backend: {r.status_code}')
except: print('❌ Backend: OFFLINE')

try:
    r = requests.get('http://localhost:11434/api/version', timeout=5)
    print(f'✅ Ollama: {r.status_code}')
except: print('❌ Ollama: OFFLINE')

try:
    r = requests.get('http://localhost:8888/health', timeout=5)
    print(f'✅ HexStrike: {r.status_code}')
except: print('❌ HexStrike: OFFLINE')

# Real Tool Check
print('\n=== REAL TOOL EXECUTION ===')
tools = [('nmap', ['--version']), ('ip', ['addr']), ('ps', ['aux'])]
for tool, args in tools:
    try:
        r = subprocess.run([tool]+args, capture_output=True, text=True, timeout=5)
        print(f'✅ {tool}: {"OK" if r.returncode == 0 else "ERROR"}')
    except: print(f'❌ {tool}: NOT FOUND')

# Swarm Test
print('\n=== SWARM EXECUTION ===')
try:
    r = requests.post('http://localhost:8765/api/swarm/execute', json={'task': 'test'}, timeout=60)
    data = r.json()
    print(f'✅ Swarm: {len(data.get("responses", {}))} agents responded')
    print(f'   Task ID: {data.get("task_id", "N/A")}')
except Exception as e: print(f'❌ Swarm: {e}')

# Evolution Check
print('\n=== EVOLUTION TRACKING ===')
try:
    r = requests.get('http://localhost:8765/api/swarm/evolution', timeout=5)
    evo = r.json()['evolution']
    print(f'✅ Tasks: {evo["tasks_completed"]}')
    print(f'✅ Skills: {len(evo["skills_learned"])}')
    print(f'✅ Tools: {len(evo["tools_mastered"])}')
except Exception as e: print(f'❌ Evolution: {e}')

print('\n✅ QUICK CHECK COMPLETE')
