#!/bin/sh

echo "====================================="
echo "  DIAGNOSTICO - SRV-LINUX"
echo "====================================="

echo ""

echo "HOSTNAME: $(hostname)"
echo "IP INTERNA: $(ip addr show enp0s8 | grep 'inet ' | awk '{print $2}')"
echo "DISCO: $(df -h / | awk 'NR==2 {print $2 " TOTAL /" &4 " LIBRE "}')"
echo ""====================================================================="