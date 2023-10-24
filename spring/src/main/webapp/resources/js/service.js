
function selectRegion(button) {
    var value = button.value;
    var selectedBtnDiv = document.querySelector('.selected-btn');


    var newButton = document.createElement('button');
    newButton.textContent = value;
    newButton.classList.add('selected-region');

    selectedBtnDiv.appendChild(newButton);

    document.querySelector('.selected-btn').addEventListener('click', function (event) {

        if (event.target.tagName === 'BUTTON') {
            event.target.remove();
        }
    });
}


function openChartRegionModal() {
    document.getElementById("myRegionmodal").style.display = "block";

    let regionNameList = [];
    let region_cntList = [];
    let amount_sumList = [];
    $.ajax({
        url: '/chart/regionServiceChart',
        type: 'GET',
        success: function (data) {
            for (let i = 0; i < data.length; i++) {
                regionNameList.push(data[i].regionName);
                region_cntList.push(data[i].regionCnt);
                amount_sumList.push(data[i].amountSum);
            }

            var ctx1 = document.getElementById('myRegionCntChart').getContext('2d');
            new Chart(ctx1, {
                type: 'bar',
                data: {
                    labels: regionNameList,
                    datasets: [{
                        data: region_cntList,
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: 'rgb(75, 192, 192)',
                        borderWidth: 1
                    }]
                },
                options: {
                    plugins: {
                        legend: {
                            display: false,
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

        },
        error: function () {
            console.error("Error while fetching data");
        }
    });
}





function openCategoryModal() {
    document.getElementById("categorymodal").style.display = "block";
}

function closeCategoryModal() {
    document.getElementById("categorymodal").style.display = "none";
}


function closeOkModal() {
    document.getElementById("myModal").style.display = "none";
}


function populateTimeOptions() {
    const startHourSelect = document.getElementById('startHour');
    const endHourSelect = document.getElementById('endHour');

    for (let i = 1; i <= 24; i++) {
        const option1 = document.createElement('option');
        option1.value = i;
        option1.textContent = i;
        startHourSelect.appendChild(option1);

        const option2 = option1.cloneNode(true);
        endHourSelect.appendChild(option2);
    }
}

populateTimeOptions();


function updateTime() {
    const startHour = document.getElementById('startHour').value;
    const endHour = document.getElementById('endHour').value;
    const timeText = startHour + ' 시 ~ ' + endHour + ' 시 ';
    const newSelectDiv = document.createElement('div');
    newSelectDiv.classList.add('select-con');

    const newSelectElement = document.createElement('div');
    newSelectElement.classList.add('select-element');
    newSelectElement.textContent = timeText;

    const myselectContainer = document.querySelector('.myselect-time');

    const deleteButton = document.createElement('button');
    deleteButton.classList.add('delete-btn');
    deleteButton.textContent = '삭제';
    deleteButton.addEventListener('click', function () {
        myselectContainer.removeChild(newSelectDiv);
        if (!myselectContainer.querySelector('.select-con')) {
            myselectContainer.style.display = 'none';
        }
    });

    newSelectDiv.appendChild(newSelectElement);
    newSelectDiv.appendChild(deleteButton);

    myselectContainer.appendChild(newSelectDiv);
    myselectContainer.style.display = 'flex';

}

