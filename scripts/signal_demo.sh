#!/bin/bash

cleanup() {
    echo ""
    echo "[$(date +%T)] Signal reçu : nettoyage en cours..."
    rm -f /tmp/signal_demo_*.lock
    echo "[$(date +%T)] Nettoyage terminé. Bye."
    exit 0
}

reload_config() {
    echo "[$(date +%T)] SIGHUP reçu : rechargement de la configuration..."
    # Simuler un rechargement
    sleep 1
    echo "[$(date +%T)] Configuration rechargée."
}

afficher_stats() {
    echo ""
    echo "[$(date +%T)] SIGUSR1 reçu : Statistiques courantes"
    echo " └─ Itérations complétées : $counter"
    echo " └─ Temps d'exécution     : ${SECONDS}s"
}

# Installer les gestionnaires de signaux
trap cleanup SIGTERM SIGINT
trap reload_config SIGHUP
trap afficher_stats SIGUSR1

LOCKFILE="/tmp/signal_demo_$$.lock"
touch "$LOCKFILE"
echo "[$(date +%T)] Démarrage (PID: $$). Lockfile: $LOCKFILE"
echo "Envoyez SIGHUP pour recharger, SIGUSR1 pour les stats, SIGTERM/SIGINT pour quitter."

# Boucle principale
counter=0
while true; do
    echo "[$(date +%T)] En cours... (itération $counter)"
    sleep 5
    counter=$((counter + 1))
done
