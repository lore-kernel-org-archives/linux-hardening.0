Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F697369976
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567144; cv=none; b=TZcSIk9wwzumdj7m9uS5IVkG1f/MjUdTtiowA8+p1YaOn06a/THSOoMzoaUqT0nVpMtbgzOljmtVAuPHeISY2xD74pEh4QOzLM08WjZjIiuOaC9ttYfjbnCe0su90OxWMt+TmqSpby88ShBRXbUZaTFJFsL9a9MmB1FDVeLkkTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567144; c=relaxed/simple;
	bh=+VK7KRl6+Lq6c3QG0QoLNUfpAYwW2X9fA09G/NfS6uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7VA+EyKdiwPP33XfHAx0ZmgCs6okbFafEjUmwPdJg0Wfj/4iMXQBRsxqwyyJ4oXQspdJBp2H7JxsLswcNUHYmaNR6SwC8VguDi5/H4eYpPa/v3zm2muq5WlnF/sDe3wLYFZkl2jLBj0FwrXG2q32aSXvJRUCqhZXr1TmMff4qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j6sLEfh9; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6sLEfh9"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so606806f8f.0
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 07:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567134; x=1764171934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuFAdi/dQ7TYcP6kPKC/D+o7MTxWjWW8Ku2RD10GvbQ=;
        b=j6sLEfh9uv7+dsvFnDqDQa6anzRkocsy8dt+OoGqRNipZTLpbhM0kN8gp+hG0HbaBs
         MMBo7xYfGVPH43vHvKGRCgch64x3w+5gOHyhKTn6HQ+sYqIorf4m52B2SrG4bBRx89Ci
         k7s7HPQsG+hLYQe0dBWwwYUE3j83EEMt+amQKWLX6AugMw0fo3ZbbVB5M+piJ6Meo17+
         DvU/V8qk2/79vb7SU4ODsNiDcw+a5f4qtSc80/uGNdJXinhamtY1cOT2Gtifllx8JCIq
         7cY4R9Y0192OrEL58Af8mu4tpPfVY0/Be+sl7rGwPj7IfS35Td5zUv2USdiF44V8DV8K
         PVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567134; x=1764171934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AuFAdi/dQ7TYcP6kPKC/D+o7MTxWjWW8Ku2RD10GvbQ=;
        b=Ttdz0K866Gl7p6Aj1CyFyEXvX84Q7Cq4gscSUlGKjudGvah/MErLXHDtSYJn/9itQz
         M6nUmRjlQNdguIZCIaqc5+i+OnRGkAniJ/O8BjKW1LyQIEpQvYoztDRSW9kkdwqqnAyp
         rhcTc3ALSAoaboRmw8gaKIS4qjni7jpDdA6y4fmmhEhNLUAwvZ/IxL8ouSOx946F/4da
         FpFZmxf2iLkbQC+jrcPSJC69aFXGUrMa+acr/2kp90D4utU4Ex7mZwFjhiuG7jETzKVS
         /SPzPmcJocYA+0F2OMk3mw9H0Cj0WotaVgGYI7fEcjsi1q4jO1Xmvzvczg1KdYPKSBGP
         Akgg==
X-Forwarded-Encrypted: i=1; AJvYcCW75i2vHHL5ZdmVgOaWKIAmClrmxofV4+R5igdC37hY+vwomC/DyKbDIvhZHKAJoVXvg/KAX00N8WyWMvyUCVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoFXXJzybcnso9sA/aYG+spflGbXCyU+A5OsJm5pL8y6jh7xzT
	bWMh+EvVW3Z5KZiqSzC418/MXPie4FahNiQeEM9Os8bAOUH91lTpSdsD7bT+6KC1Sxw=
X-Gm-Gg: ASbGncvoIAOGjspBIVTFkEqhS1pTxxTSgTjHYL/kk9xeMclunKgG3imkdSnAzZTUADo
	Sl5LLoaPACXn8kmbKoLEuapkWpwaRYir1jn/RqF6a59K95yc+bv4NKE+PJVJxYlfeUR818o2tUD
	i5AV9wiwsjqCCx+dNR5cFJr8dJYN5kHH5C4Vt4qC62e95xIkces200JcJfjmSsJkS0lkYU/h51w
	9tBb+OWLEVOsFq5QXmGj9BUXpNxLxYAPadTK+xc3U8I7HpS42IJXxRrcRptSixaE3aeEBICvKzk
	gJqCL3nv/d6HyBDQVdyaOmGQZHKRY5OAYomcT6zWBw3wDzPmS8cPKKqPJhNoZgjxOJNY5Z9eCME
	obQqpij3B4F/veE72xxRhH0Vj/8WBaxgNqgsuim4ypAKumiyqikq2RwRXT87k+i9v5prcO+Z0E2
	BEilXa2W5F+qZQ1I6lr+fXhu+m81Hy/w==
X-Google-Smtp-Source: AGHT+IEEW1UNe8+i9pRkQXcVi1K6qHmkkggtbzPn6ocK+c8Bp9XYSPJPKkUMg9h5XQagLem1rvsEdA==
X-Received: by 2002:a05:6000:26d0:b0:429:eb80:11f5 with SMTP id ffacd0b85a97d-42cb20e4a02mr3468125f8f.26.1763567134112;
        Wed, 19 Nov 2025 07:45:34 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:33 -0800 (PST)
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
Subject: [PATCH 10/26] mm/swapfile: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:11 +0200
Message-ID: <20251119154427.1033475-11-eugen.hristev@linaro.org>
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
 - nr_swapfiles

Information on these variables is stored into dedicated inspection section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/swapfile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 10760240a3a2..ee677be19041 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -42,6 +42,7 @@
 #include <linux/suspend.h>
 #include <linux/zswap.h>
 #include <linux/plist.h>
+#include <linux/meminspect.h>
 
 #include <asm/tlbflush.h>
 #include <linux/swapops.h>
@@ -65,6 +66,7 @@ static void move_cluster(struct swap_info_struct *si,
 
 static DEFINE_SPINLOCK(swap_lock);
 static unsigned int nr_swapfiles;
+MEMINSPECT_SIMPLE_ENTRY(nr_swapfiles);
 atomic_long_t nr_swap_pages;
 /*
  * Some modules use swappable objects and may try to swap them out under
-- 
2.43.0

