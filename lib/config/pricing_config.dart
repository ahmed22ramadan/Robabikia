/// أسعار تقريبية لكل فئة في السوق المصري (جنيه مصري)، بناءً على متوسط
/// نطاقات الأسعار وقت كتابة الكود. الأسعار بتتغيّر باستمرار، فده تقدير
/// استرشادي للعميل بس، مش سعر نهائي ملزم — راجعها بين فترة وفترة وعدّلها
/// هنا حسب السوق الفعلي.
///
/// ملحوظة عن فئتين بالذات:
/// "عبوات الكانز" و"أطباق ألومنيوم" بيتحسبوا بالعدد في التطبيق، لكن سعر
/// السوق بيتحدد بالكيلو. عشان كده افترضنا وزن تقريبي للقطعة الواحدة
/// (تقدر تعدّله هنا لو عندك رقم أدق من خبرتك):
///   - وزن العلبة الواحدة (كانز) ≈ 15 جرام
///   - وزن الطبق الواحد (ألومنيوم) ≈ 30 جرام
class CategoryPricing {
  /// جنيه لكل كيلو (للفئات الموزونة) أو لكل قطعة (للفئات المعدودة).
  final double pricePerUnit;

  const CategoryPricing({required this.pricePerUnit});
}

const Map<String, CategoryPricing> categoryPricing = {
  // 100-130 ج/كيلو (متوسط 115) × 0.015 كيلو/علبة تقريبًا
  'cans': CategoryPricing(pricePerUnit: 1.7),
  // متوسط الطري (150-160) والناشف (95-120)
  'aluminum_scrap': CategoryPricing(pricePerUnit: 128),
  // 80-100 ج/كيلو (ألومنيوم خفيف/مخلوط)
  'foil': CategoryPricing(pricePerUnit: 90),
  // نفس سعر الكيلو بتاع الفويل × 0.03 كيلو/طبق تقريبًا
  'aluminum_trays': CategoryPricing(pricePerUnit: 2.7),
  // 12-25 ج/كيلو (متوسط 18.5)
  'plastic': CategoryPricing(pricePerUnit: 18.5),
  // 50-70 ج/فردة (متوسط 60) — بالعدد مباشرة، مفيش تحويل وزن
  'tires': CategoryPricing(pricePerUnit: 60),
  // متوسط الخليط (19) والمميز (21)
  'iron_scrap': CategoryPricing(pricePerUnit: 20),
};

/// بيرجع السعر التقريبي لكمية معيّنة من فئة معيّنة، أو null لو الفئة
/// مش موجودة في جدول الأسعار.
double? estimatedPriceFor(String categoryId, double quantity) {
  final pricing = categoryPricing[categoryId];
  if (pricing == null) return null;
  return quantity * pricing.pricePerUnit;
}
