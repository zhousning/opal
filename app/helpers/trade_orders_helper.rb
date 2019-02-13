module TradeOrdersHelper
  def state(state)
    if state == Setting.trade_orders.pending
      Setting.trade_orders.pending_title
    elsif state == Setting.trade_orders.paid
      Setting.trade_orders.paid_title
    elsif state == Setting.trade_orders.departed
      Setting.trade_orders.departed_title
    elsif state == Setting.trade_orders.completed
      Setting.trade_orders.completed_title
    elsif state == Setting.trade_orders.canceled
      Setting.trade_orders.canceled_title
    end
  end
end
