@isTest
public class BulkTouchRecordsTest {

	private static final Integer numberOfRecordsToTest = 200;

	@isTest static void mainBulkTouchRecordsTest() {
		
		// Set Created Dates - For some reason this cannot be done in @testSetup
		for(Account[] accounts : [SELECT Id FROM Account]) {
				for(Account a : accounts) {
						Test.setCreatedDate(a.Id, DateTime.newInstance(2012,12,12));
				}
		}
		
		// Run Test
		test.startTest(); 
		System.AssertEquals( 0, [SELECT COUNT() FROM Account WHERE CreatedDate = TODAY], 'Since we set the create and modify dates, no records should show they were updated today');

		string query = 'SELECT Id FROM Account'; // No Where Clause. We want ALL records         
		BulkTouchRecords touchAllAccounts = new BulkTouchRecords(query);
		Id batchprocessid = Database.executeBatch(touchAllAccounts);
		test.stopTest();
		
		// Assertion(s)
		System.AssertEquals( numberOfRecordsToTest, [SELECT COUNT() FROM Account WHERE LastModifiedDate = TODAY], 'Every record we created, should show it was updated today.');
}

	// Create Test Data
	@testSetup static void setup() {
		Account[] accounts = eCRM_Test_Utility.createAccounts('TestAccount_', numberOfRecordsToTest);
		insert accounts;
	}

}