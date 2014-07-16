class Bodie < ActiveRecord::Base
  YOUR_OBJECTIVE = [ "Набор мышечной массы", "Выносливость", "Сушка", "Увелечение силы"]
  
  validates :pol, :objective, :age, :fat, :bol, :kind_sport, presence: true
  validates :objective, inclusion: YOUR_OBJECTIVE
  
  
end 
