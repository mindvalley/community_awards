require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdminUploadSalaries
end

module RailsAdmin
  module Config
    module Actions
      class UploadSalaries < RailsAdmin::Config::Actions::Base
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
            if params[:csv].present? and params[:period].present?

              infile = params[:csv].read.gsub(",=", ',')
              salary_table = {}
              total_salaries = 0.0
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

                salary_table[line[:email]] = line[:salary]
                total_salaries += line[:salary].to_f
              end

              salary_table.each do |email_address, salary|
                if user = User.where(email: email_address).first
                  unless user
                    ballot = user.ballots.where(period: params[:period]).first
                    ballot.adjustment_factor = (salary.to_f / total_salaries.to_f) * 100
                    ballot.save!
                  end
                end
              end
              Ballot.schedule
            end
            @results = Ballot.compute_results(params[:period])
            if result = Result.where(period: params[:period]).first
              result.update_attributes! period: params[:period], lines: @results
            else
              result = Result.create! period: params[:period], lines: @results
            end
            flash[:success] = "Salaries successfully uploaded." if params[:csv].present? and params[:period].present?
            redirect_to back_or_index if request.post?
          end
        end
      end
    end
  end
end