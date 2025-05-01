Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09581EE7C6;
	Thu,  1 May 2025 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746138228; cv=none; b=SCLHBopRL2Plw2UZc6mTrQceUkEjKXZ0xjJgyV9dMCG7RQg8zfsgLPc6mf3zL5KaynqGz1W3fhmS19/Ngg4dtzV2loviPYwVGSFpsNgnR9KJf6xd/Ud+n4wfL9ivq87QxFxbkTKwpQwCs5zgxj7jjvpuYTtzn+yBWviaSuCVTPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746138228; c=relaxed/simple;
	bh=Xr0UNUZ/sqe45TGg5XtfrsHnkuPA3WPs3QNO9Gzg4nM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ziidrr1sMTs9R234XFouHrxV+ezB/z0qKYo2xRBSkguIQW5HSTJ2drQAuJDBdF162Jg7cNUZItNHLtlH+vAXPjA7oAfaZ0g0qIQH3fbDt1VEUwwiZ44Xc2NlfRWQrcijNopAYiqYAW4rzliu+1EW0/9xcMe7V7KC86RQsiE2tZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCpqLBnQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCpqLBnQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7F4C4CEE3;
	Thu,  1 May 2025 22:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746138227;
	bh=Xr0UNUZ/sqe45TGg5XtfrsHnkuPA3WPs3QNO9Gzg4nM=;
	h=Date:From:To:Cc:Subject:From;
	b=bCpqLBnQcYJ1beLK0yL0iKgkexzuvL6vQ3gLOE4wR/TMyLfJwJYGA41BCvrEhKutH
	 stjnUT3/mkB3o9i5qv08GZ8cRYhW/cZYUisNY8iLDxNqgTqH3FkgbaEkjQ2hZV+zBk
	 BxpFVeJ0MtQccfsQcsSU7j4NRkryLHij0vJKLpIqgKN8BAGcvnkh7nOqwC3HN7zcZn
	 GStaniC1pgVcWfdJ9Sv8z6eekdlb87PuoHqT5NCq6MbpaasU66im0Eyv4gcHrKaxUD
	 5dHZm+zj62bRvaSVFODQ1EaWO+X6Rif+ZEofompAQM9rPrfB+EjBg3eoYaBSNFoWKe
	 qI0uNOqcguHXA==
Date: Thu, 1 May 2025 16:23:43 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH v2][next] overflow: Fix direct struct member initialization
 in _DEFINE_FLEX()
Message-ID: <aBP0b3gfurLFDlwY@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Currently, to statically initialize the struct members of the `type`
object created by _DEFINE_FLEX(), the internal object `obj` must be
explicitly referenced at the call site. See:

struct flex {
        int a;
        int b;
        struct foo flex_array[];
};

_DEFINE_RAW_FLEX(struct flex, instance, flex_array,
                 FIXED_SIZE, = {
                        .obj = {
                                .a = 13,
                                .b = 37,
                        },
                });

This leaks _DEFINE_FLEX() internal implementation details and make
the helper harder to use and read.

Fix this and allow for a more natural and intuitive C99 init-style:

_DEFINE_RAW_FLEX(struct flex, instance, flex_array,
                 FIXED_SIZE, = {
                        .a = 13,
                        .b = 37,
                });

Note that before these changes, the `initializer` argument was optional,
but now it's required.

Also, update "counter" member initialization in DEFINE_FLEX().

Fixes: 26dd68d293fd ("overflow: add DEFINE_FLEX() for on-stack allocs")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Update kernel-doc block for _DEFINE_FLEX(). (Kees)
 - Update changelog text - `initializer` argument is now required.

v1:
 - Link: https://lore.kernel.org/linux-hardening/aBK2TUEeQfCFop9Y@kspp/

 include/linux/overflow.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 69533e703be5..b50c8b30a14a 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -396,7 +396,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * @name: Name for a variable to define.
  * @member: Name of the array member.
  * @count: Number of elements in the array; must be compile-time const.
- * @initializer: initializer expression (could be empty for no init).
+ * @initializer: Initializer expression (e.g., pass `= { }` at minimum).
  */
 #define _DEFINE_FLEX(type, name, member, count, initializer...)			\
 	_Static_assert(__builtin_constant_p(count),				\
@@ -404,7 +404,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 	union {									\
 		u8 bytes[struct_size_t(type, member, count)];			\
 		type obj;							\
-	} name##_u initializer;							\
+	} name##_u = { .obj initializer };					\
 	type *name = (type *)&name##_u
 
 /**
@@ -444,7 +444,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * elements in array @member.
  */
 #define DEFINE_FLEX(TYPE, NAME, MEMBER, COUNTER, COUNT)	\
-	_DEFINE_FLEX(TYPE, NAME, MEMBER, COUNT, = { .obj.COUNTER = COUNT, })
+	_DEFINE_FLEX(TYPE, NAME, MEMBER, COUNT, = { .COUNTER = COUNT, })
 
 /**
  * STACK_FLEX_ARRAY_SIZE() - helper macro for DEFINE_FLEX() family.
-- 
2.43.0

