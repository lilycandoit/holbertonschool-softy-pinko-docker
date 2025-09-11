document.addEventListener('DOMContentLoaded', function() {
    const testApiButton = document.getElementById('test-api');
    
    testApiButton.addEventListener('click', async function() {
        // Create result div if it doesn't exist
        let resultDiv = document.getElementById('api-result');
        if (!resultDiv) {
            resultDiv = document.createElement('div');
            resultDiv.id = 'api-result';
            testApiButton.parentNode.appendChild(resultDiv);
        }
        
        try {
            // Try to connect to the API (this will work in task3 when we have both containers)
            const response = await fetch('/api/hello');
            
            if (response.ok) {
                const data = await response.text();
                resultDiv.textContent = `API Response: ${data}`;
                resultDiv.className = 'success';
            } else {
                throw new Error(`HTTP ${response.status}`);
            }
        } catch (error) {
            resultDiv.textContent = `API Connection Failed: ${error.message}. This is expected in task2 - API will work in task3!`;
            resultDiv.className = 'error';
        }
        
        resultDiv.style.display = 'block';
    });
});