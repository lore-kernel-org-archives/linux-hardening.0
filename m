Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A5210F1;
	Sat, 15 Mar 2025 03:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742008554; cv=none; b=QY7vj6cx4OL/0TLe8BH6QoVQ/vA/+uc/LIAoJdu0jn8UJprNQCGAXErtz4/gZ5ICuVjjkzIldXB6ztPrH63ZLUwK0s216cqaxYsoRkr5+TRdgudDLd0TcRgSwp66tvtpYQyyjuhL0geHyGczQ8PjdXqdMULMY6B9N4Uh7zSF1M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742008554; c=relaxed/simple;
	bh=6fauUqJf2RETc23o77eFJUZM9KoHAbkVXnkZpps4aeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vr/kw9Co9rP4ZOBBfZ+E+a1U9WxNojbTZuP632hz8RhMegurtKm+kdTUeKl+C2zzNiLxL9tTFsYgGyS7eYjDruhVNE7PrQE6Yl0H27gReTcqWbWHRtcNYGEFm1SsU+xM4dJe+iZOMr47pVOIfWJqTDMRi18WfxbF87b0ghYUYUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2decw82; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2decw82"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63672C4AF09;
	Sat, 15 Mar 2025 03:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742008553;
	bh=6fauUqJf2RETc23o77eFJUZM9KoHAbkVXnkZpps4aeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E2decw82ERVUEzB8Epa5JhaqLbgcc1DQ62K27AWM3sI24cuq7ab/oHUYAOyaeaVeO
	 DyO/eq/x02vrEAs5AO6qkep1I+c23m/ErHVJc9PdR8aTi4Vm1gKXsVk++/enmTOZzL
	 PfXL4lDeb3ncd8kZp4q4JZPIsNxwnRcp+4pAjVhCX3kBHnSt73WPzg0iKAi/z5VmVM
	 6EPr6WAHNMs1n6SN5zK7ckXH5fvLEkIpp1c8j4V9a78aXVRYdrcOprDEXCqBzQXav0
	 JhIc25qskgxIcD/Sci/GNzgWeROVwxSnl49e9YSF9DvCeZ3g7UTKG+PvUDHYk+q2Th
	 3IzrZEf3KOWoA==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Marco Elver <elver@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-hardening@vger.kernel.org,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v4 1/2] compiler_types: Introduce __flex_counter() and family
Date: Fri, 14 Mar 2025 20:15:44 -0700
Message-Id: <20250315031550.473587-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250315025852.it.568-kees@kernel.org>
References: <20250315025852.it.568-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5026; i=kees@kernel.org; h=from:subject; bh=6fauUqJf2RETc23o77eFJUZM9KoHAbkVXnkZpps4aeQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDOlXPjxIjE73nBMiZa7s/XPC1yVaSm9P+sa7ZV2RO7f5t a8Xh2JDRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwER47zEyXPnkmFQj8EN7XpBd S/CzJB4flnDzcxIKSU68Z0Trp794yciw4O+FVc8Sa16bfLbtOyMnFXRT84Tq+jTPKYlF5/azia1 kAgA=
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
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Marco Elver <elver@google.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-hardening@vger.kernel.org
---
 include/linux/compiler_types.h | 31 +++++++++++++++++++++++++++++
 include/linux/overflow.h       | 36 ++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 981cc3d7e3aa..8b45ecfad5b1 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -453,6 +453,37 @@ struct ftrace_likely_data {
 #define __annotated(var, attr)	(false)
 #endif
 
+/*
+ * Optional: only supported since gcc >= 15, clang >= 19
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html#index-_005f_005fbuiltin_005fcounted_005fby_005fref
+ * clang: https://github.com/llvm/llvm-project/pull/102549
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
index 0c7e3dcfe867..e2b81cb5576e 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -440,4 +440,40 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 #define DEFINE_FLEX(TYPE, NAME, MEMBER, COUNTER, COUNT)	\
 	_DEFINE_FLEX(TYPE, NAME, MEMBER, COUNT, = { .obj.COUNTER = COUNT, })
 
+/**
+ * typeof_flex_counter() - Return the type of the counter variable of a given
+ *                         flexible array member annotated by __counted_by().
+ * @FAM: Pointer to the flexible array member within a given struct.
+ *
+ * Returns "size_t" if no annotation exists.
+ */
+#define typeof_flex_counter(FAM)				\
+	typeof(_Generic(__flex_counter(FAM),			\
+			void *: (size_t)0,			\
+			default: *__flex_counter(FAM)))
+
+/** can_set_flex_counter() - Check if the counter associated with the given
+ *                           flexible array member can represent a value.
+ * @FAM: Pointer to the flexible array member within a given struct.
+ * @COUNT: Value to check against the __counted_by annotated @FAM's counter.
+ */
+#define can_set_flex_counter(FAM, COUNT)			\
+	(!overflows_type(COUNT, typeof_flex_counter(FAM)))
+
+/**
+ * set_flex_counter() - Set the counter associated with the given flexible
+ *                      array member that has been annoated by __counted_by().
+ * @FAM: Pointer to the flexible array member within a given struct.
+ * @COUNT: Value to store to the __counted_by annotated @FAM's counter.
+ *
+ * This is a no-op if no annotation exists. Count needs to be checked with
+ * can_set_flex_counter(FAM, COUNT) before using this function.
+ */
+#define set_flex_counter(FAM, COUNT)				\
+({								\
+	*_Generic(__flex_counter(FAM),				\
+		  void *:  &(size_t){ 0 },			\
+		  default: __flex_counter(FAM)) = (COUNT);	\
+})
+
 #endif /* __LINUX_OVERFLOW_H */
-- 
2.34.1

