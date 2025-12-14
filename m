Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A472405E7
	for <linux-hardening@vger.kernel.org>; Sun, 14 Dec 2025 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765717152; cv=none; b=mDxw30ZXqudyKUpqx/VIs14lkdtZmLSryWW/lnKY6WHzAqMBWnceHX+yHMpENIEnBssoL4HZzTH4L4oldgfZr2qT4ES01yaRRh4HjuO/HhaK3rPpvx+zMoNcPxaMcU6kVe40geUYkvF8RRxw46ceWTISqdw+H6SfxVncyKQpwYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765717152; c=relaxed/simple;
	bh=xMEGH4NweNU1xqQFtUTgaFs29K3lMJGSbnOZdnhJmsE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D96omcQqAbURMX9slC0v5hUpIM9l7nXbib7Ryhz2rDSmBc0g+HjHtCSpSnQJ0aMx49CgUAAcTW8409PGcBg5Vo4TiZP0DQirZk61YvA8T4MOy4pPXcb3mI8xD9AXv3AFO8iMeFAcXAnprjTrhmlktm/EEIQDRCeVeUdrUypdyfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wh+eU5mm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wh+eU5mm"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so19783565e9.3
        for <linux-hardening@vger.kernel.org>; Sun, 14 Dec 2025 04:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765717149; x=1766321949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0bB7Mlw/k/LFYE5b/qYrx7BWAqAqgGsuaNPO4jblekM=;
        b=Wh+eU5mmMK1OoDwAKk+GjJ57oIqHGB7XwOHAZ7aB+k+c9LJoZj+Hi4kw9JN0QdmIrP
         s+Ov9KAvy20/f3GEyrIKdPOOZ0h5QdNpKWV1rg5aQ1hvINF/DGXpE7ZXUXhSw3zRsbu2
         jmCqUV/uHKUGDJyLuYtivNaRCMJtFzdUBdAKJ/jCZgNePxQHXkBMgMeNS+Y1WLsFF8ny
         IilQItB9BplSI6WIRH36DBngmop6bVJ/kqhv5GRnmBF+MPLqnrw+ZiXKIgELe0nlklTp
         4ygRRbsKqe18fFP6nKCD1VMiAe/PlmNr3O0BJqcd0G7UdkGhdh+kSZUhilicUS7Pigum
         8ZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765717149; x=1766321949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bB7Mlw/k/LFYE5b/qYrx7BWAqAqgGsuaNPO4jblekM=;
        b=ub6ICLRMUJEvEWoOIRBxFn5932n2cSJoVUjDeGWJ/XBdZFgQjpMbDJSrgB8jyRF+O6
         JAWzJM4naemgoZLeImCjbPYICwws30x85JMDMmxEFQRFnDGrbFTDBFjy7hylVLTtFKfO
         W+OLi5DKPGw2H/3Iloh7QfM/KnLo03aRBDekuytC509WAMnykXX80tAoLceLxyU0ENAh
         48xFpLLSGxls8kAzDBD6hLR4lqPSjj3jk4pyOfdq8feqGEw38FeuiaymrKO44dkNagsg
         RZ7wCTweocquN4lXhExVjrf6JvyRFZbLqLbktmE8KjZxEZQJVB7cCPbOmJAVI1LT1svy
         vfww==
X-Forwarded-Encrypted: i=1; AJvYcCWWS37MuMeltrThIJ1S+SjeOUbcPNT7wd3JotDemF1EfpEmzyZaaGzb34Ljrlo0TJXqweFoYlC0tfwGYSMe0T8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVNDSgZa5668IWk7e9XtbfvdAAb/JpAmLoqi9GbNnc0QZrT9OT
	ivAfTI72ohzLNrjCgI8Tx8cpy2dDyXMcWrMVQxiMzTzhZi0Q4nE8MgmL
X-Gm-Gg: AY/fxX7YT6btHtk0gtmd0T8HFU9xCvShKGYS1o/dwniAZ2ajqbK8KXsbgpal+VicPOT
	wC4AtpZkMGNlLq+CSJAtMUQEWHVaAodDPNMWf9ATWGtBFFEuDwpTSwqFLxVMwaNceeYJZIFsffs
	dJM84JEKWSdaygRrlgBV8v2fA2ojGFAK+fxXid4qoV7kV4v+OE6sH7z8T5R3qmTS4WywrfNkcCk
	lxedSamfPXp/cPPT5GPrbl/cuipq5hNwRs0nIPV2izW3Q+zZ9EODgeXfM8VptJHXDAUSv01EDoH
	sjtEJDCrjJE3QLhOwq0/OVkLxz7CDoN6nGKRb9Iia/2szwOKG4U8Za90h3H7rxx3w/bpJ1uvgTi
	ZPcsTebWbeQJ3CyNJ+P02Oue2jZZRV1+GTwRuBf3mkkJ6sGAl2KbSLqS+8MzZiZAq9LEg9dZhTb
	JZwTScttUS3AUd5z+pMCiSMjVltX3rGoZdl5YO3CW+cwhc7zkzZUXAEvJcw3tL888Uxq1Fh4wa
X-Google-Smtp-Source: AGHT+IE9mNnuMDVwglGrvGw2yTjbcynHYB9CF2CMUg4xIjOi2ZyTS7PoXLiWyXTcksqn0f/3QYf6yA==
X-Received: by 2002:a05:600c:6291:b0:479:3a2a:94e7 with SMTP id 5b1f17b1804b1-47a8f8b1449mr81152125e9.10.1765717148670;
        Sun, 14 Dec 2025 04:59:08 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f8e90f2sm129987495e9.13.2025.12.14.04.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 04:59:08 -0800 (PST)
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 1/1] Fortify: Use C arithmetic not FIELD_xxx() in FORTIFY_REASON defines
Date: Sun, 14 Dec 2025 12:58:57 +0000
Message-Id: <20251214125857.3308-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

FIELD_GET() and FIELD_PREP() are mainly useful for hardware register
accesses, but here they are being used for some very simple oprations.

This wouldn't matter much, but they contain a lot of compile-time
checks (that really aren't needed here) that bloat the expansion
of FIELD_GET(GENMASK(7, 1), func) to over 18KB.
Even with the 'bloat reduced' FIELD_GET/PREP they are still hundreds of
characters.

Replace FIELD_GET(BIT(0), r) with ((r) & 1), FIELD_GET(GENMASK(7, 1), r) with
(r) >> 1), and (FIELD_PREP(BIT(0), write) | FIELD_PREP(GENMASK(7, 1), func))
with ((func) << 1 | (write)).

The generated code is the same, but it makes the .c file less obfuctaced,
the .i file much easier to read, and should marginally decrease compilation
time.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

Note that changing 'const u8 reason' to 'const unsigned int reason' generates
better code - in this case removing 2 instructions (one in each of the called
functions).

 include/linux/fortify-string.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index b3b53f8c1b28..171982e53c9a 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -2,7 +2,6 @@
 #ifndef _LINUX_FORTIFY_STRING_H_
 #define _LINUX_FORTIFY_STRING_H_
 
-#include <linux/bitfield.h>
 #include <linux/bug.h>
 #include <linux/const.h>
 #include <linux/limits.h>
@@ -10,10 +9,9 @@
 #define __FORTIFY_INLINE extern __always_inline __gnu_inline __overloadable
 #define __RENAME(x) __asm__(#x)
 
-#define FORTIFY_REASON_DIR(r)		FIELD_GET(BIT(0), r)
-#define FORTIFY_REASON_FUNC(r)		FIELD_GET(GENMASK(7, 1), r)
-#define FORTIFY_REASON(func, write)	(FIELD_PREP(BIT(0), write) | \
-					 FIELD_PREP(GENMASK(7, 1), func))
+#define FORTIFY_REASON_DIR(r)		((r) & 1)
+#define FORTIFY_REASON_FUNC(r)		((r) >> 1)
+#define FORTIFY_REASON(func, write)	((func) << 1 | (write))
 
 /* Overridden by KUnit tests. */
 #ifndef fortify_panic
-- 
2.39.5

