Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367623;
	b=bpzCrQom1msAdiDZDsR57Swe53NKLRHVvX9ZU85DYcv44KtpIrvy3uf3cLbCbxdTKIZd
	 5tmdvP5Gyu0iINxsPiFZf/Fjni1UA0pIWUvJQZcsmvPpxj39QCOZaNRWab1O87gSx5nJt
	 MLjmR+5xfaHtN9hcEVcpjLmEcN4iYen2fbVb9b5nxo42SWT4RIeGCSoaRJ+vKfktygW54
	 Tg5geohmQIiqgckams3MtwV3bh8To9FboTis4Pxv7tlIDsdYb8MsKzVEWq2H67qmtV98J
	 8LysIZ5HfrN570fAj+S/wNbuw7p9gChNP/GZEQSqQQIX8EGKIOnFXz0dS6MWuaOJQFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QP9+Ctp3NviXfDVXP2gE2ILUUDfgBim84aqNH/sgLwY=;
	b=UPQi3DOTRd2/3wqw+jjtbm8vvPA7TNLWWnJ9zROxLvhsXuYwAAd92U4CuzOkEeRTG6PA
	 hE9ULiUPrj1k9Wuj7lxUr5nw7g7IC4LsmfNa3TUNlx1OJxyF7Dafux0AepFncakS7l3jw
	 nGTc2wvrd6zrdVkDUQSXARDrJJfg8wMLoF1UFnaikaEPLaxtjL9XG8Aec72NvdsYdeloD
	 IgBnZTV8QZW5z1o8fsv+XWxln5novHXTIO0CJmmy4ZejRlZEN5Y81gvkC9gKrB1b/cbaO
	 1v3WJtmCDCt6VvrfXQvJT4F9UVf23m5Ii0ryDGit37cStGAwgm4TADDjwg3sgquMIDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=drMtwf+m;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852F2606A321
	for <linux-hardening@vger.kernel.org>; Wed, 11 Nov 2026 03:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 852F2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=drMtwf+m
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-37071c0f42aso4792621eec.0
        for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 19:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794367622; x=1794972422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QP9+Ctp3NviXfDVXP2gE2ILUUDfgBim84aqNH/sgLwY=;
        b=drMtwf+m1+TCoaArpSMFE+ivILjRcW1xOEKThdlbgJn+jW6tmYXM6ESSXNnUC7kyI6
         Pnp2tEMVcinXZsDXOFZjXb9p0LAtTfEEakcHaOQXaJp5Qu86o3y/QOmCv46eolZIkO6R
         fiFGJkpAocQRzieorgMBUgJkCKIvGnNMifPhTIQO8PVDrVzA31mNZh173bkQ7E8ytjad
         1547enDvgfylM8STbfTy1kiwoo1Xy+HSR3RzNTa9/B30AhHPFHQk9TJD39PJDLnONw0y
         sEtIy8IySjstTlZP6LtgoU0UAa8m1q+GdLeZHKCFhgB5lvGE61telG5FithNRP4a80MV
         LTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794367622; x=1794972422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QP9+Ctp3NviXfDVXP2gE2ILUUDfgBim84aqNH/sgLwY=;
        b=ob6quyWZTKgTgdo6+ySu2Z5R0XTwPb/b7atdP+IPc1Ptez7xTZA/FCZ62zZ6D3QF/8
         tZO2+LDZrN/eV1BVXJtasArEJqQN6oEMgeMwI6PuOs9w52yLkYnxfRcvmq3AJYLITm8k
         z3V2h1gmWp+EntX9a9trgHHPZbgtzREG1gK02VMuJWHjJAG5Nuw/zJxcRyE7ZhtihAxp
         3QT36j+3MNtBlBaDT48eOpDSBm8M8//V4LufM0X9OV7c51Cjad21c1LzJT8S9NB4Xqn3
         c6WUgrPxJPjjx5jRa7pvm4tabUpC37ZMq3T6awNzAEiM0+osVv/EJvp8FWbpodw5df+N
         fzrg==
X-Forwarded-Encrypted: i=1; AL+hErEjBImDtrZpFr7oY1H6YAw6MauCPC27yg4A/CklJgMqGda1YfAR60pdseyYfRd4N+H0Q+pgBzi6XRrwpDfKQVk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cFcViWgBxP8Sh6zU+QIIvpE8AhJ04fbAWRGHBACyG0UePlgMr
	IfkdUCXhNbqm0/FE+c1yxhu2IwN/FSrX7H4IF+h1dX5ZCBLGw4tC5rAp
X-Gm-Gg: AYBFou0m0uOcCrn91Vh3zgS+xR+i7hqeVHk/rmotR/WSUGOaSnN7GAHMa8f2V+gMnnH
	pvzzZk2Ajqo75boporiYckSic5BeUnCwvwxONfKP7/6Cg/e6eEeMacOYMkmfryB05QhntB1Xlfe
	qpNbU7UdgKGWs0GnWSCbuQrTQ39haz5LLvpTEa4q4jqSUDNjtxNeRB2x0GH+HgtkvFVrfqYYHB9
	27XxElxBq4BgPy9o2RNfrQonXLp2Jn/LbD9GX+ApyAighWZlkW/8ZDNcMcHY24alvbLR0GIkZWO
	Xbpnj0L1B3Q3nQWpwbpnX269g6n273aMetp7HsnnvPxUzMrjAqhrzllZJxeJt3rtLJCM8uQQXis
	L4dPem7g9d+ak8QiNrEdRrOzcIIMib23PeiprsgozQcLGQsjUQHeyDXttXWnoz/VA9uQkbkef0r
	J2ZQ8Rw0mavzJyJKJk5/fXx/wIqe8JpqRod+hX8h1DntxL7/sUCdYPcawQ0RZ2AfAO/3c0A1r4m
	LHF6S7Z4MN4hSoX9KF4rjhSDU3byDzkm+rrDEKb4Mg/9OdnzgUcEKjNfDnf5KdsolVgzM6azbFC
	feg9sSxbD+0veTkZRNGYuGU0urXtLXRmDT9ZprAD9Pl6DUQG6n3dCksi3h/U
X-Received: by 2002:a05:7300:51c3:b0:36e:d060:8bad with SMTP id 5a478bee46e88-3768385dc4fmr1982303eec.5.1794367622326;
        Tue, 10 Nov 2026 19:27:02 -0800 (PST)
Received: from homik.search.charter.net ([2603:8002:ad40:56f0:521b:36dc:be93:10f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520512ec1sm10567569eec.12.2026.11.10.19.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:27:01 -0800 (PST)
From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
To: nicolas.dufresne@collabora.com,
	benjamin.gaignard@collabora.com,
	p.zabel@pengutronix.de
Cc: mchehab@kernel.org,
	hverkuil+cisco@kernel.org,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kees@kernel.org,
	justinstitt@google.com,
	morbo@google.com,
	david.laight.linux@gmail.com,
	Mariia Nikitash <nikitash.mariiaw@gmail.com>
Subject: [PATCH v2] media: verisilicon: Replace strlcat() with scnprintf()
Date: Tue, 10 Nov 2026 19:24:46 -0800
Message-ID: <20261111032446.29803-1-nikitash.mariiaw@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105084518.386234-1-nikitash.mariiaw@gmail.com>
References: <20261105084518.386234-1-nikitash.mariiaw@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for removing the deprecated strlcat() API [1], replace the
strscpy() and strlcat() calls in hantro_add_func() with a single
scnprintf() call.

This preserves the resulting string, including NUL termination
and truncation behavior.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
---
Changes in v2:
- Replace seq_buf with a single scnprintf() call, as suggested
  by Hans Verkuil.

 drivers/media/platform/verisilicon/hantro_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 26e5d5547466..d8854ceb4fed 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -902,9 +902,8 @@ static int hantro_add_func(struct hantro_dev *vpu, unsigned int funcid)
 	vfd->vfl_dir = VFL_DIR_M2M;
 	vfd->device_caps = V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_M2M_MPLANE;
 	vfd->ioctl_ops = &hantro_ioctl_ops;
-	strscpy(vfd->name, match->compatible, sizeof(vfd->name));
-	strlcat(vfd->name, funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER ?
-		"-enc" : "-dec", sizeof(vfd->name));
+	scnprintf(vfd->name, sizeof(vfd->name), "%s%s", match->compatible,
+		  funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER ? "-enc" : "-dec");
 
 	if (funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER) {
 		vpu->encoder = func;
-- 
2.43.0

