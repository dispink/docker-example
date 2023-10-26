# Dev Container

## What we want?
1.  Executable in VScode because it's heavly adopted by many Dev projects
1.  Run in Python >= 3.10
1.  Commonly used packages (ssh sudo vim htop git python pip) are installed in default
1.  Detailed settings are automatically dealt with (like ssh and mounting)

The most efficient way to build a container is actually using Dockerfile and 
Docker CLI, which runs faster (low-level). But it requires more detailed 
knowledge and settings. Here we use Dev Container's UI to build the container 
(high-level). It's more convenient (common linux packages and folder binding 
are automatically dealt with) but slower. More importantly, it runs seamlessly 
with VScode.

# Prerequisites
-   Docker: needed on the remote server, where I run the container.
-   VScode: needed on local machine, where I code and manage.
-   Dev Container: it's a VScode extension to manage Docker containers.
-   SSH: needed on local and remote machines for connection. It can be guided to install in VScode.

# Adopt from template
1.  SSH to the remote server using VScode. The details are in [here](https://code.visualstudio.com/docs/remote/ssh).
1.  Create a folder for the project (it can alsoe be a repository).
1.  Copy the suitable template from `devcontainers` to your project folder. 
    For example: copy the configuration files (`.devcontainer`) from `cuda118` to your project folder. The `README.md` in the template folder has some brief about the template, which is optional for copying.
1.  Rebuild the container with the `Dev Container: Rebuild and Reopen in Container` command in VScode. Theoretically, VScode will automatically prompt a message to reopen the folder in a container when it detects the configuration files. Of course, the prerequistics need to be installed.
1. Run the `test.py` and `test.ipynb`, if they exist, to check if the container is working properly.

# Build from scratch
It is not the real _build from scratch_ because it incorporates
with Dev Container's conveneient UI to build the container, which help us to 
skip some trivial setups. Here we use the workflow building one of the templates, `cuda118`, to demonstrate the steps. If you want to modify the template or use the template directly to build a container, please check out the subfolders.

The idea is instructed by 
[Jimmy](https://github.com/sgylab/docker-example/blob/master/obspy/Dockerfile), 
[Microsoft Training](https://learn.microsoft.com/en-us/training/modules/use-docker-container-dev-env-vs-code/), 
and posts about implementing with [Jupyter](https://keestalkstech.com/2022/08/jupyter-notebooks-vscode-dev-container-with-puppeteer-support/) 
and [Cuda](https://alankrantas.medium.com/setup-a-nvidia-devcontainer-with-gpu-support-for-tensorflow-keras-on-windows-d00e6e204630) 
in VScode dev container.

Official documentations, [VScode Dev Container](https://code.visualstudio.com/docs/remote/containers) 
and its [json spcifications](https://containers.dev/implementors/json_reference/), are also good references to check out.


## Files to prepare
-   devcontainer.json: VScode related setting to setup a container. It can be 
    created by following Dec container's UI and has specifications for 
    installing Python and cuda and running the scripts (install-dev-tools.sh, 
    requirements.txt).
-   requirements.txt: list of Python packages to install.
-   install-dev-tools.sh: script to install Python packages.

## Steps: 
1.  SSH to the remote server using VScode. The details are in [here](https://code.visualstudio.com/docs/remote/ssh).

1.  Create a folder for the project.

1.  Create a container via `Dev container` in VScode. The details are in the **Default Python Dev Container Setup** section of 
    [the post](https://keestalkstech.com/2022/08/jupyter-notebooks-vscode-dev-container-with-puppeteer-support/). 
    The `Remote-Containers` command in the post is updated to be `Dev Container`
    in the latest VScode version while writing. Follow the instructions to select Python 3.11 and CUDA 11.8 (all cuda related packages need to be
    selected). 
    Now a container with Python and cuda is built and running. `.devcontainer` folder with `devcontainer.json` is created in the project folder.

1.  Grant the container access to the gpus by adding the codes to `devcontainer.json`:

    ```json
        "runArgs": [
            "--gpus=all"
        ],
    ``` 

1. Install VScode extensions by adding the codes to `devcontainer.json`:

    ```json
	"customizations": {
		"extensions": [
			"ms-python.python",
			"ms-toolsai.jupyter",
			"ms-toolsai.vscode-jupyter-cell-tags",
			"ms-toolsai.jupyter-keymap",
			"ms-toolsai.jupyter-renderers",
			"ms-toolsai.vscode-jupyter-slideshow",
			"ms-python.vscode-pylance",
			"GitHub.copilot",
			"GrapeCity.gc-excelviewer"
		]
	},
    ```

1.  Prepare `requirements.txt` in `.devcontainer` to list the Python packages to be installed later. The codes in the script:

    ```bash
    # For jupyter notebook
    ipython
    ipykernel

    # For ML
    tqdm
    transformers
    scikit-learn

    # For data science
    scipy
    numpy
    pandas
    openpyxl
    matplotlib
    ```

1.  Prepare `install-dev-tools.sh` in `.devcontainer` to wrap commands for installing Python packages. 
    
    The installation of torch-related packages is seperated from the
    `requirements.txt` becasue installing cuda11.8-compatible version requires
    an extra variable `--index-url https://download.pytorch.org/whl/cu118`. 
    The codes in the script:

    ```bash
    pip3 install --upgrade --user pip; 
    pip3 --no-cache-dir install --user torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118;
    pip3 --no-cache-dir install --user -r .devcontainer/requirements.txt;
    ```

1.  Add the codes to `devcontainer.json` to install Python packages:

    ```json
    "onCreateCommand": "bash .devcontainer/install-dev-tools.sh",
    ```

    If the commands are rather short, simply add codes to `devcontainer.json` without creating `install-dev-tools.sh`:

    ```json
    "onCreateCommand": "pip3 install --upgrade --user pip; pip3 --no-cache-dir install --user -r .devcontainer/requirements.txt",
    ```

1.  Add the codes to `devcontainer.json` to check if gpus are working every time the container is started:

    ```json
        "postCreateCommand": [
            "nvidia-smi"
        ]
    ```

1.  Rebuild the container with the `Dev Container: Rebuild and Reopen in Container` command in VScode. 
    Now the container is rebuilt with Python packages and cuda. 

1.  The versions and packages can be modified if needed.

P.S. Here we don't need to install the commonly used packages (ssh sudo vim htop
git python pip), setup ssh for the container, and bind the container's folder to
the operation system's folder beacuese they are all dealt with by 
`Dev Container` in default.