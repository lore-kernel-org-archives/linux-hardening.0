Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA272E54B1
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365396; cv=none; b=K6xYFyISR7oJdvs8Zz+r+hxI8j1rlU1RFs312yHUzhTVbTAcUd4MGtsEUnoX2g/l60lgHmRqwoD04rLMxf5IELwnnA6GQz8QTlIX44EuOQorONXt6alh2zOmrKATSZmPv87pb/hnkdhMiEkfvch2p5JUDVgTOTpX9TwBQoaZlP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365396; c=relaxed/simple;
	bh=lInkchUokjBe+FHAH3BxBiq6Y7tXF29NidQLxKe+PNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVjB7PyOiKrulKZk6aJ1OPfj//RQqzzQuzol0hM6QvO1KoL3R2rwtm4DbxVhYmgF//NIhLfv+Tzq6PxwJ3dEuFYfuQm9erOrD/nxNNcF+5dW9HSYHs7+E6zwqfLkr5ZbtPa47GcwUptElHKhDQl8Bodeugeaj8tmRBrJK0ju4w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gW9AcyqK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gW9AcyqK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso7181795e9.2
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365392; x=1753970192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl7MPjMQQR9YynEjNt+gG293fesASKmyZt5GnlBVdKk=;
        b=gW9AcyqKuSMhUqviT/CaEES5gWyFk0OxnCjCR0DV8Rfx02S0IQgPMd6CCa6dOcVh30
         63+5SGga433jpyLCKRIXeF4x+RONQMfgfnRhuEXYSrdOc15P7ZP6knymrDIPSnlOXUbc
         zFBeJYEvIP+0Q6l8vESKKOH7mvgMS3go6yHjeswsqDv5pCRNkBsMaFUpGolOHFcK9KIp
         B6bRuQK/BFUJdswR5pSmYLkG3M9hemjwfzoAjOdEICNheo8uqwkwqNhLV8X2BZObm5mV
         YQDLMYBBmiQ1th6CMa1aSDiOzN50Af38DcFCS6QDL1+4TAlQC9tZri6Kb23R6heF4d/x
         wrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365392; x=1753970192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rl7MPjMQQR9YynEjNt+gG293fesASKmyZt5GnlBVdKk=;
        b=DIqK4E/IncmiRds+8Z5QS1SNvjdHlf5tREEcz8TDwWhiqAkh/acnjADdSLV1xpldVc
         ALtNKOoEElqYwvSqdS8Nzd7EBbDKuXJBVLpCpSi4sQPaOnJ0M6HITSnPV+NXKShG9JPt
         VPzqSJcF/o8kC3C/TsjY+ockZOpS2jxVjWbAuS3TEOmpRbbGOFd7aJRJU9ZeLFCCREzY
         uZFJKA/H2mFGRFIjv3oeT7HiCSEIvGnC69QxpmfnUfKrZyr2hhKoq1OICGPn+/8sQcQc
         omTSvYlgbtNu2TY2fMP4UKRZ5ZKBTu6JCPhXsTV2w3Kd96m6DdIvZNScAlNPrndYn4NP
         EBTA==
X-Forwarded-Encrypted: i=1; AJvYcCVBAZ25016YQ8ISVdkgcPc0CUl302qd034FEp1UOkmkJWt9PK/Y1BBzlZDo0RFgRUeIbuLmrDIjvID7W47krVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9oVV9tr7ozh31d1PEqmjBNfqMd0rw3GmikXMoTAl0lXpPaYgD
	Xjg19Eg4F9Mjw5JSKKwDIN+7MIeoXhbQGi1xwzzFgnoYs6Dt1Z0lI7s6W1WZI6b/8Z0=
X-Gm-Gg: ASbGncu0ob/Z9Kxb62shjmQ5X9V5C53KW78LrSeoV6RGcfXXxHtVXa1nfUMg7KbJ+3T
	xc9mskI130B05IVdH9lMF2FSXnDjY4qac2Gzfp3T6IoOal0IUqKEqHzN5BjgiQlt67kDXi6UM1i
	b82PN+sF/U5G0xt5EaO6Auyi+7mdCJtbUmbinkvCVY8gRAUk1vllWXGzjZ0PFPEUH1t4NtSpaVf
	GlGwX2nlY88bTcjd3M4xqQgIW08FeRgaQvOTHKz5dFKRPJA+uL0bQE4UX17KgtCOorzmnctc2oy
	F5k3jd4uOQV7LQzEDL1/TB3xQrYggou0z5Hv2LRSMjG9A3KKco+McyITdYgo/9HFV4JAuxu9FBn
	FnF/TE5B8gH9jxCf+21DiOe3t93NPzEl+zpgXmM+XGs73hRSdOUrhX56bopHy96kb0JyQYHePJR
	DT1bWyKoSe9I8y
X-Google-Smtp-Source: AGHT+IHonQ82jnLO0p5HYq/pDMzB+6N1t6DWFVzcA1CVX2U3nXqH6sJ8SaBoH0rb44h0xr8LW+w4sw==
X-Received: by 2002:a05:600c:6992:b0:43d:46de:b0eb with SMTP id 5b1f17b1804b1-45868c99c85mr63756925e9.12.1753365392038;
        Thu, 24 Jul 2025 06:56:32 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:31 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 11/29] sched/core: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:54 +0300
Message-ID: <20250724135512.518487-12-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into kmemdump:
 - runqueues

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2343f5691c54..18ba6c1e174f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -67,6 +67,7 @@
 #include <linux/wait_api.h>
 #include <linux/workqueue_api.h>
 #include <linux/livepatch_sched.h>
+#include <linux/kmemdump.h>
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 # ifdef CONFIG_GENERIC_IRQ_ENTRY
@@ -119,6 +120,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+KMEMDUMP_VAR_CORE(runqueues, sizeof(runqueues));
 
 #ifdef CONFIG_SCHED_PROXY_EXEC
 DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
-- 
2.43.0

