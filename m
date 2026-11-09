Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240042;
	b=LPN9D4JVNvC9K2yJLXWpaIeszJkVHNdpHuF+bioEtgTkv9uM4d9dQTpdCDFXoHIHe6YW
	 R9m2d1A3YoVcejlRoEDXMJnNqiYUfwYgtmv1Ws0dci7s69ZwSsPMAjs/1Sd1YIGTN9yMs
	 /Yy8hYGOBcN0Ua5RFkviQm5+Sn4q7zmnsfn34uk1nv4jhsro5vfB334dWYDdrpl0c7zsB
	 SvMA7o+Afyoq5rMee6T4u0mepmgI/3mpPRsD9KNCFNS9LFAHNReP2ObuZ9M/DDFuzLQ6L
	 /nWZC8QTS+70x2HkOMu8grox8IsdgkBHTFv4ExYlV9FVfBnBif0nooiNdjsXCKVhDeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240042;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=BWpLaVBRkOlQWYeoX9SPxGyEXeXPe7MtwkGKCwhz/ks=;
	b=kjyVXvt91Zt0phPM7+uNvoDP35oi7z5loYCn4XMkd2oWTud58wUf65uNw5RjppNwwl3G
	 BTirzbnVfFei2gSMivVFG/fbfOoQINI94NElRqSmfeDoz36wYcIy/6j9fNWdPIY/KuzAt
	 YODc2m57PNVVsFOcaUvKIWoX0g9KO5ecpg6jbVP4GkGOUh43ztasbbOpuQY7YmJ/y96jF
	 wJsxW49KUkRyZS4VnT8vlCCiJBfYF7S4F2KWZwdiaz1P1m4YbkcT5W07L40z544Qdgo9l
	 NIlSMgddTOdeoORh7Ax4IEEE1IPtpiZ/AWmBfvUmWjoiFXkGI635l7GJA/g45nNUmmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Y6QGzbK4;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF396082BCF;
	Mon,  9 Nov 2026 16:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAF396082BCF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Y6QGzbK4
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FD351516;
	Mon,  9 Nov 2026 08:00:37 -0800 (PST)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42CD23F632;
	Mon,  9 Nov 2026 08:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794240040; bh=echuUgtLkD2a7BAD+7hYclWLN8NT3mDQAmCpjSBvsFk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y6QGzbK49+REvpkxtERwwRHEONKDKFghwySdcsjRjdlI517MmjfTwR3s6m0QobYBa
	 3sn/jaGFagkhKCpOG1rpEsWtLz8+b48zchh/AEr560CrvtaBdlQ6wiNUmHQvX3sRzZ
	 twgysJBNhnxsNOoKzScZ0QEdN3mSvpMohb/PcPNc=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Mon, 09 Nov 2026 15:58:26 +0000
Subject: [PATCH RFC v10 01/22] mm: Introduce kpkeys
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-kpkeys-v10-1-aa6c4d9603bc@arm.com>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
In-Reply-To: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
To: linux-hardening@vger.kernel.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Ard Biesheuvel <ardb+git@google.com>, Andy Lutomirski <luto@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>, 
 Kees Cook <kees@kernel.org>, Linu Cherian <linu.cherian@arm.com>, 
 Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Maxwell Bland <mbland@motorola.com>, 
 "Mike Rapoport (IBM)" <rppt@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Pierre Langlois <pierre.langlois@arm.com>, 
 =?utf-8?q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Quentin Perret <qperret@google.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org, 
 Ira Weiny <iweiny@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794240029; l=6214;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=echuUgtLkD2a7BAD+7hYclWLN8NT3mDQAmCpjSBvsFk=;
 b=M7uxGf8m8LgUdUIOChPJY5rfo9p8Svpg9/S7sTLYMAlbmUhfhg1wFRDmHdZYq6jO29fCVU69I
 eijdTIw94XWBsyMBWozP3mIqOnAkhHm0jYlOLiP4EQdKhP9fTFoezeO
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

kpkeys is a simple framework to enable the use of protection keys
(pkeys) to harden the kernel itself. This patch introduces the basic
API in <linux/kpkeys.h>: a pair of functions to enter/leave a kpkeys
context, and macros to define guard objects.

Each kpkeys context specifies permissions for the pkeys managed by the
framework. kpkeys_enter_context() applies those permissions and
returns a state for kpkeys_leave_context() to restore.

The saved state is represented by struct kpkeys_state, with one
field for the arch state (typically the saved pkeys register value).
The other field is used to skip the restore step in case we were
already in the context passed to enter_context().

Support for kpkeys must be indicated by selecting ARCH_HAS_KPKEYS.
The architecture must then provide:

* struct arch_kpkeys_state in <asm/kpkeys_types.h>

* arch_kpkeys_enter_context() in <asm/kpkeys.h>:
  if needed, sets the new state and saves the original one in
  arch_kpkeys_state; reports whether the context was actually
  changed

* arch_kpkeys_leave_context() in <asm/kpkeys.h>:
  restores the original state

* arch_supports_kpkeys() in <asm/kpkeys.h>:
  returns whether the system has an appropriate hardware feature to
  support kpkeys

To start with, only KPKEYS_CTX_DEFAULT is available, granting
RW access to the default pkey (0).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/kpkeys.h       | 107 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/kpkeys_types.h |  25 ++++++++++
 mm/Kconfig                   |   2 +
 3 files changed, 134 insertions(+)

diff --git a/include/linux/kpkeys.h b/include/linux/kpkeys.h
new file mode 100644
index 000000000000..69ec4808d850
--- /dev/null
+++ b/include/linux/kpkeys.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_KPKEYS_H
+#define _LINUX_KPKEYS_H
+
+#include <linux/bug.h>
+#include <linux/cleanup.h>
+#include <linux/kpkeys_types.h>
+
+/**
+ * KPKEYS_GUARD_NOOP() - helper to define a guard type that does nothing
+ * @name: the name of the guard type
+ *
+ * Define a guard type that does nothing, useful to match a real guard type
+ * that is defined under an #ifdef.
+ */
+#define KPKEYS_GUARD_NOOP(name)						\
+	__DEFINE_CLASS_IS_CONDITIONAL(name, false);			\
+	DEFINE_CLASS(name, bool, (void)_T, false, void);		\
+	static inline void *class_##name##_lock_ptr(bool *_T)		\
+	{ return _T; }
+
+#ifdef CONFIG_ARCH_HAS_KPKEYS
+
+#include <asm/kpkeys.h>
+
+/**
+ * KPKEYS_GUARD_COND() - helper to define a guard type that conditionally
+ *                       switches to a given kpkeys context
+ * @name: the name of the guard type
+ * @ctx: the kpkeys context to switch to
+ * @cond: an expression that is evaluated as condition
+ *
+ * Define a guard type that switches to @ctx if @cond evaluates to true,
+ * and does nothing otherwise.
+ */
+#define KPKEYS_GUARD_COND(name, ctx, cond)				\
+	__DEFINE_CLASS_IS_CONDITIONAL(name, false);			\
+	DEFINE_CLASS(name, struct kpkeys_state,				\
+		     kpkeys_leave_context(&_T),				\
+		     (cond) ? kpkeys_enter_context(ctx) :		\
+			      (struct kpkeys_state) {}, void);		\
+	static inline							\
+	void *class_##name##_lock_ptr(struct kpkeys_state *_T)		\
+	{ return _T; }
+
+/**
+ * KPKEYS_GUARD() - helper to define a guard type that switches to a given
+ *                  kpkeys context if kpkeys are supported
+ * @name: the name of the guard type
+ * @ctx: the kpkeys context to switch to
+ *
+ * Define a guard type that switches to @ctx if the system supports kpkeys.
+ */
+#define KPKEYS_GUARD(name, ctx)						\
+	KPKEYS_GUARD_COND(name, ctx, kpkeys_supported())
+
+/**
+ * kpkeys_enter_context() - enter a kpkeys context
+ * @ctx: the context to switch to
+ *
+ * Enters the specified kpkeys context. @ctx must be a compile-time constant.
+ *
+ * Return: state to be passed to kpkeys_leave_context().
+ */
+static __always_inline
+struct kpkeys_state kpkeys_enter_context(enum kpkeys_ctx ctx)
+{
+	struct kpkeys_state state = {};
+
+	BUILD_BUG_ON_MSG(!__builtin_constant_p(ctx),
+			 "kpkeys_enter_context() only takes constant values");
+	BUILD_BUG_ON_MSG(ctx < 0 || ctx >= KPKEYS_CTX_COUNT,
+			 "Invalid value passed to kpkeys_enter_context()");
+
+	state.entered_context = arch_kpkeys_enter_context(ctx, &state.arch_state);
+	return state;
+}
+
+/**
+ * kpkeys_leave_context() - leave a kpkeys context
+ * @state: state returned by kpkeys_enter_context()
+ *
+ * Restores the state saved when entering a kpkeys context. If no context was
+ * entered, this function does nothing.
+ */
+static __always_inline
+void kpkeys_leave_context(const struct kpkeys_state *state)
+{
+	if (state->entered_context)
+		arch_kpkeys_leave_context(&state->arch_state);
+}
+
+static inline bool kpkeys_supported(void)
+{
+	return arch_supports_kpkeys();
+}
+
+#else /* CONFIG_ARCH_HAS_KPKEYS */
+
+static inline bool kpkeys_supported(void)
+{
+	return false;
+}
+
+#endif /* CONFIG_ARCH_HAS_KPKEYS */
+
+#endif /* _LINUX_KPKEYS_H */
diff --git a/include/linux/kpkeys_types.h b/include/linux/kpkeys_types.h
new file mode 100644
index 000000000000..9de59092e9c3
--- /dev/null
+++ b/include/linux/kpkeys_types.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_KPKEYS_TYPES_H
+#define _LINUX_KPKEYS_TYPES_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_ARCH_HAS_KPKEYS
+#include <asm/kpkeys_types.h>
+#endif
+
+#if defined(CONFIG_ARCH_HAS_KPKEYS) && !defined(__ASSEMBLY__)
+
+enum kpkeys_ctx {
+	KPKEYS_CTX_DEFAULT = 0,
+	KPKEYS_CTX_COUNT,
+};
+
+struct kpkeys_state {
+	bool entered_context;
+	struct arch_kpkeys_state arch_state;
+};
+
+#endif /* CONFIG_ARCH_HAS_KPKEYS && !__ASSEMBLY__ */
+
+#endif /* _LINUX_KPKEYS_TYPES_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index afff1b25b543..4635628de622 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1265,6 +1265,8 @@ config ARCH_USES_HIGH_VMA_FLAGS
 	bool
 config ARCH_HAS_PKEYS
 	bool
+config ARCH_HAS_KPKEYS
+	bool
 
 config ARCH_USES_PG_ARCH_2
 	bool

-- 
2.56.0

