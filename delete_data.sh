#!/bin/bash
odoo="egov-odoo"
postgres="egov-db"
database="prod"

echo "=========== Start ==========="

postgres_conn="docker exec -i $postgres psql -U odoo $database"

# Stop odoo
echo  "\033[33m★\033[0m Stopping $odoo"
docker stop $odoo

# Restart postgres
echo "\n\033[33m★\033[0m Restarting $postgres"
docker restart $postgres

# Sleep 30 seconds
echo "\n\033[33m★\033[0m Sleeping next command 30 seconds"
sleep 30

############ Delete Transaction Data ############

echo "\n\033[33m★\033[0m Deleting transaction data"
$postgres_conn -c "delete from tier_review"
$postgres_conn -c "delete from stock_valuation_layer"
$postgres_conn -c "delete from stock_production_lot"
$postgres_conn -c "delete from stock_scrap"
$postgres_conn -c "delete from stock_quant"
$postgres_conn -c "delete from stock_move_line"
$postgres_conn -c "delete from stock_move"
$postgres_conn -c "delete from stock_picking"
$postgres_conn -c "delete from stock_request"
$postgres_conn -c "delete from stock_request_order"
$postgres_conn -c "delete from agreement_recital"
$postgres_conn -c "delete from agreement_section"
$postgres_conn -c "delete from agreement_clause"
$postgres_conn -c "delete from agreement_appendix"
$postgres_conn -c "delete from agreement_line"
$postgres_conn -c "delete from agreement"
$postgres_conn -c "delete from account_bank_statement_line"
$postgres_conn -c "delete from account_bank_statement"
$postgres_conn -c "delete from bank_payment_export_line"
$postgres_conn -c "delete from bank_payment_export"
$postgres_conn -c "delete from withholding_tax_cert_line"
$postgres_conn -c "delete from withholding_tax_cert"
$postgres_conn -c "delete from account_move_tax_invoice"
$postgres_conn -c "delete from account_withholding_move"
$postgres_conn -c "delete from account_payment"
$postgres_conn -c "delete from account_partial_reconcile"
$postgres_conn -c "delete from account_full_reconcile"
$postgres_conn -c "delete from expense_budget_move"
$postgres_conn -c "delete from hr_expense"
$postgres_conn -c "delete from hr_expense_sheet"
$postgres_conn -c "delete from account_budget_move"
$postgres_conn -c "delete from account_move_line"
$postgres_conn -c "delete from account_move"
$postgres_conn -c "delete from account_asset_compute_batch"
$postgres_conn -c "delete from account_asset_parent"
$postgres_conn -c "delete from account_asset_maintenance"
$postgres_conn -c "delete from account_asset_line"
$postgres_conn -c "delete from account_asset"
$postgres_conn -c "delete from contract_budget_move"
$postgres_conn -c "delete from contract_modification"
$postgres_conn -c "delete from contract_line"
$postgres_conn -c "delete from contract_contract"
$postgres_conn -c "delete from work_acceptance_committee"
$postgres_conn -c "delete from work_acceptance_evaluation_result"
$postgres_conn -c "delete from work_acceptance_line"
$postgres_conn -c "delete from work_acceptance"
$postgres_conn -c "delete from purchase_guarantee"
$postgres_conn -c "delete from purchase_budget_move"
$postgres_conn -c "delete from purchase_invoice_plan"
$postgres_conn -c "delete from purchase_order_line"
$postgres_conn -c "delete from purchase_order"
$postgres_conn -c "delete from purchase_requisition_line"
$postgres_conn -c "delete from purchase_requisition"
$postgres_conn -c "delete from purchase_request_budget_move"
$postgres_conn -c "delete from procurement_committee"
$postgres_conn -c "delete from purchase_request_allocation"
$postgres_conn -c "delete from purchase_request_line"
$postgres_conn -c "delete from purchase_request"
$postgres_conn -c "delete from sale_invoice_plan"
$postgres_conn -c "delete from sale_order_option"
$postgres_conn -c "delete from sale_order_line"
$postgres_conn -c "delete from sale_order"
$postgres_conn -c "delete from budget_balance_forward_line"
$postgres_conn -c "delete from budget_balance_forward"
$postgres_conn -c "delete from budget_commit_forward_line"
$postgres_conn -c "delete from budget_commit_forward"
$postgres_conn -c "delete from budget_move_adjustment_item"
$postgres_conn -c "delete from budget_move_adjustment"
$postgres_conn -c "delete from budget_transfer_item"
$postgres_conn -c "delete from budget_transfer"
$postgres_conn -c "delete from budget_plan_line"
$postgres_conn -c "delete from budget_plan"
$postgres_conn -c "delete from budget_allocation_line"
$postgres_conn -c "delete from budget_allocation"
$postgres_conn -c "delete from budget_control_line"
$postgres_conn -c "delete from budget_control"
$postgres_conn -c "delete from mail_tracking_value"
$postgres_conn -c "delete from mail_notification"
$postgres_conn -c "delete from mail_message"
$postgres_conn -c "delete from mail_activity"
$postgres_conn -c "delete from mail_followers"
$postgres_conn -c "delete from mail_mail"
$postgres_conn -c "delete from tier_correction_item"
$postgres_conn -c "delete from tier_correction"

#################################################

############### Delete Master Data ##############

echo "\n\033[33m★\033[0m Deleting master data"
$postgres_conn -c "delete from res_partner_bank"
$postgres_conn -c "delete from res_partner where id not in (select partner_id from res_users union select partner_id from res_company)"
$postgres_conn -c "delete from account_analytic_line"
$postgres_conn -c "delete from account_analytic_account"
$postgres_conn -c "delete from res_project_plan"
$postgres_conn -c "delete from res_project"
$postgres_conn -c "delete from hr_employee where id <> 1"
$postgres_conn -c "delete from budget_period"
$postgres_conn -c "delete from budget_template_line"
$postgres_conn -c "delete from budget_template"
$postgres_conn -c "delete from budget_kpi where id not in (1, 2)"
$postgres_conn -c "delete from budget_activity where id not in (1, 2)"
$postgres_conn -c "delete from budget_activity_keyword"
$postgres_conn -c "delete from budget_source_fund"
$postgres_conn -c "delete from budget_source_fund_group"
$postgres_conn -c "delete from ir_model_data where model = 'budget.activity' and res_id not in (select id from budget_activity)"
$postgres_conn -c "delete from ir_model_data where model = 'budget.kpi' and res_id not in (select id from budget_kpi)"
$postgres_conn -c "delete from ir_model_data where model = 'budget.source.fund' and res_id not in (select id from budget_source_fund)"
$postgres_conn -c "delete from ir_model_data where model = 'budget.source.fund.group' and res_id not in (select id from budget_source_fund_group)"
$postgres_conn -c "delete from ir_model_data where model = 'hr.employee' and res_id not in (select id from hr_employee)"
$postgres_conn -c "delete from ir_model_data where model = 'mail.message' and res_id not in (select id from mail_message)"
$postgres_conn -c "delete from ir_model_data where model = 'res.partner' and res_id not in (select id from res_partner)"
$postgres_conn -c "delete from ir_model_data where model = 'res.partner.bank' and res_id not in (select id from res_partner_bank)"
$postgres_conn -c "delete from ir_model_data where model = 'res.project' and res_id not in (select id from res_project)"

#################################################

################# Reset Sequence ################

echo "\n\033[33m★\033[0m Reset sequence number to 1"
$postgres_conn -c "update ir_sequence set number_next = 1"
$postgres_conn -c "update ir_sequence_date_range set number_next = 1"

#################################################

# Start odoo
echo "\n\033[33m★\033[0m Starting $odoo"
docker start $odoo

echo "=========== Finish ==========="
