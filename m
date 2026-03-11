Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B93366800
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773189739; cv=none; b=DR/EdweiKXlJV+Yb32pQoEpTvjbeODLbf5U0JM5BtAUsWSeggM5r09v79UvE4+j29B7MarGWi6UDIf275hAl9zvBo58zAE6RpdE45dirIQc4Pl2/EEWnQPA6pLvRMrAeekt4yPDBCPJc1biEDb/ra6D9OcqWan1cDysDKQpw/bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773189739; c=relaxed/simple;
	bh=2ksSybkciUe6CV1LGXmZxoIci6qemQKdi9QxZi+aV40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=az0ZGqolDeRSLTBedtyUUWNoBc1qSsMFy47GjuQ0wlOTBd28fobR79PcsTnvEHEAI7Rng2xx8GqFYSsAiZbONKKUd0fn3NOLISDG6dE9ZYP6uSi7TaOmP5xfFzT6rsalnUVY3yaZf8soeHO3uu8/h7/NSmRvczpjC00nP8BXUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8y82s+2; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8y82s+2"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79827d28fc4so125973647b3.1
        for <linux-hardening@vger.kernel.org>; Tue, 10 Mar 2026 17:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773189737; x=1773794537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fXezhForEiFx/NxSB2vCwZqG77lqSwqNuMXHZq3xAqM=;
        b=Z8y82s+2QaRhO/5scplKLkr7xpmLAerSXCc0AM+931aElN7uyiI9JEqNH0d5+cLRMH
         9b8cCJPZsGtqkxozVoqea+AgoppVFWtAtsWmsNL0lLvxLzcOgvWUO8pIuleomo9Z00L2
         X6S7Ot+zqZ7qRss0Laj5VTQwj7edt1uYk+aI+2mJPOjeAsSf5I2Zey3XIPEoFakxmizg
         93yniNWQh0u5F7ZokP8BTpBJpLYxcL3cQ2cITKLEXo7K9+lvlky9trKwx2yBJEUJOVV5
         pV3ZvTNiSvzRg8VbIqEmzPzY1ASTwawqisFB55aIjrXLCQOAYHhq/YWGRBVVKhNllsWB
         4NQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773189737; x=1773794537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXezhForEiFx/NxSB2vCwZqG77lqSwqNuMXHZq3xAqM=;
        b=VXnmEJUAgqihW+jO1TjME9CjJaKUeIqbHkL6rxzcBFpQapCwpq62ABiQ1wQy9Suw6H
         zMEwPXd/LWdxzuZ4g2UNqG8/iLe4UwIQjLlTRFuwvXX9YtUBBV/xEv0nUAvDA81Xh97A
         ScX3Uyh+LK93Hiy+VgvzWtTQ/kAUz8JGgSFR152Se8pJSd4EcoGU+Vmm8Meu/X2ZxcrW
         5L55cK169PtmzN0bULsaolxRmjdqIdOn+gdTS0DSsWd1c5RvsAZ8qMYFeg866xccj0tw
         vHPDLLuFo2Nf0Pl+Gt8rOYiEZyeha4Bdoy0LfGWU2GKdxJoNRrZwCUi3j1Ck7B+EvfrV
         VlLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlWgmJPdZ+6lD/McSMcEoVTprMlo03RA4JFd0IFUUeKWzsQk+QH1MnJSVL0fqGur9z6n4kQov7t4ZOaTXB2MI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzobzXC9f6flx7eCcknLjh0KlFcAKvHg+/Ms+Sc62UrFZkJLa66
	rmAS+Vm/zQ9q+z9BXRynO7vm2cDaTKeEL91ROk5Dz5NZvoGOOctvKrZs
X-Gm-Gg: ATEYQzzoeqLgL6C7E2pPACLlq3af3hDohhX/HgSC0MM/fmIFdPXrt5HlTr7tDrhu+p5
	9UTnaPKZyZIX9SpvptHHTVroDs0RM2xnOH5JlOZZWCbXel8uZ4k7PCFQ6vRNVX/WALBVrBB4GF3
	MzuK3QdW9x4jdZne1VlYEowCNPXTV+AiWjh5Pub8lKW4XQa5drpR6cquQK0MdnfOFZxl+k1VDL6
	NWgjj6TqqdIhklUbGoVFcE8w89GnOjM4HzdDmbAif4fa6OYTQsAUs+Q7Q/2gdDHNR0oKaUksa+h
	O0nTwScbj8XCVOSEN2NEiMJXD7hqLlx75P96USPRBfjkipfOV0Wl2Er3a7/zyL8xvHVSdN3AyzI
	qyp0+uwEnHrtVQhA6wBTRR58Ziwe0BmYwlgI3B3BBb7Rk7a+CDhj1QWiSXg0HKYjySGSVsQNIpn
	y/dvgui7LVwlZd8G6P8Fm0/NP7A2d4HVj8KTj2LfmeMGdUL32yhdDIIw==
X-Received: by 2002:a05:690c:906:b0:798:7ab2:eb6f with SMTP id 00721157ae682-79917e8b6c4mr6514827b3.11.1773189737566;
        Tue, 10 Mar 2026 17:42:17 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917de890fsm3753257b3.7.2026.03.10.17.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 17:42:16 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@linux-kernel@vger.kernel.org
Cc: Support Opensource <support.opensource@diasemi.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] regulator: da9063: kzalloc + kcalloc to kzalloc
Date: Tue, 10 Mar 2026 17:41:59 -0700
Message-ID: <20260311004159.32374-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce main allocation to a single kzalloc call by using a flexible
array member.

Allows using __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/regulator/da9063-regulator.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 9d369cc45d41..bf34ea440d77 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -67,7 +67,7 @@ struct da9063_regulator_data {
 
 struct da9063_regulators_pdata {
 	unsigned int			n_regulators;
-	struct da9063_regulator_data	*regulator_data;
+	struct da9063_regulator_data	regulator_data[] __counted_by(n_regulators);
 };
 
 /* Regulator capabilities and registers description */
@@ -857,15 +857,10 @@ static struct da9063_regulators_pdata *da9063_parse_regulators_dt(
 		return ERR_PTR(-EINVAL);
 	}
 
-	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	pdata = devm_kzalloc(&pdev->dev, struct_size(pdata, regulator_data, num), GFP_KERNEL);
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
-	pdata->regulator_data = devm_kcalloc(&pdev->dev,
-					num, sizeof(*pdata->regulator_data),
-					GFP_KERNEL);
-	if (!pdata->regulator_data)
-		return ERR_PTR(-ENOMEM);
 	pdata->n_regulators = num;
 
 	n = 0;
-- 
2.53.0

