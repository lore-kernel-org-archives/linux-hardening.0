Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A711327A1C
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689861; cv=none; b=hXrQFXamC7mRiOdUEkx9UvpwTOqmcPCMjmqQXWCX/ITtOOgiHsC8Ye0Skl+lrLrj2Zdxh0PsKrpgMQjnwatM+R2sw3USurXtl+0k39wnBQL2lRc9WSXBd6yKP44udmDWyVOn22nv3yn/dRiHXQR6GSJ6NnXB2CBjXeLXXJIJOx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689861; c=relaxed/simple;
	bh=y6R7JHolSByTQrZMijPqGMycDGbxs6NH+B+6pGvmKpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDwW9U9YR5cJOElFV7q8wNgbKgOh5zjaR8mxW315TXISqtOi2owKvK4GBo9e1HfHDid9bis+6HcItwhFRmdV+As8dpkdbJoEDOh3eEmKBsl/SnUqskCq6yr/wGXWHejtpqOpmkGTTvVYHmSurj58OOHa1U4D5poiyTy23CyJZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RkLKDK64; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RkLKDK64"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-72ce9790ab3so14122447b3.1
        for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689858; x=1758294658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQyd/J78t59e431BzK+r1hLIHKrEAjBfy36U2OzrJzo=;
        b=RkLKDK648r9G39cYNUgxAOkTYXEi2/89mqteQ158UtaweCw6CikKqdSLRll8g0cHql
         qRxTuJrsWD0ihRSERDZuXzora7vcp8ATffCF4huACVPct1VvjVWD2nq/KK0PEWriuuLE
         V6RC44iPBH1NihSdKirV+JOfyCZ1lTWHtGH0frmoCOX96W1rNDHhysfntO28vlTE38B7
         MdPsuoE0+HqHemQ6VXwnwNc7fBPzUNDAwfWLAquFf2P8I1G/dowEFb/dmQwCyMpk7AcG
         vX13zFnYKk7wUjiGbHMIAQtDvjn0nkWJl9Vyj5D7EYO1n1UyJBw/7tLB2hZ9RB3Fpt4Y
         SWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689858; x=1758294658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQyd/J78t59e431BzK+r1hLIHKrEAjBfy36U2OzrJzo=;
        b=ioSGI+y7dddEVwu1ktbMzuLYhEzYGJRR/ER5ByaZlMy9Xu4bhOOIe/5SP8FHFj0xHA
         Kga7FHe+xg6t8NaW1dgJABig2+iFgLvfFyOFNMY40i8rTzNd2TlMRWyq0+RW0FH0l0Db
         MnzMQ8MxPj1v4wX9C8nU2ZdjtZOdFM+NZ7q4y4i/boDtx1Z7f0NGeC5+Ru3y/OcGP8uX
         Jv7MUHLmFu/wofNi/8t2aPksA6KqX6Ph6c4ty3oEjXyGA0ujG5hFoT5Y1HJbfXTSyVpL
         eaXOOMJnbn8lL8zFq/jQzlvSkkU3+q7GE/WygqPcFndGZqAeg82bY+szgATlVJY1Ml6X
         B0yg==
X-Forwarded-Encrypted: i=1; AJvYcCVDM1LA7t30kSUnbHM7WtKJ5g2NYLqJGj/yKqVTA5xWbaXQaNO2ifZTnBRr5s1NNY8Z1+hP1W5l5w3Z5hacnh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxANq7svlfTY+c4LQHqJm8GkzDKtL/IuY/kMyeh1b/3svefl91U
	YWvn/5ZMX/qYVfTNkPvXeFh+z6MrNLfRZZ8E3d5t8hldc2fYGpyjpdBBRZHE8Zp8o2Q=
X-Gm-Gg: ASbGncviXD/hVWJvfam3GSXfLViR3+VB3q1quni103sFzH1M6CgsSiC+HS0XkaofNH3
	WSQYZIo67DmwkUfSsQLNgLB/FjimuBhKFxaLNI83/uyxYFsmQ77CuRw+93R+WUSjLv0/KiswG/X
	UmGCJv6fu7W+BLwtgUOjgJUhU5utV7PncVU0ijcUNif47qkCPO59314dCMtM9JMIeX04qjdNIRs
	Am9FYyORVIVXnafJNLBwrXbFFRbHMNKZBnIhWba1vzghejfKc/dGb/F2pHLN2REJvF9oH3QQs9N
	uPbWeltX1IpwUh0wV/rul7c6EaHtwBXbg7eni0JbbgtZw4P6kRFeXLk6NeEICXvGBUi/fPZp3lu
	PtaJ60TNrHXerIBm2kig/yBdoC9sCSyKumA==
X-Google-Smtp-Source: AGHT+IHiWq2tZ0Zh+6RCMZ5n4YEMDF8GDIlS1UolWn0dcdm4mJQCk7ANF/Eeoayp4tEVnT1oJJ4YdQ==
X-Received: by 2002:a05:690c:6089:b0:723:9ba7:7f9e with SMTP id 00721157ae682-73064cfc375mr30364727b3.25.1757689858316;
        Fri, 12 Sep 2025 08:10:58 -0700 (PDT)
Received: from eugen-station.. ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-624841586c1sm1302244d50.6.2025.09.12.08.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:10:58 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH v3 13/16] sched: Add sched_get_runqueues_area
Date: Fri, 12 Sep 2025 18:08:52 +0300
Message-ID: <20250912150855.2901211-14-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912150855.2901211-1-eugen.hristev@linaro.org>
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add simple function to get the runqueues area and size for dumping
purpose.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/sched/core.c  | 15 +++++++++++++++
 kernel/sched/sched.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9af28286e61a..a054dd1fda68 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -120,6 +120,21 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
+/**
+ * sched_get_runqueues_area() - obtain runqueues area for dumping
+ * @start: pointer to the start of the area, to be filled in
+ * @size: size of the area, to be filled in
+ *
+ * The obtained area is only to be used for dumping purpose
+ *
+ * Return: none
+ */
+void sched_get_runqueues_area(void **start, size_t *size)
+{
+	*start = &runqueues;
+	*size = sizeof(runqueues);
+}
+
 #ifdef CONFIG_SCHED_PROXY_EXEC
 DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
 static int __init setup_proxy_exec(char *str)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b5367c514c14..3b9cedb1fbeb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1330,6 +1330,8 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define raw_rq()		raw_cpu_ptr(&runqueues)
 
+void sched_get_runqueues_area(void **start, size_t *size);
+
 #ifdef CONFIG_SCHED_PROXY_EXEC
 static inline void rq_set_donor(struct rq *rq, struct task_struct *t)
 {
-- 
2.43.0

