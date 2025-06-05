return {
  settings = {
    redhat = {
      schemas = require("schemastore").yaml.schemas(),
      telemetry = {
        enabled = false,
      },
    },
  },
}
