Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A242C4B1D16
	for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 20:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838762; cv=none; b=Jph0yUO2YNQZ20pK5m9U2ai2ec8IUrnRFM7Bhcl5jY0u2TZchUO6370ZpaLTa0SOtUnja0zt+RWQHPpI/6rmwb5i3RYtrZmmG+vIncn5c7mlEH+ZapTHYZt/mkMz32O+VKJTdTtOV0A/R/VAqhnfA++/HqBGG3wytS7GtHGZO8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838762; c=relaxed/simple;
	bh=Zt3j1Q9z/F/oX+RN5O6LNAI3VUi9Y5yxIjr5XCF+/QA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Cw07Zwvw1PSvqIgAogz4/ELByXh0WLSO8tBiCeEGQsy44VJzwHG2cL0iZWVqcwxFCwiQQQzSaySLoypp4odfPu6kBT7vEdNmo2NAt4qfe35ohDU6uafl3dt9LNDglBukSheDhfW9c1MHuWuXdTUQIqHHuTMcXZm5U3/Jgt3rpOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TQ2rL2/6; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TQ2rL2/6"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e61a8eb087so41420705ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 13:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791838761; x=1792443561; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wSC/1SbujWZTugaRFDbwSTkiFwwccAK5jmzXPGY9zpc=;
        b=TQ2rL2/6REBKZnBYsKo5CyHtwdKUTU1iP3m/dRufbiOF7SYRxqpHRHrHMQP7BJfiJj
         FDjWN4TWLJzihtU+WDuFSUfi5p9OeKgnQ60uf1cDh1SXpbciXoDzYH9fpxKwr6Z1WHsv
         amjSaBr/6LKfQ8YsIPIYH6IrT/6iyEm+BTTzeLd8siyeGxjfy/GUr6ZPTmRbPFKYEhsf
         CmsowM0ytycMGrP7vYCaVz8LbLA4Lx9iO8UZbx/wPkipI8nLwM/R3xCOhVm+qxkqITil
         MiRRzSPdG784mWqyvzfye3CMJVLKlHuMwjnVYfRIGAWl/JUu3M7OJRk6U7Qxon4cGG+a
         ibdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791838761; x=1792443561;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wSC/1SbujWZTugaRFDbwSTkiFwwccAK5jmzXPGY9zpc=;
        b=q6BOZX6Yr1kVtFX3DuqwiCqqgIkTXfw9aDCMZT4aUO7Sftt5AV3epUGw4vVmg4Xcft
         Aiv94mULeFqjlS/cBHFTqWJ/641GxQCBBvWWKOsfnr8RtQnJefyNvLpNH392G6NWdw4X
         2JpRY/TDvHMZPS9iPsJQfTTSaT6wvhV5F5LuuErF6Hwk/JctQZcXgXgROO6KFC8/XizR
         AS03l1MAaOCO0cjg4RMlIF6a7nEmik1TthwdpNuyF9ddHqz89VPELgBHj8PJvjY9EQbk
         lJbaZV+HzSmemHl632ZXDV1x+d17uzELmmfICBW1Fs/htH9i+/GZk4U8QpxPzZ5pQyi0
         WgMA==
X-Forwarded-Encrypted: i=1; AKwUvBy9QqRXod+j6zhHcTufEnAa/tJwObClgFhrtU3/hMOM30JiWh5pPoTPxl/3pfzXXz5Fa7xN5p/1bUboXHZECwY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6itpHtgnDxTZQNW1FfUhYW4EEPGgu06qAA75I7FQ+dQM8jAmK
	LVd1uWjb1yaECVUY6w686hWO34nr7awevAclNUB1KThZM+0kNeEIDaLts8bDQAs4E+4UT0/7KCf
	h
X-Received: from plfp2.prod.google.com ([2002:a17:902:e742:b0:2e8:a577:d361])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2305:b0:2e2:d26c:df9f
 with SMTP id d9443c01a7336-2e842f31f28mr93563005ad.51.1791838760700; Mon, 12
 Oct 2026 13:59:20 -0700 (PDT)
Date: Mon, 12 Oct 2026 20:59:19 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261012205919.4012405-1-morbo@google.com>
Subject: [PATCH] overflow: Match arithmetic in both parts of __builtin_choose_expr
From: Bill Wendling <morbo@google.com>
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"

The two parts of the '__builtin_choose_expr()' had different arithmetic
expressions. This patch correct it so that both parts calculate:

  COUNT * sizeof(*MEMBER) + __must_be_array(MEMBER)

In practice, the call to '__must_be_array' is meant to assert if
'MEMBER' isn't an array and return '0' otherwise. However, symmetry is
less prone to subtle errors (and far more satisfying).

Fixes: 230f6fa2c1db ("overflow: Provide constant expression struct_size")
Signed-off-by: Bill Wendling <morbo@google.com>
---
 include/linux/overflow.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index a8cb6319b4fb..265ec265aa3e 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -418,7 +418,8 @@ static __always_inline size_t __must_check size_sub(size_t minuend, size_t subtr
 #define flex_array_size(p, member, count)				\
 	__builtin_choose_expr(__is_constexpr(count),			\
 		(count) * sizeof(*(p)->member) + __must_be_array((p)->member),	\
-		size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
+		size_add(size_mul(count, sizeof(*(p)->member)),		\
+			 __must_be_array((p)->member)))
 
 /**
  * struct_size() - Calculate size of structure with trailing flexible array.
-- 
2.56.0.385.gd3acb90ef8-goog

