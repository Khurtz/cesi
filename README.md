# Projet DevOps

## Description
- gestion de versions
- faire des branches
- merge de code

---

## Installation de Git

```bash
# Vérifier l'installation
git --version

# Installer Git
# https://git-scm.com/
```

## Workflow Git
 
```mermaid
gitGraph
   commit id: "Initial commit"
   branch develop
   checkout develop
   commit id: "Ajout file1, file2, file3"
   commit id: "Push develop"
   checkout main
   merge develop
   commit id: "Merge develop -> main"
   checkout develop
   commit id: "Ajout README"
   commit id: "Rename file1 + delete file3"
   checkout main
   merge develop
   commit id: "Merge final"

```
