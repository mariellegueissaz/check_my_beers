import "bootstrap";
import * as ScanditSDK from "scandit-sdk";


ScanditSDK.configure("AQN+4R24A/5tO11u+j0nZ1AecF3/Cv/d3H4uZrsNjqZXX9qQqWGKJu5+LKLNMybTtEhS7TMZEHsPV3MOg00NqcVBz9gYb9qirFjq42YtyKOTQeTkfmBz4jNbCb91R5AZChQ1/3lhl9PBRI/25lG6J6NZ3SQ2d9zPiXcjvVFw7z8PVZn6eRl5kNpEqoCuJs5fik0USP5WSnb02nCQP9qS1salnhfRMQPdbB66jXOpyQZG80JyHwTX4NPQjAJqVM4Y2cRNE8xUMWjeZGkNcl+kZOXvidtxMr/CjaPhCvnhgQvj6QD6xX15B9csIecI5baFC7/9WIXh8PQg+sxBODv7NcL0dCDN0MOumXmOvznTbjAb05T0JVqGlvVW3OsIE9t6G0PM8C2FjArfc7jKN+uB7td6dbmPHeZtBOv6cvk5KTZNh7974e0CUgzdLoECMuQ7hfYVDXFWv/8m7A3Ii7YGzXcEwtrOlcHjawVYrvnXCad30b0TXFC9S7s+u0aRVhoL3h1NbWvJPvM6JQDLvTtM3kUtZ1fII2AQfxEoDms+1RMCfJrVc5JUWdmh3hSa5eC1S2NyUWnU4RTrWHa3Zx30T3Jfm9gcOoKiSeinMaRD4pwZ45wA0aHTK+3okSEe6kT4RHMobyVeMpMgOhozgXGITddYcTQqLyvtP61mPaDlsAFHeIvlvJl3z8nnQnRhMXyt3Ij/+6vUrlchr7r6H46B/X/fVdcHvK6T0oGTov8z2bmQ07f7ZQlSF75flNutywg6pRz/r8ciCDcGHt2tTLld070ExxVxQ+bNKBau1iK/WREzAzCNJpDGosshg6dAHCZK68vJgeBNsEovpBtSK5OdJYKrTTuDwfyahXYb4alFbg==", {
  engineLocation: "https://unpkg.com/scandit-sdk@4.x/build"
});

ScanditSDK.BarcodePicker.create(document.getElementById("scandit-barcode-picker"), {
  playSoundOnScan: true,
  vibrateOnScan: true
}).then(function(barcodePicker) {
  var scanSettings = new ScanditSDK.ScanSettings({
    enabledSymbologies: ["ean8", "ean13", "upca", "upce", "code128", "code39", "code93", "itf"],
    codeDuplicateFilter: 1000
  });
  barcodePicker.applyScanSettings(scanSettings);
  barcodePicker.onScan(function(scanResult) {
    scanResult.barcodes.reduce(function(string, barcode) {
      fetch(`http://localhost:3000/find_beer_from_scan?code=${barcode.data}`)
      .then(response => response.json())
      .then((data) => {
        if (data === null) {
          console.log(data)
          alert("No beer found");
        } else {
          window.location.href = `http://localhost:3000/beers/${data.id}`;
        }
      });
    }, "");
  });
});
