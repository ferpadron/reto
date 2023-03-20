# frozen_string_literal: true

##
# This is a custom class to remove a key in any deep or unknown position into a hash
#
# In this API, used at least into Exceptions Handler model to remove passwords, since parameters are shown in an email
#
# Usage:
# t = { a: '1', b: { c: '3', d: '4' } }
#
# r = t.except_nested(:c)
# r => {:a=>"1", :b=>{:d=>"4"}}
# t => {:a=>"1", :b=>{:c=>"3", :d=>"4"}}
#
class Hash
  def except_nested(key)
    r = Marshal.load(Marshal.dump(self)) # deep copy the hashtable
    r.except_nested!(key)
  end

  def except_nested!(key)
    except!(key)
    each do |_, v|
      v.except_nested!(key) if v.is_a?(Hash)
    end
  end
end
