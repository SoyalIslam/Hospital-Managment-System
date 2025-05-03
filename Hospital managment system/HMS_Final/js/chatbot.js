document.addEventListener('DOMContentLoaded', () => {
    const chatbotWindow = document.querySelector('.chatbot-window');
    const chatbotToggle = document.querySelector('.chatbot-toggle');
    const chatbotBody = document.querySelector('.chatbot-body');
    const chatbotInput = document.querySelector('.chatbot-input');
    const closeBtn = document.querySelector('.chatbot-header .close-btn');
    const minimizeBtn = document.querySelector('.chatbot-header .minimize-btn');
    const GEMINI_API_KEY = 'AIzaSyC3XeWjQDzhNY2RTWuLnMc7fKR9lulxvRo';
    const GEMINI_API_URL = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent';

    let userName = localStorage.getItem('chatbotUserName') || window.currentUser.firstName || '';
    let hasGreeted = localStorage.getItem('chatbotHasGreeted') === 'true';
    let isChatMinimized = false;

    // GSAP for animations
    gsap.registerPlugin(ScrollTrigger);

    // Ensure proper initial state
    chatbotWindow.style.display = 'none';

    // Floating notification on first load
    const notificationBubble = document.createElement('div');
    notificationBubble.className = 'notification-bubble';
    notificationBubble.innerHTML = `
        <div class="notification-content">
            <p>👋 Hi there! Need any help? Type 'help' for options.</p>
        </div>
        <div class="notification-close">×</div>
    `;
    document.querySelector('.chatbot-container').appendChild(notificationBubble);

    // Show notification with delay
    setTimeout(() => {
        gsap.to(notificationBubble, {
            y: 0,
            opacity: 1,
            duration: 0.5,
            ease: 'back.out'
        });
    }, 2000);

    // Close notification
    document.querySelector('.notification-close').addEventListener('click', (e) => {
        e.stopPropagation();
        gsap.to(notificationBubble, {
            y: 20,
            opacity: 0,
            duration: 0.3,
            onComplete: () => {
                notificationBubble.style.display = 'none';
            }
        });
    });

    // Open chat when notification is clicked
    notificationBubble.addEventListener('click', () => {
        gsap.to(notificationBubble, {
            y: 20,
            opacity: 0,
            duration: 0.3,
            onComplete: () => {
                notificationBubble.style.display = 'none';
                openChatWindow();
            }
        });
    });

    // Initial pulse animation for chatbot toggle
    gsap.to(chatbotToggle, {
        scale: 1.1,
        duration: 1.2,
        repeat: -1,
        yoyo: true,
        ease: "power1.inOut"
    });

    // Toggle chatbot window
    chatbotToggle.addEventListener('click', () => {
        const isVisible = chatbotWindow.style.display === 'block';
        if (isVisible) {
            closeChatWindow();
        } else {
            openChatWindow();
        }
    });

    // Function to open chat window
    function openChatWindow() {
        // Hide notification if visible
        if (notificationBubble.style.display !== 'none') {
            gsap.to(notificationBubble, {
                y: 20,
                opacity: 0,
                duration: 0.3,
                onComplete: () => {
                    notificationBubble.style.display = 'none';
                }
            });
        }

        chatbotWindow.style.display = 'flex'; // Use flex for proper layout
        localStorage.setItem('chatbotOpen', 'true');

        // Stop the pulse animation when opening
        gsap.killTweensOf(chatbotToggle);
        gsap.to(chatbotToggle, { scale: 1, duration: 0.3 });

        // Enhanced opening animation with constrained positioning
        gsap.fromTo(chatbotWindow,
            { y: 50, opacity: 0, scale: 0.9 },
            { y: 0, opacity: 1, scale: 1, duration: 0.5, ease: 'power2.out' }
        );

        // Adjust height to fit viewport if necessary
        const windowHeight = window.innerHeight;
        const chatbotRect = chatbotWindow.getBoundingClientRect();
        if (chatbotRect.height > windowHeight * 0.8) {
            chatbotWindow.style.height = `${windowHeight * 0.8}px`;
        }

        // If there's no greeting yet, show it
        if (!hasGreeted) {
            setTimeout(showGreeting, 600);
            hasGreeted = true;
            localStorage.setItem('chatbotHasGreeted', 'true');
        } else if (userName && chatbotBody.querySelectorAll('.chatbot-message').length === 0) {
            setTimeout(showOptions, 600);
        }

        // Focus the input field
        setTimeout(() => {
            chatbotInput.focus();
        }, 700);
    }

    // Function to close chat window
    function closeChatWindow() {
        gsap.to(chatbotWindow, {
            y: 50,
            opacity: 0,
            scale: 0.9,
            duration: 0.4,
            ease: 'power3.in',
            onComplete: () => {
                chatbotWindow.style.display = 'none';
                chatbotWindow.style.height = ''; // Reset height
                localStorage.setItem('chatbotOpen', 'false');
                // Restart the pulse animation
                gsap.to(chatbotToggle, {
                    scale: 1.1,
                    duration: 1.2,
                    repeat: -1,
                    yoyo: true,
                    ease: "power1.inOut"
                });
            }
        });
    }

    // Close chatbot window
    closeBtn.addEventListener('click', (e) => {
        e.preventDefault();
        closeChatWindow();
    });

    // Minimize chatbot window
    if (minimizeBtn) {
        minimizeBtn.addEventListener('click', (e) => {
            e.preventDefault();
            const chatbotFooter = document.querySelector('.chatbot-footer');
            if (isChatMinimized) {
                // Restore window
                gsap.to(chatbotWindow, {
                    height: 'auto',
                    duration: 0.4,
                    ease: 'power2.out',
                    onComplete: () => {
                        chatbotBody.style.display = 'block';
                        chatbotBody.style.opacity = 0;
                        gsap.to(chatbotBody, { opacity: 1, duration: 0.3 });

                        chatbotFooter.style.display = 'flex';
                        chatbotFooter.style.opacity = 0;
                        gsap.to(chatbotFooter, { opacity: 1, duration: 0.3 });

                        minimizeBtn.innerHTML = '−';
                    }
                });
            } else {
                // Minimize window
                chatbotBody.style.display = 'none';
                chatbotFooter.style.display = 'none';

                gsap.to(chatbotWindow, {
                    height: '50px',
                    duration: 0.4,
                    ease: 'power2.out',
                    onComplete: () => {
                        minimizeBtn.innerHTML = '+';
                    }
                });
            }
            isChatMinimized = !isChatMinimized;
        });
    }

    // Dynamic greeting
    function getDynamicGreeting() {
        const hour = new Date().getHours();
        if (hour < 12) return 'Good Morning';
        if (hour < 18) return 'Good Afternoon';
        return 'Good Evening';
    }

    // Get current timestamp
    function getTimestamp() {
        return new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    }

    // Show greeting or welcome back
    function showGreeting() {
        const greeting = userName
            ? `${getDynamicGreeting()}, ${userName}! Welcome to HMS Assistant. Type 'help' for options.`
            : `${getDynamicGreeting()}! I'm your HMS Assistant. May I have your name, please?`;
        addMessage(greeting, 'bot');
        if (userName) showOptions();
    }

    // Add message to chat
    function addMessage(text, sender) {
        const message = document.createElement('div');
        message.className = `chatbot-message ${sender}`;
        message.innerHTML = `${text}<span class="timestamp">${getTimestamp()}</span>`;
        chatbotBody.appendChild(message);

        // Message animation
        gsap.fromTo(message,
            { x: sender === 'bot' ? -20 : 20, opacity: 0, scale: 0.95 },
            { x: 0, opacity: 1, scale: 1, duration: 0.4, ease: 'back.out(1.7)' }
        );

        // Auto-scroll
        gsap.to(chatbotBody, {
            scrollTop: chatbotBody.scrollHeight,
            duration: 0.4,
            ease: "power2.out"
        });
    }

    // Show typing indicator
    function showTypingIndicator() {
        const typing = document.createElement('div');
        typing.className = 'chatbot-typing';
        typing.innerHTML = '<span class="dot"></span><span class="dot"></span><span class="dot"></span>';
        chatbotBody.appendChild(typing);

        gsap.fromTo(typing,
            { opacity: 0, y: 10 },
            { opacity: 1, y: 0, duration: 0.3 }
        );

        gsap.to('.chatbot-typing .dot', {
            y: -5,
            stagger: 0.2,
            repeat: -1,
            yoyo: true,
            duration: 0.4
        });

        gsap.to(chatbotBody, {
            scrollTop: chatbotBody.scrollHeight,
            duration: 0.4
        });

        return typing;
    }

    // Hide typing indicator
    function hideTypingIndicator(typing) {
        gsap.to(typing, {
            opacity: 0,
            y: 10,
            duration: 0.3,
            onComplete: () => typing.remove()
        });
    }

    // Show navigation options
    function showOptions() {
        const optionsDiv = document.createElement('div');
        optionsDiv.className = 'chatbot-options';
        const options = [
            { text: 'Patients', url: 'patients.jsp', icon: '👨‍⚕️' },
            { text: 'Doctors', url: 'doctors.jsp', icon: '🩺' },
            { text: 'Appointments', url: 'appointments.jsp', icon: '📅' },
            { text: 'About Page', url: 'about.jsp', icon: 'ℹ️' }
        ];

        options.forEach(opt => {
            const btn = document.createElement('button');
            btn.className = 'chatbot-option-btn';
            btn.innerHTML = `${opt.icon} ${opt.text}`;
            btn.addEventListener('click', () => {
                window.location.href = opt.url;
            });
            optionsDiv.appendChild(btn);
        });

        chatbotBody.appendChild(optionsDiv);

        gsap.fromTo('.chatbot-option-btn',
            { y: 20, opacity: 0, scale: 0.9 },
            { y: 0, opacity: 1, scale: 1, stagger: 0.1, duration: 0.5, ease: 'power2.out' }
        );

        gsap.to(chatbotBody, {
            scrollTop: chatbotBody.scrollHeight,
            duration: 0.4,
            ease: "power2.out"
        });
    }

    // Send message function
    async function sendMessage() {
        const userInput = chatbotInput.value.trim().toLowerCase();
        if (!userInput) return;

        addMessage(userInput, 'user');
        chatbotInput.value = '';

        if (!userName) {
            userName = userInput;
            localStorage.setItem('chatbotUserName', userName);
            setTimeout(() => {
                addMessage(`Nice to meet you, ${userName}! How can I assist you today? Type 'help' for options.`, 'bot');
                showOptions();
            }, 500);
        } else if (userInput === 'help') {
            showOptions();
        } else if (userInput.includes('patient')) {
            addMessage('Navigating to Patients...', 'bot');
            setTimeout(() => { window.location.href = 'patients.jsp'; }, 500);
        } else if (userInput.includes('doctor')) {
            addMessage('Navigating to Doctors...', 'bot');
            setTimeout(() => { window.location.href = 'doctors.jsp'; }, 500);
        } else if (userInput.includes('appointment')) {
            addMessage('Navigating to Appointments...', 'bot');
            setTimeout(() => { window.location.href = 'appointments.jsp'; }, 500);
        } else if (userInput.includes('about')) {
            addMessage('Navigating to About...', 'bot');
            setTimeout(() => { window.location.href = 'about.jsp'; }, 500);
        } else {
            const typing = showTypingIndicator();
            try {
                const response = await fetch(`${GEMINI_API_URL}?key=${GEMINI_API_KEY}`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ contents: [{ parts: [{ text: userInput }] }] })
                });
                hideTypingIndicator(typing);
                const data = await response.json();
                const reply = data?.candidates?.[0]?.content?.parts?.[0]?.text.replace(/\*\*/g, '') || 'Sorry, I couldn’t process that.';
                setTimeout(() => addMessage(reply, 'bot'), 400);
            } catch (error) {
                hideTypingIndicator(typing);
                setTimeout(() => addMessage('Oops! Something went wrong. Try again or type "help" for options.', 'bot'), 400);
            }
        }
    }

    // Handle user input via Enter key
    chatbotInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') {
            sendMessage();
        }
    });

    // Handle user input via Send button
    document.querySelector('.send-btn').addEventListener('click', () => {
        sendMessage();
    });

    // Send button effect
    chatbotInput.addEventListener('input', () => {
        const sendButton = document.querySelector('.send-btn');
        if (sendButton) {
            if (chatbotInput.value.trim()) {
                gsap.to(sendButton, { scale: 1, opacity: 1, duration: 0.3 });
            } else {
                gsap.to(sendButton, { scale: 0.9, opacity: 0.6, duration: 0.3 });
            }
        }
    });

    // Accessibility: Focus input on Enter key
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Enter' && document.activeElement !== chatbotInput && chatbotWindow.style.display === 'flex') {
            chatbotInput.focus();
            gsap.fromTo(chatbotInput,
                { boxShadow: '0 0 0 3px rgba(26, 188, 156, 0.3)' },
                { boxShadow: '0 0 0 3px rgba(26, 188, 156, 0)', duration: 1.5 }
            );
        }
    });

    // Click outside to close
    document.addEventListener('click', (e) => {
        if (chatbotWindow.style.display === 'flex') {
            const isClickInside = chatbotWindow.contains(e.target) || chatbotToggle.contains(e.target);
            if (!isClickInside) {
                closeChatWindow();
            }
        }
    });

    // Prevent clicks inside chatbot from bubbling up
    chatbotWindow.addEventListener('click', (e) => {
        e.stopPropagation();
    });

    // Persist chatbot state
    window.addEventListener('load', () => {
        if (localStorage.getItem('chatbotOpen') === 'true') {
            openChatWindow();
        }
    });

    // Adjust chatbot position on resize
    window.addEventListener('resize', () => {
        if (chatbotWindow.style.display === 'flex') {
            const windowHeight = window.innerHeight;
            const chatbotRect = chatbotWindow.getBoundingClientRect();
            if (chatbotRect.height > windowHeight * 0.8) {
                chatbotWindow.style.height = `${windowHeight * 0.8}px`;
            } else {
                chatbotWindow.style.height = ''; // Reset if within bounds
            }
        }
    });
});