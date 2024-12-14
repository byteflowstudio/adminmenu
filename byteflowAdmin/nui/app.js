document.addEventListener('DOMContentLoaded', () => {
    const menu = document.getElementById('menu');
    const mainMenu = document.getElementById('mainMenu');
    const adminMenu = document.getElementById('adminMenu');
    const closeButton = document.getElementById('closeButton');
    const backButton = document.getElementById('backButton');
    const adminButton = document.getElementById('adminButton');
    const targetId = document.getElementById('targetId');

    // Show main menu
    mainMenu.style.display = 'block';

    // Handle closing menu
    closeButton.addEventListener('click', () => {
        fetch(`https://kurnia_menu/closeMenu`, {
            method: 'POST',
        });
        menu.style.display = 'none';
    });

    // Handle admin button
    adminButton.addEventListener('click', () => {
        mainMenu.style.display = 'none';
        adminMenu.style.display = 'block';
    });

    // Handle back button
    backButton.addEventListener('click', () => {
        adminMenu.style.display = 'none';
        mainMenu.style.display = 'block';
    });

    // Handle admin actions
    adminMenu.querySelectorAll('button[data-action]').forEach(button => {
        button.addEventListener('click', () => {
            const action = button.dataset.action;
            const id = targetId.value;

            if (!id) {
                alert('Enter a valid target ID.');
                return;
            }

            fetch(`https://kurnia_menu/adminAction`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ action, targetId: id }),
            });
        });
    });
});

document.getElementById('spawnVehicleButton').addEventListener('click', () => {
    const vehicleName = document.getElementById('vehicleName').value;

    if (!vehicleName) {
        alert('Enter a valid vehicle name.');
        return;
    }

    fetch(`https://byteflow_menu/spawnVehicle`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ vehicleName }),
    });
});

// Give Car
document.getElementById('giveCarButton').addEventListener('click', () => {
    const vehicleName = document.getElementById('giveVehicleName').value;
    const targetId = document.getElementById('giveTargetId').value;

    if (!vehicleName || !targetId) {
        alert('Enter vehicle name and target player ID.');
        return;
    }

    fetch(`https://byteflow_menu/giveCar`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ vehicleName, targetId }),
    });
});

// Give Money
document.getElementById('giveMoneyButton').addEventListener('click', () => {
    const amount = document.getElementById('giveMoneyAmount').value;
    const targetId = document.getElementById('giveMoneyTargetId').value;

    if (!amount || !targetId) {
        alert('Enter amount and target player ID.');
        return;
    }

    fetch(`https://byteflow_menu/giveMoney`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ amount, targetId }),
    });
});