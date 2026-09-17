Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9770B38F253;
	Thu, 17 Sep 2026 21:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679608; cv=none; b=Y6slumGZX4gqKbr9QrjL+aDemDA+HpppbttKTQcD7CJOuqSXt7z/U9GXrLX2oesDV25g98YtoYwKtNZCqLPfO1oT6Cu01t7ZXC2+vKKQP0tqFAiZazGCKXs80BG5UxBjAtygF0Nr3hLL9zVgK7VBuZqg30hLMN07g+VVVxlKWLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679608; c=relaxed/simple;
	bh=qi8NGj3GV5+JaJsEBaW++2H2bVjNFFa8a+Ot/7Oteh4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RXxjb1+LLxtD+4fEhrz8PJJd+j7G5pbgRhgtZwKCY9kT5O31uTOTQkfB6VXZBkny/xGuTWS4uU4N44t1oQ06R8O+K2DNox7EWf8aaZ8vVhloTTAjTlthUwsJftas/sobqAiihbvEK7H4vqnsgb2/K4EYmuQ7kKklgDVlpty8D/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h59j228G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h59j228G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0211F000FF;
	Thu, 17 Sep 2026 21:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679606;
	bh=cAYHB91mBe/nX9GCFhnVlPHTeBX8SwymcKLkPAPtfA0=;
	h=From:To:Cc:Subject:Date;
	b=h59j228Gw9TPAONxrGOjGq3evcR70tMHJkQJpxI7gQ5Ckg330CrOwl4gUroSCPtYZ
	 rZhOO3pFWGNWGJcGehsZxeS/psrqRMpsz/DjTmj70n/UUxjb5A4b1//cx/56M+MDpD
	 iGYgN3ZEUsliz6cbt+aDXJSC8HEYqE+fS0a+PjASx3kSv3imFU25Pbka/2xKgRVUIx
	 miMPYlgq84NprmJliCErWPaNEHDqlLpS5aeLcT8J/5xb0igU5eTpgD6eLWQjO+85X0
	 8e8GPSSMNK8wgcwiZ+BJHkZuW7+fLeGxChk5uz5/2iWVWk0HgH4sLwPSG5Ye1FJFpN
	 EIrwIc8yCltOA==
From: Kees Cook <kees@kernel.org>
To: Sean Wang <sean.wang@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] pinctrl: mediatek: Fix eint->base allocation type
Date: Thu, 17 Sep 2026 14:13:24 -0700
Message-Id: <20260917211323.i.101-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1996; i=kees@kernel.org; h=from:subject:message-id; bh=/FZNV9o1ewTwlu5GAymRgTjU768+QMlUG/XB6uW9yEM=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrwj9fmqEtGX7sgKPW54DouNsL7FbdWWmd4L1XfI7VJ Iko10SdjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgInEbWX4Zzk1r0Cx5kLjg9y3 8zO5z8gsOWw91/bCj5QXAepb1jWIZDL8034SmmCpnvZq6ZnSO1YJ1zqkH55Snj4n4+xhYYGlS+8 l8gMA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for making the devm_kmalloc family of allocators type
aware, we need to make sure that the returned type from the allocation
matches the type of the variable being assigned. (Before, the allocator
would always return "void *", which can be implicitly cast to any
pointer type.)

This allocates the single-entry array that mtk-eint expects (nbase is
set to 1). The assigned type is "void __iomem **", but the converted
allocation type would be "void __iomem ***", as the size was taken from
"pctl->eint->base" itself rather than from what it points at. Luckily
"void __iomem **" and "void __iomem *" are the same size. Take the size
from the pointed-at type to match the assignment.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
drivers/pinctrl/mediatek/pinctrl-mtk-common.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Sean Wang <sean.wang@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: <linux-mediatek@lists.infradead.org>
Cc: <linux-gpio@vger.kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 1a977acd6883..857d39f3438d 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -1032,7 +1032,8 @@ static int mtk_eint_init(struct mtk_pinctrl *pctl, struct platform_device *pdev)
 
 	pctl->eint->nbase = 1;
 	/* mtk-eint expects an array */
-	pctl->eint->base = devm_kzalloc(pctl->dev, sizeof(pctl->eint->base), GFP_KERNEL);
+	pctl->eint->base = devm_kzalloc(pctl->dev, sizeof(*pctl->eint->base),
+					GFP_KERNEL);
 	if (!pctl->eint->base)
 		return -ENOMEM;
 
-- 
2.34.1

