Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227F64EDCBA;
	Thu, 17 Sep 2026 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679599; cv=none; b=lBWDU/PNMyA1FMYi4IxxMizgKXaFd6IE+8UegtfPhQGr/VUJAwM3h/wsrGNbQC8dcW+E/1H5nnbtOy0SHIUENvddiWEx4eFUelTOJ+eRZXh3AlaK3K5dhVNtFJ3Kauv3imOk3vqus6E3IQuFMgpmKc70/yaPjcJ3Ulhapx2QFcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679599; c=relaxed/simple;
	bh=m0X8VrsASi1kfyr4HC/ICcMBRaf/o7N6b/EYcPQ5VMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OQJ4t0Iw+ftzeMrqI6SZCU4ejW6WXWkWD8PXb2JmoVMEowPAK3NfLBAWKAlumNurMLf6aaYuotWV8TeIVCEAnbnIk2sDwyNzr8NplCojRDmrgdWjMmK6YLyOs7ZccZ748r25RZLkCWYNopk5vl0PCji2DKFbxT6GpGbKMjWyu7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byKDWpFx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byKDWpFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0781D1F000FF;
	Thu, 17 Sep 2026 21:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679598;
	bh=7e18Sa+MwEdOb8KcbbXVUJipOg2vOL1/dkGtTJlkEDg=;
	h=From:To:Cc:Subject:Date;
	b=byKDWpFx2mt8H1ORvSgEKbybaAsAgivP5Ar9KAlCHUa8CoonfhYNKB6YYFvUxNjqG
	 PpYd568o4NjY+ZREHNLEJsUPApLdUWH2tud7OeyjinzowLsueVpQraX+ZRzAtZfO64
	 mc4PZvMu1uRpqm9lJ9NwtQouI4Aw5E3+ZQiLDhCLZ5SxQD0ow3zqnAHAUvS7m0lbfV
	 c2ZDQoclchfx5cTLvIF5eylFqB49zF78Lh/j81KaR+hZhJPGAy3wPZ+j4lFuvJh4wp
	 UA/mB3siSqi/j4gCdS8lz8lr4QBm0BB/lznp4fz3ErQmsu4B5EzZF9VSnUXrwXbbLV
	 aUeImp+/AY3Og==
From: Kees Cook <kees@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] regulator: axp20x: Remove const from new_desc allocation types
Date: Thu, 17 Sep 2026 14:13:16 -0700
Message-Id: <20260917211315.i.973-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2586; i=kees@kernel.org; h=from:subject:message-id; bh=5WUoWYFLCwF9+dFAIjiVxpXgWaC8PLG5R5iG3Q++Xbk=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrwt9I/5J1XFK81kdqEbP55JuNAveiOXcy6t88KBAwd faFPxwRHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABNhms/I8Cwvp8RfyvXuqqv/ 1/eqr5BU9GNwu9gZY3rBVsrO1vWNCsM/hQlaJfFnNp451X7TaXfHiUU9lY/Xnj64+haL2/zFj3x 28QMA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for making the devm_kmalloc family of allocators type
aware, we need to make sure that the returned type from the allocation
matches the type of the variable being assigned. (Before, the allocator
would always return "void *", which can be implicitly cast to any
pointer type.)

The assigned type is "struct regulator_desc *", but the converted
allocation types would be "const struct regulator_desc *", as all three
sizeof()s were taken from "*desc", and "desc" is
"const struct regulator_desc *". As there is no general way to remove
const qualifiers, take the size from the assignment target instead. No
change in allocation size results.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
drivers/regulator/axp20x-regulator.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>
---
 drivers/regulator/axp20x-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index da891415efc0..ec6ec071ffde 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -1652,7 +1652,7 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		    (regulators == axp803_regulators && i == AXP803_DC1SW) ||
 		    (regulators == axp809_regulators && i == AXP809_DC1SW) ||
 		    (regulators == axp15060_regulators && i == AXP15060_SW)) {
-			new_desc = devm_kzalloc(&pdev->dev, sizeof(*desc),
+			new_desc = devm_kzalloc(&pdev->dev, sizeof(*new_desc),
 						GFP_KERNEL);
 			if (!new_desc)
 				return -ENOMEM;
@@ -1665,7 +1665,7 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		if ((regulators == axp22x_regulators && i == AXP22X_DC5LDO) ||
 		    (regulators == axp809_regulators && i == AXP809_DC5LDO) ||
 		    (regulators == axp15060_regulators && i == AXP15060_CPUSLDO)) {
-			new_desc = devm_kzalloc(&pdev->dev, sizeof(*desc),
+			new_desc = devm_kzalloc(&pdev->dev, sizeof(*new_desc),
 						GFP_KERNEL);
 			if (!new_desc)
 				return -ENOMEM;
@@ -1677,7 +1677,7 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 
 
 		if (regulators == axp15060_regulators && i == AXP15060_RTC_LDO) {
-			new_desc = devm_kzalloc(&pdev->dev, sizeof(*desc),
+			new_desc = devm_kzalloc(&pdev->dev, sizeof(*new_desc),
 						GFP_KERNEL);
 			if (!new_desc)
 				return -ENOMEM;
-- 
2.34.1

