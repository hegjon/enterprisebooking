class CodeObserver < ActiveRecord::Observer
  observe :camp,
          :barrack,
          :room,
          :invoice_company,
          :contractor,
          :subcontractor
  
  def before_save(record)
    if code = record.code
      code.upcase!
    
      raise "Code to long" if code.length > 10
    end
  end
  
end
