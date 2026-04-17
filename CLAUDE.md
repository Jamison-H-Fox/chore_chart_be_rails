# Chore Chart API — Claude Notes

## OpenAPI / Swagger Docs

After implementing new endpoints, write a matching rswag spec in `spec/requests/api/v1/`, then regenerate the doc:

```
RAILS_ENV=test bundle exec rake rswag:specs:swaggerize
```

The generated file lives at `swagger/v1/swagger.yaml` and can be imported directly into Postman. It is git-tracked and should be committed alongside any new endpoint work.
