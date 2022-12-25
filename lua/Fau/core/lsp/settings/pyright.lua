-- https://github.com/microsoft/pyright/blob/main/docs/settings.md
return {
	settings = {
		pyright = {
			disableLanguageServices = false,
			disableOrganizeImports = false,
		},
		python = {
			analysis = {
				autoImportCompletions = true,
				autoSearchPaths = true,

				diagnosticMode = "openFilesOnly", -- values: workspace|openFilesOnly
				-- diagnosticSeverityOverrides = {},

				-- extraPaths = {},
				-- typeshedPaths = {},
				-- stubPath = "",

				-- logLevel = "Information",  -- values: Error|Warning|Information|Trace

				typeCheckingMode = "basic", -- values: off|basic|strict

				useLibraryCodeForTypes = false,
			}
		}
	}
}