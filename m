Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B9D145FF5;
	Wed,  7 Aug 2024 23:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723074887; cv=none; b=J4v6Ip195NrAUEy1Tvb/rvh6D1j3nffAkJbaIUJCEjexfgwibI9obFjtMdjUM516gcLVdCQt2QwQ/hY+7n04OglhmPXv6X7Bmnq+CX7YfbZYRDVQXgdReHAyzJGBMenzu36gPlZe38E90jzivVMri4Pi7h9/AH3JfkD4tmWFA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723074887; c=relaxed/simple;
	bh=NAdP41DihZcu/8i1gtQGWAr6Z7t9lMz25DMefhKAAk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y/O/14dx86YsdrRLzxHYvwjtMSZXzrq4k6lMN2c18yh9f2lPxFmhSa3uX50jo1aGnR/0Ok72YPnW8/J+wxOlKmJuAEUGXq92ekWWety2hPPZz9piKa8aa3AtrRTfSOJBaEV+3A94jDgABlI8762DbI5dafZRQY6KRIv21kOE9HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLqJnFlQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLqJnFlQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB59C32781;
	Wed,  7 Aug 2024 23:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723074886;
	bh=NAdP41DihZcu/8i1gtQGWAr6Z7t9lMz25DMefhKAAk4=;
	h=From:To:Cc:Subject:Date:From;
	b=HLqJnFlQYbwjfw6dPy4VIL14sLtSjr8Q/FcP/JtJdHSMObinDUxv2v0YUTuSgiZef
	 by/s9PRL47Pnka7rPzHhdIVE6jkaJwcmW7wRqCBOt4SkKBxnChP2cMp+jwgnn6/xmj
	 L+Kn1LEac/ttW6611/R6bAQ5zDl0SGodi1i3ucBNh4YIl2yV4ZJgUbE1AkdWcmqXWu
	 BO8D8ZrWtnIwUDCSHFYjmbRrQMOqg8NE0+zS2j5Dyml0HfaUu3WnpQt1Qfqy0pHI7B
	 gOERu64lbIe9LUKt7Q+4A97JpqujBE4ZIESrqceFcYcPekGvhv7wultNOttFFELkMJ
	 EHn0hzJzIfUEA==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jann Horn <jannh@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marco Elver <elver@google.com>,
	linux-mm@kvack.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] slab: Introduce kmalloc_obj() and family
Date: Wed,  7 Aug 2024 16:54:41 -0700
Message-Id: <20240807235433.work.317-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4691; i=kees@kernel.org; h=from:subject:message-id; bh=NAdP41DihZcu/8i1gtQGWAr6Z7t9lMz25DMefhKAAk4=; b=owGbwMvMwCVmps19z/KJym7G02pJDGlbOB2V2i0e3zKTabc8yFu/afqs6TNiFY1a974NtLgQY 2Jw69+bjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIl85mX4n3J2k8ahi90ss3Uu 5xn4+G3f9XjPqvN7cxIcbSoO1hwo+MfIsLHuLUtUdnzjqRVf5U0vHElhPyfJMkXxsvpvxnvnWvv F2QA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Introduce type-aware kmalloc-family helpers to replace the common
idioms for single, array, and flexible object allocations:

	ptr = kmalloc(sizeof(*ptr), gfp);
	ptr = kcalloc(count, sizeof(*ptr), gfp);
	ptr = kmalloc_array(count, sizeof(*ptr), gfp);
	ptr = kcalloc(count, sizeof(*ptr), gfp);
	ptr = kmalloc(struct_size(ptr, flex_member, count), gfp);

These become, respectively:

	kmalloc_obj(p, gfp);
	kzalloc_obj(p, count, gfp);
	kmalloc_obj(p, count, gfp);
	kzalloc_obj(p, count, gfp);
	kmalloc_obj(p, flex_member, count, gfp);

These each return the size of the allocation, so that other common
idioms can be converted easily as well. For example:

	info->size = struct_size(ptr, flex_member, count);
	ptr = kmalloc(info->size, gfp);

becomes:

	info->size = kmalloc_obj(ptr, flex_member, count, gfp);

Internal introspection of allocated type also becomes possible, allowing
for alignment-aware choices and future hardening work. For example,
adding __alignof(*ptr) as an argument to the internal allocators so that
appropriate/efficient alignment choices can be made, or being able to
correctly choose per-allocation offset randomization within a bucket
that does not break alignment requirements.

Additionally, once __builtin_get_counted_by() is added by GCC[1] and
Clang[2], it will be possible to automatically set the counted member of
a struct with a counted_by FAM, further eliminating open-coded redundant
initializations, and can internally check for "too large" allocations
based on the type size of the counter variable:

	if (count > type_max(ptr->flex_count))
		fail...;
	info->size = struct_size(ptr, flex_member, count);
	ptr = kmalloc(info->size, gfp);
	ptr->flex_count = count;

becomes (i.e. unchanged from earlier example):

	info->size = kmalloc_obj(ptr, flex_member, count, gfp);

Replacing all existing simple code patterns found via Coccinelle[3]
shows what could be replaced immediately (saving roughly 1,500 lines):

 7040 files changed, 14128 insertions(+), 15557 deletions(-)

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=116016 [1]
Link: https://github.com/llvm/llvm-project/issues/99774 [2]
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/kmalloc_obj-assign-size.cocci [3]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Marco Elver <elver@google.com>
Cc: linux-mm@kvack.org
---
 include/linux/slab.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index eb2bf4629157..46801c28908e 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -686,6 +686,44 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
 }
 #define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
 
+#define __alloc_obj3(ALLOC, P, COUNT, FLAGS)			\
+({								\
+	size_t __obj_size = size_mul(sizeof(*P), COUNT);	\
+	void *__obj_ptr;					\
+	(P) = __obj_ptr = ALLOC(__obj_size, FLAGS);		\
+	if (!__obj_ptr)						\
+		__obj_size = 0;					\
+	__obj_size;						\
+})
+
+#define __alloc_obj2(ALLOC, P, FLAGS)	__alloc_obj3(ALLOC, P, 1, FLAGS)
+
+#define __alloc_obj4(ALLOC, P, FAM, COUNT, FLAGS)		\
+({								\
+	size_t __obj_size = struct_size(P, FAM, COUNT);		\
+	void *__obj_ptr;					\
+	(P) = __obj_ptr = ALLOC(__obj_size, FLAGS);		\
+	if (!__obj_ptr)						\
+		__obj_size = 0;					\
+	__obj_size;						\
+})
+
+#define kmalloc_obj(...)					\
+	CONCATENATE(__alloc_obj,				\
+		    COUNT_ARGS(__VA_ARGS__))(kmalloc, __VA_ARGS__)
+
+#define kzalloc_obj(...)					\
+	CONCATENATE(__alloc_obj,				\
+		    COUNT_ARGS(__VA_ARGS__))(kzalloc, __VA_ARGS__)
+
+#define kvmalloc_obj(...)					\
+	CONCATENATE(__alloc_obj,				\
+		    COUNT_ARGS(__VA_ARGS__))(kvmalloc, __VA_ARGS__)
+
+#define kvzalloc_obj(...)					\
+	CONCATENATE(__alloc_obj,				\
+		    COUNT_ARGS(__VA_ARGS__))(kvzalloc, __VA_ARGS__)
+
 #define kmem_buckets_alloc(_b, _size, _flags)	\
 	alloc_hooks(__kmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), _flags, NUMA_NO_NODE))
 
-- 
2.34.1

