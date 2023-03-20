# frozen_string_literal: true

module FedexSrv
  ##
  # Main class of this gem
  class Rates
    FEDEX_URL = 'https://wsbeta.fedex.com:443/xml'

    def self.get(credentials, quote_params)
      res = Hash.from_xml(Nokogiri::XML(remote_data(fedex_params(credentials, quote_params))).to_s)['RateReply']
      raise res['Notifications']['Message'] unless res['RateReplyDetails']

      res['RateReplyDetails'].map { |rate| build_a_rate(rate) }.compact
    rescue StandardError => e
      { message: "Error: #{e.message}." }
    end

    def self.remote_data(url_params)
      req = Net::HTTP.post(URI(FEDEX_URL), url_params, 'Content-Type' => 'application/xml')
      raise "Fedex server answered with code: #{req.code} instead 200" unless req.is_a?(Net::HTTPSuccess) && req.body

      req.body
    end

    def self.build_a_rate(rate)
      srv_type = rate['ServiceType']
      name = srv_type.split('_').map(&:capitalize).join(' ')
      price = 0
      rate['RatedShipmentDetails'].each do |det|
        next if det['ShipmentRateDetail']['CurrencyExchangeRate']['Rate'] != '1.0'

        price = det['ShipmentRateDetail']['TotalNetChargeWithDutiesAndTaxes']['Amount'].to_f
      end
      price.positive? ? { price:, currency: 'MXN', service_level: { name:, token: srv_type } } : nil
    end

    def self.fedex_params(credentials, qps)
      %(<RateRequest xmlns="http://fedex.com/ws/rate/v13">#{fedex_authentication(credentials)}
      <Version><ServiceId>crs</ServiceId><Major>13</Major><Intermediate>0</Intermediate><Minor>0</Minor></Version>
      <ReturnTransitAndCommit>true</ReturnTransitAndCommit>
      <RequestedShipment><DropoffType>REGULAR_PICKUP</DropoffType><PackagingType>YOUR_PACKAGING</PackagingType>
      #{shipper(qps)}#{recipient(qps)}
      <ShippingChargesPayment><PaymentType>SENDER</PaymentType></ShippingChargesPayment>
      <RateRequestTypes>ACCOUNT</RateRequestTypes><PackageCount>1</PackageCount>
      <RequestedPackageLineItems><GroupPackageCount>1</GroupPackageCount>#{item_weight(qps)}#{item_dimensions(qps)}
      </RequestedPackageLineItems></RequestedShipment></RateRequest>)
   end

    def self.fedex_authentication(credentials)
      %(<WebAuthenticationDetail>
        <UserCredential><Key>#{credentials[:key]}</Key><Password>#{credentials[:password]}</Password></UserCredential>
      </WebAuthenticationDetail>
      <ClientDetail>
        <AccountNumber>#{credentials[:account_number]}</AccountNumber>
        <MeterNumber>#{credentials[:meter_number]}</MeterNumber>
        <Localization><LanguageCode>es</LanguageCode><LocaleCode>mx</LocaleCode></Localization>
      </ClientDetail>)
    end

    def self.shipper(qps)
      %(<Shipper>
        <Address>
          <StreetLines></StreetLines><City></City><StateOrProvinceCode>XX</StateOrProvinceCode>
          <PostalCode>#{qps[:address_from][:zip]}</PostalCode>
          <CountryCode>#{qps[:address_from][:country].upcase}</CountryCode>
        </Address>
      </Shipper>)
    end

    def self.recipient(qps)
      %(<Recipient>
        <Address>
          <StreetLines></StreetLines><City></City><StateOrProvinceCode>XX</StateOrProvinceCode>
          <PostalCode>#{qps[:address_to][:zip]}</PostalCode>
          <CountryCode>#{qps[:address_to][:country].upcase}</CountryCode>
          <Residential>false</Residential>
        </Address>
      </Recipient>)
    end

    def self.item_weight(qps)
      %(<Weight>
          <Units>#{qps[:parcel][:mass_unit].upcase}</Units>
          <Value>#{qps[:parcel][:weight].round}</Value>
        </Weight>)
    end

    def self.item_dimensions(qps)
      %(<Dimensions>
          <Length>#{qps[:parcel][:length].round}</Length>
          <Width>#{qps[:parcel][:width].round}</Width>
          <Height>#{qps[:parcel][:height].round}</Height>
          <Units>#{qps[:parcel][:distance_unit].upcase}</Units>
      </Dimensions>)
    end
  end
end
