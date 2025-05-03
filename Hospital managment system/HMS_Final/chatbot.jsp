document.addEventListener('DOMContentLoaded', () => {
    const chatbotToggle = document.querySelector('.chatbot-toggle');
    const chatbotWindow = document.querySelector('.chatbot-window');
    const closeBtn = document.querySelector('.close-btn');
    const minimizeBtn = document.querySelector('.minimize-btn');
    const sendBtn = document.querySelector('.send-btn');
    const chatInput = document.querySelector('.chatbot-input');
    const chatBody = document.querySelector('.chatbot-body');
    const typingIndicator = document.createElement('div');

    // Typing indicator
    typingIndicator.className = 'typing-indicator';
    typingIndicator.innerHTML = `
        <span class="typing-dot"></span>
        <span class="typing-dot"></span>
        <span class="typing-dot"></span>
    `;
    chatBody.appendChild(typingIndicator);

    // Load chatbot state
    const isChatbotOpen = localStorage.getItem('chatbotOpen') === 'true';
    if (isChatbotOpen) {
        chatbotWindow.style.display = 'flex';
        gsap.from(chatbotWindow, {
            scale: 0.8,
            opacity: 0,
            duration: 0.5,
            ease: 'back.out(1.7)'
        });
    }

    // Toggle chatbot
    chatbotToggle.addEventListener('click', () => {
        const isOpen = chatbotWindow.style.display === 'flex';
        chatbotWindow.style.display = isOpen ? 'none' : 'flex';
        localStorage.setItem('chatbotOpen', !isOpen);
        if (!isOpen) {
            gsap.from(chatbotWindow, {
                scale: 0.8,
                opacity: 0,
                duration: 0.5,
                ease: 'back.out(1.7)'
            });
        }
    });

    // Close chatbot
    closeBtn.addEventListener('click', () => {
        chatbotWindow.style.display = 'none';
        localStorage.setItem('chatbotOpen', 'false');
    });

    // Minimize chatbot
    minimizeBtn.addEventListener('click', () => {
        chatbotWindow.style.display = 'none';
        localStorage.setItem('chatbotOpen', 'false');
    });

    // Send message
    sendBtn.addEventListener('click', sendMessage);
    chatInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') sendMessage();
    });

    function sendMessage() {
        const message = chatInput.value.trim();
        if (!message) return;

        // Add user message
        const userMessage = document.createElement('div');
        userMessage.className = 'chat-message user';
        userMessage.innerHTML = `${message}<span class="timestamp">${new Date().toLocaleTimeString()}</span>`;
        chatBody.appendChild(userMessage);
        chatInput.value = '';

        // Scroll to bottom
        chatBody.scrollTop = chatBody.scrollHeight;

        // Show typing indicator
        typingIndicator.style.display = 'flex';
        gsap.from(typingIndicator, {
            opacity: 0,
            y: 10,
            duration: 0.3
        });

        // Simulate bot response
        setTimeout(() => {
            typingIndicator.style.display = 'none';
            const botMessage = document.createElement('div');
            botMessage.className = 'chat-message bot';
            const response = getBotResponse(message.toLowerCase());
            botMessage.innerHTML = `${response}<span class="timestamp">${new Date().toLocaleTimeString()}</span>`;
            chatBody.appendChild(botMessage);

            // Scroll to bottom
            chatBody.scrollTop = chatBody.scrollHeight;

            // Animate bot message
            gsap.from(botMessage, {
                opacity: 0,
                y: 10,
                duration: 0.5,
                ease: 'power2.out'
            });

            // Add quick reply options
            if (response.includes('How can I assist you')) {
                addQuickReplies();
            }
        }, 1000);
    }

    function addQuickReplies() {
        const options = [
            { text: 'Add Patient', action: 'add patient' },
            { text: 'Schedule Appointment', action: 'schedule appointment' },
            { text: 'View Doctors', action: 'view doctors' },
            { text: 'Help', action: 'help' }
        ];
        const optionsContainer = document.createElement('div');
        optionsContainer.className = 'chatbot-options';
        options.forEach(option => {
            const btn = document.createElement('button');
            btn.className = 'chatbot-option-btn';
            btn.textContent = option.text;
            btn.addEventListener('click', () => {
                chatInput.value = option.action;
                sendMessage();
                optionsContainer.remove();
            });
            optionsContainer.appendChild(btn);
        });
        chatBody.appendChild(optionsContainer);
        chatBody.scrollTop = chatBody.scrollHeight;
        gsap.from(optionsContainer.children, {
            opacity: 0,
            y: 10,
            stagger: 0.1,
            duration: 0.3,
            ease: 'power2.out'
        });
    }

    function getBotResponse(message) {
        if (message.includes('hello') || message.includes('hi')) {
            return 'Hello! How can I assist you today?';
        } else if (message.includes('add patient')) {
            return 'To add a patient, navigate to the Patients page and fill out the form with their details.';
        } else if (message.includes('schedule appointment')) {
            return 'To schedule an appointment, go to the Appointments page, select a patient and doctor, and choose a date.';
        } else if (message.includes('view doctors')) {
            return 'You can view all doctors on the Doctors page, including their specialization and availability.';
        } else if (message.includes('help')) {
            return 'I can assist with adding patients, scheduling appointments, viewing doctors, or general navigation. Try saying "add patient" or "help" for more options!';
        } else if (message.includes('time') || message.includes('date')) {
            return `The current time is ${new Date().toLocaleTimeString()} on ${new Date().toLocaleDateString()}.`;
        } else {
            return "I'm not sure I understand. Try asking about adding a patient, scheduling an appointment, or type 'help' for more options.";
        }
    }

    // Persist chat history
    function saveChatHistory() {
        const messages = Array.from(chatBody.querySelectorAll('.chat-message')).map(msg => ({
            text: msg.childNodes[0].textContent,
            type: msg.classList.contains('user') ? 'user' : 'bot',
            timestamp: msg.querySelector('.timestamp').textContent
        }));
        localStorage.setItem('chatHistory', JSON.stringify(messages));
    }

    function loadChatHistory() {
        const history = JSON.parse(localStorage.getItem('chatHistory') || '[]');
        history.forEach(msg => {
            const messageDiv = document.createElement('div');
            messageDiv.className = `chat-message ${msg.type}`;
            messageDiv.innerHTML = `${msg.text}<span class="timestamp">${msg.timestamp}</span>`;
            chatBody.appendChild(messageDiv);
        });
        chatBody.scrollTop = chatBody.scrollHeight;
    }

    // Load chat history on page load
    loadChatHistory();

    // Save chat history on message send
    chatBody.addEventListener('DOMNodeInserted', saveChatHistory);

    // Focus input on chatbot open
    chatbotToggle.addEventListener('click', () => {
        if (chatbotWindow.style.display === 'flex') {
            chatInput.focus();
        }
    });
});
