import os, subprocess, shutil
from pathlib import Path

def main():
    print("Building Chronicle")
    subprocess.call(["dotnet", "build"])
    print("Built!")
    print("Begining DLL Discovery")
    bin_path = ".\\bin\\Debug\\net8.0-windows\\"
    for f in os.scandir("."):
        if not f.is_dir() or f.path.startswith(".\\.") or f.path == ".\\Chronicle": continue
        build_folder = Path(f.path, bin_path)
        print(f"Found {f.path.removeprefix(".\\")}")
        for dll in os.scandir(build_folder):
            if not dll.path.endswith(".dll"): continue
            if not os.path.exists(Path(os.getenv("APPDATA"), "Chronicle")):
                os.mkdir(Path(os.getenv("APPDATA"), "Chronicle"))
            if not os.path.exists(Path(os.getenv("APPDATA"), "Chronicle", "plugins")):
                os.mkdir(Path(os.getenv("APPDATA"), "Chronicle", "plugins"))
            print(f"Copied {dll.path.split('\\')[-1]}")
            shutil.copyfile(dll.path, Path(os.getenv("APPDATA"), "Chronicle", "plugins", dll.path.split('\\')[-1]))

    input("Build Complete. Press [ENTER] to close.")

if __name__ == "__main__":
    main()
