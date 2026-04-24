# OpenNos — Plan de remise en service

Ce document sert de feuille de route pratique pour relancer un environnement OpenNos local et pouvoir jouer/tester.

## 1) Ce qu'il faut savoir avant de commencer

- Le projet **OpenNos** est ancien et peut dépendre d'outils .NET / MySQL versions legacy.
- Il est fréquent de devoir corriger quelques erreurs de build (packages nuget obsolètes, API dépréciées, configs manquantes).
- La manière la plus stable est de repartir d'une base locale propre et de documenter chaque correction.

## 2) Pré-requis recommandés (Linux/WSL)

- `git`
- `dotnet` SDK (plusieurs versions selon les branches)
- `mono-complete` (utile pour certains projets .NET Framework legacy)
- `mysql` (ou mariadb) local
- `redis` / `rabbitmq` selon la config du repo

## 3) Workflow conseillé

1. Cloner le dépôt d'origine dans un dossier `vendor/OpenNos`.
2. Créer un fichier `.env.local` avec:
   - host/port DB
   - user/password DB
   - ports des services login/world
3. Restaurer les dépendances (`nuget` ou `dotnet restore`).
4. Compiler (`dotnet build` / `msbuild`).
5. Démarrer les services dans l'ordre: base de données, auth/login, world/channel.
6. Créer/seed la base (script SQL si disponible).

## 4) Diagnostic rapide quand ça casse

- Erreurs de packages:
  - vider cache: `dotnet nuget locals all --clear`
  - relancer restore
- Erreurs DB:
  - vérifier encodage UTF8
  - vérifier droits SQL utilisateur
- Erreurs réseau entre services:
  - valider IP/ports en config
  - vérifier firewall local

## 5) Objectif minimal "jouable"

- build complet sans erreur
- login service up
- world service up
- client connecté sur serveur local

## 6) Itération

- Commits petits et atomiques
- Un fichier `notes/revival-log.md` pour tracer chaque fix
- Ajouter scripts d'automatisation au fur et à mesure
