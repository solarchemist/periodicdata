# JSON Schema

I want to avoid specifying the name of each and every elemental property in the schema,
because having to update the schema every time we add a new property would really
drag the whole process down.

But note that that choice means that we cannot constrain the `value` field
in *any* elemental property, as that would necessarily require a per-property
schema.

I might end up changing my mind down the line, but at present
**the schema constrains everything in YAML except the `value` field**.



## Validation

The `pajv` command returns an informative message and return code `0` (valid JSON):
```
taha@luxor:/media/bay/taha/chepec/chetex/common/R/periodicdata
(json-schema *) $ pajv validate -s tools/schema.json -d inst/extdata/periodicdata.yml
inst/extdata/periodicdata.yml valid
taha@luxor:/media/bay/taha/chepec/chetex/common/R/periodicdata
(json-schema *) $ echo $?
0
```

or return code `1` for invalid JSON:
```
taha@luxor:/media/bay/taha/chepec/chetex/common/R/periodicdata
(json-schema *) $ pajv validate -s tools/schema.json -d inst/extdata/periodicdata.yml
inst/extdata/periodicdata.yml invalid
[
  {
    keyword: 'required',
    dataPath: "['Name']",
    schemaPath: '#/patternProperties/%5E%5BA-Z%5D%5BA-Za-z_%5D%2B%24/required',
    params: { missingProperty: 'title' },
    message: "should have required property 'title'"
  }
]
taha@luxor:/media/bay/taha/chepec/chetex/common/R/periodicdata
(json-schema *) $ echo $?
1
```



## Links and notes

+ https://git.solarchemist.se/taha/periodicdata/issues/30
+ https://github.com/orgs/json-schema-org/discussions/591 - Enforce the required keys based on a regex pattern #591
+ https://stackoverflow.com/questions/36629866/json-schema-anyof-validation-based-on-one-of-properties - JSON schema anyOf validation based on one of properties
+ https://stackoverflow.com/questions/36985970/is-it-possible-to-write-a-generic-json-schema - Is it possible to write a generic JSON Schema?
+ https://xyzmaps.github.io/xyz-documentation/api/concepts/jsonschema
+ https://benbrougher.tech/posts/json-schemas-tutorial
+ https://github.com/orgs/json-schema-org/discussions/230 - How do you define generic-like schemas? #230


### Docs

+ https://tour.json-schema.org/content/03-Objects/02-Additional-Properties
+ https://tour.json-schema.org/content/08-Annotating-JSON-Schemas/04-format-and-examples
+ https://json-schema.org/understanding-json-schema/keywords
+ https://www.learnjsonschema.com/2020-12/applicator/patternproperties
+ https://json-schema.org/understanding-json-schema/structuring#dollarref


### Schema validation

```
$ pajv validate -s tools/schema.json -d inst/extdata/periodicdata.yml
inst/extdata/periodicdata.yml valid
```

+ https://json-schema-everywhere.github.io/yaml - Schema Validation for YAML
+ https://www.npmjs.com/package/pajv - nodejs CLI validator for JSON, YAML, etc.
