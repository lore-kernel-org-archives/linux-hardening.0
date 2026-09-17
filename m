Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2133248FF7B;
	Thu, 17 Sep 2026 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679570; cv=none; b=h65xqpngrjaQ/iuTzOudTiPhMbrdREkp/toWhN2QXVO+Q4e/CuLDwXSUTXA3pAF0MFXfvuV01Lm3gahsZEDVFhDfcOFnjhzy1Lco61Kmx3WsGyNTCofyqz8OOaBBeJ2ypLAD0Yru6k4IdROCY0VpqLzvTw36sarjE+MNQzyJoCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679570; c=relaxed/simple;
	bh=VA9bevVr2AFON3IA9ZNeMl5m9VLOgS3y0uAH7UfUzus=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uJRjnv6JuUdUTDZEw1Q04Vv/PVV5CqSCM5jZ0CTvbd4Dt/U4Mg9qWrKC3tHHcW0a4wbIlLv3sRvvdtf8P39sjdqU+WNp6a2+1VrklCnU5HQYT12j6Sk8N6vRfiBR93u5eiDT2j6x/0aAB8rHD/8xg8qTMu8In56DvGBlxQ2YeGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDGF8upM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDGF8upM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D291F000FF;
	Thu, 17 Sep 2026 21:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679568;
	bh=l1AwnMJm7smS3SpvMDZC84m360G5cmFfS4pcLQBELoo=;
	h=From:To:Cc:Subject:Date;
	b=PDGF8upM3TiJAXYJrkSeay1VorHiLONdJNkAdVLp99iI/xopzSyvlAquhYrLKJvuq
	 xB7iF2/pf2773tm+Ay3DrYDRw3pkPags5D4b0RxOgS8tHtfDR59/xkcYuVKYAccQDK
	 1343BcG+R262Nc6Gn3CeBwuWcKReuCHjOCCDqEY2Y82k8cpNbpoEE+E+sf/zwAugJR
	 izesXGje5lEhEnKXQF7cb+5ROUg2pf4IQu/75bH2kEwMszOH4CAZmw+is5jNmG9WJR
	 TcntKjAoIU7a2VZZW/cgxM5RmW6xEfVM3+mj/zDw/UIDcKEAMu5okojIrYVOWqGuC7
	 tHDJFX7/VnnHw==
From: Kees Cook <kees@kernel.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] extcon: realtek: Remove const from type_c_cfg allocation type
Date: Thu, 17 Sep 2026 14:12:47 -0700
Message-Id: <20260917211246.i.196-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1608; i=kees@kernel.org; h=from:subject:message-id; bh=xGMYrl4ZfY0iGlGBETr8zolNCRko5bdFbR6oxRD6Wfs=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrws//5mrfs9BpboKLDbdRea0k8/qGtTZci9g4FvR+n z5L6G1iRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwEQKnzD8U+h6cdPiMOfzb4H1 r/p4JUXVZ2T0PrEvvTslzqbz/t+CaYwMc6J38XR9mOb94MGFFbnzbiWLnz8QzHUqvP6AdcqBAk0 RHgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for making the devm_kmalloc family of allocators type
aware, we need to make sure that the returned type from the allocation
matches the type of the variable being assigned. (Before, the allocator
would always return "void *", which can be implicitly cast to any
pointer type.)

The assigned type is "struct type_c_cfg *", but the converted allocation
type would be "const struct type_c_cfg *", as the size was taken from
the local "type_c_cfg", which points to const as it comes from
of_device_get_match_data(). As there is no general way to remove const
qualifiers, take the size from the assignment target instead. No change
in allocation size results.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
drivers/extcon/extcon-rtk-type-c.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/extcon/extcon-rtk-type-c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-rtk-type-c.c b/drivers/extcon/extcon-rtk-type-c.c
index 82b60b927e41..da0b3fd3676e 100644
--- a/drivers/extcon/extcon-rtk-type-c.c
+++ b/drivers/extcon/extcon-rtk-type-c.c
@@ -1368,7 +1368,8 @@ static int extcon_rtk_type_c_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	type_c->type_c_cfg = devm_kzalloc(dev, sizeof(*type_c_cfg), GFP_KERNEL);
+	type_c->type_c_cfg = devm_kzalloc(dev, sizeof(*type_c->type_c_cfg),
+					  GFP_KERNEL);
 	if (!type_c->type_c_cfg)
 		return -ENOMEM;
 
-- 
2.34.1

