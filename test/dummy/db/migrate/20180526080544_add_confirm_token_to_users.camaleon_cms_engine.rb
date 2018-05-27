# This migration comes from camaleon_cms_engine (originally 20151212095328)
class AddConfirmTokenToUsers < CamaManager.migration_class
  def change
    add_column CamaleonCms::User.table_name, :confirm_email_token, :string, default: nil
    add_column CamaleonCms::User.table_name, :confirm_email_sent_at, :datetime, default: nil
    add_column CamaleonCms::User.table_name, :is_valid_email, :boolean, default: true
  end
end
