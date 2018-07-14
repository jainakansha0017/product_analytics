class ProductsController < ApplicationController
require 'csv'
	def product_import
		csv = Rails.root.join('public', 'prod.csv')
   		CSV.foreach(csv) do |row|
			a=Product.new
			a.schemecode=row[0].to_i
			a.s_name=row[1]
			a.rating=row[2].to_i
			a.category=row[3]
			a.objective=row[4]
			a.save
		end
	end

	def disp_product
		product=ActiveRecord::Base.connection.select_all("select p.schemecode,p.rating,p.s_name,p.category,count(*) count,sum(clicks) sum from products p left outer join mappings m on m.schemecode=p.schemecode group by p.schemecode order by count(*) desc ,sum(clicks) desc")
		render :json => {:product => product}
	end
end
