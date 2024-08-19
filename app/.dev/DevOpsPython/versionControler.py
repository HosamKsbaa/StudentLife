import sys
import yaml

def read_yaml_config(x):
    # Define the path to the YAML file
    yaml_file_path = f"../../assets/{x}/config.yaml"

    try:
        # Open and read the YAML file
        with open(yaml_file_path, "r", encoding="utf-8") as yaml_file:
            return yaml.safe_load(yaml_file)
    except Exception as e:
        print(f"An error occurred while reading the YAML file: {e}")
        return None

def update_gradle_properties(config):
    # Define the path to the gradle.properties file
    gradle_file_path = "../../android/key.properties"

    # Extracting the relevant details from the config
    key_alias = config["keyAlias"]
    key_password = config["keyPassword"]
    store_file = config["storeFile"]
    store_password = config["storePassword"]

    # Preparing the content to write to the gradle.properties file
    content = f"""keyAlias: {key_alias}
keyPassword: {key_password}
storeFile: {store_file}
storePassword: {store_password}
"""

    try:
        # Open the gradle.properties file in write mode
        with open(gradle_file_path, "w", encoding="utf-8") as gradle_file:
            gradle_file.write(content)
        print(f"gradle.properties has been updated.")
    except Exception as e:
        print(f"An error occurred while updating the gradle.properties file: {e}")

def update_app_name_file(x):
    # Define the content to write, replacing {x} with the actual value of x
    content = f"""import 'Constants.dart';

AppName CurrentApp = AppName.{x};
"""
    # Define the path to the file relative to the script's location
    file_path = "../../lib/lane.dart"

    try:
        # Open the file in write mode, which will overwrite the file if it exists
        with open(file_path, "w", encoding="utf-8") as file:
            file.write(content)
        print(f"File '{file_path}' has been overwritten with the new app name content.")
    except Exception as e:
        # If an error occurs, print the error message
        print(f"An error occurred while updating the app name file: {e}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <x>")
        x =''
    else:
        x = sys.argv[1]
        # Read the YAML config
    config = read_yaml_config(x)
    if config is not None:
        # Update the gradle.properties file with the config
        update_gradle_properties(config)
        # Update the app name file
        update_app_name_file(x)
    else:
        print("Failed to read the YAML configuration.")
