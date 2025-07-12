Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D613C30
	for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752348258; cv=none; b=n9ZokmgHLmlIGlSJUNI2h/RG1JvVrrwLyzFIuoLez1Rve5Ppq9KgTi9BeXHmpHafoHOT+mcjOI48XzE+vqMeB2e0YvJwAU6jkUrcI/uvT4ipkgg8nSurSYj0x89nkxgXazWn8psSmbrFqNYNI7kK7GYFW6jfIxxijYXVKQf3EqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752348258; c=relaxed/simple;
	bh=HP8I4UUbxpPWP5WWHpKzp4b3+cuKPSP4zyq+/xI9FKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OZZQBP3meVhWhI/dpXkT4hjd0ACce+ThXRuTtjCkCIxOsvmeFrX3ct5HyvzWh/YjywqXgmHPrRN3ef/svX2gjb2yQ/fkeAso4HgZcoQ/BOgrgo8PG+CWA+IURk1Cde3yPh+z+iau/taSOr/LfxS4A3DF9e28SXbmA0H/6kyz/eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BA2UWUmV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BA2UWUmV"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234b9dfb842so28933975ad.1
        for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 12:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752348256; x=1752953056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVUdA+i2pAr2uj9ol8r//BsDbGAmbJ0EpbI5HhTbb2I=;
        b=BA2UWUmVcAOr8aeDrbZ3w+qP5w2R0HLHOWXRDJ34sPjX1Wkl7n21zamRKS51Pzm/xn
         Zxqi6Vrnwppdfo31mkq/4RZ/wNsQL8jfToAKa6IkuZAhTQhwmskf+prCSGRC71C65A/N
         NX3lScJ/VrYQXVHSz/q6ewWCx41VELJNjtECZiHmuIAO3lYF+avK34A0RectyrHtAIYd
         EGYXOlDUBoyZS+NrXJ1XLsNdyt3yvIecowWX3kyU35uVyH9km3HJJerWo1J60YsW/2IF
         rv0QjxmKXpSNlRAtiSIYi3tjCcx9TrzEtFFsnqvSv20/V25FBj8fxuE+sFQzDWE2D6A6
         PIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752348256; x=1752953056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVUdA+i2pAr2uj9ol8r//BsDbGAmbJ0EpbI5HhTbb2I=;
        b=bhVMXqL4HweelIfttxF2AOBEofWADXTpOgh1wuDMgB9pZaXWWfDOS9KRMgXePEXBPN
         42eMB1k11NoyKhqelXFBaBUzr392MCuzKTPjwB0abXzejgdvGqAEQfQP1oG+GzRr1MPQ
         KEXL/7hyRZfEXCq4aqeraLymOsW5yF5k6hEIce7k8+gHDIEwybwC8nBTc0N7I7aGof/I
         AcJgDtcAvDHPuwinBhtro51DUNxbSFaM5LFKPBh6roCCd5xrvHnChVjWUTWp9W4JcfCY
         eEL8aL394p1WBQ/AcIudEd9HYbOlO5IGvi04F2x2AQfBfC2gD46AGshsj7Uyr0+8cOxr
         7/4g==
X-Gm-Message-State: AOJu0YyipKMdgKIPiZMLlbNwPhsaZHS8cyTxC/OdrRBbIjPq69V1is4V
	qQmzai/lGV23bYgQGyf1jU8knVBUv7aunJwlx3NOrP8TVtQwljF2F2JUxfnupsF4
X-Gm-Gg: ASbGncsERmxssbJKumwTAxoVQ21wu2Dal77Ut+BY+ZQEsmY1FR3jW3ns5osygVzQzMJ
	Fy2uuLqzuq9EVsQ+wILNWG5IhMc9h0j/utED3qXyEbGWqsEutAYjc8CzXSKYVbaoQ6GmUyaFT2P
	9wjDT+J9rWBbYWfvOs2qMVhaNZWmiEmwBvjashkKYpmZ4BTl5KK2gnZn/jGdlKdc7BzXsSOj240
	ILO4c+ij4/BDkmmPjuy1WGpVYWeHqBIIQPbsFvoY6YV24WXEic+FUgKj4ERxLqbsKr1k2CFSmwB
	AKHov0WRF7DqHdOF+Y6JjjsHkNeyTOK1QZ3fqVzFfAl5/ldSUb33zH6pgS8LcEkgpLAR1wPfzuc
	HWIVxpfu1NC9qIYBLNcGI6aHzmLruSKwGAYuMFcpjM50lPbHtjTZgmjU=
X-Google-Smtp-Source: AGHT+IGtdHZe/XxZ1MaF8uxYup8zl2UxRYeXTaC0L3H13srJ8VFRlX/DVuf8I7VeNQdG7P0d+u+i5g==
X-Received: by 2002:a17:903:2acb:b0:235:7c6:ebc2 with SMTP id d9443c01a7336-23dee188a28mr115542045ad.4.1752348255731;
        Sat, 12 Jul 2025 12:24:15 -0700 (PDT)
Received: from localhost.localdomain ([147.182.204.210])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de4332b0csm66013645ad.149.2025.07.12.12.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 12:24:15 -0700 (PDT)
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: linux-hardening@vger.kernel.org
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Subject: [RFC v1 04/17] sched: add protection to task_struct
Date: Sat, 12 Jul 2025 19:21:49 +0000
Message-Id: <20250712192202.707192-5-gatlin.newhouse@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
References: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Adds caching data structure for every task structure and optionally adds
a statistics structure to each as well.
---
 include/linux/sched.h | 11 +++++++++++
 init/init_task.c      | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4f78a64beb52..f2de0e565696 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -48,6 +48,10 @@
 #include <linux/tracepoint-defs.h>
 #include <asm/kmap_size.h>
 
+#ifdef CONFIG_SAFEFETCH
+#include <linux/safefetch.h>
+#endif
+
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
 struct bio_list;
@@ -1654,6 +1658,13 @@ struct task_struct {
 	struct user_event_mm		*user_event_mm;
 #endif
 
+#ifdef CONFIG_SAFEFETCH
+	struct df_prot_struct		df_prot_struct_head;
+#ifdef SAFEFETCH_DEBUG
+	struct df_stats_struct		df_stats;
+#endif
+#endif
+
 	/* CPU-specific state of this task: */
 	struct thread_struct		thread;
 
diff --git a/init/init_task.c b/init/init_task.c
index e557f622bd90..a378271cf3a2 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -17,6 +17,10 @@
 
 #include <linux/uaccess.h>
 
+#ifdef CONFIG_SAFEFETCH
+#include <linux/safefetch.h>
+#endif
+
 static struct signal_struct init_signals = {
 	.nr_threads	= 1,
 	.thread_head	= LIST_HEAD_INIT(init_task.thread_node),
@@ -220,6 +224,13 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 #ifdef CONFIG_SECCOMP_FILTER
 	.seccomp	= { .filter_count = ATOMIC_INIT(0) },
 #endif
+#ifdef CONFIG_SAFEFETCH
+#ifndef SAFEFETCH_MEASURE_DEFENSE
+	.df_prot_struct_head = {  .df_mem_range_allocator = { .initialized = 0 }, .df_metadata_allocator = {.first = 0, .initialized = 0, .extended = 0}, .df_storage_allocator = {.first = 0, .initialized = 0, .extended = 0}},
+#else
+	.df_prot_struct_head = {  .df_mem_range_allocator = { .initialized = 0 }, .df_metadata_allocator = {.first = 0, .initialized = 0, .extended = 0}, .df_storage_allocator = {.first = 0, .initialized = 0, .extended = 0}, .df_measures = {.search_time = 0, .insert_time = 0, .counter = 0}},
+#endif
+#endif
 };
 EXPORT_SYMBOL(init_task);
 
-- 
2.25.1

