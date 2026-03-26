Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1993358C4
	for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 04:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774500976; cv=none; b=CipozJ61Ap7xZlogM59b/Xqp428mP1+986egnTz2G2ZzMCKNLDTFWBsyQ/KV5fAhQOwNw+gGSC3LmmxcaifCB/q+hbCpG/8JP+yAqa7jcwMQmnGa4XZ5jsh3hMeX4JUBOjSr+H+rxZ5cis/0jln84l2qIwb17Zb1OSVs3TCSNuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774500976; c=relaxed/simple;
	bh=/0G1OokNS5gQF1yAnlzFoTYo6rl9HYK4TARDIpx3i8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ToBDuM52wzzrW9RXG177WSj8OispdMLyGYXBJMacMZBs6Qvjr+/bHT0w7LdEmtpDAz7xhIKueLYY/ERIMySVDlH7kdN5b1I+bUAswaL+1kKnw/gg9EevPAIM8fO7hj+nUJZLLBL3sex7wl/XTbrQNqF9Udi1zI9kDAhGTVXVp3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNkk/FBa; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNkk/FBa"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b0ba3bfe16so6988115ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 21:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774500974; x=1775105774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XljdsmAvu2M9cVCCjFds2jX6qIm7BiRW226a6zw+6M0=;
        b=ZNkk/FBaruhvolH3+gZEdrBfXiiXTUgNDOpbnsi1QlgKlAsLhAp9ot3TAW6LLcFfHS
         son5tjmypQAxn5yqfKNhvpE72hV9J8dsVOUkmgZY6A6IO+8027hl2GljOjLsTcWN2rl+
         2lLnMBodJsqwbHf8reBR+M6gLg+qR1CjwTGYT4WiiBu/goyC2NVESLhVpy9sqCMO0dOX
         CqOJjirW6EJfgrche8sfwQaYdjrz4wV1YBlzSeKtOqkoGOx20x4eF0/q1F5gdC5Fq6Yo
         fRXOAFMGvWn1cZlGU9vOt0WEiTqwNzCZ0bg/74qv2XyTs5ZEs6wpygx/wWAsuKyBiwYv
         2fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774500974; x=1775105774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XljdsmAvu2M9cVCCjFds2jX6qIm7BiRW226a6zw+6M0=;
        b=MBW2JwDiNqzBSj+I1TTWqjHK0w0pNbZW+3NO/l5GXujDKsTSgNx+UlZbEpIeyqd+TX
         3FOeyW3M78Gt+np4VG2ZmFTaA7ywHsdHSdvoWGJbID1sw/dKgUKs2odAQS8sEBgQ34Xp
         Y8R/uDkWubQG1epIoiMPM4pyNNhqE/5HPWEm/XJSdYTg4awQxUlwpLyPuCL2kQVqukD8
         bHbGsP6VK95lpI6kStKMhrNn6UM1dRhNjz3UEJdP/2DIUy5zxcJwWBdm1agnwBv7W9Os
         jBLkF9xLpoS5nLMjYQ3yFRqSKNyiSJ+N/ciHBcxb6SXK093UVN69fOxBp+v0fsA/sPOU
         ixcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8CkApMEOBbDeUSYp8T/KYBXVmziq17TWkWrVmZevwXxknmRcbBzsfm0QmLi+stAK0VeDpKFESMXEVt3XGRl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+4m6ZuFJV8v+UNTTf5rLRUNC6zMcneiueKTFgWfHaVy0CEA+z
	o+ktURPFg4UaU+Rr7riIFL5hz0aDMBMDWRef9Fimjg/wXwe42mi6Oxbe
X-Gm-Gg: ATEYQzzj7A8HDkVlnfcn3HIoZANJeN3bWiHY5ixi15TRkFJp6CMGPm5x0TmqeKMTTg5
	Kry0uVtyUJz20QuC3rur/JZ3X/n4DNm9mpYHjgfGt+BxknOi7VD2rxlKtBAIMOsVe9aaC/s/R4o
	qCbh02dbWn/u9NiDtmv3KGECdZj92nGhGJp9d4OpSOQ+EFm1c5xpDwUYbdK2v1iZKiIHTVyJVR0
	M9xoYQLv4fjRkIK3+XMndxK3wXAi9mR5Q1JYEHbpZjz97z5TJnSy9XOrereVz6paTKeI6yeMeIc
	mzqJm9IejIzorQ6ArTQvYXwr2NnOLAGXd5JMt1a3F+2ZYH/8yv/GwW6F554IqDby/3vtoLUozT+
	EpZDUIe3hHcNSbwKDe9agjiGYirq+bH+Se+dAXVa+KWcfgZKKtwHYYA8vWlq4rjNmiee7llyBz/
	VV370xPgBME5lg3M12R6jve0ZhX3mapwjNVEQrSZRKC+GrVQWuuPt7shM=
X-Received: by 2002:a17:903:b90:b0:2b0:6365:217e with SMTP id d9443c01a7336-2b0c48a7f32mr2334785ad.15.1774500973771;
        Wed, 25 Mar 2026 21:56:13 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc7b8adasm20087225ad.33.2026.03.25.21.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 21:56:13 -0700 (PDT)
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
Subject: [PATCH] clk: kirkwood: use kzalloc_flex
Date: Wed, 25 Mar 2026 21:55:55 -0700
Message-ID: <20260326045555.240730-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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
assignment to right after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/clk/mvebu/kirkwood.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/mvebu/kirkwood.c b/drivers/clk/mvebu/kirkwood.c
index ed061d82fb65..fc2972538008 100644
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
-- 
2.53.0

