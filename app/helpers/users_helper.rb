module UsersHelper
  def level_image(level)
    if 0 <= level && level < 300
      'vb1.png'
    elsif 300 <= level && level < 1000  
      'vb2.png'
    elsif 1000 <= level && level < 5000  
      'vb3.png'
    elsif 5000 <= level && level < 10000  
      'vb4.png'
    elsif 10000 <= level
      'vb5.png'
    end
  end
    
  def level_title(level)
    if 0 <= level && level < 300
      '青铜茶主'
    elsif 300 <= level && level < 1000  
      '白银茶主'
    elsif 1000 <= level && level < 5000  
      '黄金茶主'
    elsif 5000 <= level && level < 10000  
      '铂金茶主'
    elsif 10000 <= level
      '钻石茶主'
    end
  end
end
