IMAGE_NAME := local-devcontainer
TAG := nodejs-typescript
DOCKERFILE := .devcontainer/Dockerfile
GLOBAL_SETTINGS := $(HOME)/.vscode/devcontainer.json

# Build the dev container image
build:
	docker build -f $(DOCKERFILE) -t $(IMAGE_NAME):$(TAG) .

# Run the dev container
run:
	docker run -it --rm -v $(PWD):/workspace -p 4321:4321 $(IMAGE_NAME):$(TAG)

# Create global user settings file if it doesn't exist
create-global-settings:
	@if [ ! -f $(GLOBAL_SETTINGS) ]; then \
		mkdir -p $(HOME)/.vscode; \
		echo '{\n  "customizations": {\n    "vscode": {\n      "settings": {},\n      "extensions": []\n    }\n  }\n}' > $(GLOBAL_SETTINGS); \
		echo "Global settings file created at $(GLOBAL_SETTINGS)"; \
		echo "Please edit this file to add your personal settings and extensions."; \
		read -p "Press Enter to open the file in your default editor..."; \
		$${EDITOR:-vi} $(GLOBAL_SETTINGS); \
	else \
		echo "Global settings file already exists at $(GLOBAL_SETTINGS)"; \
	fi

# All-in-one command to build and setup
setup: build create-global-settings

# All-in-one command to build
publish: build

.PHONY: build run create-global-settings setup publish