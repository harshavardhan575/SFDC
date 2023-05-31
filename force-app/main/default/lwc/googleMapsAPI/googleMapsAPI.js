import { LightningElement } from 'lwc';
import getDistance from '@salesforce/apex/GoogleMapsAPI.getDistanceAndTimeMatrix';   
import LightningAlert from 'lightning/alert';

export default class GoogleMapsAPI extends LightningElement {

    costDistanceMatrix = [];
    showResults = false;
    apiResults = {};

    getDistanceMatrix() {
        console.log('===>>>Origin', this.template.querySelector('c-typeahead[data-id=origin]').getSelectedAddress());
        console.log('===>>>destination', this.template.querySelector('c-typeahead[data-id=destination]').getSelectedAddress());
        let origins = this.template.querySelector('c-typeahead[data-id=origin]').getSelectedAddress();
        let destinations = this.template.querySelector('c-typeahead[data-id=destination]').getSelectedAddress();

        getDistance({
            sourceAddress: origins,
            destinationAddress: destinations
        }).then((result)=>{
            console.log('====>>>>>', result.length);
            console.log('Result', JSON.stringify(result));
            this.showResults = false;
            this.apiResults = {};
            if( !result || Object.keys(result).length === 0 ) {
                LightningAlert.open({
                    message: 'No Results found',
                    theme: 'error', // a red theme intended for error states
                    label: 'Error!', // this is the header text
                });
            } else {
                this.showResults = true;
                this.costDistanceMatrix = [];
                this.apiResults = result;
                for( const mode in result.mapModeToTravelToCost) {
                    this.costDistanceMatrix.push({
                        'mode': mode,
                        'value': result.mapModeToTravelToCost[mode]
                    })
                }
                //console.log('===>>>', this.costDistanceMatrix);
            }
        });
    }

}