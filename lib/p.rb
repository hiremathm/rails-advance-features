class P
	def find_orders_by_cod(boolean_value)
		products = Product.where(cod_eligible: boolean_value)
		return products
	end
end