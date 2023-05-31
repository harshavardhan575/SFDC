import { LightningElement, api, track } from 'lwc';
import searchPlace from '@salesforce/apex/GoogleMapsAPI.searchPlace';   

export default class Typeahead extends LightningElement {
    @track addresses = [];  
    @api sectionName;
    error;  
    searchKey;
    selectedAddress;
    inputCompleted;
    showSelection = false;

    handleChange( event ) {
        this.searchKey = event.detail.value;
        console.log( 'searchKey is', this.searchKey );
        if( this.inputCompleted ) {
            clearTimeout( this.inputCompleted );
        }
        if ( this.searchKey ) {  
            this.inputCompleted = setTimeout( this.invokeSearchAPI.bind(this),700);
        } else  {
            this.addresses = [];  
        }
    }

    invokeSearchAPI() {
        searchPlace({ 
            searchString: this.searchKey 
        }).then(result => {  
            let searchResults = JSON.parse( result );
            searchResults.candidates.forEach( (currentItem, currentIndex) => {
                let tempRec = Object.assign({}, currentItem);
                tempRec['index'] = currentIndex;           
                this.addresses.push( tempRec );
            });
            this.showSelection = true;
            clearTimeout( this.inputCompleted );
        }).catch(error => {  
            this.error = error;  
        });  
    }

    handleSelect( event ) {
        let strIndex = event.currentTarget.dataset.id;
        this.selectedAddress = this.addresses[strIndex].formatted_address;
        this.addresses = [];
        this.showSelection = false;
        this.searchKey = this.selectedAddress;
    }

    @api getSelectedAddress() {
        return this.selectedAddress;
    }
}