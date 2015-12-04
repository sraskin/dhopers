class SmsService

  ORIGINATOR = 'Dhopers'.freeze

  attr_reader :username
  attr_reader :password
  attr_reader :provider
  attr_reader :balance_url
  attr_reader :send_url
  attr_reader :charset
  attr_reader :utc
  attr_reader :msg_type
  attr_reader :field_cnt

  ERRORS             = {}
  ERRORS['ERROR100'] = 'Temporary Internal Server Error. Try again later'.freeze
  ERRORS['ERROR101'] = 'Authentication Error (Not valid login Information)'.freeze
  ERRORS['ERROR102'] = 'No credits available'.freeze
  ERRORS['ERROR103'] = 'MSIDSN (phone parameter) is invalid or prefix is not supported'.freeze
  ERRORS['ERROR104'] = 'Tariff Error'.freeze
  ERRORS['ERROR105'] = 'You are not allowed to send to that destination/country'.freeze
  ERRORS['ERROR106'] = 'Not Valid Route number or you are not allowed to use this route'.freeze
  ERRORS['ERROR107'] = 'No proper Authentication (IP restriction is activated)'.freeze
  ERRORS['ERROR108'] = 'You have no permission to send messages through HTTP API'.freeze
  ERRORS['ERROR109'] = 'Not Valid Originator'.freeze
  ERRORS['ERROR999'] = 'Invalid HTTP Request'.freeze

  def initialize(username = '', password = '', provider = '')
    @username    = username
    @password    = password
    @provider    = provider
    @balance_url = 'http://217.118.27.5/bulksms/getBALANCE.go'.freeze
    @send_url    = 'http://217.118.27.5/bulksms/bulksend.go'.freeze
    @charset     = 0
    @utc         = 0
    @msg_type    = ''
    @field_cnt = 8
  end

  def send_sms(recipient, msg_text, showDLR = 1)
    query_str =  "/?username=#{self.username}&password=#{self.password}&charset=#{self.charset}&msgtext=#{msg_text}&originator=#{ORIGINATOR}&phone=#{recipient}&provider=#{self.provider}&showDLR=#{showDLR}&msgtype=#{self.msg_type}"
  end
end