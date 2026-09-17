Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551C34F5DF3;
	Thu, 17 Sep 2026 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679695; cv=none; b=pddnfmO0UWssH+mkBOuC2VGmDLA/fk9QCMLoyRKi+oYE3uE7QYNJp1ldZvO4qS4rq8InqXZQWwQSqcGKZUTM1uu3ReY4mq9g633lhQoU32nrhZuAK/gZxlYMcXTFUJD7KtyBi15rVftjSDdrogN/aZSOe8wgqZQrLOF0/DrfTis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679695; c=relaxed/simple;
	bh=lDmikAUbaKJW9suXHkpLVnN3X6YEA0jsyYpodGBObKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T/xDc932wOeT60jUx5beolCqw4V6X0TeDEQdh13M3j5Q2oaVk2X5tALGSav/XSGsf3RKa8HIcZTz/JbWgxUfa8OknpCtmgjmdJNhMcsT54sgpxLcCh3LbRalspIXihUAX3gE+a5aBQcoOhTOZg13lUEIg6KXH3BSUrP0+dX2NKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTSAyFSB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTSAyFSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397351F000FF;
	Thu, 17 Sep 2026 21:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679694;
	bh=z6Uv0MBPHRxJn3q9ecu1jaMLqeT/tzm70P/Da9cR4fo=;
	h=From:To:Cc:Subject:Date;
	b=ZTSAyFSBNE93q+2kIPs80MBLp5GGHB1IAFjyRc16Xr6F4KMBEQLwBlHxxE0SfaGdV
	 +afw5tP9DpaDQKkJyZZ5fYNAfIUufQqP52tgV2nmvRxxd+Dj3XEjtHjRSxXwPzKqlQ
	 8d+T+T2W3dtof7em/wr+K1aRBWrYtPGaJWATy6eU/O7+Inin1iFKgf07+a2ZpVrT6p
	 JnzX9D/6prapuYtRc4rwmT3OpbzwCCFQLEL/TITxu6Jpupj+GbHquYn2B9U/a4qkVt
	 S2As3vOHwrGXqspw5BpTdk69/VVt3kkI0Q5ZfqKospRhzZM8QmZJkMH4oK6NkuvrgN
	 87JTiCfJ3FXTQ==
From: Kees Cook <kees@kernel.org>
To: Chester Lin <chester62515@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] pinctrl: s32cc: Remove const from groups allocation type
Date: Thu, 17 Sep 2026 14:14:53 -0700
Message-Id: <20260917211452.i.365-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1987; i=kees@kernel.org; h=from:subject:message-id; bh=nNUPdVbUz/MbD5kNmfUpDCXi15TcB5OTYzbdnwH119o=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrInx4dkaXu7ZN+eW9pmP7w8n3nwlGveXz1Z3LKG4ua Bnyste3o5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCIbOBkZjmj1RvDHv97xUuXt 55WBN/vXhdw9cf316nbRzU6H3714vp6RYZZXmfuyNTfmBQn4XFnAdCSq0ecso7CVaR9j6oSDsz4 8YwUA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for making the devm_kmalloc family of allocators type
aware, we need to make sure that the returned type from the allocation
matches the type of the variable being assigned. (Before, the allocator
would always return "void *", which can be implicitly cast to any
pointer type.)

The assigned type is "const char **", but the converted allocation type
would be "const char * const *", as the size was taken from
"*func->groups", whose type "const char * const" is const qualified. As
there is no general way to remove const qualifiers, take the size from
the assignment target instead. No change in allocation size results.

Build tested ARCH=arm64 allmodconfig with GCC aarch64-linux-gnu 16.1.0:
drivers/pinctrl/nxp/pinctrl-s32cc.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Chester Lin <chester62515@gmail.com>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
Cc: NXP S32 Linux Team <s32@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Jacky Bai <ping.bai@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: <linux-gpio@vger.kernel.org>
---
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index 4b40770a38b7..9c4ebae22674 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -825,7 +825,7 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
 				     "No groups defined in %pOF\n", np);
 
 	groups = devm_kcalloc(info->dev, func->ngroups,
-				    sizeof(*func->groups), GFP_KERNEL);
+				    sizeof(*groups), GFP_KERNEL);
 	if (!groups)
 		return -ENOMEM;
 
-- 
2.34.1

