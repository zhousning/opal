module UsersHelper
  def level_image(level)
    if 0 <= level && level < 500
      'vb1.png'
    elsif 500 <= level && level < 2000  
      'vb2.png'
    elsif 2000 <= level && level < 10000  
      'vb3.png'
    elsif 10000 <= level && level < 50000  
      'vb4.png'
    elsif 50000 <= level
      'vb5.png'
    end
  end
    
  def level_title(level)
    if 0 <= level && level < 500
      '青铜茶主'
    elsif 500 <= level && level < 2000  
      '白银茶主'
    elsif 2000 <= level && level < 10000  
      '黄金茶主'
    elsif 10000 <= level && level < 50000  
      '铂金茶主'
    elsif 50000 <= level
      '钻石茶主'
    end
  end
end
