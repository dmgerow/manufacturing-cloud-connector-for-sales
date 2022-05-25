# Manufacturing Cloud Connector for Sales

[AppExchange Listing](https://appexchange.salesforce.com/appxListingDetail?listingId=a0N4V00000II6Y1UAL)

[Additional documentation in Quip](https://salesforce.quip.com/67hZAQvgiwvM)

[Github repository](https://github.com/dmgerow/manufacturing-cloud-connector-for-sales)

**Note: If you install the managed package, prepend the `MfgConnect` namespace to all fields and class names below**

This connector is used to facilitate the conversion of a Quote to a Sales Agreement. Its primary purpose is to convert Quote Lines to Sales Agreement Products on an already created Sales Agreement record. When invoked, it does the following:

1. Queries all quote lines related to the Quote ID in the `Quote__c` field on the provided Sales Agreements
2. For each quote line, a new Sales Agreement Product is created using either the default mappings, or the custom mapping plugin noted in `QuoteLineToSalesAgreementProductMapping__c` setting in the package settings
3. If a Sales Agreement Product already exists for the Quote Line’s PriceBookEntryId, the records are merged. This is because a PriceBookEntry can only exist on a Sales Agreement once.
4. The new Sales Agreement Products are inserted.

## Roadmap

- [ ] CPQ Support
- [ ] Changing default product schedules

## Setup and Usage

**Important: This needs to be added to a flow or a trigger to work. There is no automation included in this package.**

This code can be installed via managed package, or installed directly from source. In order to install this, your org must have:

- [Quotes enabled](https://help.salesforce.com/s/articleView?id=sf.quotes_enable.htm&type=5)
- [Sales Agreements enabled](https://help.salesforce.com/s/articleView?id=sf.sa_admin_enable_task.htm&type=5)

The functionality can be invoked in two ways

- Invocable Apex Action (Flow)
- From Apex (Code)

Currently, the connector will inserts new price book entries. It does not handle updates and therefore should only be run once per Sales Agreement (unless all products are removed from a Sales Agreement before running again).

### Flow Action

**This should only be used with a screen flow or after save flow.**

The Flow Action is named `Create Sales Agreement Products from Quote`. It is bulkified.

- Input: One or many Sales Agreements
- Return: None

In the event of an error within the action, an exception will be thrown. This should be handled with a fault connector.

### Apex Trigger

**This should only be run in the in the after insert context or from outside of a trigger context.**

An example of adding this to a trigger can be seen below:

```java
trigger SalesAgreementTrigger on SalesAgreement(after insert) {
    switch on Trigger.operationType {
        when AFTER_INSERT {
            QuoteToSalesAgreementService.createSalesAgreementProducts(Trigger.new);
        }
    }
}
```

### Mapping Plugins

You can create a custom mapping plugin that allows you to:

- Set the field mappings from quote line to sales agreement product
- Determine which fields should have a weighted average when merged by price book entry
- Determine which fields should be summed when merged by price book entry

An example of a mapping plugin can be seen below. Note this contains the default mappings:

```java
public with sharing class QuoteLineToSalesAgreementProductMapping implements FieldMappingConfiguration {
    public static Map<String, String> sourceToTargetMapping() {
        return new Map<String, String>{
            'PriceBookEntryId' => 'PriceBookEntryId',
            'ProductName__c' => 'Name',
            'Quantity' => 'InitialPlannedQuantity',
            'UnitPrice' => 'SalesPrice'
        };
    }
    public static Set<String> fieldsToSumOnMerge() {
        return new Set<String>{ 'InitialPlannedQuantity' };
    }
    public static Set<String> fieldsToWeightedAverageOnMerge() {
        return new Set<String>{ 'SalesPrice' };
    }
}
```

After creating a mapping plugin, you can copy the name of the Apex Class to the appropriate setting in the settings page.

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

**Note: the connector does not do anything out of the box. It needs to be invoked via apex or flow (see [Setup and Usage](https://salesforce.quip.com/67hZAQvgiwvM#temp:C:LQZc2e2935b20e8417cb3a514e9c))**

1. Run `npm install` (only required after cloning project for the first time)
2. Create scratch org
3. Push source `sfdx force:source:push`
4. Assign permission sets `sfdx force:user:permset:assign -n "ManufacturingSalesAgreementsPsl,ManufacturingCloudConnecterForSales"`
5. Seed sample data `sfdx force:apex:execute -f scripts/apex/data-setup.apex`
6. Add products to your newly created quote
7. Perform development/testing as needed

There is no page layout metadata in this project. You will need to manually add the custom fields to your layouts.

## Terms & Conditions

THIS APPLICATION IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, CONSEQUENTIAL OR SIMILAR DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS APPLICATION, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

SUBJECT TO THE FOREGOING, THIS APPLICATION MAY BE FREELY REPRODUCED, DISTRIBUTED, TRANSMITTED, USED, MODIFIED, BUILT UPON, OR OTHERWISE EXPLOITED BY OR ON BEHALF OF SALESFORCE.COM OR ITS AFFILIATES, ANY CUSTOMER OR PARTNER OF SALESFORCE.COM OR ITS AFFILIATES, OR ANY DEVELOPER OF APPLICATIONS THAT INTERFACE WITH THE SALESFORCE.COM APPLICATION, FOR ANY PURPOSE, COMMERCIAL OR NON-COMMERCIAL, RELATED TO USE OF THE SALESFORCE.COM APPLICATION, AND IN ANY WAY, INCLUDING BY METHODS THAT HAVE NOT YET BEEN INVENTED OR CONCEIVED.
