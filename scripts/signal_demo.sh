--- script_original.sh	2026-06-09 15:20:00.000000000 +0200
+++ script_modifie.sh	2026-06-09 15:22:00.000000000 +0200
@@ -15,9 +15,17 @@
     echo "[$(date +%T)] Configuration rechargée."
 }
 
+afficher_stats() {
+    echo ""
+    echo "[$(date +%T)] SIGUSR1 reçu : Statistiques courantes"
+    echo " └─ Itérations complétées : $counter"
+    echo " └─ Temps d'exécution     : ${SECONDS}s"
+}
+
 # Installer les gestionnaires de signaux
 trap cleanup SIGTERM SIGINT
 trap reload_config SIGHUP
+trap afficher_stats SIGUSR1
 
 LOCKFILE="/tmp/signal_demo_$$.lock"
 touch "$LOCKFILE"
@@ -28,5 +36,5 @@
 counter=0
 while true; do
     echo "[$(date +%T)] En cours... (itération $counter)"
-    counter=$((counter + 1))
     sleep 5
+    counter=$((counter + 1))
 done