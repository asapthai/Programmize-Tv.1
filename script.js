const stripeKey = 'pk_test_TYooMQauvdEDq54NiTphI7jx';
const stripe = Stripe(stripeKey);
const elements = stripe.elements();
const card = elements.create("card", {
    style: { base: { fontSize: "16px", color: "#32325d" } }
});

// Cache DOM Elements
const DOM = {
    form: document.getElementById('registration-form'),
    courseSelect: document.getElementById('courseSelect'),
    startDate: document.getElementById('startDate'),
    endDate: document.getElementById('endDate'),
    errorMsg: document.getElementById('date-error'),
    stripeBox: document.getElementById('stripe-box'),
    manualBox: document.getElementById('manual-box'),
    btn: document.getElementById('btn'),
    btnText: document.getElementById('btn-text'),
    fee: document.getElementById('fee-amt'),
    total: document.getElementById('total-amt'),
    pmInputs: document.querySelectorAll('input[name="pm"]'),
    stripeTokenInput: document.getElementById('stripeToken') // Added reference
};

const methodNames = {
    'momo': 'MoMo App',
    'zalopay': 'ZaloPay App',
    'bank': 'Bank Transfer Portal'
};

// 2. Main Execution
document.addEventListener('DOMContentLoaded', () => {
    card.mount("#card-element");
    setupEventListeners();
    const requiredInputs = document.querySelectorAll('input[required], select[required]');

    requiredInputs.forEach(input => {
        input.addEventListener('invalid', (e) => {
            e.target.setCustomValidity('Please fill this box');
        });
        input.addEventListener('input', (e) => {
            e.target.setCustomValidity('');
        });
    });
});

// 3. Event Handlers
function setupEventListeners() {
    // Change Course Price
    DOM.courseSelect.addEventListener('change', updatePrice);

    // Toggle Payment Method
    DOM.pmInputs.forEach(input => {
        input.addEventListener('change', (e) => togglePm(e.target.value));
    });

    // Handle Submit
    DOM.form.addEventListener('submit', handleFormSubmit);
}

// 4. Logic Functions
function updatePrice() {
    const selectedOption = DOM.courseSelect.options[DOM.courseSelect.selectedIndex];
    const price = selectedOption.getAttribute('data-price');

    DOM.fee.textContent = price;
    DOM.total.textContent = price;
    DOM.btnText.textContent = `Pay $${price}.00`;
}

function togglePm(method) {
    const isCard = method === 'card';

    DOM.stripeBox.classList.toggle('hidden', !isCard);
    DOM.manualBox.classList.toggle('hidden', isCard);

    if (!isCard) {
        DOM.manualBox.innerHTML = `
            <i class="fas fa-info-circle text-blue-500"></i> 
            You will be redirected to the <strong>${methodNames[method]}</strong> to complete payment.
        `;
    }
}

async function handleFormSubmit(e) {
    // Prevent default form submission initially to handle logic/Stripe
    e.preventDefault();

    // Validate Dates
    if (!validateDates()) return;

    // UI Loading
    setLoading(true);

    const method = document.querySelector('input[name="pm"]:checked').value;

    if (method === 'card') {
        await processStripePayment();
    } else {
        await simulateManualPayment();
    }
}

function validateDates() {
    if (DOM.startDate.value && DOM.endDate.value) {
        const start = new Date(DOM.startDate.value);
        const end = new Date(DOM.endDate.value);

        if (end < start) {
            DOM.errorMsg.classList.remove('hidden');
            return false;
        }
    }
    DOM.errorMsg.classList.add('hidden');
    return true;
}

// 5. Payment Processing
async function processStripePayment() {
    const { token, error } = await stripe.createToken(card);

    if (error) {
        document.getElementById('card-errors').textContent = error.message;
        setLoading(false);
    } else {
        console.log('Stripe Token:', token);
        // Set the token to the hidden input
        DOM.stripeTokenInput.value = token.id;
        // SUBMIT the form to the Servlet
        DOM.form.submit();
    }
}

function simulateManualPayment() {
    return new Promise(resolve => {
        setTimeout(() => {
            // For manual payments, just submit the form to the Servlet
            DOM.form.submit();
            resolve();
        }, 1500);
    });
}

function setLoading(isLoading) {
    DOM.btn.disabled = isLoading;
    if (isLoading) {
        DOM.btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
    } else {
        const currentPrice = DOM.fee.textContent;
        DOM.btn.innerHTML = `<i class="fas fa-lock"></i> <span id="btn-text">Pay $${currentPrice}.00</span>`;
    }
}