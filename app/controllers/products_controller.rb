class ProductsController < ApplicationController
require 'csv'
	def product_import
		csv = Rails.root.join('public', 'prod.csv')
   		CSV.foreach(csv) do |row|
   			category=Category.find_by_category(row[3])
   			if category.present?
				a=Product.new
				a.category_id=category.id
				a.schemecode=row[0].to_i
				a.s_name=row[1]
				a.rating=row[2].to_i
				a.objective=row[4]
				a.clicks=0;
				a.save
			end
		end
	end

	def disp_product
		# product=Category.select("products.*,categories.*").joins(:products)
		product=Product.select("products.*,categories.*,sum(products_users.user_id) as sum").joins("left outer join products_users on products_users.product_id=products.id").joins("join categories").group("products.id").order("sum(products_users.user_id) desc,clicks")
		category=Category.all
		# product=ActiveRecord::Base.connection.select_all("select p.schemecode,p.rating,p.s_name,p.category,count(*) count,sum(clicks) sum from products p left outer join mappings m on m.schemecode=p.schemecode group by p.schemecode order by count(*) desc ,sum(clicks) desc")
		# category=ActiveRecord::Base.connection.select_all("select distinct(category) from products order by category")
		render :json => {:product => product,:category => category}
	end
	def ind_product
		if current_user!=nil
			product= params[:id]
			Product.where(:schemecode => product).update_all("clicks = clicks + 1")
			user=User.find(current_user.id)
			pro=Product.find_by_schemecode(product)
			user.products << pro unless post.tags.include?(pro)
			@prod_desc=Category.select("products.*,categories.*").joins(:products).where("products.schemecode = ?", product).first
		else
			redirect_to root_path
		end
	end
end
