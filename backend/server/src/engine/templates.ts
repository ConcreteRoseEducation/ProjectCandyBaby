export type EventTemplate = {
  id: string;
  type: string;
  scope: "stock" | "sector" | "market";
  targetKey?: string;
  title: string;
  narrative: string;
  magnitude: number;
  durationTicks: number;
  weight: number;
};

export const EVENT_TEMPLATES: EventTemplate[] = [
  {
    id: "fiz_earnings_beat",
    type: "earnings_beat",
    scope: "stock",
    targetKey: "FIZ",
    title: "Fizzy Drinks crushes earnings",
    narrative: "Fizzy Drinks Corp reports a surprise jump in soda sales after a heat wave. Shares pop as investors pile in.",
    magnitude: 0.06,
    durationTicks: 4,
    weight: 3,
  },
  {
    id: "coco_miss",
    type: "earnings_miss",
    scope: "stock",
    targetKey: "COCO",
    title: "Cocoa Corp misses on rising bean costs",
    narrative: "Cocoa Corp warns that expensive cocoa beans squeezed margins. Traders sell first and ask questions later.",
    magnitude: -0.07,
    durationTicks: 5,
    weight: 3,
  },
  {
    id: "gum_launch",
    type: "product_launch",
    scope: "stock",
    targetKey: "GUM",
    title: "GumTech unveils chewable connectivity",
    narrative: "GumTech announces a new flavor-linked mesh network. Speculators bid the stock up on launch hype.",
    magnitude: 0.08,
    durationTicks: 3,
    weight: 2,
  },
  {
    id: "krsp_recall",
    type: "scandal",
    scope: "stock",
    targetKey: "KRSP",
    title: "Krispy Kingdom chip recall",
    narrative: "A batch of extra-crispy chips is recalled after a seasoning mix-up. The snack aisle wobbles.",
    magnitude: -0.05,
    durationTicks: 4,
    weight: 2,
  },
  {
    id: "cocoa_shock",
    type: "input_cost",
    scope: "sector",
    targetKey: "COCOA_CORP",
    title: "Cocoa prices spike worldwide",
    narrative: "A harvest shortfall sends cocoa prices soaring. Chocolate makers feel the squeeze across the sector.",
    magnitude: -0.06,
    durationTicks: 8,
    weight: 2,
  },
  {
    id: "halloween_demand",
    type: "seasonal",
    scope: "sector",
    targetKey: "CANDY_MART",
    title: "Halloween demand surge",
    narrative: "Costume season fills shopping carts with candy. Retailers and treat makers see a seasonal rush.",
    magnitude: 0.05,
    durationTicks: 6,
    weight: 2,
  },
  {
    id: "soda_tax",
    type: "regulation",
    scope: "sector",
    targetKey: "FIZZY_DRINKS",
    title: "Proposed soda tax jitters",
    narrative: "Lawmakers float a sugar tax on fizzy drinks. The sector dips while lobbyists scramble.",
    magnitude: -0.04,
    durationTicks: 6,
    weight: 2,
  },
  {
    id: "sugar_rally",
    type: "rally",
    scope: "market",
    title: "Sweet tooth rally",
    narrative: "A feel-good weekend of parties and bake sales lifts the whole candy market.",
    magnitude: 0.03,
    durationTicks: 5,
    weight: 2,
  },
  {
    id: "sugar_crash",
    type: "crash",
    scope: "market",
    title: "Sugar crash",
    narrative: "A health-scare headline hits the news. Almost every candy stock sells off at once.",
    magnitude: -0.08,
    durationTicks: 3,
    weight: 1,
  },
  {
    id: "shk_expansion",
    type: "product_launch",
    scope: "stock",
    targetKey: "SHK",
    title: "Sugar Shack opens 20 new shops",
    narrative: "Sugar Shack Chain announces a rapid expansion into malls. Franchise optimism lifts the stock.",
    magnitude: 0.045,
    durationTicks: 4,
    weight: 2,
  },
];

export function pickWeightedTemplate(): EventTemplate {
  const total = EVENT_TEMPLATES.reduce((sum, template) => sum + template.weight, 0);
  let roll = Math.random() * total;
  for (const template of EVENT_TEMPLATES) {
    roll -= template.weight;
    if (roll <= 0) {
      return template;
    }
  }
  return EVENT_TEMPLATES[EVENT_TEMPLATES.length - 1];
}
