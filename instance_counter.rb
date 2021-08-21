module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_writer :all, :instances

    def all
      @all ||= []
    end

    def instances
      @instances ||= 0
    end
  end

  module InstanceMethods
    def register_instance
      self.class.all << self
      self.class.instances += 1
    end
  end
end