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
    <link rel="stylesheet" href="assets/style.css">
</head>

<body class="bg-gray-50 font-sans text-gray-800">

<main class="container mx-auto px-4 py-8 max-w-6xl">
    <h1 class="text-3xl font-bold text-blue-600 text-center mb-8">Programmize - Learning Enrollment</h1>

    <% String error = (String) request.getAttribute("errorMessage"); %>
    <% String success = (String) request.getAttribute("successMessage"); %>

    <% if (error != null) { %>
    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
        <strong class="font-bold">Error!</strong>
        <span class="block sm:inline"><%= error %></span>
    </div>
    <% } %>

    <% if (success != null) { %>
    <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4" role="alert">
        <strong class="font-bold">Success!</strong>
        <span class="block sm:inline"><%= success %></span>
    </div>
    <% } %>

    <form id="registration-form" action="enroll" method="POST" class="flex flex-col lg:flex-row gap-8">
        <div class="flex-1 space-y-6">
            <div class="card bg-white p-6 rounded-lg shadow-sm border border-gray-100">
                <h2 class="section-title text-xl font-bold text-gray-700 mb-4 border-b pb-2">
                    <span class="badge bg-blue-600 text-white px-2 py-1 rounded text-sm mr-2">1</span> Registrant's Information
                </h2>

                <div class="user-badge mb-4 text-sm text-gray-600">
                    <i class="fas fa-user-circle mr-2 text-lg"></i>
                    Logged in as: <strong><%= "user@example.com" %></strong>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                    <input type="text" name="firstName" class="input-field w-full p-3 border rounded focus:ring-2 focus:ring-blue-500 outline-none" placeholder="First Name *" required>
                    <input type="text" name="lastName" class="input-field w-full p-3 border rounded focus:ring-2 focus:ring-blue-500 outline-none" placeholder="Last Name *" required>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <input type="email" name="email" class="input-field w-full p-3 border rounded focus:ring-2 focus:ring-blue-500 outline-none" placeholder="Email *" required>
                    <div class="relative">
                        <span class="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400">
                            <i class="fas fa-phone"></i>
                        </span>
                        <input type="tel" name="phone" class="input-field w-full p-3 pl-10 border rounded focus:ring-2 focus:ring-blue-500 outline-none" placeholder="Phone Number *" required>
                    </div>
                </div>
            </div>

            <div class="card bg-white p-6 rounded-lg shadow-sm border border-gray-100">
                <h2 class="section-title text-xl font-bold text-gray-700 mb-4 border-b pb-2">
                    <span class="badge bg-blue-600 text-white px-2 py-1 rounded text-sm mr-2">2</span> Enroll Information
                </h2>

                <label class="block text-sm font-semibold text-gray-700 mb-2">Select Course</label>
                <select id="courseSelect" name="course" class="input-field w-full p-3 border rounded mb-4 cursor-pointer focus:ring-2 focus:ring-blue-500 outline-none">
                    <option value="web-dev" data-price="299">Web Development ($299)</option>
                    <option value="data-sci" data-price="249">Data Science ($249)</option>
                    <option value="ml-ai" data-price="299">Machine Learning ($299)</option>
                    <option value="app-dev" data-price="249">Mobile App Development ($249)</option>
                    <option value="python" data-price="99">Python Programming ($99)</option>
                    <option value="ui-ux" data-price="149">UI/UX Design ($149)</option>
                    <option value="cybersec" data-price="299">Cybersecurity ($299)</option>
                    <option value="cloud" data-price="249">Cloud Computing (AWS/Azure) ($249)</option>
                    <option value="devops" data-price="279">DevOps Engineering ($279)</option>
                    <option value="blockchain" data-price="199">Blockchain Fundamentals ($199)</option>
                </select>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <input type="date" id="startDate" name="startDate" class="input-field w-full p-3 border rounded focus:ring-2 focus:ring-blue-500 outline-none" required>

                    <div>
                        <input type="date" id="endDate" name="endDate" class="input-field w-full p-3 border rounded focus:ring-2 focus:ring-blue-500 outline-none" required>
                        <p id="date-error" class="text-xs text-red-500 mt-1 hidden">
                            <i class="fas fa-exclamation-circle"></i> Invalid End Date
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <div class="w-full lg:w-1/3">
            <div class="card sticky top-6 bg-white p-6 rounded-lg border-blue-100 shadow-lg">
                <h3 class="text-xl font-bold text-gray-800 mb-4">Summary</h3>

                <div class="border-b pb-4 mb-4 space-y-2 text-sm">
                    <div class="flex justify-between text-gray-600">
                        <span>Fee</span>
                        <span>$<span id="fee-amt">299</span>.00</span>
                    </div>

                    <div class="flex justify-between items-center text-red-600 text-xl font-bold mt-2">
                        <span>Total</span>
                        <span>$<span id="total-amt">299</span>.00</span>
                    </div>
                </div>

                <h4 class="font-bold text-gray-700 mb-3">Payment Method</h4>

                <div class="grid grid-cols-2 gap-3 mb-5" id="payment-options">

                    <label class="cursor-pointer border rounded p-3 text-center hover:bg-blue-50 has-[:checked]:border-blue-600 has-[:checked]:bg-blue-50 transition">
                        <input type="radio" name="pm" value="card" class="hidden" checked onchange="togglePm('card')" />
                        <i class="fas fa-credit-card text-blue-600 block text-xl mb-1"></i>
                        <span class="text-xs font-bold">Card</span>
                    </label>

                    <label class="cursor-pointer border rounded p-3 text-center hover:bg-pink-50 has-[:checked]:border-pink-600 has-[:checked]:bg-pink-50 transition">
                        <input type="radio" name="pm" value="momo" class="hidden" onchange="togglePm('momo')" />
                        <i class="fas fa-wallet text-pink-600 block text-xl mb-1"></i>
                        <span class="text-xs font-bold">MoMo</span>
                    </label>

                    <label class="cursor-pointer border rounded p-3 text-center hover:bg-blue-50 has-[:checked]:border-blue-400 has-[:checked]:bg-blue-50 transition">
                        <input type="radio" name="pm" value="zalopay" class="hidden" onchange="togglePm('zalopay')" />
                        <i class="fas fa-mobile-alt text-blue-400 block text-xl mb-1"></i>
                        <span class="text-xs font-bold">ZaloPay</span>
                    </label>

                    <label class="cursor-pointer border rounded p-3 text-center hover:bg-green-50 has-[:checked]:border-green-600 has-[:checked]:bg-green-50 transition">
                        <input type="radio" name="pm" value="bank" class="hidden" onchange="togglePm('bank')" />
                        <i class="fas fa-university text-green-700 block text-xl mb-1"></i>
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

                <input type="hidden" name="stripeToken" id="stripeToken">

                <button type="submit" id="btn"
                        class="w-full bg-red-500 hover:bg-red-600 text-white font-bold py-3 rounded-lg shadow transition flex justify-center items-center gap-2">
                    <i class="fas fa-lock"></i>
                    <span id="btn-text">Pay $299.00</span>
                </button>
            </div>
        </div>
    </form>
</main>

<script src="assets/script.js"></script>
</body>
</html>