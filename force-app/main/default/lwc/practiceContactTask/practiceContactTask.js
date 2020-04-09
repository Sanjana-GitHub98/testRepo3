/* eslint-disable no-alert */
/* eslint-disable no-console */
/* eslint-disable vars-on-top */
import { LightningElement,api,wire, track } from 'lwc';
import getContacts from '@salesforce/apex/ContactData.getContacts';
//import bookTable from '@salesforce/apex/ContactData.bookTable';
import getBookingData from '@salesforce/apex/ContactData.getBookingData';


export default class RecordIdExample extends LightningElement {
@api recordId;
@api contactId;
@api ConIdStr;
@track contactId;
@track selectedItemChecked; 
@track bookDtlsLst;
@wire(getContacts)
contacts;
getCurrentIndex(event) {
      var selectedItem = event.currentTarget;
      var currentId = selectedItem.getAttribute("data-index");
      var index = parseInt(currentId, 10);
      // eslint-disable-next-line no-console
      console.log('index value=>'+index);
      return index;
      }
      getSelCheckDtls(event)
{
      // console.log('index' + index);
      // eslint-disable-next-line no-unused-vars
      var itemChecked = event.target.checked;
      console.log('itemChecked value=>'+itemChecked);
      //eslint-disable-next-line no-unused-vars
      var index = this.getCurrentIndex(event);
      this.selectedItemChecked=event.target.value;
      console.log('getSelCheckDtls '+JSON.stringify(this.selectedItemChecked));
}
@wire(getBookingData,{ConIdStr:'$contactId'}) Bktbldata;

getBookDtls()
{
      // console.log('index' + index);
      // eslint-disable-next-line no-unused-vars
      //var selectedItemChecked = event.target.checked;
      // console.log('getSelCheckDtls method called');
      // eslint-disable-next-line no-unused-vars
      // eslint-disable-next-line vars-on-top
      // eslint-disable-next-line no-unused-vars
      // var index = this.getCurrentIndex(event);
      //  var chkname=event.currentTarget.getAttribute("data-index");
      console.log('in bookDtls method');
      this.contactId =  this.selectedItemChecked;
      let eachObj = this.contacts;
      eachObj.Name = this.contactId;
      //console.log('index value='+index);
      // console.log('Selected  Name ='+ JSON.stringify(eachObj));
      console.log('chkname  Name ='+ this.contactId);
      //this.getBookTabledata(event);

}
//@wire(bookTable,{ConIdStr:'$contactId'}) booktbl;

getcheckIsBookAmt(event)
{ // eslint-disable-next-line no-unused-vars
      // var ConSelectId=event.get("ContIdToBookTbl");
      console.log('changed Is Booking');
      var index = this.getCurrentIndex(event);
    //  var ConSelectId;
      var HoldOldIndxAmt=0;
     // var holdChkIndex=isCheck;
      this.bookDtlsLst=this.Bktbldata.data;
      
      console.log('bookDtlsLst data=>'+JSON.stringify(this.bookDtlsLst));
      var BookDtlsIndexDataChked=this.bookDtlsLst[parseInt(index,10)];
      console.log('BookDtlsIndexDataChked[index] data=>'+JSON.stringify(BookDtlsIndexDataChked));
      //alert('BookDtlsIndexDataChked=='+BookDtlsIndexDataChked);
      if(BookDtlsIndexDataChked!=null){
            if(BookDtlsIndexDataChked.Amount__c!=null)       //Checking whether Amount Feild is empty
            {
                  
                  for(var i=0;i<this.bookDtlsLst.length;i++){
                  if(this.bookDtlsLst[i].Is_Booking__c===true){
                        var HoldCurrIndxAmt=this.bookDtlsLst[i].Amount__c;
                        HoldOldIndxAmt= HoldOldIndxAmt + HoldCurrIndxAmt ;
                        console.log('1.HoldOldIndxAmt=='+HoldOldIndxAmt);
                       var aa =this.bookDtlsLst[i].Gross_Amount__c ;
                       console.log('aa=='+aa);
                      this.bookDtlsLst[i].Gross_Amount__c = this.bookDtlsLst[i].Amount__c;
                      // console.log('Done');
                  }
                 
                  console.log('2.HoldOldIndxAmt=='+HoldOldIndxAmt);
                  //this.bookDtlsLst[i].Gross_Amount__c = HoldOldIndxAmt;
            
            }
                  //BookDtlsIndexDataChked.Gross_Amount__c = parseInt(HoldOldIndxAmt);
                  //BookDtlsIndexDataChked.Contact__c=ConSelectId;
                  // component.set("v.bookedList",bookDtlsLst);
                  
            }
            else
            {
                  alert('Amount Is required');
            }
            
      }
      else
      {alert('No Row present');}
      return this.bookDtlsLst;
      // eslint-disable-next-line no-unreachable
      console.log('bookDtlsLst'+JSON.stringify(this.bookDtlsLst));
      }

      
}