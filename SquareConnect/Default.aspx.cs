using Square;
using Square.Apis;
using Square.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SquareConnect
{
    public partial class _Default : Page
    {
        public string ResultMessage
        {
            get;
            set;
        }
        private SquareClient client;

        public _Default()
        {
            // Get environment
            Square.Environment environment =ConfigurationManager.AppSettings["Environment"] == "sandbox" ?
                Square.Environment.Sandbox : Square.Environment.Production;

            // Build base client
            client = new SquareClient.Builder()
                .Environment(environment)
                .AccessToken(ConfigurationManager.AppSettings["AccessToken"])
                .Build();
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private static string NewIdempotencyKey()
        {
            return Guid.NewGuid().ToString();
        }
        protected void sqcreditcard_Click(object sender, EventArgs e)
        {
            string nonce = Request.Form["nonce"];
            IPaymentsApi PaymentsApi = client.PaymentsApi;
            // Every payment you process with the SDK must have a unique idempotency key.
            // If you're unsure whether a particular payment succeeded, you can reattempt
            // it with the same idempotency key without worrying about double charging
            // the buyer.
            string uuid = NewIdempotencyKey();

            // Monetary amounts are specified in the smallest unit of the applicable currency.
            // This amount is in cents. It's also hard-coded for $1.00,
            // which isn't very useful.
            Money amount = new Money.Builder()
                .Amount(500L)
                .Currency("USD")
                .Build();

            // To learn more about splitting payments with additional recipients,
            // see the Payments API documentation on our [developer site]
            // (https://developer.squareup.com/docs/payments-api/overview).
            CreatePaymentRequest createPaymentRequest = new CreatePaymentRequest.Builder(nonce, uuid, amount)
                .Note("From Square Sample Csharp App")
                .Build();

            try
            {
                CreatePaymentResponse response = PaymentsApi.CreatePayment(createPaymentRequest);
                this.ResultMessage = "Payment complete! " + response.Payment.Note;
            }
            catch (Exception ex)
            {
                this.ResultMessage = ex.Message;
            }
        }
    }
}