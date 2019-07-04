class UserController < ApplicationController
  def index
    users = User.all
    render json: users
  end

  def create
    data = Roo::Excelx.new(params[:file].original_filename)
    users = []
    ((data.first_row + 1)..(data.last_row)).each do |row_number| # start loop from the second row, as first row has headings and map the data to local varaibles
      user_data =  data.row(row_number)
      users.push({firstname: user_data[0], lastname: user_data[1], age: user_data[2], sex: user_data[3]})
    end
    render json: User.create(users)
  end
end
