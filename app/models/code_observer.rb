class CodeObserver < ActiveRecord::Observer
  observe :camp,
          :barrack,
          :room,
          :invoice_company,
          :contractor,
          :subcontractor
  
  def before_save(record)
    record.code.upcase!
    
    raise "Code to long" if record.code.length > 10
  end
  
end
