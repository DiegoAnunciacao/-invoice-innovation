module InvoicesHelper
  def format_name(name)
    name.squish.titleize
  end

  def format_address(address)
    address.squish.titleize
  end
end
