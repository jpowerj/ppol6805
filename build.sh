quarto render
# First the submodule
cd dsan-globals
git add -A .
git commit -m "Auto-commit to dsan-globals submodule from dsan6750"
git push origin HEAD:main
# Now the main repo
cd ..
git add -A .
git commit -m "Auto-commit"
git push
