import 'package:flutter/material.dart';

class ComplaintRulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tamil Nadu Complaint Rules'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rules and Regulations for Moving a Complaint',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            _buildSectionTitle('1. Introduction'),
            _buildSectionContent(
              'The process for lodging complaints in Tamil Nadu involves several steps designed to ensure that all grievances are addressed efficiently and fairly. This guide provides a comprehensive overview of the procedures and regulations to help you file a complaint successfully.',
            ),
            SizedBox(height: 16.0),
            _buildSectionTitle('2. Types of Complaints'),
            _buildSectionContent(
              'Complaints can be categorized into the following types:\n'
              '- Civil Issues\n'
              '- Criminal Offenses\n'
              '- Administrative Issues\n'
              '- Consumer Complaints\n'
              '- Service-related Complaints\n'
              'Each type has a specific process that needs to be followed for efficient resolution.',
            ),
            SizedBox(height: 16.0),
            _buildSectionTitle('3. Steps to File a Complaint Offline'),
            _buildSectionContent(
              'Step 1: Identify the issue clearly and gather all relevant documents and evidence related to the complaint.\n'
              'Step 2: Visit the nearest police station or the appropriate department where the complaint needs to be lodged.\n'
              'Step 3: Fill out the complaint form with accurate details. Make sure to provide your contact information for follow-ups.\n'
              'Step 4: Submit the form along with any supporting documents. Obtain an acknowledgment receipt for your submission.\n'
              'Step 5: Follow up on your complaint by contacting the department or using online tracking tools if available.',
            ),
            SizedBox(height: 16.0),
            _buildSectionTitle('4. Steps to File a Complaint Online'),
            _buildSectionContent(
              'Tamil Nadu provides an online portal for complaint registration which can be accessed at [Insert URL]. The steps for filing a complaint online are:\n'
              'Step 1: Visit the official Tamil Nadu complaint registration portal.\n'
              'Step 2: Register or log in to your account.\n'
              'Step 3: Fill in the complaint form with all mandatory fields and attach necessary documents.\n'
              'Step 4: Submit the form and note down the complaint reference number for future tracking.\n'
              'Step 5: Monitor the status of your complaint using the reference number provided.',
            ),
            SizedBox(height: 16.0),
            _buildSectionTitle('5. Important Contacts'),
            _buildSectionContent(
              'For any assistance, you can contact the following departments:\n'
              '- Police Department: [Insert Police Department Contact Information]\n'
              '- Consumer Protection: [Insert Consumer Protection Contact Information]\n'
              '- Administrative Grievances: [Insert Administrative Contact Information]\n'
              'These contacts are crucial for follow-ups and additional help regarding your complaints.',
            ),
            SizedBox(height: 16.0),
            _buildSectionTitle('6. Frequently Asked Questions (FAQs)'),
            _buildSectionContent(
              'Q: How long does it take to resolve a complaint?\n'
              'A: The resolution time varies depending on the complexity of the issue. Generally, it may take a few weeks to a few months.\n\n'
              'Q: Can I file a complaint anonymously?\n'
              'A: Yes, some departments allow anonymous complaints, but providing your contact information helps in follow-ups and providing updates.\n\n'
              'Q: What should I do if my complaint is not addressed?\n'
              'A: If your complaint is not addressed in a reasonable timeframe, you can escalate it to higher authorities or seek legal advice.',
            ),
            SizedBox(height: 16.0),
            _buildSectionTitle('7. Conclusion'),
            _buildSectionContent(
              'Following these steps ensures that your complaint is processed efficiently and reaches the concerned authorities promptly. Always keep records of your submissions and follow up regularly to ensure timely resolution.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 16.0,
      ),
    );
  }
}
