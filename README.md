# Práctica 1: Entorno de Virtualización e Infraestructura Base
**Asignatura:** Administración de Sistemas

## Descripción
Este proyecto implementa una infraestructura de red virtual heterogénea (Linux/Windows) para simular un entorno corporativo con monitoreo automatizado. El objetivo es asegurar conectividad bidireccional entre nodos críticos mediante scripts de diagnóstico.

## Arquitectura de Red
La red opera bajo el segmento `192.168.10.0/24` en una red interna de VirtualBox (`red_sistemas`) con **Modo Promiscuo: Permitir Todo**.

|--------------------------------------------------------------------|
| 	Nodo  		| SO 					| Rol	 	| IP			 |
|---------------|-----------------------|-----------|----------------|
|	NixOS-Srv 	| NixOS (Minimal) 		| Monitor 	| `192.168.10.1` |
|	Win-Srv** 	| Windows Server 2022 	| Backup 	| `192.168.10.2` |
|	Win-Cliente | Windows 10 			| Auditor	| `192.168.10.3` |
|--------------------------------------------------------------------|

## Guía de Instalación y Configuración

### 1. Servidor NixOS (Monitor)
Pasos para el particionado e instalación base desde la ISO minimal:

```bash
# 1. Preparamos el disco
sudo parted /dev/sda -- mklabel msdos
sudo parted /dev/sda -- mkpart primary ext4 1MiB 100%
sudo mkfs.ext4 -L nixos /dev/sda1
sudo mount /dev/disk/by-label/nixos /mnt

# 2. Generamos la configuración base
sudo nixos-generate-config --root /mnt

# 3. Editamos la configuración
sudo nano /mnt/etc/nixos/configuration.nix

# 4. Agregamos los siguientes apartados
networking.hostName = "Srv-Linux-Sistemas";
boot.loader.grub.enable = true;
boot.loader.grub.device = "/dev/sda"; 
# Se recomienda habilitar SSH aquí también
services.openssh.enable = true;

# 5. Instalamos y reiniciamos
sudo nixos-isntall
reboot
´´´
### 2. Windows Server (Backup)
# 1. Configuramos la red mediante Powershell (Ejecutamos como adm)
# Asignación de IP Estática
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.10.2 -PrefixLength 24

### 3. Windows 10 (Cliente)
# 1. Configuramos la red mediante Powershell (Ejecutamos como adm)
# Asignación de IP Estática
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.10.3 -PrefixLength 24

## Uso de los scripts

### 1. Windows (Cliente y Server)
# 1. Abrir PowerShell como admin

# 2. Ejecutar
.\tarea1_diagnostico.ps1

### 2. NixOS Linux (Server)
# 1. Dar permisos de ejecucion
chmod +x tarea1_diagnostico.sh

# 2. Ejecutar
./tarea1_diagnostico.sh

## Solucion de problemas

### 1. Conflicto de MAC Address

# Causa: Al clonar las máquinas, la interfaz WAN y LAN compartían la misma MAC

# Solución: Se regeneraron las direcciones MAC desde VirtualBox y se limpió la configuración con Remove-NetIPAddress
