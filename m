Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C392E92C3
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365406; cv=none; b=idzcqSpUqFeYS85EfEdYMxbbGlYfic6xtpsW6uzONJhWKTpp5u4TD1AU99HAG5+MApb0/OQdFp0YEwa1JUukMFgHbTPy+p+3yBS+gWi28c0RQB9MbEBUKOXeE/+gvspKVk/WO79JAPE/08itXR8dKoT0P5UGOKd9E5ryZJXIiW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365406; c=relaxed/simple;
	bh=wARnIHcM6q6qiMPnn5loBslIGs8WDjRosQ7TWci8o8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGGC4LtNoYV+MzbB3CAFM9jMgzNz2vAdeD/7P2nPd1TQHkhaNFYRliYX4D7pb82wDCsN0eQGe3cy+FPzs92TV2Y+w8Tapn/HMoDSfaynUKlG6DG8cE9d2H11Aj65yYf/QJdVkonf2M7RIsGBTbiEAg7QGoT7eEbUkrbuJ4Z4Coo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JOAY9+ss; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JOAY9+ss"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4560d176f97so11421745e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365400; x=1753970200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ay6ISBVXr4RhwBg6A2t7OCdYp+NqRXGL2jP3qh5ffs0=;
        b=JOAY9+ssBL5AftLlTXlwCYP/JT+QP2lzmifqj13XQuxS3W5e2xCdZGZJnGOoxAJ+BH
         31i11imIbD07KejKcMpa89wM3cs+YfFj29ONOHDQ7VaHrBWEbk8SU3hOpyQll2rGMs96
         1WbBJO6uGitA1frzw/38lz3rF8qXBUsYBMeLOpuNlvl/9TgiJIzHAseN2dPAwJRnR7sn
         b2/QOtkcBzcgIa1Rr/PiTMLwP1DX5yui2tNfPlZXV3rV1jD6PM0Sk3O9pcW8OiOMaGvZ
         RbOvuf4JT21MCkQpb/L+SzfX8EOnFYRr9SCpz5xAtpIj9aMZHf4/6AN2HTCP+STXJ3Bb
         MVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365400; x=1753970200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ay6ISBVXr4RhwBg6A2t7OCdYp+NqRXGL2jP3qh5ffs0=;
        b=MrEFW/Qz2OBnZYGmfCodBeS4HfDSJDx/faV/kxuOFedOUfVKwDwaM87qaqr+Sw/Zn4
         O9ekEsplAEkir3oWRTSj21AKWDFGCXY/SDTj3G20d81UkIGETi8sievdhPSMAIUy1a2w
         lmI8jqMKKopldYw3gcmyaDv1u87RZPu61v1xn8yji7OtpKFhoPtX0Pj0AIpa8E1RJbWt
         Ih6DMxiFn3SCjpnKEyhFNaxjC5uit4gFNR9LSOjWN2Jjd6du52YNYqQLHBSikUlFj8CC
         +cTB9ryIGL0KthFHzotFSwtv+t3/znkug0BkKsdbZk0zbRWrXcW8RKsMTfaAoSnH69pt
         ndPw==
X-Forwarded-Encrypted: i=1; AJvYcCVINSf01yhl2hkJYb6kTM5L8bzqzI1Ik/IYLT/Gfhzx4hYXjtpbFrH0pgQLKq/OeVQEJ6Ve9g8UWjdjpwJg940=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsdJ4f1p3Hyvsl2suV6clL03AoQJqH0Bnz6qwaJdfwgyou0S+2
	6hsNWJQ71bS87ipIgfHBlI4i006na+kCR/Hb5XXjqj0tdt0gM48OelhiKHKDcFsH+xg=
X-Gm-Gg: ASbGncuoCLE1PxIEltftaQkuc+o0TKDu8MKys5am1i6jR+KkMBn1dJw4dyMY4WILyZm
	t9s3qy2nd1Xwi5JYIrMbu9FlDypESwuC9N0L88wvsjAmYRwppLdI/WyZkTrFdbdI+YNU2PcwoPQ
	wkpcbUUWbnI3BUWVTFpcxwfUK63v7Z2b/86A9+RgV0LujSNwohuVZpKAKNFgpofX8ry0ZL0RwT1
	ufm7hblJxigadVqv38u3DVogCZ8kiZB7zYjnHFgFJqHieAQ63DlHO4pILnMIllCSr/dDMtT7GXX
	25s3fuWdSRxrODtasnKeUj2GtXVDl+BdHquAewD/JY2/0BRh+Ggi6WfejbQtAx7BmoqVlOKXXVR
	D0/Gj3m3AMwBToCV0Exk2MNhlAAAwzZW+tuivztpBJGO1rcw9lc7WmmGY4rMvXuq/d0KmN0a1Sx
	Q2lMlbJsdGjJ8C
X-Google-Smtp-Source: AGHT+IGCkgT/Av7S5A2E0I2QQdMK0eQR1KK2t84reKZkouB15tDDQWfO+rh0+B+shYiLiz/J/iIBUg==
X-Received: by 2002:a05:6000:1882:b0:3b4:9721:2b2d with SMTP id ffacd0b85a97d-3b768c9c202mr6498976f8f.9.1753365400320;
        Thu, 24 Jul 2025 06:56:40 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:40 -0700 (PDT)
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
Subject: [RFC][PATCH v2 20/29] printk: Register information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:03 +0300
Message-ID: <20250724135512.518487-21-eugen.hristev@linaro.org>
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
 - prb_descs
 - prb_infos
 - prb
 - prb_data
 - printk_rb_static
 - printk_rb_dynamic

Information on these variables is stored into dedicated kmemdump section.

Register dynamic information into kmemdump:
 - new_descs
 - new_infos
 - new_log_buf
In the case when the log buffer is dynamically replaced by a runtime
allocated version, call kmemdump to register the data with a replace
flag to remove the old registered data.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/printk/printk.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0efbcdda9aab..f7d60dbe5e5a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -48,6 +48,7 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
+#include <linux/kmemdump.h>
 
 #include <linux/uaccess.h>
 #include <asm/sections.h>
@@ -540,10 +541,16 @@ static u32 log_buf_len = __LOG_BUF_LEN;
 #endif
 _DEFINE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
 		 PRB_AVGBITS, &__log_buf[0]);
+KMEMDUMP_VAR_CORE_NAMED(prb_descs, _printk_rb_static_descs, sizeof(_printk_rb_static_descs));
+KMEMDUMP_VAR_CORE_NAMED(prb_infos, _printk_rb_static_infos, sizeof(_printk_rb_static_infos));
+KMEMDUMP_VAR_CORE_NAMED(prb_data, __log_buf,  __LOG_BUF_LEN);
+KMEMDUMP_VAR_CORE(printk_rb_static, sizeof(printk_rb_static));
 
 static struct printk_ringbuffer printk_rb_dynamic;
+KMEMDUMP_VAR_CORE(printk_rb_dynamic, sizeof(printk_rb_dynamic));
 
 struct printk_ringbuffer *prb = &printk_rb_static;
+KMEMDUMP_VAR_CORE(prb, sizeof(prb));
 
 /*
  * We cannot access per-CPU data (e.g. per-CPU flush irq_work) before
@@ -1211,7 +1218,10 @@ void __init setup_log_buf(int early)
 		goto out;
 	}
 
-	new_log_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
+	new_log_buf = kmemdump_alloc_id_size_replace(KMEMDUMP_ID_COREIMAGE_prb_data,
+						     new_log_buf_len,
+						     memblock_alloc,
+						     new_log_buf_len, LOG_ALIGN);
 	if (unlikely(!new_log_buf)) {
 		pr_err("log_buf_len: %lu text bytes not available\n",
 		       new_log_buf_len);
@@ -1219,7 +1229,10 @@ void __init setup_log_buf(int early)
 	}
 
 	new_descs_size = new_descs_count * sizeof(struct prb_desc);
-	new_descs = memblock_alloc(new_descs_size, LOG_ALIGN);
+	new_descs = kmemdump_alloc_id_size_replace(KMEMDUMP_ID_COREIMAGE_prb_descs,
+						   new_descs_size, memblock_alloc,
+						   new_descs_size, LOG_ALIGN);
+
 	if (unlikely(!new_descs)) {
 		pr_err("log_buf_len: %zu desc bytes not available\n",
 		       new_descs_size);
@@ -1227,7 +1240,10 @@ void __init setup_log_buf(int early)
 	}
 
 	new_infos_size = new_descs_count * sizeof(struct printk_info);
-	new_infos = memblock_alloc(new_infos_size, LOG_ALIGN);
+	new_infos = kmemdump_alloc_id_size_replace(KMEMDUMP_ID_COREIMAGE_prb_infos,
+						   new_infos_size, memblock_alloc,
+						   new_infos_size, LOG_ALIGN);
+
 	if (unlikely(!new_infos)) {
 		pr_err("log_buf_len: %zu info bytes not available\n",
 		       new_infos_size);
@@ -1284,9 +1300,11 @@ void __init setup_log_buf(int early)
 	return;
 
 err_free_descs:
-	memblock_free(new_descs, new_descs_size);
+	kmemdump_free_id(KMEMDUMP_ID_COREIMAGE_prb_descs,
+			 memblock_free, new_descs, new_descs_size);
 err_free_log_buf:
-	memblock_free(new_log_buf, new_log_buf_len);
+	kmemdump_free_id(KMEMDUMP_ID_COREIMAGE_prb_data,
+			 memblock_free, new_log_buf, new_log_buf_len);
 out:
 	print_log_buf_usage_stats();
 }
-- 
2.43.0

