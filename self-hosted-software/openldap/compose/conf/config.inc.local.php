<?php
// A random keyphrase is required to initialize the service
$keyphrase = getenv('SSP_KEYPHRASE');
$debug = false;

// LDAP server config
$ldap_url = "ldap://openldap:1389";
$ldap_starttls = false;
$ldap_binddn = "cn=admin,dc=protossnet,dc=local";
$ldap_bindpw = getenv('LDAP_BIND_PASSWORD');

$ldap_base = "ou=users,dc=protossnet,dc=local";
$ldap_login_attribute = "uid";
$ldap_fullname_attribute = "displayName";
$ldap_filter = "(&(objectClass=inetOrgPerson)($ldap_login_attribute={login}))";

// Password policies that new passwords must comply
$pwd_min_length = 8;
$pwd_max_length = 16;
$pwd_min_lower = 1;
$pwd_min_upper = 1;
$pwd_min_digit = 1;
$pwd_min_special = 1;
$pwd_special_chars = "^@%!-_";
$pwd_no_reuse = true;
$pwd_diff_login = true;
$pwd_diff_last_min_chars = 0;
$pwd_no_special_at_ends = false;

// "manager" means that the user defined in ldap_binddn is the responsible of
// changing the user's passwords within LDAP (the rest of users don't have enough privileges)
$who_change_password = "manager";
$lang = "en";
$allowed_lang = array("en");
?>