Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD13636403A
	for <linux-hardening@vger.kernel.org>; Wed,  4 Mar 2026 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772666434; cv=none; b=NnMtj6n+WCBw6a7MiA6L3kuw0eqMLcGOH6Z29E9WCgJwUJUir8/Z02NEd5Vs32JUUA54H1lkVZ7JuofR7KffReCADCEKJQLO/ChaLEzmeEjk0c1sDYHOOTNyjhaPUhkfbAPmJILnZtU4+q2EtF/+fxfbhy5YyVm7x3EcseS+J7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772666434; c=relaxed/simple;
	bh=FhSYioIp87zWW15JxImwp9ZRr+LkR0h+oTrgy/6ObAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sAbxzNr7at7mWjNnF7hklylW75tG0a0LNtec53OOUdOGeD+tLPWBIbj6OouA5BWb7kJSprupcHyX4jla4Ak0OXiuRQUuQ2vw8wUo5IuMZ+zvwUMnbTVbyzPV0I0LwMJouJgTKpD14zggR38oRzuGIXZOsw8CZmFAxTFWHFg+N7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvZgaBmj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvZgaBmj"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82746ed8cdcso4794601b3a.3
        for <linux-hardening@vger.kernel.org>; Wed, 04 Mar 2026 15:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772666433; x=1773271233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S8/7Iq+R5X6wke7kdfyu42X+a9yz8jbqYH+qW9takpM=;
        b=jvZgaBmjpazpAcLzAkO0xrU8rWKeTCeWYyJtOk78yaRmxeJWFr3etZG23HUo6FpwC1
         WidvddPpV7Kxgs0J73d5vH88d462faLZDTUb2+jJ8Cq7PfqPu1/g2beQ4SnwwcONH5CL
         DZ0mZsrkIR7UCOEUTG9YQJ1dfZgh2/TbfLlS7TF0JFFmp4mu/Eryk43QfsvV7ZgkZej+
         +ByzV+MvlAYUJ4ByJODJiN3R1L14+HLm5OzhZuCFyJyInyvPgshE/J5Oa0QYrxeGS7CF
         kxhNoDEAmX8o7ldEcVg5nOacXMpSxmOhzNGUSSdiw22R8GqZKtdaxYxoMHfLRhHyExBe
         roUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772666433; x=1773271233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8/7Iq+R5X6wke7kdfyu42X+a9yz8jbqYH+qW9takpM=;
        b=Hat2Zj5sM5u/pm0eWPNN/9OokMQCgBtRPnQdJzB0Xhj7IiJ012QWtGS69FSRHuEW15
         N2hzeMjr0SPPpRWWKt0LiMFTh5BIGUbkSZGRXypQGvBX833STh5Jny7PAvZdxJknxFk9
         MeFSdBPkgzfbo17LJkFtvsndjTkYJIZN5hCXzjU4zKl+BHMdY6iPFcvaqVi81hEqKI/q
         Qaen0Y5u+1E9+j8oJOVz51Qfur1V+3ZQ+b97KU1ux3UE6VNKGjNEsTCXea+Vduy9g7hc
         rza8ZyKKGcq3/fntx8Eqfoa9UlVtA3LQYE4ei6bNxeQHBq78UCRLNN4zFAQsnJVDHQyB
         3jBw==
X-Forwarded-Encrypted: i=1; AJvYcCX/Hb9+iXQynOpyS7PRzedacgH2SlmWdVYWUdoDfW/tLrqThsI4w9DCtvsBqSTM8VgVXFghYZhICvU8bSQH+N8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc+ksn4zyWnz+LlKf28vELcc7bLvRlZ2WSD7HHX/A2nZTfZYnG
	w4rgErOK47or9pyfW7Ir0k6aQ0eLBHRIuU8FNTxcpkJ/ez25U7U2l91e
X-Gm-Gg: ATEYQzxbK0X2x5rhuhdrxDVZXbOYaewQsi/T8a3ZgBYFpVOv540RDhBFWIj/P67wC8G
	IQU2ZS1KZ9srh5+z8a5y2pbiK07dzIy6xITvENMpWe3zXnLnkb7iWmJaomx+arVvrKngaHZe6zQ
	R+EXT+1v1t3aNHXQ20FvrqTuYiG9iJZJkH49RxUUU0ib369Iimh+920zBVI4DDdPWvHOURadhQk
	yr1OMrJhwx8fpevS603jdDBo2HnbKakUHRZgthrZUTWww0Y6FZuU2/bavEKdDR79wbvWy+4wXaD
	KuppLQnrC/+jCcrJ5Xte3JPFlmPQrNzQLtsokQ7xjzUz5Ev5Pek2/5VzxN5AyMn8SlAr2HvVc5u
	nFivb2GmBFNi5qqC/8H8F9YUF6W4ceFDPM8ocNyb2LEBKm/xh2x6n7V/kATUDdxfjEz515tHWqH
	99VWjm4CPYBGfQvkyJXULBNq1VBu4ruq1OUdP13J6jbU9/I7YcTiW7ww==
X-Received: by 2002:a05:6a00:1c98:b0:827:2eff:a29e with SMTP id d2e1a72fcca58-82972c655e8mr3140323b3a.34.1772666433049;
        Wed, 04 Mar 2026 15:20:33 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d544ffsm19730769b3a.12.2026.03.04.15.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:20:31 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] soc: mediatek: mtk-dvfsrc: use flex array
Date: Wed,  4 Mar 2026 15:20:14 -0800
Message-ID: <20260304232014.164408-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocation from kzalloc + kcaloc to one allocation.

Allows extra runtime analysis with __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/soc/mediatek/mtk-dvfsrc.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-dvfsrc.c b/drivers/soc/mediatek/mtk-dvfsrc.c
index 548a28f50242..48b1fcf3e101 100644
--- a/drivers/soc/mediatek/mtk-dvfsrc.c
+++ b/drivers/soc/mediatek/mtk-dvfsrc.c
@@ -71,8 +71,8 @@ struct dvfsrc_opp {
 };
 
 struct dvfsrc_opp_desc {
-	const struct dvfsrc_opp *opps;
 	u32 num_opp;
+	struct dvfsrc_opp opps[] __counted_by(num_opp);
 };
 
 struct dvfsrc_soc_data;
@@ -489,7 +489,6 @@ static u32 dvfsrc_get_opp_gear(struct mtk_dvfsrc *dvfsrc, u8 level)
 
 static int dvfsrc_get_hw_opps_v4(struct mtk_dvfsrc *dvfsrc)
 {
-	struct dvfsrc_opp *dvfsrc_opps;
 	struct dvfsrc_opp_desc *desc;
 	u32 num_opps, gear_info;
 	u8 num_vcore, num_dram;
@@ -520,24 +519,19 @@ static int dvfsrc_get_hw_opps_v4(struct mtk_dvfsrc *dvfsrc)
 		 num_opps, num_vcore, num_dram, num_emi);
 
 	/* Allocate everything now as anything else after that cannot fail */
-	desc = devm_kzalloc(dvfsrc->dev, sizeof(*desc), GFP_KERNEL);
+	desc = devm_kzalloc(dvfsrc->dev, struct_size(desc, opps, num_ops + 1), GFP_KERNEL);
 	if (!desc)
 		return -ENOMEM;
 
-	dvfsrc_opps = devm_kcalloc(dvfsrc->dev, num_opps + 1,
-				   sizeof(*dvfsrc_opps), GFP_KERNEL);
-	if (!dvfsrc_opps)
-		return -ENOMEM;
+	desc->num_opp = num_opps + 1;
 
 	/* Read the OPP table gear indices */
 	for (i = 0; i <= num_opps; i++) {
 		gear_info = dvfsrc_get_opp_gear(dvfsrc, num_opps - i);
-		dvfsrc_opps[i].vcore_opp = FIELD_GET(DVFSRC_V4_GEAR_INFO_VCORE, gear_info);
-		dvfsrc_opps[i].dram_opp = FIELD_GET(DVFSRC_V4_GEAR_INFO_DRAM, gear_info);
-		dvfsrc_opps[i].emi_opp = FIELD_GET(DVFSRC_V4_GEAR_INFO_EMI, gear_info);
+		desc->opps[i].vcore_opp = FIELD_GET(DVFSRC_V4_GEAR_INFO_VCORE, gear_info);
+		desc->opps[i].dram_opp = FIELD_GET(DVFSRC_V4_GEAR_INFO_DRAM, gear_info);
+		desc->opps[i].emi_opp = FIELD_GET(DVFSRC_V4_GEAR_INFO_EMI, gear_info);
 	};
-	desc->num_opp = num_opps + 1;
-	desc->opps = dvfsrc_opps;
 
 	/* Assign to main structure now that everything is done! */
 	dvfsrc->curr_opps = desc;
-- 
2.53.0

