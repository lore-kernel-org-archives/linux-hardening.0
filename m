Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55AB31A550
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689816; cv=none; b=EjoATG1tXkmyGtzDavaD3YT+C65ZEUMFBW537piwwLkJ+3hIYMm9a0rgtG6zdKKSoTbInffdH17S66EkJMwI/wlXxJHXliUaYSt8gkpWdIiHZ7io4Q3HT8mWGz7JOZOUzbPXp1LvY5nySXR80obrvzv7Uk0ZENyNlCPEK88So5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689816; c=relaxed/simple;
	bh=GVNCGH9tQf5YYe+DYh6Siqxk4Q3JqHAijX/d/+i2q6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIkxpC60j6QC5ZQ+3xXfZR1dtCmky3TltAFxi/ixQD8PfOkIRpFbceVecplclC/k8ZZd+xVHYh9TyCtsnwCaJQgekz/vsz4pIKrXvjqIn1zLAsm00Xlt4y3XkI9M/awmu4p9xWMFP0Qv1Ic0/Hu0ZTKlhMm3/iapXLLfP2nJVfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VRvJd4NC; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VRvJd4NC"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-724b9ba77d5so20256177b3.3
        for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 08:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689814; x=1758294614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYpcsE3JJVoPh3yiGg+2u2fE9IOmYvM0Rb6jQc+GT84=;
        b=VRvJd4NC+YHhBbcWu/+E+2UN/RPZLIywCS7nFWk4cNrh7/aNzQOyqE0XVbnOT7m6oz
         4p1lgLalhIWQ8Ysj5/pKJKxsK8js/C8JQmUDxU6ZC7jRp09BAI6OisRvZxPiEfBOa8II
         DbOz2+CJFrIZQKYrHYByVmF4eKfvnR8sPz3nkwfV6Fppvh7xObmTh2/oZzrt7LqimY7N
         RLMUmJ6BRL8fiBRxXTAxIsIgN4c91NAY0K8Ah9P9wdHs3j6Uy2n1CAzJvfV+7fIiSUEM
         RwRc/0FluPslIgBW27+O2M1w3JQwtTtm/jBsvU5ELMqIeFFLreoIakdXDnNuObQCATvb
         u7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689814; x=1758294614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYpcsE3JJVoPh3yiGg+2u2fE9IOmYvM0Rb6jQc+GT84=;
        b=ayxDa61L8f6V2ygPFdu1lTixEY2UdsQ8hl6OlFut2+Gr6Ps0p2D0MBzWnbZ1QHgpy/
         TMFVsOnQOK+9PJ3HKcN5P8aNA8lhJQSo3TXSmjpNkGL/cETL8tbhSbbDuk6y3N97LwVS
         xNQbazgN8tBhUWHbB8RCOuO2KADD5cZEjEhrxJj97zZmpg0mYWvYm1bOM/juX/eG4wPs
         UiEjVBLAJrsr3zBI16a5OUnPo+2tr02D8pu19Pz7DSlBrYb+XB3L93gAmDAQ+0f2+ckk
         T/ylyzmHHgim9jmha95p4tyky7vexhVN799rSwiXgeJErXSqROZfvnxFc9tFvE9lMC3J
         d3ag==
X-Forwarded-Encrypted: i=1; AJvYcCXTy5TBwzLz5LfJdl5ZlBHVgnvNG2lbisXd91W4DuQR4obQrQXR5fag0nq5IzHsKa+qqvDvQVsk+yrDgceOts8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5VfLZ7NOIbqsuk3Jxa/xwd9wfesEQsJAN4Mz31YMWa6Wjuwz7
	BX0P4EXox/M45uGKPjzyFoNYoyToJeuqjN5k66zBm9Yms6YQJrE5gBa4uZcofomjk8I=
X-Gm-Gg: ASbGncuVA8X93rCgb8ZQQ7TStUQ0UzRwZ2z2r7EkQHZoG5W72ScY/C7Em/2HTglg1m7
	eNXoAjHs0Ll9G5bOaRuRghzbLQmUD3ifqVfwgqYUbSHNQ9aAzffrICKckyISGHaFGqeWpLagv1p
	/tsyZVsrkbs5l4Vk7WLX9ZEfsmn8Q4WD0WFPfjmBVH24vt6fIFlIU0ynqB+CyJ2XFlHQOiVBloX
	iqT48JzYK95Spy16rdZKGvXFTLoymzaagDltYqBf1SJChpNSs9QjoPrSZrPxn2wSe3HgBP8ej2m
	U3b3y6wIV/fh755czXMuDQNlbV8FAxT/sKqGt8JRmAARo4+JvEnZQqitIMoHl0oCGfHvSgUy0AB
	BWWXXE1HeeGTlzgonShcJ3XGdqS/iSMyMDRL6ls1NKhjL
X-Google-Smtp-Source: AGHT+IE2B/J5wRLXOu5lnuN+Axv8riYyigPru1eeeYCbQIMixSd8q/6Ui1Mo233PH+t3U62U0f7UQg==
X-Received: by 2002:a05:690c:10c:b0:71f:c7ae:fb73 with SMTP id 00721157ae682-730659befadmr31464037b3.42.1757689810056;
        Fri, 12 Sep 2025 08:10:10 -0700 (PDT)
Received: from eugen-station.. ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-624841586c1sm1302244d50.6.2025.09.12.08.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:10:09 -0700 (PDT)
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
Subject: [RFC][PATCH v3 04/16] Documentation: kmemdump: Add section for coreimage ELF
Date: Fri, 12 Sep 2025 18:08:43 +0300
Message-ID: <20250912150855.2901211-5-eugen.hristev@linaro.org>
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

Add section describing the utility of coreimage ELF generation for
kmemdump.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 Documentation/dev-tools/kmemdump.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/dev-tools/kmemdump.rst b/Documentation/dev-tools/kmemdump.rst
index 504321de951a..5616843e0407 100644
--- a/Documentation/dev-tools/kmemdump.rst
+++ b/Documentation/dev-tools/kmemdump.rst
@@ -27,6 +27,14 @@ are limited.
 Although the kernel has multiple debugging mechanisms, kmemdump fits
 a particular model which is not covered by the others.
 
+kmemdump can also prepare specific regions of the kernel that can be
+put together to form a minimal core image file. To achieve this, the first
+region is an ELF header with program headers for each region, and another
+region contains specific ELF NOTE section with vmcoreinfo.
+There are also multiple regions registered with basic kernel information
+that will allow debugging tools like 'crash' to load the image.
+To enable this feature, use CONFIG_KMEMDUMP_COREIMAGE.
+
 kmemdump Internals
 ==================
 
-- 
2.43.0

