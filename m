Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DF5151985
	for <linux-hardening@vger.kernel.org>; Wed,  5 Mar 2025 02:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141044; cv=none; b=pw5G4lGVEiZmJZKa2zUJ7fuzkuj6q2oTj3R/N7zGsR/YUF7Eb5qsxCcjEK8TpaIz9QpbLLkScQm/py7KkWQsA/cd6OsU/GEeGBrVXtHRGfBXjM6FaVPH+jmLZf+FCeXtzXps9K8KRcLwqaRwRcVZaL23GsQfUhERd89Rm5GDHVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141044; c=relaxed/simple;
	bh=Lwirzx82Cwj4cIROcGyzk0QJ025NE1gG42EW69viQ5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNT8JR5uWhfL59i8vdsk5sM1pFn/8OlltanmySy9g9GU4IBuDaai9cdXQINANxFADaPzyqkDPrP1y3UO2MYsc3IZhWumrJibh7nF12c20lNUzzj+6JVdVtgdN0+m9MaQe0S9wmW5fBON+NAS2fJBG3EU+k/PAzB0odbw/uzZW6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PiHN9kP5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PiHN9kP5"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab7f9f57192so96668266b.3
        for <linux-hardening@vger.kernel.org>; Tue, 04 Mar 2025 18:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741141041; x=1741745841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rvSTlkpvpW7p+80Sjr3aDnt6o0B0yeaCG4YXkElwWc=;
        b=PiHN9kP5LAPdvY8W/S2XGXdoZ0jJmrTepauuM/T9EbcQz5csksWhfLMk4NjXwc0BsF
         sOtpQ3Rzi3Z5P+88EVT5PXbpUJM9a5B094Kim1ixzaKZjtAPqPtLdqc0gcKE4gPyuss3
         BUDQpeGcXSkLBn92q0+IzfP+MOyyAb5Uh8qPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741141041; x=1741745841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rvSTlkpvpW7p+80Sjr3aDnt6o0B0yeaCG4YXkElwWc=;
        b=uXsH1V6Iog7tKJpqQbK/cNArqRbLyOD+WQ1OQzg8+dMCLvNo/+G2D2UvtfgQjO1KQk
         20mT1dsoQTtF+jA1MWHR1BPnROOauBfhhaaQABMd/pdsb+BbeteJgYuU9njUqBNZhOXp
         Ysb8u7OAWm833hY8FMRauxljmZxnr7+KrrHNA7oIHlpcl/5h/MYZEOZV479JCvIp59Vi
         29zZ5zmt1xWLWZN3zFAGzq5vaAv6YfQ13uNj0jct3fIV9JHRWW6sD7WizQXCcLWr5tuL
         QoXljGQ5P2Gok32lzkThmE+ZqfFYYu+YY3xn9dWinCDyGDfw1uPh6JOGkKpgUkkiJP8H
         nSWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWVayuyPoj84SNRckR2aoq7X1vCg5y4FHBUmYDqvEl3af5zUQ5bXcacJX/A42RU68lq49pfAVguAZ+bJKuV9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwDbcNIjSVVehUUwhTSxDMrfA8xha5C+PQjZ16Y9hZE3L9GyRD
	MLoRSRQ6uTmxLiwnSPhnA8vg649X6EzcLTJKXe2zZyRj5HiTxJ6MvvQnXZpKQw==
X-Gm-Gg: ASbGncvj83/0HRh6rTWE9755WKhXcWuFn0PzTW8Lfa1FOIqIQMJ7aNle+yQ1oD8ZA94
	Uw7H1bR6NKRPdYq7CSw+Wy1PQuoBFpZ8gRCZtLzva+C+rm3SZyyLWLV70tV1wN/w50NzFR76Cas
	DY8MBFL+A4qjW2VrDDMnliLMT91Ym2lNGYw57gAh4y+9o9pSTtjX1imWurHtLdFev+S1NVcHtxJ
	H+b1yWJmjwLTU3U2cFrC++KVcvDUjl+kl7V5ZF7m2Su13L1Vd0D6ojXA1a9Y7bw5mCLnicGnGEC
	hkWskOCjt6XEMILrk+hx+M3LGSQWX6oQ2liEkg6vVjHTav81KtM3Y1cj/xghi+yJjr3MiXPMpQK
	D
X-Google-Smtp-Source: AGHT+IG4LOJECTRz17K9A3USe11OyP2C9IBySPUjmXUBtjR0nV5q11MemrUEwg48VpC14wTFHsEuNQ==
X-Received: by 2002:a05:6402:34d1:b0:5de:ce71:badf with SMTP id 4fb4d7f45d1cf-5e59f45048dmr459772a12.6.1741141040807;
        Tue, 04 Mar 2025 18:17:20 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a55besm8891211a12.72.2025.03.04.18.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:17:20 -0800 (PST)
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
	linux-kselftest@vger.kernel.org,
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
	Jeff Xu <jeffxu@chromium.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v9 1/7] mseal sysmap: kernel config and header change
Date: Wed,  5 Mar 2025 02:17:05 +0000
Message-ID: <20250305021711.3867874-2-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250305021711.3867874-1-jeffxu@google.com>
References: <20250305021711.3867874-1-jeffxu@google.com>
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
ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS) and VM_SEALED_SYSMAP
macro for future patches.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 include/linux/mm.h | 10 ++++++++++
 init/Kconfig       | 22 ++++++++++++++++++++++
 security/Kconfig   | 21 +++++++++++++++++++++
 3 files changed, 53 insertions(+)

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
index d0d021b3fa3b..7f67d8942a09 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1882,6 +1882,28 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
 config ARCH_HAS_MEMBARRIER_SYNC_CORE
 	bool
 
+config ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
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
+	  time of the process. The existence of this flag for an architecture
+	  implies that it does not require the remapping of the system
+	  mappings during process lifetime, so sealing these mappings is safe
+	  from a kernel perspective.
+
+	  After the architecture enables this, a distribution can set
+	  CONFIG_MSEAL_SYSTEM_MAPPING to manage access to the feature.
+
+	  For complete descriptions of memory sealing, please see
+	  Documentation/userspace-api/mseal.rst
+
 config HAVE_PERF_EVENTS
 	bool
 	help
diff --git a/security/Kconfig b/security/Kconfig
index f10dbf15c294..a914a02df27e 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -51,6 +51,27 @@ config PROC_MEM_NO_FORCE
 
 endchoice
 
+config MSEAL_SYSTEM_MAPPINGS
+	bool "mseal system mappings"
+	depends on 64BIT
+	depends on ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
+	depends on !CHECKPOINT_RESTORE
+	help
+	  Apply mseal on system mappings.
+	  The system mappings includes vdso, vvar, vvar_vclock,
+	  vectors (arm compat-mode), sigpage (arm compat-mode), uprobes.
+
+	  A 64-bit kernel is required for the memory sealing feature.
+	  No specific hardware features from the CPU are needed.
+
+	  WARNING: This feature breaks programs which rely on relocating
+	  or unmapping system mappings. Known broken software at the time
+	  of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
+	  this config can't be enabled universally.
+
+	  For complete descriptions of memory sealing, please see
+	  Documentation/userspace-api/mseal.rst
+
 config SECURITY
 	bool "Enable different security models"
 	depends on SYSFS
-- 
2.48.1.711.g2feabab25a-goog

