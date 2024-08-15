quarto render
# First the submodule
cd dsan-globals
git add -A .
git commit -m "Auto-commit"
git push
# Now the main repo
cd ..
git add -A .
git commit -m "Auto-commit"
git push
