import { preferences } from '@kit.ArkData';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

const PREF_NAME: string = 'pet_status_store';

const KEY_LOVE: string = 'love';
const KEY_HUNGRY: string = 'hungry';
const KEY_WASH: string = 'wash';
const KEY_PET_NAME: string = 'petName';
const KEY_BOND_XP: string = 'bondXp';
const KEY_LAST_FED: string = 'lastFed';
const KEY_LAST_WASHED: string = 'lastWashed';
const KEY_LAST_LOVED: string = 'lastLoved';
const KEY_CARE_COUNT: string = 'careCount';

export class PetPreferences {
  private static instance: PetPreferences | null = null;
  private store: preferences.Preferences | null = null;

  static getInstance(): PetPreferences {
    if (!PetPreferences.instance) {
      PetPreferences.instance = new PetPreferences();
    }
    return PetPreferences.instance;
  }

  async init(context: common.UIAbilityContext): Promise<void> {
    try {
      this.store = await preferences.getPreferences(context, PREF_NAME);
    } catch (err) {
      const e = err as BusinessError;
      console.error(`Preferences init failed: ${e.code}, ${e.message}`);
    }
  }

  async loadAll(): Promise<void> {
    if (!this.store) {
      return;
    }
    try {
      const love = await this.store.get(KEY_LOVE, 80) as number;
      const hungry = await this.store.get(KEY_HUNGRY, 80) as number;
      const wash = await this.store.get(KEY_WASH, 80) as number;
      const petName = await this.store.get(KEY_PET_NAME, 'Isabella') as string;
      const bondXp = await this.store.get(KEY_BOND_XP, 0) as number;
      const lastFed = await this.store.get(KEY_LAST_FED, Date.now()) as number;
      const lastWashed = await this.store.get(KEY_LAST_WASHED, Date.now()) as number;
      const lastLoved = await this.store.get(KEY_LAST_LOVED, Date.now()) as number;
      const careCount = await this.store.get(KEY_CARE_COUNT, 0) as number;

      AppStorage.setOrCreate(KEY_LOVE, love);
      AppStorage.setOrCreate(KEY_HUNGRY, hungry);
      AppStorage.setOrCreate(KEY_WASH, wash);
      AppStorage.setOrCreate(KEY_PET_NAME, petName);
      AppStorage.setOrCreate(KEY_BOND_XP, bondXp);
      AppStorage.setOrCreate(KEY_LAST_FED, lastFed);
      AppStorage.setOrCreate(KEY_LAST_WASHED, lastWashed);
      AppStorage.setOrCreate(KEY_LAST_LOVED, lastLoved);
      AppStorage.setOrCreate(KEY_CARE_COUNT, careCount);
    } catch (err) {
      const e = err as BusinessError;
      console.error(`Preferences load failed: ${e.code}, ${e.message}`);
    }
  }

  async save(key: string, value: number | string): Promise<void> {
    if (!this.store) {
      return;
    }
    try {
      await this.store.put(key, value);
      await this.store.flush();
    } catch (err) {
      const e = err as BusinessError;
      console.error(`Preferences save failed for ${key}: ${e.message}`);
    }
  }

  async reset(): Promise<void> {
    if (!this.store) {
      return;
    }
    try {
      await this.store.clear();
      await this.store.flush();

      AppStorage.setOrCreate(KEY_LOVE, 80);
      AppStorage.setOrCreate(KEY_HUNGRY, 80);
      AppStorage.setOrCreate(KEY_WASH, 80);
      AppStorage.setOrCreate(KEY_PET_NAME, 'Isabella');
      AppStorage.setOrCreate(KEY_BOND_XP, 0);
      AppStorage.setOrCreate(KEY_CARE_COUNT, 0);
      const now = Date.now();
      AppStorage.setOrCreate(KEY_LAST_FED, now);
      AppStorage.setOrCreate(KEY_LAST_WASHED, now);
      AppStorage.setOrCreate(KEY_LAST_LOVED, now);
    } catch (err) {
      const e = err as BusinessError;
      console.error(`Preferences reset failed: ${e.message}`);
    }
  }
}

export function timeAgo(timestamp: number): string {
  const diffMs = Date.now() - timestamp;
  const mins = Math.floor(diffMs / 60000);
  if (mins < 1) {
    return 'just now';
  }
  if (mins < 60) {
    return `${mins}m ago`;
  }
  const hours = Math.floor(mins / 60);
  if (hours < 24) {
    return `${hours}h ago`;
  }
  const days = Math.floor(hours / 24);
  return `${days}d ago`;
}

export function bondLevel(xp: number): number {
  return Math.floor(xp / 10) + 1;
}

export function bondProgress(xp: number): number {
  return (xp % 10) * 10;
}
