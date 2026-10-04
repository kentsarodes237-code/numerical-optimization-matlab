# Corrections appliquées

Uniquement les points identifiés lors de la relecture stricte ont été corrigés :

1. `newton_loc.m` utilise désormais réellement la recherche linéaire de Wolfe (`wolfe.m`) au lieu d'un backtracking d'Armijo seul.
2. Le compteur d'itérations de Newton compte les mises à jour effectivement réalisées, ce qui évite d'annoncer deux itérations lorsqu'un seul pas de Newton conduit déjà à l'optimum.
3. L'exercice 17 compare désormais gradient et Newton depuis plusieurs points de départ, pour `f2` et `f3`, avec trajectoires et historiques de convergence.
4. Le fichier demandé par l'énoncé est maintenant `pfd.m` (au lieu de `pdf_opti.m`) et les scripts associés utilisent bien `x0 = [9;1]`.
5. La classification analytique manquante des points critiques de `f1` est explicitée dans `testNewton.m` : les points `(0, pi/2 + k*pi)` sont des selles, tandis que `((-1)^(k+1), k*pi)` sont des minima stricts/globaux.

Aucune autre partie du projet n'a été modifiée.
