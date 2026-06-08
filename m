Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7576F35200D
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 05:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895781; cv=none; b=FPswJIjmHYs26pMs/ePG/KK6mMoDR9VxTyD9xkqnJXKyzN8m3nYBukeXJFCDwIs4ftXfcueBOkBOorZuhN5BXTMQesqZk4nejDIA3luqJWHdwaQ1lQLH+fLA0XFZbwhNSOMJvnFl0AyPd9GGKJ0eJ+If6p4KobrKfLAy5IAkZiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895781; c=relaxed/simple;
	bh=iHMQG214PPQmbdBQdYAyiKSs4eIX1mzLRERBaN7T4L8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o2wb+/mHuQ/QumehdsozM13Qpc/SlJ2P6X/g3h7PJ03x7sALZYNtMN+ktPxCCWyy7gf35ceO6yT8wMBe7+x0wyeh2eLWab7lFlei0B7aOjR4sEGLnEeniuLbQHax7WBIjF6O1hHmm3Tjy/l7W52rV2AxRzTG+C9bb/4fxmRVk4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3UlDHgL; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3UlDHgL"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c858014845aso1499721a12.1
        for <linux-hardening@vger.kernel.org>; Sun, 07 Jun 2026 22:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780895780; x=1781500580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ud+rVLLtmeaFikk63rpGcD+7hJ3NPyth5NFlQdc5XLg=;
        b=a3UlDHgLQhlsWlVHRAW8lPTrk6vDIcNlATmWTUO+GFYMMIIGVkqC/u2K2kacFPhnQf
         9JAVFKhl53qdpsRH0l5su6pbPSkhouILuTqH1vI5bFs2Fcjold77cXdqe+9l8BR4jE0T
         c/COxENUfKWsNIwquvnzlYnKgC6R+fCdsAKKkC6ZeFlUjyfYNVPNyHZ0knmQuR+Xh7zV
         B7mfLecfze9MysfUEUb0SyD2+/NWhDEd5HEDGI4LuFN9a85+7sGvWZx51Zzdz4BpEBcc
         dIb+hHbZJK5ab06TK/HDRP3mA38hX+lGsc3giiVRar7rvDDy16sqNqM4DArGxW60kXbg
         CPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780895780; x=1781500580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ud+rVLLtmeaFikk63rpGcD+7hJ3NPyth5NFlQdc5XLg=;
        b=EuLjBxm7BgC81KG/O70Xw2lCQ5fOEQi2TWnNCslllqaPwQJoj4qcORuqRrUzdCpMUq
         qd7unSKaH1GNFVYjeMyoNs4Fm0HRestvfLLHCaCVhET/DTKVaeGPFDve9SaDkARrtekq
         +TGwITSXQ++5yeVy4lf5ZQyyNk0gjE+slf1XoZ15voWuihxr49Y/jcif+1JYVO2jooY2
         eeTwxo7+O0WjhqIN4wLAWu7KK0xomD8Gww9+ym3ZRltdU8muiKvIi36eMMz0vQ+YVMPk
         glBtDr9we0BBaFa/w7K9Q9aLu1EN5Dz2ghfWemL0GLGZ060YUSW4q4HAhObwgYG6V0HL
         eqCA==
X-Forwarded-Encrypted: i=1; AFNElJ/Xf/NtKQr077U0DS8n1ES21cmmYi2Sacn/NEnvw9Nt88HYDe1ejbI1cImvypTFhb5okVV8Cf1PMxjmye0A5xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbdAPBVBvKUdO2LVV6HfS1BoZHPlvAN1OQNFDeAcoXldZUtOK1
	Wr5sBmhSLeYV1qnynPP8+w+JC6Y/OTPUK3i1SAVqxKiSWQyvmB0kUHr9
X-Gm-Gg: Acq92OEspae5TWOmzWBess2c6rEAqGFXw4yXzqN2qTVDJasAMYD1hG0cP5j8tI6PkqG
	SbPY3+HQZLHCiIu3UjBBXcyivTljkFFvUtz/vtUJEO6C8+gNUnHK633IVDQvnxhRwihBSWueBNr
	hw+u0XIAqTHX/NCg3/aVmuNjp2Zh4Fj9z8FMLnkGpw7BYBoIe7cp4oFpaLyeg4EhC7eanoFpDPh
	wXsve9R/A7ghdTtP4Z7ctwklBGqFf8RcOH5tMwde7NCooyb7qNRioE6o/EivHrlTQKRZBIY0Ujn
	nrC93eFyTatSLeGfNNE2mVHPal6+BxhBd3P+PzzDXFjSYhatBdtBqSA02/roPppzjYHXCOz5Rd0
	tDZGmfl93iFhBcju3UnZaI06wGHopQpq3a9ZyBweZyx8hppcYz/uZgVjyLhA84NrnfU5oaA4Zig
	aknj9CfRRSC+s4HdAkhHTJw2u/eAPRWLMZnwCUTyuYNG/HkAz3KFH9yflDL5z0rmuJBy6fmnL+H
	9xyyVsS7NNPAXO4Ju0AjmX2hMHMZVxK2/cOO+JC2DIoog==
X-Received: by 2002:a05:6a21:1405:b0:3b3:2fc3:880d with SMTP id adf61e73a8af0-3b4d3ce5059mr10314307637.25.1780895779906;
        Sun, 07 Jun 2026 22:16:19 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a61b3sm14459163a12.17.2026.06.07.22.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 22:16:19 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Marvell Kirkwood and Armada 370, 375, 38x,...),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv3] clk: kirkwood: use kzalloc_flex
Date: Sun,  7 Jun 2026 22:16:02 -0700
Message-ID: <20260608051602.7176-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify allocation by using a flexible array member and kzalloc_flex to
combine allocations.

Add __counted_by for extra runtime analysis. Move counting variable
assignment to right after allocation. kzalloc_flex does this
automatically with GCC >= 15.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
---
 v3: change description slightly.
 v2: remove unused goto.
 drivers/clk/mvebu/kirkwood.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/mvebu/kirkwood.c b/drivers/clk/mvebu/kirkwood.c
index ed061d82fb65..f4f62b241193 100644
--- a/drivers/clk/mvebu/kirkwood.c
+++ b/drivers/clk/mvebu/kirkwood.c
@@ -253,8 +253,8 @@ struct clk_muxing_soc_desc {

 struct clk_muxing_ctrl {
 	spinlock_t *lock;
-	struct clk **muxes;
 	int num_muxes;
+	struct clk *muxes[] __counted_by(num_muxes);
 };

 static const char *powersave_parents[] = {
@@ -297,21 +297,18 @@ static void __init kirkwood_clk_muxing_setup(struct device_node *np,
 	if (WARN_ON(!base))
 		return;

-	ctrl = kzalloc_obj(*ctrl);
-	if (WARN_ON(!ctrl))
-		goto ctrl_out;
-
-	/* lock must already be initialized */
-	ctrl->lock = &ctrl_gating_lock;
-
 	/* Count, allocate, and register clock muxes */
 	for (n = 0; desc[n].name;)
 		n++;

+	ctrl = kzalloc_flex(*ctrl, muxes, n);
+	if (WARN_ON(!ctrl))
+		goto ctrl_out;
+
 	ctrl->num_muxes = n;
-	ctrl->muxes = kzalloc_objs(struct clk *, ctrl->num_muxes);
-	if (WARN_ON(!ctrl->muxes))
-		goto muxes_out;
+
+	/* lock must already be initialized */
+	ctrl->lock = &ctrl_gating_lock;

 	for (n = 0; n < ctrl->num_muxes; n++) {
 		ctrl->muxes[n] = clk_register_mux(NULL, desc[n].name,
@@ -324,8 +321,6 @@ static void __init kirkwood_clk_muxing_setup(struct device_node *np,
 	of_clk_add_provider(np, clk_muxing_get_src, ctrl);

 	return;
-muxes_out:
-	kfree(ctrl);
 ctrl_out:
 	iounmap(base);
 }
--
2.54.0

