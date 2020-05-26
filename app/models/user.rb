class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :assignments
  has_many :roles, through: :assignments  
  attr_accessor :login
  after_create :set_default_role
  devise :database_authenticatable, 
         :registerable,
         #:recoverable, 
         :rememberable, 
         :trackable, 
         :validatable
  
  def self.find_for_database_authentication warden_conditions
  conditions = warden_conditions.dup
  login = conditions.delete(:login)
  where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
  end
   
  #validates :nombre, :presence => true

  validates :username, :presence => true, :if => :es_empleado?

   def es_empleado?
      puts self.dni
       if Empleado.where(legajo: self.dni).empty?
        errors.add(:base, "No es empleado municipal")
       end
   end
  #validates :username, :numericality => true
  validates :dni, :uniqueness => true  #{message: 'El dni ingresado ya existe para otro usuario. Verifique'}
  validates :email, :presence => true
 #  def email_changed?
  # 	  false   	
 #  end
 private
  def set_default_role
    
    params = {user_id: User.find_by_dni(self.dni).id, role_id: Role.find_by_name('BONO_SUELDO').id}#Role.find_by_name('BONO_SUELDO')}
    Assignment.create(params)
    #self.id, Role.find_by_name('BONO_SUELDO')
  end

  #def assignment_params
   # params = {user_id: self.id, role_id: Role.find_by_name('BONO_SUELDO')}
    # params.require(:assignment).permit(self.id, Role.find_by_name('BONO_SUELDO'))
  #end

 def role?(role)
   roles.any? { |r| r.name.underscore.to_sym == role }
 end
  
end
