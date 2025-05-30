Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544DE23E35B;
	Fri, 30 May 2025 19:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748632403; cv=none; b=ZqXOxHNPG9UN1HDMJq3rPeC2GrihAm4SWoP9iHFznvGgt36qknZSTwTb+YuTk9nNGBR0hdDduA3Fi04q4zFks7S7Ih1VFPoKdvf5ambbPnRnxs4lfWzZ1ggMaBPnSWozPp1jrZXA4QpwCm+kLl5CXkENl5dLJRKm22LI2PxM8j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748632403; c=relaxed/simple;
	bh=HzXJ6AEdcwmvBWA+PgiZUgeoUUm0HSXNmXjkxF0eRDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qAzM73JnAnQi6R+Awm383fZyWa7tT4llafQNrUoh11BT9fWPMEfdTxOVsVAp6s/MCcmB4Hh+xcqUfg1H6NRG2Swmuth+ughNv+9mnvI4dWr5FawAczU0JfkdQdJWnjXCvRelgWCye4/arZgim+AMrrDYY5uSALzxYRF0XTbvSXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fviMXFQc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fviMXFQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0918C4CEE9;
	Fri, 30 May 2025 19:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748632402;
	bh=HzXJ6AEdcwmvBWA+PgiZUgeoUUm0HSXNmXjkxF0eRDs=;
	h=From:To:Cc:Subject:Date:From;
	b=fviMXFQcF4MiK9d/GhA2R0n7qXLFOkB6Asvr2RQbBkaxooffdv6uQfNwK3kRfwWdQ
	 U5ZCv29xdRC9gpGAIQh8m+ijqkoAKWExmp1LwKIfI+tQSljPQjqtV0uHxQMybs2UYs
	 PRbACuaFNs+kuq8sDYL4CsGWdspnTuVHADXP8PqC2rRsVX/lJMz3IPmonK7eRGn2Wy
	 sqTL8qXdTAzgdGY8MzCpMDlGC8i/Qp0cjb6g0VqC2izrLGooqxsls/PwclBtOAMgWW
	 VWhmfuYKQ1NdtB4JkCTvD3wLYJXc+wffeKfNpNIpl4bJzb1A4lOeSrYmqq+zG2Dm3D
	 WYUyVEY+DbMlw==
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] overflow: Introduce __DEFINE_FLEX for having no initializer
Date: Fri, 30 May 2025 12:13:16 -0700
Message-Id: <20250530191312.work.661-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3412; i=kees@kernel.org; h=from:subject:message-id; bh=HzXJ6AEdcwmvBWA+PgiZUgeoUUm0HSXNmXjkxF0eRDs=; b=owGbwMvMwCVmps19z/KJym7G02pJDBlWzD5z+qurGts6rTnDZWRjXaW6lAvq/x3stV/9qXX31 X97lb91lLIwiHExyIopsgTZuce5eLxtD3efqwgzh5UJZAgDF6cATIRhNiPDxePxP45c09Kvi/X0 Vr8Wubr2h0bdq+WHeZ3WicabWZyoZWRoTtgfn9/p7Lrfb6LsbqPbD3Oy2rYufXf4Q/5ev9ATwd1 8AA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

While not yet in the tree, there is a proposed patch[1] that was
depending on the prior behavior of _DEFINE_FLEX, which did not have an
explicit initializer. Provide this via __DEFINE_FLEX now, which can also
have attributes applied (e.g. __uninitialized).

Examples of the resulting initializer behaviors can be seen here:
https://godbolt.org/z/P7Go8Tr33

Link: https://lore.kernel.org/netdev/20250520205920.2134829-9-anthony.l.nguyen@intel.com [1]
Fixes: 47e36ed78406 ("overflow: Fix direct struct member initialization in _DEFINE_FLEX()")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: <linux-hardening@vger.kernel.org>
---
 include/linux/overflow.h | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 7b7be27ca113..154ed0dbb43f 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -389,24 +389,37 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 	struct_size((type *)NULL, member, count)
 
 /**
- * _DEFINE_FLEX() - helper macro for DEFINE_FLEX() family.
- * Enables caller macro to pass (different) initializer.
+ * __DEFINE_FLEX() - helper macro for DEFINE_FLEX() family.
+ * Enables caller macro to pass arbitrary trailing expressions
  *
  * @type: structure type name, including "struct" keyword.
  * @name: Name for a variable to define.
  * @member: Name of the array member.
  * @count: Number of elements in the array; must be compile-time const.
- * @initializer: Initializer expression (e.g., pass `= { }` at minimum).
+ * @trailer: Trailing expressions for attributes and/or initializers.
  */
-#define _DEFINE_FLEX(type, name, member, count, initializer...)			\
+#define __DEFINE_FLEX(type, name, member, count, trailer...)			\
 	_Static_assert(__builtin_constant_p(count),				\
 		       "onstack flex array members require compile-time const count"); \
 	union {									\
 		u8 bytes[struct_size_t(type, member, count)];			\
 		type obj;							\
-	} name##_u = { .obj initializer };					\
+	} name##_u trailer;							\
 	type *name = (type *)&name##_u
 
+/**
+ * _DEFINE_FLEX() - helper macro for DEFINE_FLEX() family.
+ * Enables caller macro to pass (different) initializer.
+ *
+ * @type: structure type name, including "struct" keyword.
+ * @name: Name for a variable to define.
+ * @member: Name of the array member.
+ * @count: Number of elements in the array; must be compile-time const.
+ * @initializer: Initializer expression (e.g., pass `= { }` at minimum).
+ */
+#define _DEFINE_FLEX(type, name, member, count, initializer...)			\
+	__DEFINE_FLEX(type, name, member, count, = { .obj initializer })
+
 /**
  * DEFINE_RAW_FLEX() - Define an on-stack instance of structure with a trailing
  * flexible array member, when it does not have a __counted_by annotation.
@@ -424,7 +437,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * elements in array @member.
  */
 #define DEFINE_RAW_FLEX(type, name, member, count)	\
-	_DEFINE_FLEX(type, name, member, count, = {})
+	__DEFINE_FLEX(type, name, member, count, = { })
 
 /**
  * DEFINE_FLEX() - Define an on-stack instance of structure with a trailing
-- 
2.34.1

