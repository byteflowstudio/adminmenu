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
        fetch(`https://byteflow_menu/closeMenu`, {
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

            fetch(`https://byteflow_menu/adminAction`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ action, targetId: id }),
            });
        });
    });
});
