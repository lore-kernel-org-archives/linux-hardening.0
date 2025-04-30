Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E755E3D561;
	Wed, 30 Apr 2025 23:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746056786; cv=none; b=fcYeZukWQhss6PuFD2iKKvFyLwi2jJ/m8FeZOPgpayebO2ozUfxaLBA+St4jATqt1dBFakU4fqJKFj8U6BOS6gXsM1Ofvni+EO8AN3j7BVUZuYI9hnRlAPNWDSIPpKBU+NxyQBgqnS8M+RlsjvcHxD3hNZg1TANlrMFL98qyb58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746056786; c=relaxed/simple;
	bh=ag4v8mPOKJ4KE3uAXjKPV01w+5GzpXiyNxIrjQkGTs4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CzJIe/yY4E1i5lWIXo3Y9M8fqeR2E2iyGcBPSw+9ElPgbTDTicKZ/fu+sOGHDOYW9ymUR/E4QWhXVwsz/wu4ig2CGX0shd2bM9LEk42sbzcow2hynTP8/qAMviBIf/lykdK4DWRSP2akLePHGAK82SJmXdEU2agdZfNGDGQPxdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqINPp+1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqINPp+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602C2C4CEE7;
	Wed, 30 Apr 2025 23:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746056785;
	bh=ag4v8mPOKJ4KE3uAXjKPV01w+5GzpXiyNxIrjQkGTs4=;
	h=Date:From:To:Cc:Subject:From;
	b=KqINPp+1XSlQnZ7XPsBYydoVksJCGTH441fSEJGBjMQYn4b3oyXg6uUhst1YxllTJ
	 /3gLbgI7KO9kgJweooY4NZ6aPyJNCZooeCTYGH5xn8msAhFZK2igUrFdAGgAKGVcIW
	 qTEV/FZFG520gOYGOtYRJQTfYnW0EgeMY2rdVqfpgnJo1ICLbvrDuVVRL8bXCRsjyW
	 Kj+RpEVsQ/yVcf0a3J9l/9D1bj8WsXNJ+pqVAtLZr7az0bXfTkwuGn0uMYYlVrozix
	 1RkO86AzNbmoEZ0mfqATstCEoiowg8kgaILkY4kAzXhfMy74krCgY03ebGkJj693iM
	 yFMshz4e/kTyw==
Date: Wed, 30 Apr 2025 17:46:21 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] overflow: Fix direct struct member initialization in
 _DEFINE_FLEX()
Message-ID: <aBK2TUEeQfCFop9Y@kspp>
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

Also, update "counter" member initialization in DEFINE_FLEX().

Fixes: 26dd68d293fd ("overflow: add DEFINE_FLEX() for on-stack allocs")
Link: https://lore.kernel.org/linux-hardening/c4828c41-e46c-43c9-a73a-38ce8ab2c1c4@embeddedor.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/overflow.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 69533e703be5..170d3cfe7ecc 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
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

