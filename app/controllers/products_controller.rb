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
		category=ActiveRecord::Base.connection.select_all("select distinct(category) from products order by category")
		render :json => {:product => product,:category => category}
	end
	def ind_product
		if current_user!=nil
			product= params[:id]
			mapping=Mapping.where(:user_id => current_user.id , :schemecode => product).first
			if mapping.present?
				count=mapping.clicks+1
				ActiveRecord::Base.connection.update("update mappings set clicks="+count.to_s+" where user_id="+current_user.id.to_s+" and schemecode="+product.to_s)
			else
				mapping=Mapping.new
				mapping.user_id=current_user.id
				mapping.schemecode=product
				mapping.clicks=1
				mapping.save
			end
			@prod_desc=Product.find_by_schemecode(product)
		else
			redirect_to root_path
		end
	end
end
