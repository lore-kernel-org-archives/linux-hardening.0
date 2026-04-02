Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763881A681C
	for <linux-hardening@vger.kernel.org>; Thu,  2 Apr 2026 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775089231; cv=none; b=NT3brBVSznkGU04qXKUTSV74DOY4wmKZ7fzXhDUV3VE3gqCrsIB0fYH8DGJUrRlzpR3eGoberZt4ziXGAObcmAHiu2KTAo/Sva0Aqj/AhuJoVZ+KZICuQ0MfZpUoqxaZjEMQGu8H9Oa7U49U6oFHhDrS/+Z5NT000XQ3nQNPheg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775089231; c=relaxed/simple;
	bh=/6ausaTtB1EwdmgBARDVXnzjs0gUU73ZHyMDrVpLs0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jVPwNZDZeDAHWVixws8ikKKMIProSyb5PYs5dkVHcR/kRJrkvvlwIgZ4ci1H2C39l7pcNU9RC0JAGQ95pHWq16SScpBJ/r9Ogrw1PgcGcJkNawpQGY4P29vPhXaS9yzCABGJiQYXwsjJR26lBPR0LvqiOEkUKcb0IUCVeSS2deE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkIygf1F; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkIygf1F"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b4520f6b32so512073eec.0
        for <linux-hardening@vger.kernel.org>; Wed, 01 Apr 2026 17:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775089230; x=1775694030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LXMgCcTK6RGFXVFZT8A9Tz2PiBZRhwxEuoWHnwTbJPI=;
        b=nkIygf1Fs6p8dz+51xl1LbLJLOkRAj7efZtLLBFtWJuMOV7UT9UK6xZBJc/2GhAe9X
         ckhPXGfF3DKwtTI+CyAVfik3qIwp8LzInuoPWljl3N8BSG7JRhr15lp5ni2hLqzAWWVF
         ydAmPm4p0vjjL/5w+ww9jg5msQHFSoMu69YaPpQQGoJBeTwa0qIyCdJXwreIuqSjjdMu
         5srkF1gn0K2oawqruqddAAonnjb+2AwfRfzyH9QhVZE3wpUA5NOSdNQaFMxfu72GWMB4
         YspQZw2R7KNEdQO9S8WlluIjNNwBxumLRBm47mefokhpv83WFZuumA+Rc/TKB99Vp+DQ
         7rZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775089230; x=1775694030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXMgCcTK6RGFXVFZT8A9Tz2PiBZRhwxEuoWHnwTbJPI=;
        b=OKSOQd6aL4r9luT8MPu9SUGxkHd1aWFbE6ZaSzmqXI2zUAxS67c0gGO/K9O+Ew7guE
         +x0cBP2FjvikFHybKNoaxEEMvqR+MmZDGPz7VSYVraaRqgtpX6okpqrBKNPKAin+u+8i
         JtPuARCIwz02uzxJVGLNHm4bGsvvpwG2xPfdif89lRskIitmZBYD4hxxG6bHjxz8705T
         kN5B7Tgj1ECqpkxTasWj/LepXTV3Vrx32ohT1aYwTJeGCA9wRV2SE8Txg5MHag5OWrAV
         hxNzx2m8funt6OXnjSTEm60fRyLeSt7+rJMxB08V6ysZf2AUg/tg1JmBmrosu+cmvzH/
         qG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU48AkwdP/pIqpZ11iEW3SDKP9NB8p7Ae5eVEytUa6N0J4tC1Gtb5bFcku0/sSU1h15v7ObIytQnx57nciJgSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymbyTxnGBBXHgH2ifoAJlxyY8Sm9gPLSEZRGvn89RAiuRQpYbQ
	0f0d5qKqUk4hKoJGMcOWuPIubV6hqpNhqxCBO59WpyQrQNq4loAMtJqx
X-Gm-Gg: ATEYQzzR98zlvPjYglgS4OL/pokD4WC0G1vNh/axpDd6eXIQAX7DoB1HsmnQ1DesSZL
	Q+OeE2cy3zHIuv1oATS/r3LpMFAXMi9EoxK9qkz50Ah/pjyXz9kIjqo8+/Hz9pEb/u5dkMuClpf
	OuIoTajHuDd9dCMV94vaPfSffSqMchO5Z4T+jGnT48by/ddbG804XpY3dRbQTg6nsn0Yix/m/T7
	QrKKEc98QyyEkTq4o7C4c1dU1vXiFHX2TQ1oj6j1uCZoMZqEn2V7EfLWltYHzF7zNJEWOjYxLGs
	zlGNE2xqrPO5QujLLAWIbaNBzCMrZeR/KjGhto8IqYWIWrnsDVp6/FHWCVg5k7GhkRjvI0jBui2
	l8Ey21pBSkqmeOWLj/vLbfBDvoO6WR6cfSjY2mxtg77YiSQ284KKTHwnTFZgcKlGeivVEMBHowK
	R3nxUymNjLzeScBxfs/eZUbGMDeZ+pPFbwzR0oF10IwSw108hT1W1XlWc=
X-Received: by 2002:a05:7300:e613:b0:2c0:ba91:48b6 with SMTP id 5a478bee46e88-2c932eb27abmr2824768eec.26.1775089229350;
        Wed, 01 Apr 2026 17:20:29 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca79e1d93bsm1031337eec.12.2026.04.01.17.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 17:20:28 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Marvell Kirkwood and Armada 370, 375, 38x,...),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] clk: mvebu: use kzalloc_flex
Date: Wed,  1 Apr 2026 17:20:11 -0700
Message-ID: <20260402002011.89926-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine kzalloc and kcalloc in one
allocation so they can be freed together.

Add __counted_by for extra runtime analysis. Move counting variable
assignment right after allocation as done by kzalloc_flex with GCC >=
15.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/clk/mvebu/common.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/mvebu/common.c b/drivers/clk/mvebu/common.c
index 28f2e1b2a932..4129690fcae0 100644
--- a/drivers/clk/mvebu/common.c
+++ b/drivers/clk/mvebu/common.c
@@ -189,10 +189,10 @@ DEFINE_SPINLOCK(ctrl_gating_lock);
 
 struct clk_gating_ctrl {
 	spinlock_t *lock;
-	struct clk **gates;
 	int num_gates;
 	void __iomem *base;
 	u32 saved_reg;
+	struct clk *gates[] __counted_by(num_gates);
 };
 
 static struct clk_gating_ctrl *ctrl;
@@ -257,24 +257,21 @@ void __init mvebu_clk_gating_setup(struct device_node *np,
 		clk_put(clk);
 	}
 
-	ctrl = kzalloc_obj(*ctrl);
+	/* Count, allocate, and register clock gates */
+	for (n = 0; desc[n].name;)
+		n++;
+
+	ctrl = kzalloc_flex(*ctrl, gates, n);
 	if (WARN_ON(!ctrl))
 		goto ctrl_out;
 
+	ctrl->num_gates = n;
+
 	/* lock must already be initialized */
 	ctrl->lock = &ctrl_gating_lock;
 
 	ctrl->base = base;
 
-	/* Count, allocate, and register clock gates */
-	for (n = 0; desc[n].name;)
-		n++;
-
-	ctrl->num_gates = n;
-	ctrl->gates = kzalloc_objs(*ctrl->gates, ctrl->num_gates);
-	if (WARN_ON(!ctrl->gates))
-		goto gates_out;
-
 	for (n = 0; n < ctrl->num_gates; n++) {
 		const char *parent =
 			(desc[n].parent) ? desc[n].parent : default_parent;
-- 
2.53.0

