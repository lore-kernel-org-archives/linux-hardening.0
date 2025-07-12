Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDA53C30
	for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752348260; cv=none; b=KauD1yAfvRl3SDd56wC9Z1UfNlhU/ECcq71ElvVfSzY6H+7bTe7QiqduOchRRAYVKyZ+lQaNGuCQ104aQLvJPEWM2+QQc2/V5/53SAir6C7P5BKkY+UAxj9l/MI6YvJZGqfF9XZNlMxexgLog03NV+tHP3omT2roD55xZEUsFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752348260; c=relaxed/simple;
	bh=Nes6f1fZBpLY2nyg1iafWnX3Jwp2nx2d3NnanYM0RTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eikQ+7sEhzBn3O77YiXudo2FKttREPjoQuMkxYZV7GQxfVr6IicA7tUWlCr5W00VSoeP3i6CAsHVD2ezQWm+ve18BaECOh3SiYKiIh2Xjj/LYMvkGcYo2zJi+W9nCFW4ulfH6EJgnK8aWRyLMjG8oO/aO/Soa1jMKW+cw92dSU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czHzSnPd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czHzSnPd"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23c703c471dso35551265ad.0
        for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 12:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752348258; x=1752953058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IE9HMJY8sR3JkIClAZLUFN6qbNwz8PyZBZ/MV3KbT1Y=;
        b=czHzSnPdsvCQ90SqTt2RwQT5FB1EM7LMm55KbqVSr0h1iyIUX112Xr2BLggPO1Fjpi
         /Tyt9aqg29iLbhetZSM/7xW1k89iv+wW0+cQxXoXSPJ9FCEJtoOvqMQV3f0qKkpeqPa0
         zQNcTj2UMdAIio3wQHFPmtlh5FiL7DnJAcKs5BK3kYqf0HQredEM10Ff3GBcjq4Bw9Q2
         rFL0fMwZXoYwWfsFS3JtDzMrh5tGEqt/FLBTxKwuDzzpAQPLK8GCJETS4hEwtikwBVy2
         vfCULaMVzemMos4dgCcJnkC/9ltQjJosjceFfDUmCxpjvGUXWQ4x3XF7vb+Fq9JRQUiL
         AWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752348258; x=1752953058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IE9HMJY8sR3JkIClAZLUFN6qbNwz8PyZBZ/MV3KbT1Y=;
        b=DimoxowEEfk9GzpSGaCgp5A1Frw6jWBoNPvfJUJEKnrssneTHUI7qm/AUtVrFl9zkl
         tcxOgIcswuF+L2edUYHtm8mr7CSRc9n2obQ+KoFC9VU2NmSvf3ZTWBpMlAY0fCFg8MCQ
         lO5PE99V70FYPnEbyA1jXv1Gn8TROyGljkHRanDDcaBZm/bLnsMp5T5pbq/rECroKfh0
         +dB38Ph1tW6CCgsvWijyTJBCp+0rkvsFbJ1wl9N9//EZw73yxW4Sl76FUZpaJ2Wqjjcq
         hjMmwH6Libo5M9SCtRGsMKD398vVGrwp3gMdl71M+k2rmIRoNnXijTuGBpln3eAAf38n
         QrNA==
X-Gm-Message-State: AOJu0Yxqa+H/rHKyJ12Nt8C8sU95PAYu4fnxbGGBeZK/KGXce4Q67tuB
	etbff8/N6eOqQyAyzjiHN5/MptaAAHi+uLiHcZhQck3+mh9bYOnlgwld6gj0f4R0
X-Gm-Gg: ASbGncvvqe4mSUugof/HD549nHOrH3U1Av/fW3G8zKFFCY7+zRwp+86l2u3SG3FNa9w
	GB1trFXccjA1zh4qpBD2lYAoedkhU25zOT1wB6Tuj6BJSorMBuaVdo2xYVIeTe5iLL1ri9nOTo4
	95DBD7xDSQ6VAYkjmgJYCGHMx7Hj+lIakKMgIjSjFzG/uhC5mF9wCT/1XfevCEhs9d1O0Kn/3v+
	JRe+yLwLnF9L8dfFsCqamKPx1wFYo4gDkVcl4dipw0+fZcs9aMyAXShSAY3pUfwXglCW7FuVaNB
	Y6NpuHYccKAHEqS4xfnAAO3YnFwKA89kwvmb2nC+xUPkORBu4Dk0t9CCQD8OGm60WjpkJe9u2B/
	3gsqfO/Cbo8SOKBBSNIiglA8tB00LtikK/HtZvOD4WTIH
X-Google-Smtp-Source: AGHT+IEO5Rphs4LbYS2Nhspv81kY+igXMR/dKURQvnC2SlQiDyz4g2BqGdgFu9fUez5fPJlw0J+uBw==
X-Received: by 2002:a17:902:cecb:b0:23d:dd5b:886a with SMTP id d9443c01a7336-23de2eafdd7mr178211455ad.0.1752348257669;
        Sat, 12 Jul 2025 12:24:17 -0700 (PDT)
Received: from localhost.localdomain ([147.182.204.210])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de4332b0csm66013645ad.149.2025.07.12.12.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 12:24:17 -0700 (PDT)
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: linux-hardening@vger.kernel.org
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Subject: [RFC v1 06/17] futex: add get_user_no_dfcache() functions
Date: Sat, 12 Jul 2025 19:21:51 +0000
Message-Id: <20250712192202.707192-7-gatlin.newhouse@gmail.com>
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

Add disabled cache get_user function calls to futex functions to disable
using the SafeFetch cache on any fast userspace mutexes.
---
 kernel/futex/core.c     | 5 +++++
 kernel/futex/futex.h    | 4 ++++
 kernel/futex/pi.c       | 5 +++++
 kernel/futex/requeue.c  | 5 ++++-
 kernel/futex/waitwake.c | 4 ++++
 5 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 90d53fb0ee9e..0ad5e0dba881 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1023,8 +1023,13 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
 		return -1;
 
 retry:
+#ifdef CONFIG_SAFEFETCH
+	if (get_user_no_dfcache(uval, uaddr))
+		return -1;
+#else
 	if (get_user(uval, uaddr))
 		return -1;
+#endif
 
 	/*
 	 * Special case for regular (non PI) futexes. The unlock path in
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index fcd1617212ee..515338cf4289 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -308,7 +308,11 @@ static __always_inline int futex_get_value(u32 *dest, u32 __user *from)
 		from = masked_user_access_begin(from);
 	else if (!user_read_access_begin(from, sizeof(*from)))
 		return -EFAULT;
+#ifdef CONFIG_SAFEFETCH
+	unsafe_get_user_no_dfcache(val, from, Efault);
+#else
 	unsafe_get_user(val, from, Efault);
+#endif
 	user_read_access_end();
 	*dest = val;
 	return 0;
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index dacb2330f1fb..f9f4ac192338 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -1140,8 +1140,13 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		return -ENOSYS;
 
 retry:
+#ifdef CONFIG_SAFEFETCH
+	if (get_user_no_dfcache(uval, uaddr))
+		return -EFAULT;
+#else
 	if (get_user(uval, uaddr))
 		return -EFAULT;
+#endif
 	/*
 	 * We release only a lock we actually own:
 	 */
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index c716a66f8692..3ebc08a9a8e8 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -468,8 +468,11 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags1,
 			if (unlikely(ret)) {
 				futex_hb_waiters_dec(hb2);
 				double_unlock_hb(hb1, hb2);
-
+#ifdef CONFIG_SAFEFETCH
+				ret = get_user_no_dfcache(curval, uaddr1);
+#else
 				ret = get_user(curval, uaddr1);
+#endif
 				if (ret)
 					return ret;
 
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index e2bbe5509ec2..bf4ed107aff8 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -629,7 +629,11 @@ int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 		if (ret) {
 			futex_q_unlock(hb);
 
+#ifdef CONFIG_SAFEFETCH
+			ret = get_user_no_dfcache(uval, uaddr);
+#else
 			ret = get_user(uval, uaddr);
+#endif
 			if (ret)
 				return ret;
 
-- 
2.25.1

