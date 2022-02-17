select billing_table.billing_account_id, 
billing_table.project.id,
billing_table.service.description,
billing_table.sku.description,
sum(billing_table.cost) as cost
FROM `<dataset-name>.detailed_usage_cost.<detailed-billing-table>` as billing_table,
`<dataset-name>.pricing_export.cloud_pricing_export` as pricing_table
where billing_table.billing_account_id = '' -- billing account id
and billing_table.billing_account_id = pricing_table.billing_account_id
and 'Marketplace Services' in unnest(pricing_table.product_taxonomy)
and billing_table.service.id=pricing_table.service.id
and billing_table.sku.id = pricing_table.sku.id
and invoice.month= '202201'
group by 1, 2
order by 3 desc;