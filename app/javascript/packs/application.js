import "bootstrap";
import * as ScanditSDK from "scandit-sdk";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!

import { initMapbox } from '../plugins/init_mapbox';
import { openAdvancedSearch } from '../components/nav_search';
import { openNavbar } from '../components/open_navbar';
import { closeNavbar } from '../components/close_navbar';
import { locateUser } from '../components/geocoding';
import { displayProgressBar } from '../components/progressbar';
import { displayProgressBarAdv } from '../components/progressbar-advanced';
import { initSelect2 } from '../plugins/init_select2';

initMapbox();
openNavbar();
closeNavbar();
openAdvancedSearch();
locateUser();
displayProgressBar();
displayProgressBarAdv();
initSelect2();

////////////////////////////////////////////////////////// SCAN JS

ScanditSDK.configure("AXwuUTu4JU+LBRvfhh/bd0c9J06lD9UlAnJwcyY70+48W4Gi2nAJ7ux1PpgxEE3qGC3x9iVam105Y3S9c1aYuXxOBykIbKqANG4/SFFTRS+YaxMR1DaGyPwf3G0TN9OzLR5Cn5sy0RTPHR1OSKWOLeCXEq8TgSuciS0q9KeWa/6wz9ICOKjKr7iNngGjjcK7Akcd4WRnEyDKCxL+jUhg7Lli3l+BAR6gqVfMZPnE2RllOAx6MMstyaCUY7Tl+/Dd5Vgw2ZT9bwMXMjFDPgA5x+l6qZmsNe78zmzaqg738e7DtyKZ5DrpwAOuaZJU1yYgcHij+rMhvnVyDKEKK1pDc3HAFBNBYQ34e35xOuwzwwRu6hV0x236N692dFEEwJ42z90QcV8kXTX8Qt8gldWemc97C7A4dQku7C+hea4fuBQlZUQcuU60ebO/TUXKkhT5UuWdW31rzdeR1yiCirZ6gvcj6B707yl088O4zcsKimOaI96c6a1MSHcVJ4henA60n4XgJ78V2UJ7nt3GP9LodbHU7uCTJr6VeKT5MuW1Y7/eCoRP7bmvGoTxyvsQCv2asWdNzKyIvW4TWsDqLmeIwSgVremrXoSK5JhdGo8zUd+pSVdbi7c0JQU7HIjLwfp+cRSId0ZSuX7OrDaGlKpNARa8YtEVyANbhBZ0CyvHAcKgf1W4DG3TU1TRTx63F5QH2A8yjYUYuruhlZr+T5a87tkVP/fi2pDl9NnPYLszUCqJwrT1YrFuV55qlJ9RC+/i9CQhwDiT+Bwfw9mHth0sRuFgdBKUFE5nAd6XuX42gRMHSw==", {
  engineLocation: "https://unpkg.com/scandit-sdk@4.x/build"
});

ScanditSDK.BarcodePicker.create(document.getElementById("scandit-barcode-picker"), {
  playSoundOnScan: true,
  vibrateOnScan: true,
}).then(function(barcodePicker) {
  var scanSettings = new ScanditSDK.ScanSettings({
    enabledSymbologies: ["ean8", "ean13", "upca", "upce", "code128", "code39", "code93", "itf"],
    codeDuplicateFilter: 1000
  });
  barcodePicker.applyScanSettings(scanSettings);
  barcodePicker.onScan(function(scanResult) {
    scanResult.barcodes.reduce(function(string, barcode) {
      fetch(`/find_beer_from_scan?code=${barcode.data}`)
      .then(response => response.json())
      .then((data) => {
        if (data === null) {
          if (confirm('No Beer found. Add to Database?')) {
            window.location.href = `/beers/new?barcode=${barcode.data}`;
          }
        } else {
          window.location.href = `/beers/${data.id}`;
        }
      });
    }, "");
  });
});
