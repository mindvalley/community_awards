require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdminUploadEmployees
end

module RailsAdmin
  module Config
    module Actions
      class UploadEmployees < RailsAdmin::Config::Actions::Base
        # There are several options that you can set here. Check https://github.com/sferik/rails_admin/blob/master/lib/rails_admin/config/actions/base.rb for more info.
        register_instance_option :collection? do
          true
        end
        register_instance_option :http_methods do
          [:get, :post]
        end
        register_instance_option :controller do
          Proc.new do
            # Get all selected rows
            if request.post? && params[:csv].present?
              # Employee.destroy_all
              infile = params[:csv].read.gsub(",=", ',')
              n, errs, headers = 0, [], []
              CSV.parse(infile) do |row|
                n += 1
                if n == 1
                  headers = row.map {|i| i.to_s.downcase.parameterize.underscore.to_sym }
                  next
                end
                # skip blank row
                next if row.join.blank?

                line = {}
                headers.each_with_index {|header, index| line[header] = row[index]}

                puts line.inspect

                logger.info "importing: #{line.inspect}"
                if employee = Employee.where(email: line[:email]).first
                  employee.delete
                end

                if employee = Employee.where(email: line[:email]).first
                  employee.delete
                end
                
                # line[:email_address] = line[:email]
                employee = Employee.create! line
                Rails.logger.info employee.inspect

                begin
                  employee.date_joined = Date.parse(employee.start_date) if employee.start_date
                rescue Exception => e
                  logger.error "#{e.message} #{e.backtrace}"
                end

                if employee.status == 'intern' || employee.status == 'non-employee' || (employee.team && employee.team.downcase == 'executive')
                  employee.voteable = false
                  employee.save!
                end
              end
              flash[:success] = "#{@model_config.label} successfully uploaded."
              redirect_to back_or_index
            end
          end
        end
      end
    end
  end
end