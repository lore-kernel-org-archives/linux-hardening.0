Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC92208992
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 22:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437570; cv=none; b=dkJqE6eaTGfMwFCfTHkM9tgb7z+di9hpz8VZSfBGIqoSWROC9Bkg+p1KwfsJiq8AL4EDCGTwscnC5lOE1ChUgVOohnM20rUpN0FbRiEsOOOkwiP49Jd8hj/5N1k1j9qthrm2yubyA2r+B6Ne1N8/dy6QGN1pboE9rIZdZf0N+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437570; c=relaxed/simple;
	bh=EHkej4atJd0rKCJJMNxCG0jUmkBMWzE6gnyd/AI989c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuvgRPwr+MZDgz8tXAf0qumVQLmZU/0Nlnh843N1zy4Z8qkliaSgznuPSMFXc8f9xcqoNxMv2UusTmxs4iEwvxMLP4/MQ5WQIzsx6dtUVZ3W0vUIOvID2pXG9qH4QmFVGB/Y0fj7CAUD5jDgnNf9zDQCGo2QrOJ5m9JV1LpWIZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ib0q1WoB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ib0q1WoB"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2210f7cb393so9909175ad.2
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 14:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740437568; x=1741042368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr43TU7OB3/UBZWZ8a0+AJgECDu1pAru/awGEv3HrHg=;
        b=Ib0q1WoBriV+lqB4vcR+l2nhJmV9w83ObklUlhFf0RfJx99HDE8x10HQXtKqV9AA80
         tn9c1LvIE1LIAsV2dItDv2mGp6c340aEIj86xL1Vkgv73Ww+o1QIc6o580clViSwgc+P
         /+ln1pP/WfakTtoiVPnuUtxfeJ+iF06pTgIOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740437568; x=1741042368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gr43TU7OB3/UBZWZ8a0+AJgECDu1pAru/awGEv3HrHg=;
        b=YqRH8dt69H6fdBy2seLk4Zbx6/dLbBGmqgqTXvQfuSaEFn757YTEkTMt+glcUVxmL4
         doYsW+2VlTdQ/b8vv/nZLdA6yQrc5BrNx24EB4aOfsh7Mg2bITMSXnmwjIi7te0X4pQz
         /gNzQ52DsZmPLLc8d5sIhT2x5VBy/EAmCaVnlI4iYRRYxdctx74PbTEDUouu5OT0+lBE
         88fUpKxN2E1LsioInWIFW8wh6cfVUI2Rj5ckmPcjid7y9/TIln/oNy2SN+nG/1uoCy+M
         d5K70B0BeMQlvba5FJnoG9AnWwVq2gdD5DOFpvWt5Swq1GWOSDlLq5bqEomvod7So/Jt
         7NtA==
X-Forwarded-Encrypted: i=1; AJvYcCWHIHSyMqggeB8NeuZKHqMcbEoYyJH39tp1qM0UtA61Lnqjgc1ULWaLMRC175oJqllbKkaUnEmfPaVw9mhzM80=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUaFZo/vleigrMQ0YX9X8aEs+U5H1I+mlnWK2vT0nuj/I80vrJ
	3bOANNwqvcOMKQg84ZrU4B30DaXnHrM77UHFd3JsDmHVZtF0cOk432B/+HfYGA==
X-Gm-Gg: ASbGncvc1Dp/EueIKLHnVz9EIsdYbYcFFmRTBxavyjABNZpvClahYQueMLC3fdoIe3Z
	OqV1/M0H57q3hKZM0RBdGgAC/6MKBTUBf5phBNUwWZzPQshbjqySV/n/+zE1NgKdI4amefhsX8d
	XiU3Fnzh5jd+OqlnI3Po8DE6iEvoWHXNwUygnKksLEyT9gFOHVjArtP8o5Xh6Z09I8yeZmF0bjF
	goiIpLDmXoXh4WGYU6A0L46cPWNj9s/hWvwlgF8LJSsX7soNtYAGy+XfCmyLq8ST0SFpm9Fc2b+
	K2HwZPuqGxpjol4yFCEOTq2DhIU3HJ+YNHRlFJ19o3gSbu3JErcacYNX+9Dj
X-Google-Smtp-Source: AGHT+IESaZ58UChl4iGsoSvsujhtUwwJr3CbpWnJiWfiHt9MzqGV0YmPpuc1uUFRRY7FoYU65Kkk1w==
X-Received: by 2002:a17:902:da92:b0:220:dae5:34b5 with SMTP id d9443c01a7336-2219ff5f4b9mr92927075ad.7.1740437568464;
        Mon, 24 Feb 2025 14:52:48 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a000a73sm1412625ad.42.2025.02.24.14.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 14:52:47 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v7 1/7] mseal, system mappings: kernel config and header change
Date: Mon, 24 Feb 2025 22:52:40 +0000
Message-ID: <20250224225246.3712295-2-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250224225246.3712295-1-jeffxu@google.com>
References: <20250224225246.3712295-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Provide infrastructure to mseal system mappings. Establish
two kernel configs (CONFIG_MSEAL_SYSTEM_MAPPINGS,
ARCH_HAS_MSEAL_SYSTEM_MAPPINGS) and VM_SEALED_SYSMAP
macro for future patches.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 include/linux/mm.h | 10 ++++++++++
 init/Kconfig       | 18 ++++++++++++++++++
 security/Kconfig   | 18 ++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb7..8b800941678d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4155,4 +4155,14 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
 int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
 int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
 
+
+/*
+ * mseal of userspace process's system mappings.
+ */
+#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
+#define VM_SEALED_SYSMAP	VM_SEALED
+#else
+#define VM_SEALED_SYSMAP	VM_NONE
+#endif
+
 #endif /* _LINUX_MM_H */
diff --git a/init/Kconfig b/init/Kconfig
index d0d021b3fa3b..07435e33f965 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1882,6 +1882,24 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
 config ARCH_HAS_MEMBARRIER_SYNC_CORE
 	bool
 
+config ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
+	bool
+	help
+	  Control MSEAL_SYSTEM_MAPPINGS access based on architecture.
+
+	  A 64-bit kernel is required for the memory sealing feature.
+	  No specific hardware features from the CPU are needed.
+
+	  To enable this feature, the architecture needs to update their
+	  special mappings calls to include the sealing flag and confirm
+	  that it doesn't unmap/remap system mappings during the life
+	  time of the process. After the architecture enables this, a
+	  distribution can set CONFIG_MSEAL_SYSTEM_MAPPING to manage access
+	  to the feature.
+
+	  For complete descriptions of memory sealing, please see
+	  Documentation/userspace-api/mseal.rst
+
 config HAVE_PERF_EVENTS
 	bool
 	help
diff --git a/security/Kconfig b/security/Kconfig
index f10dbf15c294..15a86a952910 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -51,6 +51,24 @@ config PROC_MEM_NO_FORCE
 
 endchoice
 
+config MSEAL_SYSTEM_MAPPINGS
+	bool "mseal system mappings"
+	depends on 64BIT
+	depends on ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
+	depends on !CHECKPOINT_RESTORE
+	help
+	  Seal system mappings such as vdso, vvar, sigpage, uprobes, etc.
+
+	  A 64-bit kernel is required for the memory sealing feature.
+	  No specific hardware features from the CPU are needed.
+
+	  Note: CHECKPOINT_RESTORE, UML, gVisor, rr are known to relocate or
+	  unmap system mapping, therefore this config can't be enabled
+	  universally.
+
+	  For complete descriptions of memory sealing, please see
+	  Documentation/userspace-api/mseal.rst
+
 config SECURITY
 	bool "Enable different security models"
 	depends on SYSFS
-- 
2.48.1.658.g4767266eb4-goog

