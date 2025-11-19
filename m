Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53182E7637
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567128; cv=none; b=IaXLt9BJP9nrXSg7FYvTE08qYPMQsANnGMUbPHmd1TxOY4SkFUhIxBcFD1QHojGnoVCol+5PvfdOxbNp5SEAyPvgLdrbWd5phJMq1E6l1wvsl3AyLIrlbbLQoTXxERyD0QJu09z1DN3nq765QCF+id4kHk57+1lLNfNuwoHPBE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567128; c=relaxed/simple;
	bh=T6SjDhmcY0qxcuyqrC2MrBGCJa3hOQc9OYm2K6gInfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KApETXXhQ86oJgeEeO0biDuVwcH+Av5iyvrxfbKxvlzx8O1cOToGELZEqYG7RKVimS9MURH8t83anqm5l68Tgq0z7qcihSinhQnvpXxGqh2kvmSDHuOCgxShrA5XyzGAIR5Yw8T/8824rgtyIBv9sfLryA65Y1w5H+cI8EG7Uc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FslOMpT0; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FslOMpT0"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b31c610fcso5924294f8f.0
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 07:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567124; x=1764171924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCvJkYlF4keL+Fd6f7hwRGbLb7cgm1v1S6Qn3Ctc9SY=;
        b=FslOMpT0D6lQ2kcCfXCiK0uWzCKjdNJ+AScQFNAM8TZvG3xEM7hVRVsKm91uZMaTvz
         4ob7Vilx6or0EGs2w+NmOwSkxBsRgfBYuD4SXQ1WbbhJKL95YIWP18GQZJrCJn4gXokf
         tudwNkwtKWBIJqQsMpTYbscsCy2OJigihpRNBGv+IyyKzjhSkKhfzVARu4Qyx6Hkq0mm
         1I86zQNM4dXOBcXvNdoMUynBcD7yv7L6gKD5o1nmiPzDy6GzgNzrtWtBJYAKSrgDIaK6
         pRjDKWJeLrjp7UAQu+Ih0+8lSAKK0ipcr5Lla6ZRc+MOkqYY/bqS7qUUjRISp7uAjz90
         dUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567124; x=1764171924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NCvJkYlF4keL+Fd6f7hwRGbLb7cgm1v1S6Qn3Ctc9SY=;
        b=rEg+lccJXebnOZX+HkDFSoRHNksN3+4v/M/Niit0wGG4yAU3wgfV1pKltQoyK9cQeJ
         3NWYnc6/ArtWlH/kS3+SJOi9ZVvTVWIjeapwqJVHKnj4YvmL1UByTxjVWgPo68cLjraD
         hksmR2uQV6c8pTQODPocxsPUojWabI9klpySom5mo4EBR5cSX6okqyKifIO7fdRcgl8U
         ju+fzaqEv5/PvyV6vy6lS2iyBAv5RO856w1GWQScmbEofahJ5gnuH+s/plWyCMGyYlnf
         gi/XHn0ERTASy1YavbG9o9iQR3Z51ql+eviIcSVqXOYqsgz0WgQoELgUIBk0TyODWpWa
         aWtA==
X-Forwarded-Encrypted: i=1; AJvYcCVusreIo6ZgyYZJFMOS8QrmEsYfe8pLb2KjuFuXN02Hjx/Fy/e9AmWLKOohhkme07VgIQMC4S7JIgG1HetWoj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnimjB17hmTri0v4/d5PgzCsTPpu5apv8K4x1HFkxDMLERoWvl
	POXl2g36HYQ6QyaBrzt3iukGkxzrYzF39J8VnerNkLb6CRwHE4DtQ+vZrRWqaBnKdto=
X-Gm-Gg: ASbGncs2IkR219cY5A9WNjXmIvpT4X3WNMUyVq8z3Q4lLhKXAkiFEYnRP7ZUrt3F0pd
	acRDSwhtD8x07IhvokGmec2ihyIna2UIWoTXD4zs+Bn/6R4k10h36QalK8yeWbGJ9XXPEjpkuTb
	6tx2B2vaFc18pFBJd4UoVARp6e/8QhhkdmJ5eORV+UPlHmjAB0Y7Velpt4hHrHK//xYt6YZJQ2R
	S2EQr+Fwe4oDUtR28SxrXKmVCGdYXlGULikx7YTD5xDqbU7Y9KboPbzrDxx9vaQykyfvDH7P653
	HiJSbWxNfTpqkQ9ejYrbgiBbgyqdct2wx379gagXSCykyjBka+4anrFaG51tDSmFFkKAuvnItxN
	lK7wXJTNKwR1RUqIJtybBa+rvU6sCnhxLDlEG0SHsJk//cjIj//9FyS6804rWAy2c587Ok+9t78
	3f/OeBq9TFAFxvd0ejsKPX5Lw+sGq7QQ==
X-Google-Smtp-Source: AGHT+IFVCfX9pNo5qLPfR5wjMBWTLaRukJCHurtJsWmWrjGoOxpQq2PCC7itN5NhSfJZMSf9UOyBtQ==
X-Received: by 2002:a05:6000:1ace:b0:42b:3366:632a with SMTP id ffacd0b85a97d-42b59386ademr21562007f8f.39.1763567123749;
        Wed, 19 Nov 2025 07:45:23 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:23 -0800 (PST)
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
	linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org,
	tony.luck@intel.com,
	kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 04/26] cpu: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:05 +0200
Message-ID: <20251119154427.1033475-5-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into inspection table:
 - __cpu_present_mask
 - __cpu_online_mask
 - __cpu_possible_mask
 - __cpu_active_mask

Information on these variables is stored into dedicated inspection section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index db9f6c539b28..1f2df5a5b9ab 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -38,6 +38,7 @@
 #include <linux/random.h>
 #include <linux/cc_platform.h>
 #include <linux/parser.h>
+#include <linux/meminspect.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -3089,18 +3090,22 @@ struct cpumask __cpu_possible_mask __ro_after_init
 struct cpumask __cpu_possible_mask __ro_after_init;
 #endif
 EXPORT_SYMBOL(__cpu_possible_mask);
+MEMINSPECT_SIMPLE_ENTRY(__cpu_possible_mask);
 
 struct cpumask __cpu_online_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_online_mask);
+MEMINSPECT_SIMPLE_ENTRY(__cpu_online_mask);
 
 struct cpumask __cpu_enabled_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_enabled_mask);
 
 struct cpumask __cpu_present_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_present_mask);
+MEMINSPECT_SIMPLE_ENTRY(__cpu_present_mask);
 
 struct cpumask __cpu_active_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_active_mask);
+MEMINSPECT_SIMPLE_ENTRY(__cpu_active_mask);
 
 struct cpumask __cpu_dying_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_dying_mask);
-- 
2.43.0

