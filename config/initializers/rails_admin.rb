# RailsAdmin config file. Generated on May 07, 2013 13:07
# See github.com/sferik/rails_admin for more informations
require Rails.root.join('lib', 'rails_admin_upload_employees.rb')
require Rails.root.join('lib', 'rails_admin_upload_salaries.rb')
RailsAdmin.config do |config|

  module RailsAdmin
    module Config
      module Actions
        class UploadEmployees < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)
        end
      end
    end
  end
  module RailsAdmin
    module Config
      module Actions
        class UploadSalaries < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)
        end
      end
    end
  end

  config.authenticate_with{:authenticate_user!}
  config.authorize_with :cancan, AdminAbility
  config.actions do
    # root actions
    dashboard                     # mandatory
    # collection actions
    index                         # mandatory
    new
    export
    history_index
    bulk_delete
    # member actions
    show
    edit
    delete
    history_show
    show_in_app
   
    # Set the custom action here
    upload_employees do
      # Make it visible only for article model. You can remove this if you don't need.
      visible do
        bindings[:abstract_model].model.to_s == "Employee"
      end
    end
    upload_salaries do
      # Make it visible only for article model. You can remove this if you don't need.
      visible do
        bindings[:abstract_model].model.to_s == "Employee"
      end
    end
  end

  config.model Result do
    show do
      field :period
      field :lines do
        label "Final Results"
        pretty_value do
          bindings[:view].render partial: "result"
        end
      end
    end
  end
  ################  Global configuration  ################

  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['Awards V2', 'Admin']
  # or for a more dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  # RailsAdmin may need a way to know who the current user is]
  config.current_user_method { current_user } # auto-generated

  # If you want to track changes on your models:
  # config.audit_with :history, 'User'

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, 'User'

  # Display empty fields in show views:
  # config.compact_show_view = false

  # Number of default rows per-page:
  # config.default_items_per_page = 20

  # Exclude specific models (keep the others):
  # config.excluded_models = ['User']

  # Include specific models (exclude the others):
  # config.included_models = ['User']

  # Label methods for model instances:
  # config.label_methods << :description # Default is [:name, :title]


  ################  Model configuration  ################

  # Each model configuration can alternatively:
  #   - stay here in a `config.model 'ModelName' do ... end` block
  #   - go in the model definition file in a `rails_admin do ... end` block

  # This is your choice to make:
  #   - This initializer is loaded once at startup (modifications will show up when restarting the application) but all RailsAdmin configuration would stay in one place.
  #   - Models are reloaded at each request in development mode (when modified), which may smooth your RailsAdmin development workflow.


  # Now you probably need to tour the wiki a bit: https://github.com/sferik/rails_admin/wiki
  # Anyway, here is how RailsAdmin saw your application's models when you ran the initializer:



  ###  User  ###

  config.model 'User' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your user.rb model definition

  #   # Found associations:



  #   # Found columns:

      configure :id, :integer 
      configure :first_name, :string 
      configure :last_name, :string 
      configure :email, :string 
      configure :created_at, :datetime 
      configure :updated_at, :datetime 
      configure :password, :password         # Hidden 
      configure :password_confirmation, :password         # Hidden 
      configure :reset_password_token, :string         # Hidden 
      configure :reset_password_sent_at, :datetime 
      configure :remember_created_at, :datetime 
      configure :sign_in_count, :integer 
      configure :current_sign_in_at, :datetime 
      configure :last_sign_in_at, :datetime 
      configure :current_sign_in_ip, :string 
      configure :last_sign_in_ip, :string 
      configure :auth_hash, :string 
      configure :provider, :string 
      configure :uid, :string 
      configure :info, :string 
      configure :credentials, :string 
      configure :extra, :string

  #   # Cross-section configuration:

      object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

      list do
        # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
        # items_per_page 100    # Override default_items_per_page
        # sort_by :id           # Sort column (default is primary key)
        # sort_reverse true     # Sort direction (default is true for primary key, last created first)
      end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  end

end
