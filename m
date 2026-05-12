Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8C935F16C;
	Tue, 12 May 2026 19:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614487; cv=none; b=leORlqfp9tlfYxMoSKSbm+Li/54ApmUskeN9jbYZibXucLDaCPt/0nm7l4bPuXYBvGgFLw7zb7em4vTDoXEZPRyAX2ltczEgrzovvVPIxkbL2t1E4k1iWuaI7UTM4WSQqGZ8efT4WheaMuVm5h/XJqyvPToDAzYvbI1HqgiW7ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614487; c=relaxed/simple;
	bh=H0PKcI+X1azySWejCpjBgaF8b2QXNjA36BQg8U+kBWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oX/OaL2ysjzTsP68ROPeooGZnFLA577edUZU9kv//guUcsdkbUwDVZqEe521m/cx3ScWZ+CXVQDCjnjksZP2I/9801vKmOmDwt1Bd8xXWnVqLbL5HiX7yMeoUUbtrP+jvvf9TAPDB5L2jOKXwlkRhXboADxpmJqaTxXHP1pEmrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxuzV8ie; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxuzV8ie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C90FC2BCB0;
	Tue, 12 May 2026 19:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778614486;
	bh=H0PKcI+X1azySWejCpjBgaF8b2QXNjA36BQg8U+kBWQ=;
	h=Date:From:To:Cc:Subject:From;
	b=oxuzV8ierG9it+dELhKJXdyxDsKCBWTzNuKFjuS3zdyoid7MSKwrdDjwNRwO7VjvG
	 F1Cy9qFzs5ddlYD6coohgZaxCEtFKJjrFIYfNDCRn8x3FqQCVsUFPp73dQfhmIEmO2
	 i5NhgdHDmxuTouNF6yvAMfnF2Dz5q8ZogKeKue03fabaQZ4kYPKPhHT18ziLUL/8K5
	 8bk+sOKk8+YAVvAf2FwxHpEkgw1NuddiY8Ac1YtG3L4qFyJv72k5JBfaMRKMduK7+F
	 rSmqSNZXxFAQbGiPbKob/nVFTTU17fcV5NrdVK+B7H20vLBl3fvvZ2Cs0kdHb0RzNl
	 J/CyAeWR5CXHw==
Date: Tue, 12 May 2026 13:34:44 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH][next] stddef: Fix kernel-doc/Sphinx warnings for
 __TRAILING_OVERLAP()
Message-ID: <agOA1PDX2h3PNhl2@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix the following kdoc warnings:

Documentation/driver-api/basics:127: ./include/linux/stddef.h:110: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
Documentation/driver-api/basics:127: ./include/linux/stddef.h:115: ERROR: Unexpected indentation. [docutils]
Documentation/driver-api/basics:127: ./include/linux/stddef.h:116: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
Documentation/driver-api/basics:127: ./include/linux/stddef.h:117: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
Documentation/driver-api/basics:127: ./include/linux/stddef.h:122: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
Documentation/driver-api/basics:127: ./include/linux/stddef.h:124: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
Documentation/driver-api/basics:127: ./include/linux/stddef.h:139: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
Documentation/driver-api/basics:127: ./include/linux/stddef.h:140: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605120507.9iQRMgKR-lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/stddef.h | 48 +++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 665d7a68cd98..f666ced2a9e7 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -104,26 +104,26 @@ enum {
  * union, designated initializers for MEMBERS may overwrite portions
  * previously initialized through NAME.
  *
- * For example:
- *
- * struct flex {
- *	size_t count;
- *	u8 fam[];
- * };
- *
- * struct composite {
- *	...
- *	__TRAILING_OVERLAP(struct flex, flex, fam, __packed,
- *		u8 data;
- *	);
- * } __packed;
- *
- * static struct composite comp = {
- *	.flex = {
- *		.count = 1,
- *	},
- *	.data = 2,
- * };
+ * For example::
+ *
+ *	struct flex {
+ *		size_t count;
+ *		u8 fam[];
+ *	};
+ *
+ *	struct composite {
+ *		...
+ *		__TRAILING_OVERLAP(struct flex, flex, fam, __packed,
+ *			u8 data;
+ *		);
+ *	} __packed;
+ *
+ *	static struct composite comp = {
+ *		.flex = {
+ *			.count = 1,
+ *		},
+ *		.data = 2,
+ *	};
  *
  * In the example above, .flex and .data initialize different views of the same
  * union storage. Since .data is initialized last, it _may_ overwrite portions
@@ -133,7 +133,7 @@ enum {
  * A couple of alternatives are shown below.
  *
  * a) Initialize only one view of the overlapped storage and assign the rest
- *    at runtime:
+ *    at runtime::
  *
  *	static struct composite comp = {
  *		.flex = {
@@ -147,9 +147,7 @@ enum {
  *		...
  *	}
  *
- *	(Compiler Explorer test code: https://godbolt.org/z/zz4K1Ejvf)
- *
- * b) Alternatively, replace designated initializers with runtime assignments.
+ * b) Alternatively, replace designated initializers with runtime assignments::
  *
  *	static void foo(void)
  *	{
@@ -160,6 +158,8 @@ enum {
  *		...
  *	}
  *
+ * Compiler Explorer test code: https://godbolt.org/z/zz4K1Ejvf
+ *
  * For another example of the above see commit 5e54510a9389 ("acpi: nfit:
  * intel: avoid multiple -Wflex-array-member-not-at-end warnings")
  *
-- 
2.51.0

