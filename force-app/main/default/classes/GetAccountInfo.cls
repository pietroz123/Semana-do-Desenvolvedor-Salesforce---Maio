public with sharing class GetAccountInfo {

	public static Boolean hasCNPJverification(String accountId) {
		Account acc = [SELECT Id, Ultima_Atualizacao__c FROM Account WHERE Id = :accountId];
		return acc.Ultima_Atualizacao__c != null;
	}

	@AuraEnabled
	public static String saveRecord(String accountId, String json){
		TOReceitaAPI receitaAPI = TOReceitaAPI.parse(json);

		Account acc = new Account(Id = accountId);
		acc.Name = receitaAPI.nome;
		acc.Razao_Social__c = receitaAPI.nome;
		acc.Message__c = receitaAPI.message;
		acc.Status__c = receitaAPI.status;
		acc.Ultima_Atualizacao__c = receitaAPI.ultima_atualizacao;
		acc.Tipo__c = receitaAPI.tipo;
		acc.Phone = receitaAPI.telefone;
		acc.BillingStreet = receitaAPI.logradouro + ', ' + receitaAPI.numero + ' - ' + receitaAPI.bairro;
		acc.BillingPostalCode = receitaAPI.cep;
		acc.BillingCity = receitaAPI.municipio;
		acc.BillingState = receitaAPI.uf;

		update acc;

		return acc.Id;
	}

}
