drupal_deps Cookbook
==============
This cookbook installs any Drupal dependencies.

Usage
-----
#### drupal_deps::default

Just include `drupal_deps` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[drupal_deps]"
  ]
}
```

License and Authors
-------------------
Authors: M Parker
