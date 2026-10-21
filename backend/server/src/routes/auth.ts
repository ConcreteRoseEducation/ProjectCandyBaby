import { Router } from "express";
import { getSupabaseClient, ensureUser } from "../auth";
import { UserRow } from "../types";

export const authRouter = Router();

function sanitizeProfile(row: UserRow) {
  const isMinor = row.is_child_account || (row.age != null && row.age < 13);
  return {
    id: row.id,
    displayName: row.display_name,
    username: row.username,
    fullName: row.full_name,
    age: isMinor ? null : row.age,
    isChildAccount: isMinor,
    accountType: isMinor ? "minor" : "standard",
    sugarCoins: Number(row.sugar_coins),
  };
}

authRouter.post("/auth/signup", async (req, res) => {
  const email = String(req.body?.email ?? "").trim();
  const password = String(req.body?.password ?? "").trim();
  const displayName = req.body?.displayName ? String(req.body.displayName).trim() : email.split("@")[0] || "Trader";

  if (!email || !password) {
    res.status(400).json({ error: "Email and password are required" });
    return;
  }

  if (password.length < 6) {
    res.status(400).json({ error: "Password must be at least 6 characters long" });
    return;
  }

  try {
    const supabase = getSupabaseClient();
    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        data: {
          display_name: displayName,
        },
      },
    });

    if (error || !data.user) {
      res.status(400).json({ error: error?.message || "Failed to create Supabase account" });
      return;
    }

    const dbUser = await ensureUser(data.user.id, displayName);

    res.status(201).json({
      message: "User registered successfully in Supabase Auth",
      token: data.session?.access_token || null,
      user: sanitizeProfile(dbUser),
      supabaseUser: {
        id: data.user.id,
        email: data.user.email,
      },
    });
  } catch (error) {
    res.status(500).json({ error: error instanceof Error ? error.message : "Signup failed" });
  }
});

authRouter.post("/auth/login", async (req, res) => {
  const email = String(req.body?.email ?? "").trim();
  const password = String(req.body?.password ?? "").trim();

  if (!email || !password) {
    res.status(400).json({ error: "Email and password are required" });
    return;
  }

  try {
    const supabase = getSupabaseClient();
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password,
    });

    if (error || !data.user || !data.session) {
      res.status(401).json({ error: error?.message || "Invalid email or password" });
      return;
    }

    const displayName = data.user.user_metadata?.display_name || email.split("@")[0] || "Trader";
    const dbUser = await ensureUser(data.user.id, displayName);

    res.json({
      token: data.session.access_token,
      user: sanitizeProfile(dbUser),
      supabaseUser: {
        id: data.user.id,
        email: data.user.email,
      },
    });
  } catch (error) {
    res.status(500).json({ error: error instanceof Error ? error.message : "Login failed" });
  }
});

authRouter.post("/auth/google", async (req, res) => {
  const idToken = req.body?.idToken ? String(req.body.idToken).trim() : null;
  const email = req.body?.email ? String(req.body.email).trim() : null;
  const displayName = req.body?.displayName ? String(req.body.displayName).trim() : email?.split("@")[0] || "Google User";

  try {
    const supabase = getSupabaseClient();
    let supabaseUser: { id: string; email?: string } | null = null;
    let token: string | null = null;

    if (idToken) {
      const { data, error } = await supabase.auth.signInWithIdToken({
        provider: "google",
        token: idToken,
      });

      if (!error && data.user && data.session) {
        supabaseUser = data.user;
        token = data.session.access_token;
      }
    }

    if (!supabaseUser && email) {
      const dummyPassword = `SupabaseGoogleAuth_${email}_Secure!`;

      const loginRes = await supabase.auth.signInWithPassword({
        email,
        password: dummyPassword,
      });

      if (loginRes.data.user && loginRes.data.session) {
        supabaseUser = loginRes.data.user;
        token = loginRes.data.session.access_token;
      } else {
        const signupRes = await supabase.auth.signUp({
          email,
          password: dummyPassword,
          options: {
            data: { display_name: displayName, provider: "google" },
          },
        });
        if (signupRes.data.user) {
          supabaseUser = signupRes.data.user;
          token = signupRes.data.session?.access_token || null;
        }
      }
    }

    if (!supabaseUser) {
      res.status(400).json({ error: "Failed to authenticate Google user in Supabase" });
      return;
    }

    const dbUser = await ensureUser(supabaseUser.id, displayName);

    res.json({
      token,
      user: sanitizeProfile(dbUser),
      supabaseUser: {
        id: supabaseUser.id,
        email: supabaseUser.email,
      },
    });
  } catch (error) {
    res.status(500).json({ error: error instanceof Error ? error.message : "Google Auth failed" });
  }
});
