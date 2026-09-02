// Use require module for load a external JS library
require(['https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.js'], function (Chart) {
    // Interval to check exist First Frame Container, necessary to works on Edge
    var internval = setInterval(function() {
		
        // Select by jQuery a first frame container
        var firstFrame = $("div[id*='Frame_Demo_gridctl_cnt']:first");
		// See if first frame exists
        if (firstFrame.length > 0) {
           		
		
			
            // Insert a Html Cavas element. Will be used for Chart
            firstFrame.find('.ui-control-frame:last').append('<canvas id="myChart" width="900" height="410"></canvas>');

            // Change some CSS style in frame control
            firstFrame.find('.ui-control-frame:first').css({            
			     "width": "900px", "height": "410px",
                "transition": "height 0s linear,width 0s linear",
                "background-color": "rgb(244, 244, 244)"								
            });			
			
           
			//Looking at grid to load all elements and number of time each element			
				var txt = new Array();		
				var cellText = $("div[class*='ui-grid-celltext'");	
			// cellText.lenght > 0 only if there is text on the grid
				if (cellText.length > 0) {
				// clear Interval, now we execute the code, else we loop every 10ms
				 clearInterval(internval);			
				
				//Look at all elements on the grid		
	
				for (var j=0; j<cellText.length; j++) {				
			
					txt[j] = cellText[j].innerText;
						
				}
					
				var txtCategory = new Array();
				var textArray = new Array();
				var dataArray = new Array();
				var i=0;
				// load all elements on the second column, 
            	for (var j=1; j<cellText.length; j=j+7) {		
					txtCategory[i] = txt[j] ;
				//	console.log(txtCategory[i]);
					i++;				
				}
				var h=0;
				var hit=0;						
				// The second
				textArray[0] = txtCategory[1];
			
				dataArray[0] = 1;
				for (var l=2; l<txtCategory.length; l++) {		
			
					for (var k=0; k < textArray.length; k++) {
			
						if (txtCategory[l]==textArray[k]) {
							dataArray[k]=dataArray[k] + 1;							
							hit = 1;			
							break;
						} 						
					}		
					if (hit == 0) {							
						textArray[k] = txtCategory[l];
						dataArray[k] = 1;					
					} else {			
						hit = 0;
					}
				}			
			
			//Number of clicks to the button 'button_Demo_gridctl'
			 var btnClicks = 0;
			 // get hook on the button with ID button_Demo_gridctl
			var buttonFrame = $("div[id*='button_Demo_gridctl_cnt']:first");
            buttonFrame.click(function () {
                btnClicks++;
		        if ((btnClicks % 2) == 1) {				    					
				   // Expand Chart
                    firstFrame.css({ "z-index": "6" });
					ctx.style.visibility='visible';
                    firstFrame.find('.ui-control-frame:first').css({ "width": "900px", "height": "410px", "background-color": "rgb(244, 244, 244)" });
					document.getElementById('Grid_demo_gridctl_container').style.visibility ='hidden';
                  }
                else { 
					// Contract Chart
					firstFrame.css({ "z-index": "0" });
					firstFrame.find('.ui-control-frame:first').css({ "width": "0px", "height": "0px", "background-color": "rgb(244, 244, 244)" });
					document.getElementById('Grid_demo_gridctl_container').style.visibility ='visible';
                }
            });						
		//	var backGroundColor = new Array[];
		//	backGroundColor[0] = 'rgba(255, 99, 132, 1)';			
		//	backGroundColor[1] = 'rgba(54, 162, 235, 1)';
		//	backGroundColor[2] = 'rgba(255, 206, 86, 1)';
		//	backGroundColor[3] = 'rgba(75, 192, 192, 1)';
		//	backGroundColor[4] = 'rgba(153, 102, 255, 1)';
		//	backGroundColor[5] = 'rgba(255, 159, 64, 1)';
		//	backGroundColor[6] = 'rgba(255, 0, 0, 1)';
		//	backGroundColor[7] = 'rgba(0, 255, 0, 1)';
		//	backGroundColor[8] = 'rgba(0, 0, 255, 1)';
		//	backGroundColor[9] = 'rgba(123, 123, 255, 1)';
			
			// Get Canvas Element
            var ctx = document.getElementById('myChart');
			// Render chart Hidden
            ctx.style.visibility='hidden';
			// Make chart with canvas element
            var myChart = new Chart(ctx, {
                type: 'bar',      
					data: {
						labels: textArray,
                    datasets: [{
                        label: '# of times for each Category',
            			data: dataArray,
		              backgroundColor: [
							'rgba(255, 99, 132, 1)',
							'rgba(54, 162, 235, 1)',
							'rgba(255, 206, 86, 1)',
							'rgba(75, 192, 192, 1)',
							'rgba(153, 102, 255, 1)',
							'rgba(255, 159, 64, 1)',
							'rgba(255, 0, 0, 1)',
							'rgba(0, 255, 0, 1)',
							'rgba(0, 0, 255, 1)',
							'rgba(123, 123, 255, 1)'
                        ],
		//				backgroudColor : backGroundColor,
        //                borderColor: [
		//					'rgba(255, 99, 132, 1)',
		//					'rgba(54, 162, 235, 1)',
		//					'rgba(255, 206, 86, 1)',
		//					'rgba(75, 192, 192, 1)',
		//					'rgba(153, 102, 255, 1)',
		//					'rgba(255, 159, 64, 1)',
		//					'rgba(255, 0, 0, 1)',
		//					'rgba(0, 255, 0, 1)',
		//					'rgba(0, 0, 255, 1)',
		//					'rgba(123, 123, 255, 1)'
         //               ],
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true
                            }
                        }]
                    }
                }
            });	

		
			//After creating chart
			
        }
    }}, 10);	 
	
	});
	
