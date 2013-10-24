# Usage

__Important :__ This setup is unsuitable for production use. It's only meant to simplify development.

```
vagrant up
vagrant ssh

# To initialize Tiki versions
activate 12 branches/12.x   # For Tiki 12
activate 13 trunk           # For 13/trunk/next

# To switch between them in the shell / Update local version
activate 12
activate 13

# Using the console
tiki database:update          # tiki is set as an alias for convenience
```

Each version must be initialized independently. They are available on port 80xx where xx is the version number.

The database connection is assigned through an environment variable, no need for db/local.php

- Tiki 12 is on http://localhost:8012
- Tiki 13 is on http://localhost:8013
- ...
- phpMyAdmin is on http://localhost:8100 (no authentication)
