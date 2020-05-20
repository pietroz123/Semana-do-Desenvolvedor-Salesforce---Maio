public with sharing class ReceitaAPI {

    private static final String endpoint = 'https://www.receitaws.com.br/v1/cnpj/';

    @AuraEnabled
    public static TOReceitaAPI callReceitaAPI(String cnpj) {

        Http http = new Http();

        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint + cnpj);
        req.setMethod('GET');
        req.setTimeout(12000);

        try {

            HttpResponse res = http.send(req);

            if (res.getStatusCode() == 200) {
                String json = res.getBody();
                return TOReceitaAPI.parse(json);
            }
            else if (res.getStatusCode() == 429) {
                TOReceitaAPI toReceita = new TOReceitaAPI();
                toReceita.status = 'ERROR';
                toReceita.message = 'Too Many Requests';
                return toReceita;
            }

        } catch (Exception ex) {
            TOReceitaAPI toReceita = new TOReceitaAPI();
            toReceita.status = 'ERROR';
            toReceita.message = ex.getMessage();
            return toReceita;
        }

        return null;
    }

}
