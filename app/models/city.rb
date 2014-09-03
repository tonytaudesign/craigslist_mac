class City < ActiveRecord::Base


  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
        city = City.new
        city.city = row["Name"]
        city.country = row["Country Code"]
        city.save
    end
  end

	 def self.open_spreadsheet(file)
	    case File.extname(file.original_filename)
      when '.ods' then Roo::OpenOffice.new(file.path, nil, :ignore) 	
	    when ".csv" then Roo::Csv.new(file.path)
	    when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
	    when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
	    else raise "Unknown file type: #{file.original_filename}"
	    end
	  end
end
