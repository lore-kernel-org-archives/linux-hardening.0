Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0A3538A7
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567133; cv=none; b=kxH/0I5BmEwlucIcv15+6jkQ5Rpd5m/IfDI39egZstbNHIc8OhKoOFGFCSrlxV2UBbtUefPiYzD9FgBbB0YbO19456vxQFxrZOFfb7bNAYMF3/3Crw9KysxRZPwZI109wpj6yb/DxEt3taG/XYM+CQPXsczeTU1zof3t7AMP1s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567133; c=relaxed/simple;
	bh=VU47rRSEpIhBbnpqxo3Mzoi4kyXh9HmEgVPJi/PKKQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOZ69klYB780YuyBSFn2mZQabjBbs/Y7FHvIkU4oFVTBAr6R02EuXakD7KXDEOSera7T2kCJKfhualAsEkxndJHQyg4JMbp2BopsNLNVIeLw1YphSrzIKbTZco2kmYBPywf8MYAo/VBAImxtLKexHMrv56pqsrzNnwEv/N2l7Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XZ/ijRdZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XZ/ijRdZ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47778b23f64so46355815e9.0
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 07:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567127; x=1764171927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjfIjN6LzAYPexJPKxlzOegJPOplIDmw8UmBc2QBBmw=;
        b=XZ/ijRdZu5x0OvTVmkMq1wPbsmeKFbLQbYrPafVtvHT+ZqFCKf2Qcp9C1tVp2N/J0D
         knNKJXhbr9JziRTGWFdIQncXLZViZHEaisM6DwHPeG9AVVqt8e5GgvS/eZ6W3CQ/wgNE
         eUAxxuNkPdWWUIiLOxyTbNxpAEDi0zbJRjyi0M/skuHii8wzYx9Fd2XFdKA55bwmURB0
         E/GzFp+ssYwIxqtSwO6ujSuf9arYgXH7dCM0Qa9fwXjuXaTftH8SAdowmnTn83UEVeRo
         Dr6xOSIAlKga7MCQloURP4hs/LnWJvAeIdLWYMQ+WB3ui+rujTltgYm6XmZue5TsfJXv
         q+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567127; x=1764171927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tjfIjN6LzAYPexJPKxlzOegJPOplIDmw8UmBc2QBBmw=;
        b=qhv8BMcdU3Ga/A3JzSDHvbu79atcVGOuK3pNKtBnQcek9sPFP7QOd5oo+M3RwryP5F
         v8qz3EWYgKSbv+iOPsoYwmIi4HvcsQlz4D9gakZWveLGEF2ibYVPrOB6jWAn7EVm+6JI
         zk9KRWxk0LZ/siiDWwEql6No6e8BTEk9gObQ9j16FgXbYHBzwG9PeB9Iehsl74W5lux5
         y1v0vhU4N/2LtN2NRBv7Wg1qgWzUo4i5jfxrDPkMbc86yMtzvZ2LYs3eKKQUSuo/58HX
         rarvtTPNan6wcjycFiQIan/lXOpwCl5PAATrjRjrBcteNWsamocvHT3jXLSxko7tRlVA
         X9fA==
X-Forwarded-Encrypted: i=1; AJvYcCUG+YW3jiSLmAdZF3L9g59n1Kst5Ot7woIn5RiGmIDq/ssAhj+5BB3pk7eL468ZlzcUVVJyrqchcH2+KI4u4lA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoMuJ9wyl3s6U/6lxD11oH/QzvfMXscbUgI3R3saODGaJq7ES+
	+CzrakpoZ6ZtmwnQXYpaKqt/RuI+dGmzThlOrlLuA2UiEo1bBy2Efqe8CtADGx4TPVg=
X-Gm-Gg: ASbGncuGDnwxFtlqLgA6pnpwYgb4swYG+WByJtnnjH4IvRR3itYmJIo68elJ4/o56Yv
	ZC70JVQMZAPXBYGCNucteTeDVU1uvluzBjw/thSU3CF0/q40YcKvqz5sLaOsyU5/mFcm8KXv3AA
	u8dm1ZggYTU/+a0IV0SSNWLjUppdnqtGz0zZNR6rPUTITgE62M2AAdUkjn5E3F7/h3RajfonyyW
	3xB1jcqLotB81jNCO20D44mb66AMeRSyiOPIxmGol5mlHUrp6ubWml+WTZOGbhro3+m6Qdso6lb
	2x5wdx65sj2tSUv8NlXM3IWUlTNckD1DVc9jXfHEa2f78E2wzOiZiQifCZ4c5n6ZfO4OwBHqoDW
	3Eqw6Qn0+Psvc4XkZVbZOBY+6bhQctklKom6XffRnETEPIUSvAtsDDHMz1VuQnfWgCcO8nepGOL
	8M0xofGpbtGgUsjqEf975DQVJToG4lLA==
X-Google-Smtp-Source: AGHT+IEfh56DkbcMOsGMiLrQQwNoxfW0lTNMGX96p1i+gi2+G5lC/DiQdo+bbBRy4PiX1VmL8kOK2Q==
X-Received: by 2002:a05:6000:2a0e:b0:42c:a506:9dbf with SMTP id ffacd0b85a97d-42ca506a058mr10726960f8f.39.1763567127227;
        Wed, 19 Nov 2025 07:45:27 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:26 -0800 (PST)
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
Subject: [PATCH 06/26] timers: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:07 +0200
Message-ID: <20251119154427.1033475-7-eugen.hristev@linaro.org>
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
 - jiffies_64

Information on these variables is stored into dedicated inspection section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/time/timer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 553fa469d7cc..c6adea734b93 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -44,6 +44,7 @@
 #include <linux/compat.h>
 #include <linux/random.h>
 #include <linux/sysctl.h>
+#include <linux/meminspect.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -60,6 +61,7 @@
 __visible u64 jiffies_64 __cacheline_aligned_in_smp = INITIAL_JIFFIES;
 
 EXPORT_SYMBOL(jiffies_64);
+MEMINSPECT_SIMPLE_ENTRY(jiffies_64);
 
 /*
  * The timer wheel has LVL_DEPTH array levels. Each level provides an array of
-- 
2.43.0

