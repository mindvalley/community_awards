class UploadsController < ApplicationController
  def employees
    if request.post? && params[:csv].present?
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
        if employee = Employee.where(email_address: line[:email_address]).first
          employee.update_attributes! line
        else
          employee = Employee.create! line
        end
        employee.date_joined = Date.parse(employee.start_date_dd_mm_yy)

        if employee.status == nil || (employee.team && employee.team.downcase == 'executive')
          employee.votable = false
          employee.save!
        end

      end
    end
    redirect_to root_url, notice: 'CSV uploaded successfully'
  end

  def salaries
    raise params.inspect
  end
end
