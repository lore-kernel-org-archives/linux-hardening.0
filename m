Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3DD2C11E6;
	Sat, 22 Nov 2025 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763775786; cv=none; b=hOdIm349Y52FOD8ehcyKhOjkxlkITcYjN4zAJ+EJR9LCM6dsbaQDnuRPdoppXZ3OGZhz9hDeRKqGV7EqhRxY3H8JVvc/SSb6bpI7PhDjY/HBUtn1M2SMTojLaUKhqCCQ/cvhBmlLMKWNBdbf1V9e1PmmyE/RYA8JawM2QYoLpKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763775786; c=relaxed/simple;
	bh=Bm5UctH3mgw7LUjsKVnWiQeM2ZjrjWLRLpRvc3SOhQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PXg9A29tfdGyvklARrtnBkM30XMtUtwshU3DvimTn7A69MpVvWNvaDash0VnzhNRgj/CnOqcfIA9LM5V1uNfIM43VE/DUECL1HOFzBpp+YoKcS6nJNtQ31tyElwvkSIZFTAMWqFSP9oe8GeCVIf5wWqvzzQStZYkIzelMrnN0M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bY5wuqa8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bY5wuqa8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0EEC4AF0C;
	Sat, 22 Nov 2025 01:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763775785;
	bh=Bm5UctH3mgw7LUjsKVnWiQeM2ZjrjWLRLpRvc3SOhQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bY5wuqa8a45W1HINfdbep5urhBZTK2k+WQTidy33+y0UlNS72H74z1CfoVuW3hv7V
	 z5FUQMqtrQdtYTB9J+wYlts/dfP+OMaVtwEmnKQ6kVx9FZ+Jj9VFKVlUi5bpwWa1yd
	 daQJRa28y6IKVTL3KGIVBArcTmb5up8agCLOny+j7E58LB1oMO3dTYEgfdSuQ2oUkV
	 n+eST1UZDdTnzReF+ohecgxU/jd9p60qSWkqP83/sI0Z7fA7T8nEks1X9w75Qjwgcp
	 HZMoDc4RKpnM3zWm1fQ4v2vyseKu/YgO/WKEiy7J8c+z03lL/NuR0nufzgSzx/C/HA
	 lJSm+TzfJdi1w==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Marco Elver <elver@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-hardening@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Lameter <cl@linux.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jann Horn <jannh@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-mm@kvack.org,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v5 1/4] compiler_types: Introduce __flex_counter() and family
Date: Fri, 21 Nov 2025 17:42:57 -0800
Message-Id: <20251122014304.3417954-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251122014258.do.018-kees@kernel.org>
References: <20251122014258.do.018-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5209; i=kees@kernel.org; h=from:subject; bh=Bm5UctH3mgw7LUjsKVnWiQeM2ZjrjWLRLpRvc3SOhQI=; b=owGbwMvMwCVmps19z/KJym7G02pJDJmKoso7nm58EGTt81C0PG6jhZD/jO6pLRohBZOjykWLY zhERVk7SlkYxLgYZMUUWYLs3ONcPN62h7vPVYSZw8oEMoSBi1MAJvLPmpHhtnWqcu45r7Nt6RxR piEzpIWdq2qOP7DcfZlTa5bZAbadjAwPN/G4mYuxhbHdYPr2JoUnd9p5t+mHfkaHZvQWbL51NZQ FAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Introduce __flex_counter() which wraps __builtin_counted_by_ref(),
as newly introduced by GCC[1] and Clang[2]. Use of __flex_counter()
allows access to the counter member of a struct's flexible array member
when it has been annotated with __counted_by().

Introduce typeof_flex_counter(), can_set_flex_counter(), and
set_flex_counter() to provide the needed _Generic() wrappers to get sane
results out of __flex_counter().

For example, with:

	struct foo {
		int counter;
		short array[] __counted_by(counter);
	} *p;

__flex_counter(p->array) will resolve to: &p->counter

typeof_flex_counter(p->array) will resolve to "int". (If p->array was not
annotated, it would resolve to "size_t".)

can_set_flex_counter(p->array, COUNT) is the same as:

	COUNT <= type_max(p->counter) && COUNT >= type_min(p->counter)

(If p->array was not annotated it would return true since everything
fits in size_t.)

set_flex_counter(p->array, COUNT) is the same as:

	p->counter = COUNT;

(It is a no-op if p->array is not annotated with __counted_by().)

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-hardening@vger.kernel.org
---
 include/linux/compiler_types.h | 31 ++++++++++++++++++++++++++
 include/linux/overflow.h       | 40 ++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c46855162a8a..a31fe3dbf576 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -507,6 +507,37 @@ struct ftrace_likely_data {
 #define __annotated(var, attr)	__builtin_has_attribute(var, attr)
 #endif
 
+/*
+ * Optional: only supported since gcc >= 15, clang >= 19
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html#index-_005f_005fbuiltin_005fcounted_005fby_005fref
+ * clang: https://clang.llvm.org/docs/LanguageExtensions.html#builtin-counted-by-ref
+ */
+#if __has_builtin(__builtin_counted_by_ref)
+/**
+ * __flex_counter() - Get pointer to counter member for the given
+ *                    flexible array, if it was annotated with __counted_by()
+ * @FAM: Pointer to flexible array member of an addressable struct instance
+ *
+ * For example, with:
+ *
+ *	struct foo {
+ *		int counter;
+ *		short array[] __counted_by(counter);
+ *	} *p;
+ *
+ * __flex_counter(p->array) will resolve to &p->counter.
+ *
+ * Note that Clang may not allow this to be assigned to a separate
+ * variable; it must be used directly.
+ *
+ * If p->array is unannotated, this returns (void *)NULL.
+ */
+#define __flex_counter(FAM)	__builtin_counted_by_ref(FAM)
+#else
+#define __flex_counter(FAM)	((void *)NULL)
+#endif
+
 /*
  * Some versions of gcc do not mark 'asm goto' volatile:
  *
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 725f95f7e416..12ca286c0f34 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -540,4 +540,44 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 	(__member_size((name)->array) / sizeof(*(name)->array) +			\
 						__must_be_array((name)->array))
 
+/**
+ * typeof_flex_counter() - Return the type of the counter variable of a given
+ *                         flexible array member annotated by __counted_by().
+ * @FAM: Pointer to the flexible array member within a given struct.
+ *
+ * Returns: "size_t" if no annotation exists.
+ */
+#define typeof_flex_counter(FAM)				\
+	typeof(_Generic(__flex_counter(FAM),			\
+			void *: (size_t)0,			\
+			default: *__flex_counter(FAM)))
+
+/**
+ * __can_set_flex_counter() - Check if the counter associated with the given
+ *                            flexible array member can represent a value.
+ * @FAM: Pointer to the flexible array member within a given struct.
+ * @COUNT: Value to check against the __counted_by annotated @FAM's counter.
+ *
+ * Returns: true if @COUNT can be represented in the @FAM counter. When
+ * @FAM is not annotated with __counted_by(), always returns true.
+ */
+#define __can_set_flex_counter(FAM, COUNT)			\
+	(!overflows_type(COUNT, typeof_flex_counter(FAM)))
+
+/**
+ * __set_flex_counter() - Set the counter associated with the given flexible
+ *                        array member that has been annoated by __counted_by().
+ * @FAM: Pointer to the flexible array member within a given struct.
+ * @COUNT: Value to store to the __counted_by annotated @FAM's counter.
+ *
+ * This is a no-op if no annotation exists. Count needs to be checked with
+ * __can_set_flex_counter(@FAM, @COUNT) before using this function.
+ */
+#define __set_flex_counter(FAM, COUNT)				\
+({								\
+	*_Generic(__flex_counter(FAM),				\
+		  void *:  &(size_t){ 0 },			\
+		  default: __flex_counter(FAM)) = (COUNT);	\
+})
+
 #endif /* __LINUX_OVERFLOW_H */
-- 
2.34.1

