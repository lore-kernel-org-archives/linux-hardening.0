Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE94D381AFF;
	Sat,  9 May 2026 03:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778297326; cv=none; b=hBwMiIuJKoqefGu9dE/0NFPmSaTIpbfAkJun6tRFA5O+zIwIkEB7/46aI5JHIDShiQ5nlLIg2hyW8e8v9W4Pjj3sWDbVVNsEjHKH4PeUOvc3pY3WEIL/cM2HWgM8Ae9suVz75z5oSDvdgN3bq3/BE08A2CJhUvr1HFBCgg5XOmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778297326; c=relaxed/simple;
	bh=imYWbFyLism7kfVJrqxg5opLuNGgNjD7c1knO+Nknas=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hus+3MiKykx5U/QFQGIkG8Sp8DwYOUdOZrEm2W0VBcLUSPZi/kdsNiYpUnIm1TBfxDoXxVinNXJpNnoL+Vu6fF/rSFd+hy9O2GVtC+ylc9rJgK93xyz5pzc0rJ+ZeaF3AiyEkIN1b3mc4qDQIgNWpmvixqHxkeOZbpgqgRlD7iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bnp6jaBl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bnp6jaBl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA8FC2BCB0;
	Sat,  9 May 2026 03:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778297326;
	bh=imYWbFyLism7kfVJrqxg5opLuNGgNjD7c1knO+Nknas=;
	h=Date:From:To:Cc:Subject:From;
	b=Bnp6jaBl54RKWeLqgkHySc2fw7fNDUP0cpzNvpIeektzSKcXX0kQc1jTqagqlBsUl
	 B+47MwWYhJ9llUwIx1M3G3h9SXrZeA0AWhlenspZWO8T/n+anQWk0oOIP75ARbSBQm
	 tdPZ3/npiL5BfkZk8cVUghRf/wcAsWnr69wH5ZK3t4xp4nCq6ZcEklezaDux4RsdSl
	 ANa/TB0E6ANc8zHn6efehILbwlp4npvYIXrKBH6IbxfYsFu+2enOszjt1m+5pp7iGz
	 Qk+igvkBCUmnWRCddkZUwOH+W1QnDg+cKVVIQdkkOHbGrw0Hvtm7vsOhwPxsBpgYxC
	 dos659gGVs36Q==
Date: Fri, 8 May 2026 21:28:43 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] stddef: Document designated initializer semantics for
 __TRAILING_OVERLAP()
Message-ID: <af6p68531gNsTM5U@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Document the designated initializer behavior for overlapping storage
between NAME and MEMBERS, and clarify the implications for static
initialization to help avoid unintended overwrites.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/stddef.h | 56 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 80b6bfb944f0..36c91c725546 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -100,6 +100,62 @@ enum {
  * Creates a union between a flexible-array member (FAM) in a struct and a set
  * of additional members that would otherwise follow it.
  *
+ * Beware that, as this helper encloses TYPE NAME and MEMBERS in the same
+ * union, designated initializers for MEMBERS may overwrite portions
+ * previously initialized through NAME.
+ *
+ * For example:
+ *
+ * struct flex {
+ *	size_t count;
+ *	u8 fam[];
+ * };
+ *
+ * struct composite {
+ *	...
+ *	__TRAILING_OVERLAP(struct flex, flex, fam, __packed,
+ *		u8 data;
+ *	);
+ * } __packed;
+ *
+ * static struct composite comp = {
+ *	.flex = {
+ *		.count = 1,
+ *	},
+ *	.data = 2,
+ * };
+ *
+ * In the example above, .flex and .data initialize different views of the same
+ * union storage. Since .data is initialized last, it _may_ overwrite portions
+ * previously initialized through .flex, leading to .flex.count being zeroed
+ * out.
+ *
+ * A couple of alternatives are show below.
+ *
+ * Initialize only one view of the overlapped storage and assign the rest
+ * at run time:
+ *
+ * static struct composite comp = {
+ *	.flex = {
+ *		.count = 1,
+ *	},
+ * };
+ *
+ * static void foo(void)
+ * {
+ *	comp.data = 2;
+ *	...
+ * }
+ *
+ * (Compiler Explorer test code: https://godbolt.org/z/zz4K1Ejvf)
+ *
+ * Alternatively, move the entire initialization to run time.
+ *
+ * For an example of stack-based inialization see commit 5e54510a9389
+ * ("acpi: nfit: intel: avoid multiple -Wflex-array-member-not-at-end warnings")
+ *
+ * Link: https://git.kernel.org/linus/5e54510a9389caa9
+ *
  * @TYPE: Flexible structure type name, including "struct" keyword.
  * @NAME: Name for a variable to define.
  * @FAM: The flexible-array member within @TYPE
-- 
2.51.0

