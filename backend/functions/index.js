const { onSchedule } = require("firebase-functions/v2/scheduler");
const { getFirestore } = require("firebase-admin/firestore");
const { initializeApp } = require("firebase-admin/app");

initializeApp();
const db = getFirestore();

exports.tickMarket = onSchedule("every 1 minutes", async (event) => {
    const stocksRef = db.collection("stocks");
    const snapshot = await stocksRef.get();

    const batch = db.batch();

    snapshot.forEach(doc => {
        const data = doc.data();
        const volatility = 0.05;
        const changePercent = (Math.random() * 2 - 1) * volatility;
        const newPrice = data.currentPrice * (1 + changePercent);
        const finalPrice = Math.max(0.01, newPrice);

        const history = data.priceHistory || [];
        history.push(finalPrice);
        if (history.length > 50) history.shift(); // Keep last 50 points

        batch.update(doc.ref, {
            currentPrice: finalPrice,
            priceHistory: history
        });
    });

    await batch.commit();
    console.log("Market ticked successfully.");
});
