require 'spec_helper'

describe GrapeSlate::Generators::Document do
  let(:routes) do
    SampleAPI.routes.select {|route| route.namespace == namespace}
  end

  subject(:document) { described_class.new(namespace, routes) }


  describe '#generate' do

    subject(:generate) { document.generate }

    context 'when namespace is /cases' do
      let(:namespace) { '/cases' }

      it do
        is_expected.to eq(
          ["# Cases", "## Get a list of all cases", "```shell\n curl /v1/cases --request GET --data '{\"limit_results\":100}' --header 'Content-Type: application/json' --header 'Authorization: Bearer <YOUR_TOKEN>' --verbose\n ```\n\n", "This is useful if you need to display an index page of cases on\nyour application. It is also handy if you want to limit the results of a\nrequest to the first 100 returned values.\n\nWe can add multiline comments here!", "### HTTP Request\n`GET /v1/cases`", "", "### Query Parameters\nParameter | Type | Required / Values | Description\n--------- | ---- | ----------------- | -----------\nlimit_results | Integer | `false`  | Return this number of cases as a maximum", "## individual case", "```shell\n curl /v1/cases/:id --request GET --header 'Content-Type: application/json' --header 'Authorization: Bearer <YOUR_TOKEN>' --verbose\n ```\n\n", "### HTTP Request\n`GET /v1/cases/:id`", "", "", "## create a case", "```shell\n curl /v1/cases --request POST --data '{\"name\":\"super case\",\"description\":\"the best case ever made\"}' --header 'Content-Type: application/json' --header 'Authorization: Bearer <YOUR_TOKEN>' --verbose\n ```\n\n> Example Response\n\n```json\n{\n  \"id\": 8731,\n  \"created_at\": \"Fri, 30 Oct 2015 09:52:21 +1100\",\n  \"description\": \"Your description here\",\n  \"name\": \"Case name\",\n  \"updated_at\": \"Fri, 30 Oct 2015 09:52:21 +1100\"\n}\n```", "### HTTP Request\n`POST /v1/cases`", "", "### Request Parameters\nParameter | Type | Required / Values | Description\n--------- | ---- | ----------------- | -----------\nname | String | `true`  | the cases name\ndescription | String | `false`  | the cases name", "## update a case", "```shell\n curl /v1/cases/:id --request PUT --header 'Content-Type: application/json' --header 'Authorization: Bearer <YOUR_TOKEN>' --verbose\n ```\n\n", "### HTTP Request\n`PUT /v1/cases/:id`", "", "### Request Parameters\nParameter | Type | Required / Values | Description\n--------- | ---- | ----------------- | -----------\nname | String | `false`  | the cases name\ndescription | String | `false`  | the cases name"]
        )
      end
    end

    context 'when namespace is /main_information' do
      let(:namespace) { '/main_information' }

      it do
        is_expected.to eq(
          ["# Main Information"]
        )
      end
    end

  end


  describe '#filename' do
    subject(:filename) { document.filename }

    context 'when namespace is at root level' do
      let(:namespace) { '/cases' }

      it { is_expected.to eq 'cases' }
    end

    context 'when namespace is nested' do
      let(:namespace) { '/cases/:case_id/studies' }

      it { is_expected.to eq 'studies' }
    end
  end
end
