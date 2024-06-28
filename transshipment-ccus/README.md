# Modelo de transbordo aplicado a CCUS no Brasil

Software necessário:
1. [Python](https://www.python.org/)
2. [Pip](https://pip.pypa.io/en/stable/)

É recomendado utilizar o [venv](https://docs.python.org/3/library/venv.html) para isolar as versões do Python. Se for utilizar, é necessário criar um novo ambiente virtual com o seguinte código: `python -m venv .venv`, que irá criar o diretório .venv nesta pasta, para ativá-lo, rode o seguinte comando: `source .venv/bin/activate`. Para sair do ambiente virtual, rode o seguinte comando: `deactivate`

Após instalar os oftwares, é necessário instalar o pacote pulp, que está em `requirements.txt` por meio do pip. Para instalar, rode o seguinte código: `pip install -r requirements.txt`.

Após isso, é possível rodar o código com este comando: `python src/transshipment.py`