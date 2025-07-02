#!/bin/bash

# Pragul sub care se va trimite notificarea
CRITICAL_LEVEL=25

BATTERY_DIR="/sys/class/power_supply/BAT1"

NOTIFICATION_SENT=0

while true; do
    # Citim starea (Discharging/Charging) și capacitatea
    STATUS=$(cat "$BATTERY_DIR/status")
    CAPACITY=$(cat "$BATTERY_DIR/capacity")

    # Verificăm dacă bateria se descarcă ȘI nivelul este sub pragul critic
    if [ "$STATUS" = "Discharging" ] && [ "$CAPACITY" -le "$CRITICAL_LEVEL" ]; then
        # Verificăm dacă nu am trimis deja o notificare pentru acest prag
        if [ "$NOTIFICATION_SENT" -eq 0 ]; then
           notify-send "Baterie Scăzută!" "Nivelul bateriei este de ${CAPACITY}%." -u critical

            # Setăm flag-ul pe 1 pentru a nu mai trimite notificarea
            NOTIFICATION_SENT=1
        fi
    elif [ "$STATUS" = "Charging" ] || [ "$CAPACITY" -gt "$CRITICAL_LEVEL" ]; then
        # Resetăm flag-ul dacă bateria este pusă la încărcat sau a trecut peste prag
        NOTIFICATION_SENT=0
    fi

   sleep 60
done
