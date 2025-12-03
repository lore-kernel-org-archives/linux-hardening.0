Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BAA2EB86A;
	Wed,  3 Dec 2025 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764804637; cv=none; b=lgrwhlQVOiakCzImybHAduntnKHAbGJAsIe39GLBzKOgg+pNgJmo0QOO4qJ6IxlU2/6S1motED7MESbhwNDjiVdQ9yOjrv7FfdLvxFG0UBDaO775MPitQmQRfTp65ctTSOZ0P+pp1jxpN5dVI5Nm3swzIj59pF8LcoNkq1Ns1rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764804637; c=relaxed/simple;
	bh=MfXbJ6vSs1Dx3b2SfnaSAfowCKIWsMTNjHXn3OinNe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ricgTHyj797pMyE13q77RzMZNILzEPosTA87MbvrA9P9LfSGbWEs+wjEt7dfuKxdNr8pUKJ2Hhxr6foLCBMfAxgLMWgFSxBkEUZgKpU5MFeR0QvrwBjXsmkmg54N8IghGRsukkAs8ntvslDB2hZNr2dWkk/ABr5m5Ge7U9aYCu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkKzzvC5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkKzzvC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E903C116C6;
	Wed,  3 Dec 2025 23:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764804637;
	bh=MfXbJ6vSs1Dx3b2SfnaSAfowCKIWsMTNjHXn3OinNe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GkKzzvC57I+ubbzzUXskQZPPGE1GvWjqTiM3d35YfztkY9NIikn9kZ0T5XWf2PxAi
	 GQ6P4Y3Spf4QUlTwHZJooN9f2Ia6Q2b9h0klqmRNW5/klLd0GuZR3Nu6FoApw+Xin1
	 DvbMZp62pbv1KK5jklUVk5wCy9maWxe2Ssb9xo8aqvEXedQVjo3AmEi19cUH/8ALvT
	 Ygp8GmIrVwPmd692LyrycPTdMK6sBy7bIJxNyqc1f0HcrNv8hp8db+TRYQ9VUoU0AQ
	 qHTcsbtd2ymA2lZ2RdBNlLW+UAD4OTaUBYSWACqvTKz3jPGGk8+ZcV++UUULCi9FaE
	 e+CZ4JNFFVAxw==
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
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Joe Perches <joe@perches.com>,
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
Subject: [PATCH v6 3/5] compiler_types: Introduce __flex_counter() and family
Date: Wed,  3 Dec 2025 15:30:33 -0800
Message-Id: <20251203233036.3212363-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203233029.it.641-kees@kernel.org>
References: <20251203233029.it.641-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5281; i=kees@kernel.org; h=from:subject; bh=MfXbJ6vSs1Dx3b2SfnaSAfowCKIWsMTNjHXn3OinNe8=; b=owGbwMvMwCVmps19z/KJym7G02pJDJkGJ6SyquI9VTrT7K0fRN96M/XBg4q2dqVNr7rUPzbWO P1O3Leto5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCLe/Qz/M962TshlVb25WTQ3 YnViltHfjsB5KdXZGiIu2ROm6jhNY2R4Op1R/sq13++vuB0wmvLk3Fpvj8u+a03qGFTK09OCWHb zAgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Introduce __flex_counter() which wraps __builtin_counted_by_ref(),
as newly introduced by GCC[1] and Clang[2]. Use of __flex_counter()
allows access to the counter member of a struct's flexible array member
when it has been annotated with __counted_by().

Introduce typeof_flex_counter(), overflows_flex_counter_type(), and
__set_flex_counter() to provide the needed _Generic() wrappers to get
sane results out of __flex_counter().

For example, with:

	struct foo {
		int counter;
		short array[] __counted_by(counter);
	} *p;

__flex_counter(p->array) will resolve to: &p->counter

typeof_flex_counter(p->array) will resolve to "int". (If p->array was not
annotated, it would resolve to "size_t".)

overflows_flex_counter_type(typeof(*p), array, COUNT) is the same as:

	COUNT <= type_max(p->counter) && COUNT >= type_min(p->counter)

(If p->array was not annotated it would return true since everything
fits in size_t.)

__set_flex_counter(p->array, COUNT) is the same as:

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
 include/linux/compiler_types.h | 31 +++++++++++++++++++++++++
 include/linux/overflow.h       | 42 ++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

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
index 725f95f7e416..f362e155a7ec 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -540,4 +540,46 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 	(__member_size((name)->array) / sizeof(*(name)->array) +			\
 						__must_be_array((name)->array))
 
+/**
+ * typeof_flex_counter() - Return the type of the counter variable of a given
+ *                         flexible array member annotated by __counted_by().
+ * @FAM: Instance of flexible array member within a given struct.
+ *
+ * Returns: "size_t" if no annotation exists.
+ */
+#define typeof_flex_counter(FAM)				\
+	typeof(_Generic(__flex_counter(FAM),			\
+			void *: (size_t)0,			\
+			default: *__flex_counter(FAM)))
+
+/**
+ * overflows_flex_counter_type() - Check if the counter associated with the
+ *				   given flexible array member can represent
+ *				   a value.
+ * @TYPE: Type of the struct that contains the @FAM.
+ * @FAM: Member name of the FAM within @TYPE.
+ * @COUNT: Value to check against the __counted_by annotated @FAM's counter.
+ *
+ * Returns: true if @COUNT can be represented in the @FAM's counter. When
+ * @FAM is not annotated with __counted_by(), always returns true.
+ */
+#define overflows_flex_counter_type(TYPE, FAM, COUNT)		\
+	(!overflows_type(COUNT, typeof_flex_counter(((TYPE *)NULL)->FAM)))
+
+/**
+ * __set_flex_counter() - Set the counter associated with the given flexible
+ *                        array member that has been annoated by __counted_by().
+ * @FAM: Instance of flexible array member within a given struct.
+ * @COUNT: Value to store to the __counted_by annotated @FAM_PTR's counter.
+ *
+ * This is a no-op if no annotation exists. Count needs to be checked with
+ * overflows_flex_counter_type() before using this function.
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

