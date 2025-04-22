Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505AD2980A0;
	Tue, 22 Apr 2025 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745342499; cv=none; b=Il5M31Ru9m1ISW4DnRBJQFKW8tZPlsGKaUiMf47Q9uP46ssWgQ7aazIjqfOa5uqf7QEIA4fEIw4v49rdpKoYPHMxiR8xO9wY4CLTRar/EAqoUU/Xatpdlf3mpbO3bQDjxWrd0HsIW2/uyWJFKrmIZS7IP9rRxoeB4KKuFAfjMJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745342499; c=relaxed/simple;
	bh=q6Iu6iCIREXhZUWduhe7aRN+4iwB309Pe4IIIyb+U2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pkth0cDVkQWZ6BePirjzhNU+Jb5HvpwBljLOBJ/BkDC1ue14tdbHEbYytstP40/SzKOt1AbEGs33wtpv+vNF0etOnh5FFgy4LnsMZbqLmkqi7S5mQT2r7EzKvn/ADhgK6aSgJqJIQnLMCc/4RNdoPowTghpkSlFDb+RzB7BiOzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZYiddYw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZYiddYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4256FC4CEE9;
	Tue, 22 Apr 2025 17:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745342498;
	bh=q6Iu6iCIREXhZUWduhe7aRN+4iwB309Pe4IIIyb+U2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZYiddYwQBvmjiZoyf7o74oTErBjdSsZU+n6RpG7t29mFi1heap6hLT80OA5DH9Ma
	 S/q7evet8cs2lczVvTsyKu8ZVPLpRSdYToaFnlL3MdQIBjSuCGc18oEzuO4/Js1xX1
	 W4s0rY0e6v3uXCZmSsSucUpgOiqy0v92e6WCQEGiAnUuCIXSy2pEjmv5AMa30y4cMZ
	 l3WyGcuBbVHVpYsqa1xxDKLFUUR2nk26LsoGnm0h1YaC8yfS+V56KBKV6MmWbErl1X
	 1lyTmB2THDLJ/ifheIwNf62v7OY9n/pTCuFKTNX+8V3iX9CG8P5QW/AkJ9YarwUveN
	 +YJzP53IwN6Iw==
Date: Tue, 22 Apr 2025 11:21:36 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2][next] overflow: Add STACK_FLEX_ARRAY_SIZE() helper
Message-ID: <8f9ab8fcd26ce59c0e0e25e095b446a77849c08e.1745342381.git.gustavoars@kernel.org>
References: <cover.1745342381.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1745342381.git.gustavoars@kernel.org>

Add new STACK_FLEX_ARRAY_SIZE() helper to get the size of a
flexible-array member defined using DEFINE_FLEX()/DEFINE_RAW_FLEX()
at compile time.

This is essentially the same as ARRAY_SIZE() but for on-stack
flexible-array members.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/overflow.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 6ee67c20b575..5b2e0cc9aba2 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -420,6 +420,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * flexible array member.
  * Use __struct_size(@name) to get compile-time size of it afterwards.
  * Use __member_size(@name->member) to get compile-time size of @name members.
+ * Use STACK_FLEX_ARRAY_SIZE(@name, @member) to get compile-time size of array @member.
  */
 #define DEFINE_RAW_FLEX(type, name, member, count)	\
 	_DEFINE_FLEX(type, name, member, count, = {})
@@ -438,8 +439,20 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * flexible array member.
  * Use __struct_size(@NAME) to get compile-time size of it afterwards.
  * Use __member_size(@NAME->member) to get compile-time size of @NAME members.
+ * Use STACK_FLEX_ARRAY_SIZE(@name, @member) to get compile-time size of array @member.
  */
 #define DEFINE_FLEX(TYPE, NAME, MEMBER, COUNTER, COUNT)	\
 	_DEFINE_FLEX(TYPE, NAME, MEMBER, COUNT, = { .obj.COUNTER = COUNT, })
 
+/**
+ * STACK_FLEX_ARRAY_SIZE() - helper macro for DEFINE_FLEX() family.
+ * Returns the number of elements in @array.
+ *
+ * @name: Name for a variable defined in DEFINE_RAW_FLEX()/DEFINE_FLEX().
+ * @array: Name of the array member.
+ */
+#define STACK_FLEX_ARRAY_SIZE(name, array)						\
+	(__member_size((name)->array) / sizeof(*(name)->array) +			\
+						__must_be_array((name)->array))
+
 #endif /* __LINUX_OVERFLOW_H */
-- 
2.43.0

