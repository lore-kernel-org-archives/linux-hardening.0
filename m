Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA9033D4E9;
	Sun, 10 May 2026 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778447434; cv=none; b=qmsZNXDQIbto/8E6caMxD4CYObe/HQj70S0DGchZVvmLfBO43AZ5ylxXTOXQYy8tiUxhFbvPcIuZ+tJZ3Pmx5h5CzcDilT7tB6P6Kn7IW5M3wFrAwmsDx5FpxeMCMbpsV1dtFSwNvakg/OuLIreU+Am/9x84dbIhDtWmLLtc7zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778447434; c=relaxed/simple;
	bh=mPNEZix8x1dfm+jDYOJGD8MkjI6F8K7kOIU+tWvfLRU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aJA2oxbq5qk5k+zxJIYsM4o2sLvsXaKJWet3L3OhwuGEqlwCgxRrpovWzt2oz2U7K+DMeCzvItxV7TihPRP3Zt/NNqm61c/yQevTwNFVG0Hcw58zLKUMmP2xvAo3jaed/QV70DNS+HSaUWP7N5e3TIMpp1JYW2kqTgUWXnX09eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GO1Yrowi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GO1Yrowi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4F0C2BCF6;
	Sun, 10 May 2026 21:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778447434;
	bh=mPNEZix8x1dfm+jDYOJGD8MkjI6F8K7kOIU+tWvfLRU=;
	h=Date:From:To:Cc:Subject:From;
	b=GO1YrowisMog6tFpp/TeklGarS5R4a2QwUo3e8ME9tcN3p5V6jNl1ILDLBBryULpw
	 Ng5DTJNim9VztYYXtSaSBWCJl0X1t0iJyg5QwIeOBFkLIU1ugM610UIgC276ivT6lI
	 Wne6EGfB9Y/wFRcYa4JOuNLxon0Bereg+QUQj7EpJ3Lus1cd5oV6a43uKiUyhh7pk2
	 FDXwcAqKdPuu4a9DRqlleu6dooPHWzkjyE611yaIneuPSJKUUfUY5QYHDtEFFBUCmY
	 lUap1B0Uf8yRlpmrlcOJJdbWI1mfmaV8EjXXc9KwovDvrfkpJwR5psm4jwRhB9COY9
	 SUR2sO0IWwOsQ==
Date: Sun, 10 May 2026 15:10:31 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] stddef: Document designated initializer semantics
 for __TRAILING_OVERLAP()
Message-ID: <agD0R-kNbg9YMOCT@kspp>
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
Changes in v2:
 - Fix a couple of typos.
 - Update format.

v1:
 - Link: https://lore.kernel.org/linux-hardening/af6p68531gNsTM5U@kspp/

 include/linux/stddef.h | 65 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 80b6bfb944f0..ce0e5d7b205b 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -100,6 +100,71 @@ enum {
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
+ * A couple of alternatives are shown below.
+ *
+ * a) Initialize only one view of the overlapped storage and assign the rest
+ *    at runtime:
+ *
+ *	static struct composite comp = {
+ *		.flex = {
+ *			.count = 1,
+ *		},
+ *	};
+ *
+ *	static void foo(void)
+ *	{
+ *		comp.data = 2;
+ *		...
+ *	}
+ *
+ *	(Compiler Explorer test code: https://godbolt.org/z/voM4E36dT)
+ *
+ * b) Alternatively, replace designated initializers with runtime assignments.
+ *
+ *	static void foo(void)
+ *	{
+ *		struct composite comp;
+ *
+ *		comp.flex.count = 1;
+ *		comp.data = 2;
+ *		...
+ *	}
+ *
+ * For another example of the above see commit 5e54510a9389 ("acpi: nfit:
+ * intel: avoid multiple -Wflex-array-member-not-at-end warnings")
+ *
+ * Link: https://git.kernel.org/linus/5e54510a9389caa9
+ *
  * @TYPE: Flexible structure type name, including "struct" keyword.
  * @NAME: Name for a variable to define.
  * @FAM: The flexible-array member within @TYPE
-- 
2.51.0

