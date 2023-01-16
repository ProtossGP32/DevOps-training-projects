# NextCloud Docker Compose deployment
## Changes on services names

- `db` service has been renamed to `nextcloud_db` as it collisioned with the OpenProject deployment that uses the same service name

## Additional required files:

Some secret files must be created and populated for nextCloud and postgreSQL admin user and password as well as db name:

- `nextcloud_admin_user.txt`
- `nextcloud_admin_password.txt`
- `postgres_db.txt`
- `postgres_user.txt`
- `postgres_password.txt`

Create them and secure its access so nobody except the system admin can read or modify them. Review the `docker-compose.yml` file for further details on its usage.
