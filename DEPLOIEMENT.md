# Mise en ligne sur together.army

Le site est prêt pour le domaine final. Toutes les URL SEO pointent vers `https://together.army/`
(canonical, Open Graph, sitemap, robots.txt, données structurées).

## 1. Préparer les fichiers

```bash
./scripts/build.sh
```

Crée `dist/` et `together-army-site.zip` (≈ 2,3 Mo) pour Netlify.
(`./scripts/build.sh vercel` ou `./scripts/build.sh ovh` pour les autres hébergeurs.)

## 2. Publier sur Netlify

**Glisser-déposer (le plus simple)**

1. https://app.netlify.com → **Add new site → Deploy manually**
2. Glisser le dossier **`dist/`** (ou le zip) dans la zone de dépôt.
3. Site configuration → **Change site name** : par ex. `together-army`.

**Ou en ligne de commande**

```bash
npx netlify-cli@latest login
npx netlify-cli@latest deploy --dir=dist --prod
```

`_redirects` et `_headers` sont pris en compte automatiquement :
www → together.army, lien court `/billetterie` → Shotgun, cache des images, en-têtes de sécurité.
La page `404.html` est servie automatiquement.

## 3. Brancher le domaine

1. Netlify → Domain management → **Add a domain** → `together.army`
   (Netlify ajoute aussi `www.together.army`). Choisir **together.army** comme domaine principal.
2. Chez OVH (Web Cloud → Noms de domaine → together.army → **Zone DNS**) :
   - supprimer l'enregistrement `A` actuel de `together.army` (213.186.33.5) et tout `AAAA` ;
   - ajouter : `A` · sous-domaine vide · `75.2.60.5` ;
   - `www` : `CNAME` → `<nom-du-site>.netlify.app.` (ex. `together-army.netlify.app.`)
   Netlify affiche les valeurs exactes dans Domain management.
3. Attendre la propagation (quelques minutes à quelques heures), puis dans Netlify →
   Domain management → HTTPS → **Verify DNS / Provision certificate** (Let's Encrypt, gratuit).

## 4. Vérifications après mise en ligne

- [ ] `https://together.army` s'affiche ; `www.` et `http://` redirigent vers `https://together.army`
- [ ] `https://together.army/billetterie` ouvre Shotgun
- [ ] `https://together.army/une-page-qui-nexiste-pas` affiche la page 404 TOG&HER
- [ ] Le code source ne contient **qu'une** balise robots : `index, follow`
      (sur `*.netlify.app`, une balise `noindex` est ajoutée automatiquement : c'est normal)
- [ ] Aperçu de partage : https://developers.facebook.com/tools/debug/ → « Scrape Again »
- [ ] Résultat enrichi « événement » : https://search.google.com/test/rich-results
- [ ] Google Search Console : propriété « Domaine » together.army (validation par TXT chez OVH),
      puis soumettre `https://together.army/sitemap.xml`

## Après la mise en ligne

- Mettre à jour la page Shotgun : nom **TOG&HER**, lien vers together.army, contact info@together.army.
- Ajouter `https://together.army` dans la bio Instagram @together.officiel.
- Tarifs : si un billet change sur Shotgun (fin de l'Early ticket…), mettre à jour la section
  Billetterie **et** les `offers` des données structurées dans `index.html`, puis relancer
  `./scripts/build.sh` et redéployer `dist/`.
- Les copies de test (staging Vercel, GitHub Pages, `*.netlify.app`) restent en `noindex`.
