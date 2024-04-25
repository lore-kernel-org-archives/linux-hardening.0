Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175C96AB9
	for <linux-hardening@vger.kernel.org>; Thu, 25 Apr 2024 01:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714007957; cv=none; b=QOtdj85Bani2mTih7O7PlGvtwJ2dZUpH8AGgrTf8qonwaUr2RRL2ExIE/eQQTbSrd97VN3fcfHLeA4reMhp6tpKtxv/rsWpMrHZoGXrdwBITAra4s0KCDoPwcw4s4yyPpWpvreU++0wwKhe7Ig2czMOQFdi+sUj7Ob4s9G5fu0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714007957; c=relaxed/simple;
	bh=uLT8FYB0z9hpMnlQW6hKjbJMmTUuyZlRXmjjQNhJGwU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jLInamnD1uF/umNT/AoXO5xHxAo0TzjJk0+TOxVLCm7zqOqIqCuuH6jNicE/tTRC3dO8PMeNLgg+Lj4MktU5pwRRvErAhpDJD+Ew7/XYyLVobTn7cFbr3AyakAwG2UuVPpYl+Lu3A6b/FGcLbqKnc0tS6aBGX1Oc2frwEnvI3iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fWZwQRki; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fWZwQRki"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6156b93c768so7917127b3.1
        for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 18:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714007955; x=1714612755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fhtSrAi+//xuc+I8DI7Sfszz5H0fgzv1dQ1F/lNIbLU=;
        b=fWZwQRkiXoY/CeWe6theD4Bl5iRjc0MB39xrBtIJEZ+eNmL3w6Wwr1rk6YqH6hcY05
         8NUVxTmo5x6TFqbdPeDTIR0TDYURb8b42kevm629CV81PSLRz1PGjpSiKBiWuMAPo9He
         QrBOUaJx5NWPnZpiqIlyO3vhX8csX+wFwEpsZcY6RAVYTHaY9U/6xN9wMqBQT/572cxD
         VsMUXWF+/dKUwRgynAcOOufqIJrIWy+3eUzNfHWTK5HJtyGqSEwRuxWodUXuKb4v1xdw
         Pu96x59JTEXsipO26B6Sm0j41e+LbcCDYuCTQN2Vhyz+UTywmbcPpHT8rQxRs97vzwej
         AGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714007955; x=1714612755;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fhtSrAi+//xuc+I8DI7Sfszz5H0fgzv1dQ1F/lNIbLU=;
        b=iBXd/qRwSs9gtt38OVU4i5++K/A772NUj7u4pKR5rrOr5FLT2r7wPn4ZYZlYpp+mrK
         9y5M2kVHohwMxz+hSsLiGWVGHp60nMygYbSHSHviJf95sHqOi6Jpasd0Rfmr1yt83nQs
         pgvWXutO+o3bbAWmPWAzH7KMo0vQwOc0ZByM4tD5z+T0A/RcnOtEA/GjQbMPWwunkVKa
         bAP9HZogD+9UGw1BmnCC//FQIkaNc5HsvBKEfsdjNSa/eIdTFwXX/xQ6EGep8ZsbW+AQ
         6sNpk+fVr1FnypHdznIZ8bnCiMpiMX4Z5v4cQboR9dNzNaNZDjSaNb54MrF0peyLuRE5
         TChw==
X-Forwarded-Encrypted: i=1; AJvYcCWNzhaGCLO6TZJfqG5Yl79lfZdW5kB0nTBm8fdwyWFXC2+PRaqPEfcbyK4gf7VURvwfB2crIFvYBicPcZfe0CkoGqOM7XYDHe20I1m/GCYH
X-Gm-Message-State: AOJu0Yxx/Xedrnv0tt4cjDIpdLcBzVr3LYDZfzQdQ0UM4BA8MWlTB/78
	C+M95ySzeEjSLHiTwPiZmamIdlydD9XLeq508KkU8IbGVPvlgRq7yCeLvqQyH5Z1dt5XwuvV2xJ
	ZZRERKrGi8f8aFyK0Q10nHg==
X-Google-Smtp-Source: AGHT+IGjyJXrIQ/HPFqodscDOz8YvnLkg3hYnAsGcpKNSDsZzEE8YFhfmdMCjhCj4C6Cs8vE34OjReb+sQ9JNy71xw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:2b05:b0:dc6:d233:ffdd with
 SMTP id fi5-20020a0569022b0500b00dc6d233ffddmr1437183ybb.0.1714007955020;
 Wed, 24 Apr 2024 18:19:15 -0700 (PDT)
Date: Thu, 25 Apr 2024 01:19:13 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJGvKWYC/53NwW5CIRCF4VcxrB0DM0Cxq75H4wJhvJIoGLghN
 ea+u2jSReOm7fKcxfffROOauIn31U1U7qmlksfQ65UIR58nhhTHFiiRlJQG2lxzuFwh1tS5Nsg
 8Q2weTj5vSRKEUhkCWHLWGccmIIqBXSof0tcz9Lkb+5jaXOr12e3q8f450RUoMN7aYMgp/cYfU ynTiTehnMWj0fF/Lg73wHtt0BvCuH9x6dvVUkv3a5eGKwMpslsd0fx0l2W5Ax9tpi2NAQAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714007954; l=2356;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=uLT8FYB0z9hpMnlQW6hKjbJMmTUuyZlRXmjjQNhJGwU=; b=CRkKkJ86IKr54dqqwbv7Lx0P+RGq3++z6F1qmKPSqj6SJ3t9Okv6f+h2SHOs+EFklHCfanqqy
 FLsGsHXWMXvCrfYcSeRJ0xUvYgFHj4oPOrqUanyaT2k/vnHJ8Y2ovY3
X-Mailer: b4 0.12.3
Message-ID: <20240425-strncpy-drivers-net-dsa-lan9303-core-c-v4-1-9fafd419d7bb@google.com>
Subject: [PATCH v4] net: dsa: lan9303: use ethtool_puts() for lan9303_get_strings()
From: Justin Stitt <justinstitt@google.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

This pattern of strncpy with some pointer arithmetic setting fixed-sized
intervals with string literal data is a bit weird so let's use
ethtool_puts() as this has more obvious behavior and is less-error
prone.

Nicely, we also get to drop a usage of the now deprecated strncpy() [1].

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v4:
- drop unnecessary { } (thanks Alexander L.)
- carry Kees' RB because of trivial change
- Link to v3: https://lore.kernel.org/r/20240408-strncpy-drivers-net-dsa-lan9303-core-c-v3-1-0c313694d25b@google.com

Changes in v3:
- use ethtool_puts over ethtool_sprintf
- Link to v2: https://lore.kernel.org/r/20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com

Changes in v2:
- use ethtool_sprintf (thanks Alexander)
- Link to v1: https://lore.kernel.org/r/20231005-strncpy-drivers-net-dsa-lan9303-core-c-v1-1-5a66c538147e@google.com
---
 drivers/net/dsa/lan9303-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index fcb20eac332a..f3b50adae865 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -1007,15 +1007,14 @@ static const struct lan9303_mib_desc lan9303_mib[] = {
 static void lan9303_get_strings(struct dsa_switch *ds, int port,
 				u32 stringset, uint8_t *data)
 {
+	u8 *buf = data;
 	unsigned int u;
 
 	if (stringset != ETH_SS_STATS)
 		return;
 
-	for (u = 0; u < ARRAY_SIZE(lan9303_mib); u++) {
-		strncpy(data + u * ETH_GSTRING_LEN, lan9303_mib[u].name,
-			ETH_GSTRING_LEN);
-	}
+	for (u = 0; u < ARRAY_SIZE(lan9303_mib); u++)
+		ethtool_puts(&buf, lan9303_mib[u].name);
 }
 
 static void lan9303_get_ethtool_stats(struct dsa_switch *ds, int port,

---
base-commit: c85af715cac0a951eea97393378e84bb49384734
change-id: 20231005-strncpy-drivers-net-dsa-lan9303-core-c-6386858e5c22

Best regards,
--
Justin Stitt <justinstitt@google.com>

