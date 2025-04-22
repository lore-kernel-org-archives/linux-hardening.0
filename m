Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1507E2D3A86;
	Tue, 22 Apr 2025 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745355922; cv=none; b=I+j2tC4DuQR/gcmc3DDNMaAp/7ObZbD3tlTzr9t9LW3OluF43hp5vRdIKrmtIfYRe0SAGC9T4cOezUJbCNH3R1JO4Oh8jOXQE2CL1/hktNqLzZ8cnxAuOokQp+d0zS4sE3dupInOBKvCYRH8bFofVLqjAq/GDJnEfgqAlwJMICQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745355922; c=relaxed/simple;
	bh=QewQgT4zxjt168k0wJQ0OCYW49XgLV/VkID/jwaA6ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ex1oqbld4dGE/xy1w6qk5fnoosS020w75nHDjpNb40O/mRB32oEKLN173OWOCqzIlefPdckG2KiHyl79RxDReY8McMopP/7TWIkAbR3ZgdrnovR6WnzRRIjvYmD04jSxV7AKJ9mXRpE7CI5X3T6VcZMY8b2crQHeEdwN3mro+Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGbBmwGl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGbBmwGl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1904FC4CEED;
	Tue, 22 Apr 2025 21:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745355921;
	bh=QewQgT4zxjt168k0wJQ0OCYW49XgLV/VkID/jwaA6ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sGbBmwGlPYn3e0D0/BRhlnZ5b2jTLkmKgupV0fZH5NxO11qJT17bbcEG4ZFYCNr4T
	 //tsqPnNhkMboYw+u8ZhPmz+sLwJi+5M3QyUNMYxGNG7p2mviVhacWxr4Gv+aEWgdA
	 koafPw613f7FHSRmOCZ6BSNBV1A2zgkUgfwP6DSC56rplZf1emW/cpZpeLznPx1Hdb
	 L014OWOuLblLF7q+u/JQcKoHgW3v8doUjklsOgTkKZxxcaMxY/uuPQrSK7vjmPf6kh
	 j2L+vkNWuran0Ce2H4taUBD2F+yGFTXRMZ2MedoLpygQs28xOkJYPwFeG49w3igBOQ
	 KFUWVW1kDZPHw==
Date: Tue, 22 Apr 2025 15:05:18 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2][next] overflow: Add STACK_FLEX_ARRAY_SIZE() helper
Message-ID: <83d53744e11c80eb3f03765238cbe648855f4168.1745355442.git.gustavoars@kernel.org>
References: <cover.1745355442.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1745355442.git.gustavoars@kernel.org>

Add new STACK_FLEX_ARRAY_SIZE() helper to get the size of a
flexible-array member defined using DEFINE_FLEX()/DEFINE_RAW_FLEX()
at compile time.

This is essentially the same as ARRAY_SIZE() but for on-stack
flexible-array members.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use "number of elements" instead of "size of" in kernel-doc blocks.

v1:
 - Link: https://lore.kernel.org/linux-hardening/8f9ab8fcd26ce59c0e0e25e095b446a77849c08e.1745342381.git.gustavoars@kernel.org/

 include/linux/overflow.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 6ee67c20b575..f33d74dac06f 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -420,6 +420,8 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * flexible array member.
  * Use __struct_size(@name) to get compile-time size of it afterwards.
  * Use __member_size(@name->member) to get compile-time size of @name members.
+ * Use STACK_FLEX_ARRAY_SIZE(@name, @member) to get compile-time number of
+ * elements in array @member.
  */
 #define DEFINE_RAW_FLEX(type, name, member, count)	\
 	_DEFINE_FLEX(type, name, member, count, = {})
@@ -438,8 +440,21 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * flexible array member.
  * Use __struct_size(@NAME) to get compile-time size of it afterwards.
  * Use __member_size(@NAME->member) to get compile-time size of @NAME members.
+ * Use STACK_FLEX_ARRAY_SIZE(@name, @member) to get compile-time number of
+ * elements in array @member.
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

