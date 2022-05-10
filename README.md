# Manufacturing Cloud Connector for Sales

This connector is used to facilitate the conversion of a Quote to a Sales Agreement. The functionality can be invoked in two ways

- Invocable Apex Action (Flow)
- From Apex (Code)

## Code Style and Formatting

1. Install recommended extensions in `.vscode/extensions.json`
2. Make sure below workspace settings exist in `.vscode/settings.json`

```json
{
  "editor.codeActionsOnSave": { "source.fixAll": true },
  "eslint.format.enable": true,
  "eslint.lintTask.enable": true,
  "apexPMD.rulesets": ["pmd/pmd_rules.xml"]
}
```

## Developer Setup

1. Run `npm install` (only required after cloning project for the first time)
2. Create scratch org
3. Push source `sfdx force:source:push`
4. Assign permission sets `sfdx force:user:permset:assign -n "ManufacturingSalesAgreementsPsl,ManufacturingCloudConnecterForSales"`
5. Seed sample data `sfdx force:apex:execute -f scripts/apex/data-setup.apex`

## Org Setup (After Develop Setup)

1.
