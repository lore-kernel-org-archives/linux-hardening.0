Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719144;
	b=qQ9BBuGa2YnQ4elngBzeiUsWXqqAglV00QLfnA+bCxGHoRNHNmdFe2I7jCkTk0hMLkmM
	 fYl6z8yoD36rKQpGrfx1lsWOzTijgDR8nrAHeRQmSDCkNSa5bGNHEmWPZ0vBehivwNH8+
	 sAwJbQl3Z1J6JGxMGgG/We+urD1uctA3/INBlS0lJmpaTO7ugTMVY8k8PJM7MK1HytQ70
	 Kyeo4VuylalZnWCXvGOhxB4xHwAiN9mYCod3CRNEJdZtapyzXDuBpAZ3iU2DuVoS+by7Z
	 GCqnauPDvGoXT9ZJrS7MSlxQpYdxp1C2eLPk6a6a70zZa8gk83FRg5jDMHfqwomaYFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=Ed/gwawEhmgCUsO2zTzDURm/4rT61HQtm1nt/NY8TTM=;
	b=LdL0QnDpNAhFarpPJmR2/sle7OyKduJ4u7eYIoE6YiX61LQmr+kF272G59VFentAzjpm
	 rFvJrWjVtxraP7AA/3jhXJCEvhRojB6WmsJSy6RUNBlJGKuC3GgqecUf+b31OdvYdV/Cc
	 nunWEhaHykb3JVvy27rXBkChyvonD3YKoH9B/zfxbwES5bJMilfNJtvv9nsaA0IHEeZY6
	 Kxkl4ASUnYypBFzMP083yHVvaDzCqJvfBJc4XG1HWwxvf5PV9rZMYJ//wRgeCVBRDiYjP
	 RgVDov8Gc/5U/ebc/u+zqcY+y0RiT70fF5UX342DR2mtjILw2U6zVkPgkXTPzlVQUKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=LjkGSTSx;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7302860A2633
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 15:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7302860A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=LjkGSTSx
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e98798cbddso20815925ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 07:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793719144; x=1794323944; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ed/gwawEhmgCUsO2zTzDURm/4rT61HQtm1nt/NY8TTM=;
        b=LjkGSTSxekW6xIIn3mTxQgw/diszga0IGombK+vxWIc8cEl3FzTKktJOCqwZR2d8Q4
         1u8EkadbjKwkreFDFOWrUbmHdxhazi7emzWeS8O8DqRnmB9Dec6vHtU+k3ikVuAGVUdF
         KnAN6OIzEEo6NvzWavNf6tS23ERsjmM7z/Hq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719144; x=1794323944;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ed/gwawEhmgCUsO2zTzDURm/4rT61HQtm1nt/NY8TTM=;
        b=cTTHLu2GcchT9EsALF5XT6EgVeulWxQh9MV1fXDXtF8NfahDMoadc0YwOEx2JkHvab
         B9zpF5sot/NYeZh9UQVZivZHsKaLuP5ARHy0rvEclbcAnLRqCa+wtzarQK97wVfqlXq0
         8PaRpxusIZgaBh9aDvO2xln54FdFG8a+pM1XQyCbSpP+uLMn3uyWiz0aYb+K38NEtEin
         SpvgJ2dxjTDxIRIMJTkapqcGs9v886SVEHOJxmIGRAquArGoLWWIkuq4DEDq6yf+KAQ8
         qoELxVIktkatsSPcCUX+i2YvMYhFyrhSv+BL6nDvy5GOMZ1iy8a5XGqKwgcCMRlsBGVv
         Ss8A==
X-Forwarded-Encrypted: i=1; AKwUvBy8C5Yh4fC1c2R1S7fKVV6v0ueXVzfi7eGSvhlX8ycwB99oz3/TzpFVQ1uWHOvUGcbjtIRMWpj5sCiqz+7Z6NE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sRw4xO2cfBeKfwIxnG1nbqKj1G2J2oyQK/EkebKyfToMcPoqd
	gYIRldawCxqWNcGRZaFkYOGqjw6aHqGYb/kMPeDuwIQXlGePNzs7E/ZnHLrb2bfikgk=
X-Gm-Gg: AYBFou0Cmjc+GM7wu8WivnPHLRJMIGRszNF3xICIx/5KUu+YV4pVcn0m7utIJpk2++l
	YAN13aE8nYBAIyFJYxlBVBh1x1/MxyuEEf6nDub6wfQwW58POvMefvdcviSRH3lQ//CQ3aM7FWB
	rtAKvV4mRhous7FUzqdZgRMb75U7X6JoRYfMmY/E3qfUVDrdywFbcydUauuPk8RgUW3NBUuu4V7
	kHd7hAdAAfO40dhR2F6Tutd8Xdr9zpVGpaYH0VrS22TdVnbAiz0Yfoe56ZC4vT17OscCpybxctx
	v3exmrvurf9FKzYPKO5atRafXQ25VVm1FTZWPL/HiJJckIgWariS31olUDwvvqIkG+HINEfk6hb
	kH0SsLq236DJLKp2+3bIg3Aa8YmqNsHNZEYGZMgBpSCUh36mgBv2A6j7rDT4N5T0HDu6kK8DcEO
	eKEvl08lcY5M3quCCinhFnGtZD9ly6tMFYPuSzc0bwGoaQ2D56/65UAushBZjqd3zlM7xxENyoy
	ynAX4Lj2/JinQBn109xvogEsFa6kCNqJeaTJ/RUfq1fDlFh1it9xvMRRZ6uhpTX8YZIXNT9UkKF
	hVwCLNi8Be5X8++4/pvjd+0vzaAQy2xOo/ph0cZ8PH/EMOix2M4djUJBx96W8SPsyKQvs1XJEE5
	2ZAwqEGDTvH1g3Oz8YZGtmdqhAfwyFGlLfIjnqv/K/rRAX6swmEAwi/cOmW3DGXR3Qwch8L58J0
	3Ob5uaKuXWedCMMuLKYg==
X-Received: by 2002:a17:903:1b05:b0:2db:733c:fd1f with SMTP id d9443c01a7336-2eb364005f0mr112964235ad.8.1793719143805;
        Tue, 03 Nov 2026 07:19:03 -0800 (PST)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39262c47sm43118815ad.38.2026.11.03.07.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:19:02 -0800 (PST)
Date: Tue, 3 Nov 2026 23:18:59 +0800
From: Chris Down <chris@chrisdown.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Jeff Xu <jeffxu@google.com>, David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Andrey Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Shuah Khan <shuah@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH v2 7/8] mm/mseal: Add no_mseal_sys_mappings boot parameter
Message-ID: <701a3346a0105e801d247c11139853f156a8d15a.1793718940.git.chris@chrisdown.name>
References: <cover.1793718940.git.chris@chrisdown.name>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793718940.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

CONFIG_MSEAL_SYSTEM_MAPPINGS seals each process' system mappings, such
as the vDSO, when they are created. These are read-only or execute-only
mappings which every process trusts, so sealing them means that a memory
corruption bug which can pass a bad pointer to mprotect(), mremap() or
munmap() can't be used to make them writable, or to move or replace
them.

However, sealing can only be chosen at build time, and it breaks
software which moves or modifies these mappings. This is not ideal,
since hosts which want sealing and hosts which run such software then
can't share a kernel.

For example, at Meta, we build sealing into the kernel for our VM hosts,
and we'd like it on as much of the rest of the fleet as possible. The
problem is that the rest of the fleet also runs things which it breaks.
As one example among many, Reverie (which our deterministic execution
tool, Hermit, is built on) patches the vDSO of the processes it traces
by injecting an mprotect() [0]. So right now the hosts which want
sealing need their own kernel image, and this option is one of the
things which forces that.

So, to improve this, let's add no_mseal_sys_mappings. That way one
kernel can be built with CONFIG_MSEAL_SYSTEM_MAPPINGS=y, keep sealing on
by default, and turn it off only on the hosts which need it. Kernels
built without the option are unchanged.

Since sealing can now be turned off at boot, MSEAL_SYSTEM_MAPPINGS also
no longer needs to depend on !CHECKPOINT_RESTORE. The option is off by
default and already documents that it breaks CRIU, so let's drop the
dependency. For the same reason, the documentation no longer needs to
say that it can't be enabled universally.

Link: https://docs.rs/reverie-core/latest/reverie/vdso/index.html # [0]
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 Documentation/userspace-api/mseal.rst           |  9 +++++----
 mm/Kconfig                                      | 15 ++++++++-------
 mm/mseal.c                                      | 12 ++++++++++++
 mm/vma.h                                        |  5 ++++-
 5 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..a72904ebb98d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4603,6 +4603,13 @@ Kernel parameters
 
 	nomodule	Disable module load
 
+	no_mseal_sys_mappings
+			[KNL,EARLY] With CONFIG_MSEAL_SYSTEM_MAPPINGS, don't
+			seal system mappings such as the vDSO. Sealing them
+			breaks software which moves, unmaps or modifies them,
+			such as CHECKPOINT_RESTORE (CRIU), UML, gVisor and rr.
+			See Documentation/userspace-api/mseal.rst.
+
 	nonmi_ipi	[X86] Disable using NMI IPIs during panic/reboot to
 			shutdown the other cpus.  Instead use the REBOOT_VECTOR
 			irq.
diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
index 060c9829306b..0efdc5469085 100644
--- a/Documentation/userspace-api/mseal.rst
+++ b/Documentation/userspace-api/mseal.rst
@@ -143,12 +143,13 @@ Use cases
 
   If supported by an architecture (CONFIG_ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS),
   the CONFIG_MSEAL_SYSTEM_MAPPINGS seals all system mappings of this
-  architecture.
+  architecture. The ``no_mseal_sys_mappings`` kernel command line parameter
+  turns this off.
 
   WARNING: This feature breaks programs which rely on relocating
-  or unmapping system mappings. Known broken software at the time
-  of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
-  this config can't be enabled universally.
+  or unmapping system mappings. Software known to break with it
+  at the time of writing includes CHECKPOINT_RESTORE, UML, gVisor
+  and rr.
 
 When not to use mseal
 =====================
diff --git a/mm/Kconfig b/mm/Kconfig
index 316515589cdb..bb2a60f52c8e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1359,24 +1359,25 @@ config MSEAL_SYSTEM_MAPPINGS
 	bool "mseal system mappings"
 	depends on 64BIT
 	depends on ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
-	depends on !CHECKPOINT_RESTORE
 	help
 	  Apply mseal on system mappings.
 	  The system mappings includes vdso, vvar, vvar_vclock,
 	  vectors (arm compat-mode), sigpage (arm compat-mode), uprobes,
 	  uprobe trampolines (x86).
 
-	  A 64-bit kernel is required for the memory sealing feature.
-	  No specific hardware features from the CPU are needed.
-
 	  WARNING: This feature breaks programs which rely on relocating
-	  or unmapping system mappings. Known broken software at the time
-	  of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
-	  this config can't be enabled universally.
+	  or unmapping system mappings. Software known to break with it
+	  at the time of writing includes CHECKPOINT_RESTORE, UML, gVisor
+	  and rr.
+
+	  With this configuration option set, the feature can be disabled
+	  with the no_mseal_sys_mappings boot parameter.
 
 	  For complete descriptions of memory sealing, please see
 	  Documentation/userspace-api/mseal.rst
 
+	  If unsure, say N.
+
 config HAVE_ARCH_USERFAULTFD_WP
 	bool
 	help
diff --git a/mm/mseal.c b/mm/mseal.c
index 7a8ac66dc215..271b44e628c5 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -7,6 +7,7 @@
  *  Author: Jeff Xu <jeffxu@chromium.org>
  */
 
+#include <linux/init.h>
 #include <linux/mempolicy.h>
 #include <linux/minmax.h>
 #include <linux/mman.h>
@@ -16,6 +17,17 @@
 #include <linux/sched.h>
 #include "internal.h"
 
+#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
+bool mseal_system_mappings_disabled __ro_after_init;
+
+static int __init early_no_mseal_sys_mappings(char *buf)
+{
+	mseal_system_mappings_disabled = true;
+	return 0;
+}
+early_param("no_mseal_sys_mappings", early_no_mseal_sys_mappings);
+#endif
+
 static bool range_contains_unmapped(unsigned long start, unsigned long end)
 {
 	VMA_ITERATOR(vmi, current->mm, start);
diff --git a/mm/vma.h b/mm/vma.h
index 3982b239d0b4..11ff9c7d6592 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -800,9 +800,12 @@ static inline bool vma_is_sealed(struct vm_area_struct *vma)
 }
 #endif
 
+extern bool mseal_system_mappings_disabled;
+
 static inline bool mseal_system_mappings(void)
 {
-	return IS_ENABLED(CONFIG_MSEAL_SYSTEM_MAPPINGS);
+	return IS_ENABLED(CONFIG_MSEAL_SYSTEM_MAPPINGS) &&
+	       !mseal_system_mappings_disabled;
 }
 
 #if defined(CONFIG_STACK_GROWSUP)
-- 
2.54.0

