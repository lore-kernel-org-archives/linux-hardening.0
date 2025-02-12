Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF321D95A9
	for <linux-hardening@vger.kernel.org>; Wed, 12 Feb 2025 03:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330520; cv=none; b=SOfBTNnlQhlrfNW1JtbSRwcY+0YxCrkiJeNtXI3Q3BXQDuAwkPWMD1LvgoUMwqUwkacfOLBLqXqlM/iahVq7l7bsRVuph+QBw1Q3m57WztoOcUe1lWsROxondBU2lKLOkLcOaZ5eJPd1GD0BWEGJnXNBK6XPSuPnRV3/sdDQ1zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330520; c=relaxed/simple;
	bh=3VXEI9CDqujeRW1KtdOvB9JLbbeUVXm1g3iGikU4Xtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrlVr2tIAu9vW9XV0O5M9kn2YRiWe2WIRxxfQaYAPn+K6GNX314IQM3uBRXJxlD6/zC/ehSfeTFtcbhr28JPXFfnPquZ5xJy++XhTifDxa5P+i45wHScjrdfZNKpcMRstNSpBz1FwLqUsO8BhLTmpGZSA+BQVxke1oke/E02Hi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mfShiWRs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mfShiWRs"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f4aa501a4so10595815ad.1
        for <linux-hardening@vger.kernel.org>; Tue, 11 Feb 2025 19:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739330518; x=1739935318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGlgtnJud/tm4lyrsEmm3OjwE2GDthkuHJ1JyP15EEc=;
        b=mfShiWRsz7p9LTRqrjCqns4GtsKPBZkJw4/FHb0eg1hga8xrlkfsJU4tmRa+07c079
         m9VoRdh8qg3Sx/jqaUb877lZQPbpaWNekSzjYJZEYRr4lb2cFvFQeZkGgpNsRgkieXsW
         iDsxQTGX8hoW1Fv1Bu+XSi/wacNvQloD8+7zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330518; x=1739935318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGlgtnJud/tm4lyrsEmm3OjwE2GDthkuHJ1JyP15EEc=;
        b=TwYpBv0WhydMYmH2deCJmL1pTAIgUc9BlkTNFfsegjRBbuSD+ajnuvh1oVZJrVd69H
         2vdgppyTQi4+biRwP0HBhy7IwRH5MYdBXzuDEPBsV9jfUNi8ulvg8S+RV2rPF87Q0uj4
         gHicTLWuNlhixbHVJ04JfMp+fg4/rtIMEzrXkyxfHCLWhe3CEcGadqekUsHckPx0uS4k
         jV/vno518gSGFth1cHQ3EDson5BgY5Ga7lrslFfUvB5w3Ko7E7/TTRtbjHPxT97u+BQD
         clUIXG2IAn3N+ez5Fry58xkdzLvGqG8UuTesuzPrv5TNWHy73dxGvttalvch2DwFd6n8
         fbhA==
X-Forwarded-Encrypted: i=1; AJvYcCXWwGJt7JKwcVP8mT/S3OmmuFN9FxYtZg1bE/nvgeYdohYCZ8p3tqOqtioBKvEvdgHTxIJFghM64UKC4swuaCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvHXjdMRqNaVmJi5Z7CkM1AAZLfYBOTtCn02VWOrF9vrFi9tnv
	4Rqw7PEcZQHvPsg9EExC36ympvETGxS7efuiaD0gyb4XWb4kNh7parn9sBUNFQ==
X-Gm-Gg: ASbGncu+u1iyL0qEyPjkP/ayLzy5Dg9p9+j8ykYSNuaNm+0ExPzioMd6lJUWJOO0nip
	/70Eb3h7Ix2Y5D6SPjJpEKIhDTDtePiiHzPKTWF2CSiMeHufg5X+bPg1eat99BYsCFtkKJLANfq
	mDjLJPT7bsLm/BGXSOb3CN6FN7W/xJQ0siqvQB0rU4KFCD3bP1LmRiGxS0QqvUg1HgYRFhEbbts
	Hr8Suo7Z5gGKRdC++1dPGnxADcyQ4+O9PihJxfnVDbdqfGk+y/LVkq2rPPZVZ9xy/tCqCFvrREl
	yPEz9SmJ6/dXMtcE22zbs2gJam8OW6YrtQsI/xL2zZHT+SeH1w==
X-Google-Smtp-Source: AGHT+IEURlNafHcVNKrTKgOcgxh+gG6kKLNCaOgM84jrdUBBOm8abnn5+RM1CQymWz2I341kNGd0sw==
X-Received: by 2002:a17:903:22c5:b0:21b:d105:26a7 with SMTP id d9443c01a7336-220bbb045admr10702145ad.6.1739330517663;
        Tue, 11 Feb 2025 19:21:57 -0800 (PST)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fbf999b5cesm299750a91.34.2025.02.11.19.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 19:21:57 -0800 (PST)
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
Subject: [RFC PATCH v5 1/7] mseal, system mappings: kernel config and header change
Date: Wed, 12 Feb 2025 03:21:49 +0000
Message-ID: <20250212032155.1276806-2-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212032155.1276806-1-jeffxu@google.com>
References: <20250212032155.1276806-1-jeffxu@google.com>
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
ARCH_HAS_MSEAL_SYSTEM_MAPPINGS) and a header file (userprocess.h)
for future patches.

As discussed during mseal() upstream process [1], mseal() protects
the VMAs of a given virtual memory range against modifications, such
as the read/write (RW) and no-execute (NX) bits. For complete
descriptions of memory sealing, please see mseal.rst [2].

The mseal() is useful to mitigate memory corruption issues where a
corrupted pointer is passed to a memory management system. For
example, such an attacker primitive can break control-flow integrity
guarantees since read-only memory that is supposed to be trusted can
become writable or .text pages can get remapped.

The system mappings are readonly only, memory sealing can protect
them from ever changing to writable or unmmap/remapped as different
attributes.

System mappings such as vdso, vvar, and sigpage (arm), vectors (arm)
are created by the kernel during program initialization, and could
be sealed after creation.

Unlike the aforementioned mappings, the uprobe mapping is not
established during program startup. However, its lifetime is the same
as the process's lifetime [3]. It could be sealed from creation.

The vsyscall on x86-64 uses a special address (0xffffffffff600000),
which is outside the mm managed range. This means mprotect, munmap, and
mremap won't work on the vsyscall. Since sealing doesn't enhance
the vsyscall's security, it is skipped in this patch. If we ever seal
the vsyscall, it is probably only for decorative purpose, i.e. showing
the 'sl' flag in the /proc/pid/smaps. For this patch, it is ignored.

It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
alter the system mappings during restore operations. UML(User Mode Linux)
and gVisor are also known to change the vdso/vvar mappings. Consequently,
this feature cannot be universally enabled across all systems. As such,
CONFIG_MSEAL_SYSTEM_MAPPINGS is disabled by default.

To support mseal of system mappings, architectures must define
CONFIG_ARCH_HAS_MSEAL_SYSTEM_MAPPINGS and update their special mappings
calls to pass mseal flag. Additionally, architectures must confirm they
do not unmap/remap system mappings during the process lifetime.

In this version, we've improved the handling of system mapping sealing from
previous versions, instead of modifying the _install_special_mapping
function itself, which would affect all architectures, we now call
_install_special_mapping with a sealing flag only within the specific
architecture that requires it. This targeted approach offers two key
advantages: 1) It limits the code change's impact to the necessary
architectures, and 2) It aligns with the software architecture by keeping
the core memory management within the mm layer, while delegating the
decision of sealing system mappings to the individual architecture, which
is particularly relevant since 32-bit architectures never require sealing.

Additionally, this patch introduces a new header,
include/linux/usrprocess.h, which contains the mseal_system_mappings()
function. This function helps the architecture determine if system
mapping is enabled within the current kernel configuration. It can be
extended in the future to handle opt-in/out prctl for enabling system
mapping sealing at the process level or a kernel cmdline feature.

A new header file was introduced because it was difficult to find the
best location for this function. Although include/linux/mm.h was
considered, this feature is more closely related to user processes
than core memory management. Additionally, future prctl or kernel
cmd-line implementations for this feature would not fit within the
scope of core memory management or mseal.c. This is relevant because
if we add unit-tests for mseal.c in the future, we would want to limit
mseal.c's dependencies to core memory management.

Prior to this patch series, we explored sealing special mappings from
userspace using glibc's dynamic linker. This approach revealed several
issues:
- The PT_LOAD header may report an incorrect length for vdso, (smaller
  than its actual size). The dynamic linker, which relies on PT_LOAD
  information to determine mapping size, would then split and partially
  seal the vdso mapping. Since each architecture has its own vdso/vvar
  code, fixing this in the kernel would require going through each
  archiecture. Our initial goal was to enable sealing readonly mappings,
  e.g. .text, across all architectures, sealing vdso from kernel since
  creation appears to be simpler than sealing vdso at glibc.
- The [vvar] mapping header only contains address information, not length
  information. Similar issues might exist for other special mappings.
- Mappings like uprobe are not covered by the dynamic linker,
  and there is no effective solution for them.

This feature's security enhancements will benefit ChromeOS, Android,
and other high security systems.

Testing:
This feature was tested on ChromeOS and Android for both x86-64 and ARM64.
- Enable sealing and verify vdso/vvar, sigpage, vector are sealed properly,
  i.e. "sl" shown in the smaps for those mappings, and mremap is blocked.
- Passing various automation tests (e.g. pre-checkin) on ChromeOS and
  Android to ensure the sealing doesn't affect the functionality of
  Chromebook and Android phone.

I also tested the feature on Ubuntu on x86-64:
- With config disabled, vdso/vvar is not sealed,
- with config enabled, vdso/vvar is sealed, and booting up Ubuntu is OK,
  normal operations such as browsing the web, open/edit doc are OK.

In addition, Benjamin Berg tested this on UML.

Link: https://lore.kernel.org/all/20240415163527.626541-1-jeffxu@chromium.org/ [1]
Link: Documentation/userspace-api/mseal.rst [2]
Link: https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/ [3]

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 include/linux/userprocess.h | 18 ++++++++++++++++++
 init/Kconfig                | 18 ++++++++++++++++++
 security/Kconfig            | 18 ++++++++++++++++++
 3 files changed, 54 insertions(+)
 create mode 100644 include/linux/userprocess.h

diff --git a/include/linux/userprocess.h b/include/linux/userprocess.h
new file mode 100644
index 000000000000..bd11e2e972c5
--- /dev/null
+++ b/include/linux/userprocess.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_USER_PROCESS_H
+#define _LINUX_USER_PROCESS_H
+#include <linux/mm.h>
+
+/*
+ * mseal of userspace process's system mappings.
+ */
+static inline unsigned long mseal_system_mappings(void)
+{
+#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
+	return VM_SEALED;
+#else
+	return 0;
+#endif
+}
+
+#endif
diff --git a/init/Kconfig b/init/Kconfig
index d0d021b3fa3b..892d2bcdf397 100644
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
+	  speical mappings calls to include the sealing flag and confirm
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
index f10dbf15c294..bfb35fc7a3c6 100644
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
+	  Note: CHECKPOINT_RESTORE, UML, gVisor are known to relocate or
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
2.48.1.502.g6dc24dfdaf-goog

