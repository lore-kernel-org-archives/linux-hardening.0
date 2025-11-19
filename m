Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE39393DDA
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567159; cv=none; b=O+rn6Kqm2psYzegKw8Gz48YLBAtevA29rhVqPKLhxSLHQZMznMa8YhvRt9si2eRSIUI69e0S1Obt8XRcgADpTOSMH1ppP+KNaBGsqYMw2hRh7jxmvjYJDooZaZOw71ZSZOagLSs2VXO8ypnvRur0F8VtT9qYGWwxWh9cQj+JWAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567159; c=relaxed/simple;
	bh=f3/jMwmnVv3mI87uodqbEJ5zmLRyilWaBRh2oB7xeIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6+vCFazVp18tjn4dlnSbMvNNeobWAnpHaESj4yNoJlfnLIchjxa5OvjxgPd3rmFU55KKV27Y4gsRYDUElrtIevHqv1tl1Wv53yROxARj1npltjwaLQhfPaxtW92Q40QEQfI9aQpmBhj6x0Nn0jlPV7oF5j/et8JHynbBag3oN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XXrmnSHa; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XXrmnSHa"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477549b3082so56842865e9.0
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 07:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567150; x=1764171950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG3MkEScUQgKy+QWFE7rEK/ceT0KdBZscolLPvZ1jcY=;
        b=XXrmnSHaTf1vf6uqqllPUT0sMUElMq1GY66Her4KbnbRi5e+DUU+M+SWXGUt2CZ6yi
         Fcfg1D6NcZVjy26O1mHYrbiVIPaAlLBA2GBqvpgLMBXyymHP7sB69YUN84ZdMxEQx29S
         DToilDeS7YIqZBRpQLn/r+GmhRa5gNuXE+wcynhuswMQIYn0NsTWAoMVNaNDtskjuf6d
         eua2UlS0Q7BEVBAS9dnTmdA56yZpIwU8XFShysHoYhbEidZl0ofZ+gQZPlTrTx3l7IgY
         d2eNag3MWaOS0TVX4RMZONoYBqxONt/LCOMwvGtHCkIwtA0Jveoa88lEMBckYQCQjlIx
         QEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567150; x=1764171950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TG3MkEScUQgKy+QWFE7rEK/ceT0KdBZscolLPvZ1jcY=;
        b=KTI/Q96IKfhFCFzmyO23wDyShseB3m36TDVrLI2k18uOWIQBp0RdC0SB7yjBa/d7db
         Pwo7VGAeB1eTsRpGwbr1YSCK/BXhxwdnsYfDgO/NG5wYBjxH9LAaEo6CmogKt0YfCfhP
         S9QUv2rRqSqZs4A4xRdHJcGu7RtWHeSEzW8XUqsWNG79hiBF8wR4zayiQC//dIPrI3MB
         qOPpeVHE4gx3RrxSxkHOG85bISf9Jj1W3Wrira0LlOWPMQ9UCEJ7FpdioaSyBH5VVd13
         fqTgVNvGYli/OU+2j7dY2unuQ7wYQXHaxFc9Unsy645u1gOblrRrXn8LyhQiMBuUhp5N
         pfTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU92crjwWBLcESpmBkRot93zmnO0x1lwkHIPT64uZ6H5xhMB1qk0Y2M37z3FUNF6EprdbaeC66cqgHRt4JwNJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8/+IYxE5/zzqHp0tf9xcrfnGOn8LXyw8KLfH7V8kEqjJXaDnW
	EyYudxjkk0we71TI/wK8IftplnHllezzBi6byXaHUeJDQibGbTwl2xUqlzyvxiFKTH4=
X-Gm-Gg: ASbGncu0+9TRDwPaaqF8a3BAwBKXT77S7oULnlS3GfhPsoU8c0gmxzyia/ibAvLXn8U
	RhI+zNvQxyk7UwgvuwobPwGseUVC6mbduZfDq5HJytp4JnIeX4AWmqthADtdslmpYgisTGLA6x8
	haWe/xWhPrF8CqpZklxllsEbQ3eouW8kGopToerVkmHQr5w6dhrto4qBCW8OuwXo9swEPfjANn+
	lpKN1rdafE9nCPZD1qnP+NA1yqvFQ/sZs9YvC+MyUjk+ym6Ugp+WLOERlzDSx+o/+7/OamBzN2/
	GBRXkE4QcI/TRjRT+qtIEbX+RuIm7nOaQW54lmMlv6fzgxLv9b3/n5THkJ69eJyIsvSUnNV9Tyr
	KFHjLmioScnfdzq5swXdzZhrl7g/gNc9SW85N76JNyHlCisIv/5ZWmyeKjybDe+tD/e0ceyuo7p
	wYq+FGm1qHu1fo1CDU/C+5seH9/O89hw==
X-Google-Smtp-Source: AGHT+IHArpVzpD3LO0mA1+dNKflLF3LKgYCdBzRW5r7OQjPk30YRri90746lAxdaW694nNfBsFGkIg==
X-Received: by 2002:a05:600c:a05:b0:475:dc5c:3a89 with SMTP id 5b1f17b1804b1-4778fea881fmr202472465e9.34.1763567149948;
        Wed, 19 Nov 2025 07:45:49 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:49 -0800 (PST)
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
Subject: [PATCH 19/26] mm/numa: Register information into meminspect
Date: Wed, 19 Nov 2025 17:44:20 +0200
Message-ID: <20251119154427.1033475-20-eugen.hristev@linaro.org>
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

Register dynamic information into meminspect:
 - dynamic node data for each node

This information is being allocated for each node, as physical address,
so call memblock_mark_inspect that will mark the block accordingly.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/numa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/numa.c b/mm/numa.c
index 7d5e06fe5bd4..379065dd633e 100644
--- a/mm/numa.c
+++ b/mm/numa.c
@@ -4,6 +4,7 @@
 #include <linux/printk.h>
 #include <linux/numa.h>
 #include <linux/numa_memblks.h>
+#include <linux/meminspect.h>
 
 struct pglist_data *node_data[MAX_NUMNODES];
 EXPORT_SYMBOL(node_data);
@@ -20,6 +21,7 @@ void __init alloc_node_data(int nid)
 	if (!nd_pa)
 		panic("Cannot allocate %zu bytes for node %d data\n",
 		      nd_size, nid);
+	memblock_mark_inspect(nd_pa, nd_size);
 
 	/* report and initialize */
 	pr_info("NODE_DATA(%d) allocated [mem %#010Lx-%#010Lx]\n", nid,
-- 
2.43.0

