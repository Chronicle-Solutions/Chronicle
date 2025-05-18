# Chronicle
<em>Developed by Chornicle Software Solutions</em>


## Overview
Briefly describe what your project does and its main features.

## Table of Contents
- [Requirements](#requirements)
- [Installation](#installation)
    - Chronicle Security Application
    - Chronicle Desktop App
- [Usage](#usage)
- [Features](#features)
- [Contributing](#contributing)
- [License](#license)

## Requirements

The <em>Chronicle Software Suite</em> requires the following items before installation:

* Windows 8+
* [.NET SDK 8.0 and .NET Runtime](https://dotnet.microsoft.com/en-us/download)
* [MariaDB 10.5 or later](https://mariadb.com/downloads/)
* [Python3.12 or later](https://www.python.org/downloads/)
* A reverse proxy, such as Apache or NGINX on UNIX systems, or IIS for Windows Systems.

## Installation
The <em>Chronicle Software Suite</em> comes in two parts. The first part is referred to as the <em>Chronicle Security Application</em>, or the *CSA* and handles all sign-in actions in a secure manner. The second part is referred to as the <em>Chronicle Desktop App</em> or *CDA*, which is the User Interface that typical users will utilize.

### Installing the *Chronicle Security Application*

The Chronicle Security Application is a cross-platform application that is able to run on Windows, Linux, MacOS, or any server that can run Python. This guide will be mostly focused on installing to a UNIX machine.

To start, clone the Chronicle Security Application repository to your computer.
``` bash
git clone https://github.com/Chronicle-Solutions/Chronicle-Authentication-Server.git

cd Chronicle-Authentication-Server

python -m venv .venv
```

If Python is not found on your computer, please ensure that it is installed. If it still not able to be found, please try the following:
* `python3.12 -m venv .venv`
* `python3.13 -m venv .venv`
* `py -m venv .venv`
* `python3 -m venv .venv`

After this:
* If you are on a Windows computer, please run `.\.venv\Scripts\Activate.ps1`

* If you are on MacOS or Linux, please run `source .venv\bin\activate`

Next, install the required packages. `pip install -r requirements.txt`

If you are only testing the Chronicle Software Suite, start an instance of the CSA with `flask run --host 0.0.0.0`.

Please note that this method server is not intended to be used on production systems. It was designed especially for development purposes and performs poorly under high load. As such, it is recommended that you use a dedicated WSGI server, which can handle simultaneous requests.

The CSA comes bundled with two of these WSGI alternatives. They are called `Gunicorn` and `Waitress`. If you are deploying your CSA on a Windows Server, please use Waitress, as Gunicorn is not supported on Windows.

#### Deploying the CSA

To deploy the CSA, we recommend using a reverse proxy, such as NGINX, Apache Web Server, or IIS. If you are on Windows, please follow the steps below. If you are on a UNIX system, please skip to the `UNIX Setup` section.
##### Windows Setup

To start, we must start our WSGI Server. To do this, run:

```
waitress-serve --host 0.0.0.0 app:app
```

This can be converted into a Windows Service with the `sc.exe` command, however we will not be focusing on this for current deployments..

Next, using IIS or another Reverse Proxy Server, create a rule that will redirect all traffic to `http://localhost:8080`. The application allows for the incoming request URL to not match the path of the target. For example:

| Request URI                                     | Target URI                         |
|-------------------------------------------------|------------------------------------|
| http://localhost/chronicle/environments         | http://localhost:8080/environments |
| http://example.com/applications/chronicle/login | http://localhost:8080/login        |

In other words, so long as the reverse proxy removes all the non-CSA designated path components, the CSA will still accurately route all requests.


Congrats! Our authentication server will now be able to handle requests! Now lets configure our Authentication Information.

---

##### Unix Setup

To begin the configuration on a UNIX machine, first we want to create a systemd service to run our server.

We recommend using the following template for your service:
```
[Unit]
  Description=Chronicle Security Application Service - Handles all requests to authenticate with the Chronicle Software Suite.
  After=network.target

  [Service]
  User=www
  Group=www-data
  WorkingDirectory=<Chronicle Security Path>
  Environment=\"PATH=<Chronicle Security Path>/.venv/bin\"
  ExecStart=<Chronicle Security Path>/.venv/bin/gunicorn --workers 3 --bind unix:app.sock -m 007 app:app
  Restart=on-failure
  RestartSec=5s

  [Install]
  WantedBy=multi-user.target
  ```

  Next, setup NGINX or Apache for a reverse proxy. Your proxy should point to the Unix Sock File of: `<Chronicle Security Path>/app.sock`.

  The application allows for the incoming request URL to not match the path of the target. For example:

| Request URI                                     | Target URI                         |
|-------------------------------------------------|------------------------------------|
| http://localhost/chronicle/environments         | http://localhost:8080/environments |
| http://example.com/applications/chronicle/login | http://localhost:8080/login        |

In other words, so long as the reverse proxy removes all the non-CSA designated path components, the CSA will still accurately route all requests.


Congrats! Our authentication server will now be able to handle requests! Now lets configure our Authentication Information.

##### Auth Configurations

The Chronicle Security Application allows for many useful features, such as separate environments to be deployed at the same time. The information for these environments are stored in a SQLite Database called db.sqlite.

The Chronicle Software Suite requires at least one environment to be configured for the software to work.

We will go over creating environments in the Installation of the Chronicle Desktop Application.


### Installing the *Chronicle Desktop Application*

The Chronicle Desktop Application or the CDA is the End-User's method of interacting with Chronicle. The main application provides authentication functions and a plugin loader. All other features are handled through plugins. For more information on plugins, check out the "PluginGuide.md" file.

There are two ways to install the CDA. The first is using the `Install.msi` file. This will install the core Chronicle App, as well as the starter plugins. These plugins contain:

* Operator Management
* Object Security
* Building and Room Management
* Resource Management (To be added)
* Reservation and Booking Management (To be added)

The installer will also assist in setting up your `clientID` and your Authentication Server. The Client ID is a unique identifier generated by the installer to be used during the authentication process. It allows the assignment of specific environments to certain machines. Please note that the clientID is machine specific, and not user specific. The data is stored in the registry at `HKEY_LOCAL_MACHINE\SOFTWARE\ChronicleSoftware` in the key labeled `clientID`. It is not recommended to change this value unless you understand the implications of such a change.

The `Install.msi` file can be found in the Github Releases of the Chronicle repository.


Additionally, Chronicle supports building code directly from the source. For this, ensure that the .NET 8.0 SDK is installed and accessible by the current user.

``` ps
git clone --recurse-submodules git clone https://github.com/Chronicle-Solutions/Chronicle.git

cd Chronicle

dotnet build
```

The above code will clone the repository and all it's submodules, then build the solution. By default, dotnet will build all standard plugins and copy them to the user's AppData folder.

Finally, update the following registry keys:

`HKEY_LOCAL_MACHINE\SOFTWARE\ChronicleSoftware` clientID should contain a UUID that will act as the Authentication Client Identifier
`HKEY_CURRENT_USER\SOFTWARE\ChronicleSoftware` authServer should contain the URI of the Authentication Server.

## Database Initialization

This software is configured to connect to a MariaDB or MySQL server. We recommend utilizing a MariaDB 10.5 or newer server.

The setup file for this software can be found in the `setup.sql` file. To install, connect to the MariaDB or MySQL Server using your preferred Database Management Tool, such as MySQL Workbench or Datagrip, or through the command line.

Once you have connected to the database, create a new schema, then run the contents of the setup.sql file. This file will create the table structure, as well as a default operator and class.

Next, you must create two sign-ons for the database.
1. Create an account for authentication. This should only have **select** access for the OPERATORS and ACCESS_PROFILES tables.
2. Create an account for an Access Profile. This should have select, update, insert and delete access for all tables.

Create a record in the `ACCESS_PROFILES` table with the information from your Access Profile Account. Then, update the default user (`operatorID = ''`) to use this new Access Profile.

Using the `environmentManager.py` script in the ChronicleAuth folder, create a new global environment using the credentials for the authentication account.

You should now be able to load the Chronicle.exe app and sign in using the default account (no username, no password). We highly recommend updating this user's password to something more secure. You can do this by navigating to the following path: `System Administration -> Security -> Operators`, then `File -> Open` and selecting the default account.

## Usage
Provide examples and instructions for using your project.

```bash
npm start
```

## Features
- Feature 1
- Feature 2
- Feature 3

## Contributing
Explain how others can contribute to your project.

## License
State the license under which your project is distributed.
