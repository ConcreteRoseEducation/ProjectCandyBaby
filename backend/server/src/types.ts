export type SectorRow = {
  id: number;
  key: string;
  display_name: string;
};

export type StockRow = {
  id: number;
  symbol: string;
  name: string;
  sector_id: number;
  sector_key: string;
  sector_name: string;
  base_price: number;
  current_price: number;
  description: string;
  is_active: boolean;
  volatility: number;
};

export type EventRow = {
  id: number;
  type: string;
  scope: string;
  target_id: number | null;
  title: string;
  narrative: string;
  magnitude: number;
  decay_type: string;
  duration_ticks: number;
  remaining_ticks: number;
  starts_at: Date;
  created_by: string;
};

export type UserRow = {
  id: number;
  firebase_uid: string;
  display_name: string | null;
  sugar_coins: number;
};

export type TradeType = "BUY" | "SELL";
