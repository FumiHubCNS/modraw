.PHONY: js docs

install: 
	# install the build tool for JS written in Golang
	curl -fsSL https://esbuild.github.io/dl/v0.19.11 | sh
	python -m pip install -e .
	python -m pip install twine wheel
	npm install

pypi: clean
	uv build
	uv publish

js:
	# build the JS file, only needed for the edge widget
	npm run build-draw

dev:
	npm run dev-draw

clean:
	rm -rf .ipynb_checkpoints build dist drawdata.egg-info

docs: 
	marimo export html-wasm demo.py --output docs/index.html --mode edit

serve:
	uv run python -m http.server 8000 --directory docs