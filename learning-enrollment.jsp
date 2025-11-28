<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Programmize - Enrollment</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://js.stripe.com/v3/"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        .input-field {
            width: 100%;
            padding: 0.75rem 1rem;
            border-radius: 0.5rem;
            border: 1px solid #e5e7eb;
            outline: none;
            transition: all 0.2s;
        }
        .input-field:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 2px #bfdbfe;
        }
        .card {
            background-color: white;
            padding: 1.5rem;
            border-radius: 0.75rem;
            box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            border: 1px solid #f3f4f6;
        }
        .section-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: whitesmoke;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .badge {
            background-color: #dbeafe;
            padding: 0.25rem 0.75rem;
            border-radius: 0.25rem;
            font-size: 1.125rem;
        }
        .user-badge {
            background-color: #ecfeff;
            border-left: 4px solid #06b6d4;
            padding: 0.75rem;
            margin-bottom: 1.25rem;
            color: #0e7490;
            font-size: 0.875rem;
            display: flex;
            align-items: center;
        }
    </style>
</head>

<body class="bg-gray-50 font-sans text-gray-800">

<main class="container mx-auto px-4 py-8 max-w-6xl">
    <h1 class="text-3xl font-bold text-blue-600 text-center mb-8">Programmize - Learning Enrollment</h1>

    <form id="registration-form" action="register" method="POST" class="flex flex-col lg:flex-row gap-8">
        <div class="flex-1 space-y-6">

            <div class="card bg-white p-6 rounded-lg shadow-sm border border-gray-100">
                <h2 class="section-title text-xl font-bold text-gray-700 mb-4 border-b pb-2">
                    <span class="badge bg-blue-600 text-white px-2 py-1 rounded text-sm mr-2">1</span>
                    Registrant's Information
                </h2>

                <div class="user-badge mb-4 text-sm text-gray-600">
                    <i class="fas fa-user-circle mr-2 text-lg"></i>
                    Logged in as: <strong>user@example.com</strong>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                    <input type="text" name="firstName" class="input-field" placeholder="First Name *" required>
                    <input type="text" name="lastName" class="input-field" placeholder="Last Name *" required>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <input type="email" name="email" class="input-field" placeholder="Email *" required>
                    <div class="relative">
                        <span class="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400">
                            <i class="fas fa-phone"></i>
                        </span>
                        <input type="tel" name="phone" class="input-field pl-10" placeholder="Phone Number *" required>
                    </div>
                </div>
            </div>

            <div class="card bg-white p-6 rounded-lg shadow-sm border border-gray-100">
                <h2 class="section-title text-xl font-bold text-gray-700 mb-4 border-b pb-2">
                    <span class="badge bg-blue-600 text-white px-2 py-1 rounded text-sm mr-2">2</span>
                    Enroll Information
                </h2>

                <label class="block font-semibold text-gray-700 mb-2 text-sm">Select Course</label>
                <select id="courseSelect" name="course" class="input-field mb-4 cursor-pointer">
                    <option value="web-dev" data-price="299">Web Development ($299)</option>
                    <option value="data-sci" data-price="249">Data Science ($249)</option>
                    <option value="ml-ai" data-price="299">Machine Learning ($299)</option>
                    <option value="app-dev" data-price="249">Mobile App Development ($249)</option>
                    <option value="python" data-price="99">Python Programming ($99)</option>
                    <option value="ui-ux" data-price="149">UI/UX Design ($149)</option>
                    <option value="cybersec" data-price="299">Cybersecurity ($299)</option>
                    <option value="cloud" data-price="249">Cloud Computing ($249)</option>
                    <option value="devops" data-price="279">DevOps Engineering ($279)</option>
                    <option value="blockchain" data-price="199">Blockchain Fundamentals ($199)</option>
                </select>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <input type="date" id="startDate" name="startDate" class="input-field" required>

                    <div>
                        <input type="date" id="endDate" name="endDate" class="input-field" required>
                        <p id="date-error" class="text-xs text-red-500 mt-1 hidden">
                            <i class="fas fa-exclamation-circle"></i> Invalid End Date
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <div class="w-full lg:w-1/3">
            <div class="card sticky top-6">
                <h3 class="text-xl font-bold text-gray-800 mb-4">Summary</h3>

                <div class="border-b pb-4 mb-4 text-sm">
                    <div class="flex justify-between text-gray-600">
                        <span>Fee</span>
                        <span>$<span id="fee-amt">299</span>.00</span>
                    </div>

                    <div class="flex justify-between text-red-600 text-xl font-bold mt-2">
                        <span>Total</span>
                        <span>$<span id="total-amt">299</span>.00</span>
                    </div>
                </div>

                <h4 class="font-bold text-gray-700 mb-3">Payment Method</h4>

                <div class="grid grid-cols-2 gap-3 mb-5">
                    <label class="cursor-pointer border rounded p-3 text-center hover:bg-blue-50">
                        <input type="radio" name="pm" value="card" class="hidden" checked>
                        <i class="fas fa-credit-card text-blue-600 text-xl mb-1"></i>
                        <span class="text-xs font-bold">Card</span>
                    </label>

                    <label class="cursor-pointer border rounded p-3 text-center hover:bg-pink-50">
                        <input type="radio" name="pm" value="momo" class="hidden">
                        <i class="fas fa-wallet text-pink-600 text-xl mb-1"></i>
                        <span class="text-xs font-bold">MoMo</span>
                    </label>

                    <label class="cursor-pointer border rounded p-3 text-center hover:bg-blue-50">
                        <input type="radio" name="pm" value="zalopay" class="hidden">
                        <i class="fas fa-mobile-alt text-blue-400 text-xl mb-1"></i>
                        <span class="text-xs font-bold">ZaloPay</span>
                    </label>

                    <label class="cursor-pointer border rounded p-3 text-center hover:bg-green-50">
                        <input type="radio" name="pm" value="bank" class="hidden">
                        <i class="fas fa-university text-green-700 text-xl mb-1"></i>
                        <span class="text-xs font-bold">Bank</span>
                    </label>
                </div>

                <div id="stripe-box" class="mb-4">
                    <div id="card-element" class="p-3 border rounded bg-white"></div>
                    <div id="card-errors" class="text-red-500 text-xs mt-1"></div>
                </div>

                <div id="manual-box" class="hidden mb-4 p-3 bg-gray-50 border rounded text-sm text-gray-600"></div>

                <label class="flex items-start gap-2 mb-6 text-xs text-gray-500 cursor-pointer">
                    <input type="checkbox" required class="mt-1">
                    I agree to Terms & Conditions.
                </label>

                <input type="hidden" id="stripeToken" name="stripeToken">

                <button type="submit" id="btn"
                        class="w-full bg-red-500 hover:bg-red-600 text-white font-bold py-3 rounded-lg shadow flex justify-center items-center gap-2 transition-colors">
                    <i class="fas fa-lock"></i>
                    <span id="btn-text">Pay $299.00</span>
                </button>
            </div>
        </div>
    </form>
</main>

<script>
    // 1. Configuration
    const stripeKey = 'pk_test_TYooMQauvdEDq54NiTphI7jx';
    const methodNames = {
        'momo': 'MoMo App',
        'zalopay': 'ZaloPay App',
        'bank': 'Bank Transfer Portal'
    };

    let stripe, elements, card;

    document.addEventListener('DOMContentLoaded', () => {
        setupEventListeners();

        const requiredInputs = document.querySelectorAll('input[required], select[required]');
        requiredInputs.forEach(function(input) {
            input.addEventListener('invalid', function(e) { e.target.setCustomValidity('Please fill this box'); });
            input.addEventListener('input', function(e) { e.target.setCustomValidity(''); });
        });

        try {
            if (typeof Stripe !== 'undefined') {
                stripe = Stripe(stripeKey);
                elements = stripe.elements();
                card = elements.create("card", {
                    style: { base: { fontSize: "16px", color: "#32325d" } }
                });
                card.mount("#card-element");
            }
        } catch (error) {
            console.error("Stripe init failed:", error);
        }
    });

    const getDOM = function() {
        return {
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
            stripeTokenInput: document.getElementById('stripeToken')
        };
    };

    function setupEventListeners() {
        const DOM = getDOM();
        if (DOM.courseSelect) {
            DOM.courseSelect.addEventListener('change', updatePrice);
        }
        if (DOM.pmInputs) {
            DOM.pmInputs.forEach(function(input) {
                input.addEventListener('change', function(e) { togglePm(e.target.value); });
            });
        }
        if (DOM.form) {
            DOM.form.addEventListener('submit', handleFormSubmit);
        }
    }

    function updatePrice() {
        const DOM = getDOM();
        const selectedOption = DOM.courseSelect.options[DOM.courseSelect.selectedIndex];
        const price = selectedOption.getAttribute('data-price');

        DOM.fee.textContent = price;
        DOM.total.textContent = price;

        // FIXED: Used string concatenation (+) instead of backticks
        DOM.btnText.textContent = 'Pay $' + price + '.00';
    }

    function togglePm(method) {
        const DOM = getDOM();
        const isCard = method === 'card';

        if(isCard) {
            DOM.stripeBox.classList.remove('hidden');
            DOM.manualBox.classList.add('hidden');
        } else {
            DOM.stripeBox.classList.add('hidden');
            DOM.manualBox.classList.remove('hidden');

            // FIXED: Used string concatenation (+) to avoid JSP EL conflict
            DOM.manualBox.innerHTML =
                '<div class="flex items-center gap-2">' +
                '<i class="fas fa-info-circle text-blue-500"></i>' +
                '<span>Redirecting to <strong>' + methodNames[method] + '</strong>...</span>' +
                '</div>';
        }
    }

    function validateDates() {
        const DOM = getDOM();
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

    async function handleFormSubmit(e) {
        e.preventDefault();
        const DOM = getDOM();
        if (!validateDates()) return;
        setLoading(true);

        const method = document.querySelector('input[name="pm"]:checked').value;

        if (method === 'card') {
            await processStripePayment();
        } else {
            await simulateManualPayment();
        }
    }

    async function processStripePayment() {
        const DOM = getDOM();
        if (!stripe || !card) {
            alert("Stripe is not loaded.");
            setLoading(false);
            return;
        }
        const result = await stripe.createToken(card);
        if (result.error) {
            document.getElementById('card-errors').textContent = result.error.message;
            setLoading(false);
        } else {
            DOM.stripeTokenInput.value = result.token.id;
            DOM.form.submit();
        }
    }

    function simulateManualPayment() {
        const DOM = getDOM();
        return new Promise(function(resolve) {
            setTimeout(function() {
                DOM.form.submit();
                resolve();
            }, 1000);
        });
    }

    function setLoading(isLoading) {
        const DOM = getDOM();
        DOM.btn.disabled = isLoading;
        if (isLoading) {
            DOM.btnText.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
        } else {
            const currentPrice = DOM.fee.textContent;
            // FIXED: Concatenation
            DOM.btnText.textContent = 'Pay $' + currentPrice + '.00';
        }
    }
</script>

</body>
</html>