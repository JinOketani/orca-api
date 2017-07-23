# coding: utf-8

module OrcaApi
  class PatientService
    # 患者保険・公費情報の取得
    module GetHealthPublicInsurance
      def get_health_public_insurance(id)
        api_path = "/orca12/patientmodv32"
        req_name = "patientmodreq"

        body = {
          req_name => {
            "Request_Number" => "01",
            "Karte_Uid" => orca_api.karte_uid,
            "Orca_Uid" => "",
            "Patient_Information" => {
              "Patient_ID" => id.to_s,
            }
          }
        }
        res = Result.new(orca_api.call(api_path, body: body))
        if !res.ok?
          # TODO: エラー処理
        end

        unlock(api_path,
               req_name => {
                 "Request_Number" => "99",
                 "Karte_Uid" => res.karte_uid,
                 "Orca_Uid" => res.orca_uid,
                 "Patient_Information" => res.patient_information,
               })

        keys = %w(
          HealthInsurance_Information
          PublicInsurance_Information
          HealthInsurance_Combination_Information
        )
        res.raw.first[1].select { |k, _|
          keys.include?(k)
        }
      end
    end
  end
end
