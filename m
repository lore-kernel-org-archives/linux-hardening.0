Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE8A80BF8
	for <linux-hardening@vger.kernel.org>; Fri,  6 Dec 2024 01:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733449177; cv=none; b=d9Y1Tf6P4u/wnoPW2e4yBV17U9uYhOsFDjF1B0Z0NwZczO2fEOplZW2kxCyO60AyuAIzov6ej7sYzHt+mYZ4CKDmliIIXMVQ1FP/WtZYhqTpAQxKKkdxIKkKtbk1rIMaPcx1+EwNvWU6wmOyEMI8Cxf78KOMIZu2P6EV2pnOF3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733449177; c=relaxed/simple;
	bh=tq6idRPlH9QbeZXVYLBlZDnSxi74kYOKjPG57wGwzlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LfUCTaTpp/hQFdCRqdrxsX6Ad7OoQlQkqsG0/iEdRHgf4RT9SJ/OWZyumkRcP5PHsdPDUc6jsBM6tl/WkArmiuygvcyWV2/skJNJm35JyLnC5SuIdSeLqfd4kvAcM1iBzC77oq7ALvqcbHd+F7cvryJGdiGxejhNdkAwg2TMPeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S0z7PE2X; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S0z7PE2X"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-215607278acso1322395ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 05 Dec 2024 17:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733449175; x=1734053975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XSQJ1HOy65NxdTTDtOXYHpi4KVX/eOZdGvlizxFTiXY=;
        b=S0z7PE2XLQvVrZ+JAsVw9V2uDeqzbavkMFpQahEqdE2EhtwqoV6iSl5NeK+ex07qMN
         X/lAS4Z5TQF376GiWIXyswEFRlxrw2DIuFbirF02MoZfLBu5OiX0dOgrRG+Bcr6MRbeU
         c+g4lgqhUiVcP5CmcvAN0tqBXHa+DMJMe8kys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733449175; x=1734053975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSQJ1HOy65NxdTTDtOXYHpi4KVX/eOZdGvlizxFTiXY=;
        b=lZJymbTx0QAyIYDx40mx54vE10XlLimwkDMYbfw30ztUv1PiAONF7c0GHUkY+Ppsi3
         FH8lyBhXpst451l/2gzFCvilLd20xTao2W2i/w2h3dXPp07C4mfgVtc4lCpZ1ncyHbr4
         v/aE5DKbGuyFtTEVNGvQF2KVDYfIeH7w7HAPRmfz+vD+jhwe/9QLwPtMQb4KYILsEj2m
         cWbemG+9rkn+69e0G9hgcAiA849Tv638PweriJx5uOvZqYznH3/DDXMQBFzQ1PJcJKQU
         ZFCwmuSyA3yayTO4bLIw7wO6JjlsrMZorIApMT6SjFU34FkIlFZFoWesIFzC9lxIHA0S
         0UWw==
X-Forwarded-Encrypted: i=1; AJvYcCU3ndRwL7dNSCvSRqYprNxWAWq8/ovEvJ3wRs93NO5S4iqq3sM0b9++jRdjRGoSBkZifTZxJCuob8UgS6Ab58c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/H+Kt97Fx1nke4ji861lmhTn5B7SkUDjUN2gDDAmYEGUFBsx1
	6omh3Eg0LZprzPGRvXu5jmOJvO6UBQdhXwWN+ntY1qMkoOcr9s0dSjZXxgxgAg==
X-Gm-Gg: ASbGncvw825kx2xqx4442SvTbiwomD1uRRmNUDWzyotL4itnRW8hj1HB1yXv/Z5Jny8
	11lvLpNr8N5lAcZkUYy0UgPKOu870Cx/zBfqdc8NE6dVIXXCMRbA9OOSvZNWf/dr2MlKCuBvsg8
	VhMFolQIagWSYEObY34ivh6gEGL9OErRSUdAyPIul4RLNVhMsLs62R1OJKcB5gMiOgZVvKV/OvA
	kAV2HwHqDvyuQDunSKRUZuAcDM9hHh4iguefzSdH6LcEj7UH2kDrx2vJ90qy7mcz+lmXG2Sc6Kb
	9MVCtlOogiI=
X-Google-Smtp-Source: AGHT+IH3Fdeuwj9S9gBBbgIm2RrejRpYnXUO7GaCkJRgcg3/NVfmxr6SCUcgXFAlwY+/gZdwpnrdaA==
X-Received: by 2002:a17:903:41ca:b0:215:7595:9474 with SMTP id d9443c01a7336-21614d44b20mr5508645ad.5.1733449175580;
        Thu, 05 Dec 2024 17:39:35 -0800 (PST)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-215f8f092e2sm18343865ad.202.2024.12.05.17.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 17:39:34 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	keescook@chromium.org,
	pedro.falcato@gmail.com,
	rdunlap@infradead.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v1] mseal: move can_do_mseal to mseal.c
Date: Fri,  6 Dec 2024 01:39:34 +0000
Message-ID: <20241206013934.2782793-1-jeffxu@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

No code logic change.

can_do_mseal is called exclusively by mseal.c,
and mseal.c is compiled only when CONFIG_64BIT flag is
set in makefile. Therefore, it is unnecessary to have
32 bit stub function in the header file.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 mm/internal.h | 16 ----------------
 mm/mseal.c    |  8 ++++++++
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 74dc1c48fa31..5e4ef5ce9c0a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1457,22 +1457,6 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 			  int priority);
 
-#ifdef CONFIG_64BIT
-static inline int can_do_mseal(unsigned long flags)
-{
-	if (flags)
-		return -EINVAL;
-
-	return 0;
-}
-
-#else
-static inline int can_do_mseal(unsigned long flags)
-{
-	return -EPERM;
-}
-#endif
-
 #ifdef CONFIG_SHRINKER_DEBUG
 static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
 			struct shrinker *shrinker, const char *fmt, va_list ap)
diff --git a/mm/mseal.c b/mm/mseal.c
index 81d6e980e8a9..e167220a0bf0 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -158,6 +158,14 @@ static int apply_mm_seal(unsigned long start, unsigned long end)
 	return 0;
 }
 
+static inline int can_do_mseal(unsigned long flags)
+{
+	if (flags)
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * mseal(2) seals the VM's meta data from
  * selected syscalls.
-- 
2.47.0.338.g60cca15819-goog

