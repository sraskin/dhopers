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

  RESPONSE             = {}
  RESPONSE['ERROR100'] = 'Temporary Internal Server Error. Try again later'.freeze
  RESPONSE['ERROR101'] = 'Authentication Error (Not valid login Information)'.freeze
  RESPONSE['ERROR102'] = 'No credits available'.freeze
  RESPONSE['ERROR103'] = 'MSIDSN (phone parameter) is invalid or prefix is not supported'.freeze
  RESPONSE['ERROR104'] = 'Tariff Error'.freeze
  RESPONSE['ERROR105'] = 'You are not allowed to send to that destination/country'.freeze
  RESPONSE['ERROR106'] = 'Not Valid Route number or you are not allowed to use this route'.freeze
  RESPONSE['ERROR107'] = 'No proper Authentication (IP restriction is activated)'.freeze
  RESPONSE['ERROR108'] = 'You have no permission to send messages through HTTP API'.freeze
  RESPONSE['ERROR109'] = 'Not Valid Originator'.freeze
  RESPONSE['ERROR999'] = 'Invalid HTTP Request'.freeze
  RESPONSE['INVALID'] = 'Unknown error'.freeze
  RESPONSE['OK']       = 'Sms has been sent successfully'

  def initialize(username = '', password = '', provider = '')
    @username    = username
    @password    = password
    @provider    = provider
    @balance_url = 'http://manage.muthofun.com/bulksms/getBALANCE.go'.freeze
    @send_url    = 'http://manage.muthofun.com/bulksms/bulksend.go'.freeze
    @charset     = 0
    @utc         = 0
    @msg_type    = ''
    @field_cnt   = 8
  end

  def send_sms(recipient, msg_text, showDLR = 1)
    res = nil
    query_str = "http://manage.muthofun.com/bulksms/bulksend.go?username=odesk.irfan@gmail.com&password=bonomali1247&originator=dhopers.com&phone=#{recipient}&msgtext=#{msg_text}"

    begin
      conn      = Faraday.new(:url => query_str)
      res = conn.get
    rescue => e
      return RESPONSE['INVALID']
    end

    return RESPONSE[res.body]
  end

  def test_sms_url
    'http://manage.muthofun.com/test.html'
  end

  def get_balance
    query_str = "http://manage.muthofun.com/bulksms/getBALANCE.go?username=odesk.irfan@gmail.com&password=bonomali1247&originator=dhopers.com"

    res = nil

    begin
      conn      = Faraday.new(:url => query_str)
      res = conn.get
    rescue => e
      return RESPONSE['INVALID']
    end

    return res.body
  end
end