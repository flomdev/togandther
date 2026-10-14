# Mise en ligne sur together.army

Le site est prêt pour le domaine final. Toutes les URL SEO pointent vers `https://together.army/`
(canonical, Open Graph, sitemap, robots.txt, données structurées).

Préparer les fichiers à envoyer :

```bash
./scripts/build.sh
```

Cela crée `dist/` et `together-army-site.zip` (≈ 2,3 Mo).

---

## Option A — Vercel (recommandé)

1. Depuis `dist/` (pas besoin de Git) :
   ```bash
   cd dist && npx vercel@latest deploy --prod --yes
   ```
   À la première exécution, créer un nouveau projet nommé `together-army`
   (ne pas réutiliser `togandther-staging`).
2. Ajouter les domaines au projet :
   ```bash
   npx vercel@latest domains add together.army
   npx vercel@latest domains add www.together.army
   ```
3. Chez OVH (Web Cloud → Domaines → together.army → Zone DNS) :
   - supprimer l'enregistrement `A` actuel de `together.army` (213.186.33.5) et tout `AAAA` ;
   - ajouter `A` · sous-domaine vide · `76.76.21.21` ;
   - remplacer le `CNAME` de `www` par `cname.vercel-dns.com.`
   (Vercel affiche les valeurs exactes dans Project → Settings → Domains.)
4. Attendre la propagation (quelques minutes à quelques heures). Vercel génère le HTTPS tout seul.

`vercel.json` gère : redirection www → together.army, lien court `/billetterie`, cache et en-têtes.

## Option B — Hébergement OVH (FTP)

1. Activer le certificat SSL gratuit (Hébergement → Multisite → together.army → SSL).
2. Envoyer **le contenu** de `dist/` dans le dossier `www/` (FTP ou FileZilla), y compris
   le fichier caché `.htaccess`.
3. `.htaccess` gère : HTTPS forcé, www → together.army, lien court `/billetterie`, page 404, cache.

---

## Vérifications après mise en ligne

- [ ] `https://together.army` s'affiche, `http://` et `www.` redirigent vers `https://together.army`
- [ ] `https://together.army/billetterie` ouvre Shotgun
- [ ] `https://together.army/une-page-qui-nexiste-pas` affiche la page 404 TOG&HER
- [ ] Le code source ne contient **qu'une** balise robots : `index, follow` (pas de `noindex`)
- [ ] Aperçu de partage : https://developers.facebook.com/tools/debug/ → « Scrape Again »
- [ ] Résultat enrichi événement : https://search.google.com/test/rich-results
- [ ] Google Search Console : ajouter la propriété « Domaine » together.army (validation par
      enregistrement TXT chez OVH), puis soumettre `https://together.army/sitemap.xml`

## Après la mise en ligne

- Mettre à jour la page Shotgun : nom **TOG&HER**, lien vers together.army, contact info@together.army.
- Ajouter `https://together.army` dans la bio Instagram @together.officiel.
- Tarifs : si un billet change sur Shotgun (fin de l'Early ticket…), mettre à jour la section
  Billetterie **et** les `offers` des données structurées dans `index.html`.
- Les copies de test (staging Vercel, GitHub Pages) restent en `noindex` automatiquement.
