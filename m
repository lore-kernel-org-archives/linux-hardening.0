Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA312F2E;
	Fri,  2 May 2025 00:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746146694; cv=none; b=o54sX3a21zTHx5Kkgr49GIUKi0rHK5LTqhROIoJWFX5sPzojUwI0YcDeLHTZI+GZooafZmjQEhHo6B/krWWjWmttyNlH6nOyz5Pb96+yjx6c2qgm8HZkL1+JBTQTPF9UWJmAVdUCvqbX9nBAHfHHwhZNdOJSnpJhvO9syB3jeGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746146694; c=relaxed/simple;
	bh=I9YnlpZ7nYw/byrY2ZMUf792m/wnT2mUUf7KIelZxbY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jl1DKLFEazSveRPvkr40YcnQAaHytJliU3khbkPb/T+kdpoUdhqcqGi5r0wdlWd46y0b1qe7Yi7+5q4XtlpQrUxTFZPKMV2TCY33CTa+EGip715WJzmbK/LTTM69LBdz9qLKthkUBGa1dOYMKU+8Pqb8v9gVUsPd5EBcDQ0RlE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6MmL330; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6MmL330"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20679C4CEE3;
	Fri,  2 May 2025 00:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746146694;
	bh=I9YnlpZ7nYw/byrY2ZMUf792m/wnT2mUUf7KIelZxbY=;
	h=Date:From:To:Cc:Subject:From;
	b=h6MmL3302zkA+VMyeHxvFjJxJSaXlRLKplJSkPSr8AeN1YoVBuuDXRb3xMVboQb4v
	 5EJhVFfESa2NSwAK2wI0bO1a0Td97OheDrsGsgDP/RuR7ZZ1O96mf9buyXujPCkmjd
	 JHI3TYWwj5fBJlpXpDIKXn6I/ylhMTko1lTAgRBLNsatloZTvQi1R+BXtHuW6eTytY
	 prSNvpgF3tEtOGWroSYtaheJbqj9gbxHNXvPrZP2Z4Ge9GcNRGdf+rATgtJkQ2Ef7X
	 NXtkOLQ+2hvTMEJ4Kmbjb1SWGTIvFGi4J67GfgM0nKBZ8GWqQBE5ZeScEmG8VP95dj
	 LIiIfXv/+DQPA==
Date: Thu, 1 May 2025 18:44:43 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH v3][next] overflow: Fix direct struct member initialization
 in _DEFINE_FLEX()
Message-ID: <aBQVeyKfLOkO9Yss@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Currently, to statically initialize the struct members of the `type`
object created by _DEFINE_FLEX(), the internal `obj` member must be
explicitly referenced at the call site. See:

struct flex {
        int a;
        int b;
        struct foo flex_array[];
};

_DEFINE_FLEX(struct flex, instance, flex_array,
                 FIXED_SIZE, = {
                        .obj = {
                                .a = 0,
                                .b = 1,
                        },
                });

This leaks _DEFINE_FLEX() internal implementation details and make
the helper harder to use and read.

Fix this and allow for a more natural and intuitive C99 init-style:

_DEFINE_FLEX(struct flex, instance, flex_array,
                 FIXED_SIZE, = {
                        .a = 0,
                        .b = 1,
                });

Note that before these changes, the `initializer` argument was optional,
but now it's required.

Also, update "counter" member initialization in DEFINE_FLEX().

Fixes: 26dd68d293fd ("overflow: add DEFINE_FLEX() for on-stack allocs")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - Fix changelog text: s/_DEFINE_RAW_FLEX/_DEFINE_FLEX

Changes in v2:
 - Update kernel-doc block for _DEFINE_FLEX(). (Kees)
 - Update changelog text - `initializer` argument is now required.
 - Link: https://lore.kernel.org/all/aBP0b3gfurLFDlwY@kspp/

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

