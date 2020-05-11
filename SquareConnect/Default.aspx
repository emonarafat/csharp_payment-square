<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SquareConnect._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Begin Payment Form -->
    <div class="sq-payment-form">
        <!--
    Square's JS will automatically hide these buttons if they are unsupported
    by the current device.
  -->
        <div id="sq-walletbox">
            <button id="sq-google-pay" class="button-google-pay"></button>
            <button id="sq-apple-pay" class="sq-apple-pay"></button>
            <button id="sq-masterpass" class="sq-masterpass"></button>
            <div class="sq-wallet-divider">
                <span class="sq-wallet-divider__text">Or</span>
            </div>
        </div>
        <div id="sq-ccbox">
            <!--
      You should replace the action attribute of the form with the path of
      the URL you want to POST the nonce to (for example, "/process-card").
      You need to then make a "Charge" request to Square's transaction API with
      this nonce to securely charge the customer.
      Learn more about how to setup the server component of the payment form here:
      https://docs.connect.squareup.com/payments/transactions/processing-payment-rest
    -->
            
                <div class="sq-field">
                    <label class="sq-label">Card Number</label>
                    <div id="sq-card-number"></div>
                </div>
                <div class="sq-field-wrapper">
                    <div class="sq-field sq-field--in-wrapper">
                        <label class="sq-label">CVV</label>
                        <div id="sq-cvv"></div>
                    </div>
                    <div class="sq-field sq-field--in-wrapper">
                        <label class="sq-label">Expiration</label>
                        <div id="sq-expiration-date"></div>
                    </div>
                    <div class="sq-field sq-field--in-wrapper">
                        <label class="sq-label">Postal</label>
                        <div id="sq-postal-code"></div>
                    </div>
                </div>
                <div class="sq-field">
                    <button id="sq-creditcard" class="sq-button" onclick="onGetCardNonce(event)">
                        Pay $1.00 Now
                    </button>
                    <div class="hidden">
                        <asp:Button ID="sqcreditcard" ClientIDMode="Static" runat="server" Text=" Pay $1.00 Now" CssClass="sq-button" OnClick="sqcreditcard_Click"></asp:Button></div>
                </div>
                <!--
        After a nonce is generated it will be assigned to this hidden input field.
      -->
                <div id="error"></div>
                <input type="hidden" id="card-nonce" name="nonce" />
          
        </div>
    </div>
    <!-- End Payment Form -->

</asp:Content>
