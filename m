Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868326;
	b=iVg12/AhigDblXme+sZTHUTX3iqru0lZ/LlacL52/RqXeSoNan9xU0hkR0EKouEI6RFH
	 Z4e94Ns1kla3zI1HDESf4TBWIgItZ/Tf7xqxrHhdeWcAsyp/6sHFbYxIqPNhk8Ad689OU
	 NYGtrJHaXL1IoDWUBvqDnL1yhUrQH/+rjXF9orHCX62tal5FjRX+61w2kqMlEdr5MlRxO
	 tP0VSAa9EPYYgfXwZrwnI7JBcSeezgoFRtj+E6etpYp+H+0U6YqDFwsGc99d54sR0mBkw
	 0APiyrOf1NsTEU2cKrqWKe6khQbbYg06LLqGWCpzSw4K5Izp6J0SplX/A5IO3Wq1zhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pDxvxLItiSCdu3fsI80x3ws6o0fFDQAmdzilH9mdUKE=;
	b=XiDB7qexxB9LTlgXMar8q4jNxkS+Kaz4jjcvUCB01EXfwsEty61w13aBcbXR3mNCK5Ly
	 SAjhQd2CebCCf+PyMLFpcSIONfOz9BwpdOUsZGmRqLHStkBP/7Wv12sOYG3AyVn/Wxyn6
	 ZG1CInqJ9FaawOm8K1NNpYUnQeMWZtZacEmmXOpkwEBWDHbYl3DB/yfrLfusIaA0JxM5q
	 /sHOh5FIqCbe/KG5sw5hf6tlgk/H55tA7b+5GJFofynP581BK8OgvDhSTDzc6AsNKOPOd
	 CZsNWvQrvHuGPCwa/iAjxNVTQ3qJGIsupvwU8KyiNoXph79dNWZOTg+qtW6Dscw01MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M1RJiphd;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF29606A329
	for <linux-hardening@vger.kernel.org>; Thu,  5 Nov 2026 08:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EF29606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M1RJiphd
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso4371463eec.0
        for <linux-hardening@vger.kernel.org>; Thu, 05 Nov 2026 00:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793868325; x=1794473125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pDxvxLItiSCdu3fsI80x3ws6o0fFDQAmdzilH9mdUKE=;
        b=M1RJiphdP5y2FZbyx2CNnpLv/K9/cAK8GR5d8bYeBrKMIDmoTfDJJeGZnzw+tVC5xQ
         1ZZGNtTPK/XFASEbop+aorrpFgFX4Q2qDaQ7t1Gyen02THreJFYumzcDDPlxx+nkkj89
         E30GXCGyLYhsf6xNp45WsQMe/7xUXKb2OMTfnjutGIRwrOtkKjF6st4haBTOrqENBXAx
         Ef6wqpr+NOjcfUXB+zVEtW/WRdOIe9uIiU0K7HfCrw26xxLMyzj3M/hSWYfzQmTsloyU
         gOw3WENlqj9wqK1JFswlbk+T8P9l1+ifdGWYSj9XQfIOAsnaXJIldEWmJ6cCT4lstkFV
         zbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793868325; x=1794473125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pDxvxLItiSCdu3fsI80x3ws6o0fFDQAmdzilH9mdUKE=;
        b=0wkPChyh2+rl28SezNz31zFdJ0FRnmT8YKkGdHZkgE0T8D8Oq0Eu64IfK/fTwOxMOh
         KlCqCanI5H82HFqtqOBeT4UH0qo3x9lyYkxfNwyp5btR+Bzdzow8Ee0jsporFS7uwz9g
         dQbmFCyXxA2LbBRgb39i9jN6G7QUoBb/2FnPqaWRM+d2Alz7cBEEeScPCftOzUxyndOT
         XlC295CG90vo2Pl/yBbag78DLTf7Tnjcc1pHHWMocKNJrabITfVCsNyzDY5wa7QiyYL9
         17DYVROjuSG2GGP8fQEG0aQN9Dxbz6YuPM5bUuIMnBrBlKi0tY8u6B6VTBWHeaZ8EOqP
         Bq3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwxiyEO/a4HQrztEoO+7iLl4J+gxW0impGugntPcWcKjksovofuOmn430TGahTA6YAOVWBdMHpqB37p8dzNvcs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4GB+retFXx9VzTH1sJWig6ifPY6dUCVJGUmm6EgKy5OSFK/Mb
	UipfpKg17PJLQ40Oo/V3KT1T3ukNbt9tnoCH7K7rmWtRVEESgp2i74NC
X-Gm-Gg: AYBFou3YMiu/8dx0wnmUcEAkVWGp+2ITMh/jNDKd8mqXoVbmPFxVw97rprjiabPky+J
	UAmeiVT6CM3PWW+Z/JWEtUBGPMYaZG+FZ/Hx3gSbKygIlBGrgJP2Spr9+NrsD/9q99qydEkC6s4
	A5EuavAWzpH+pCIbbIUxHwhjZptXyL84Gcof8ij2qWlzUqcotnsyaYiuKTE5S2/UgPO9zieZzOa
	sMPpT5V5e2F8uv9H+EmJ+t2V83o7xVeOM69hVbZ1saVBgJF37MUDIed32D00Kizx0nKvjJdAF2D
	3o+uCpNvPUHIWwpOtDmHqXNHX+Ff1W2hQ3amAPZhRn7/WIAmQcslcrTkbYWP3KRT9uFfjD0CJES
	7WUexmDFI1P18lhM6KfNI87de2mLXsmsbheq8XR+bl0JAB0Xx2zJxdbQDZVHSpr9NLqauOOs+ou
	58Vb3LQyguBBqS93hGFLmBaukB3hddDnPOzSJ8TK3Y/QUQnPusal9mmCv+j/1ozjk6fSp4uEVOT
	/jNfc8Mlv6kWetTPD62hj4eM45CKvvH9rP7vWGf5N36d3qtXM5Iy75clcUJU5/1kwmn1gbcoApc
	UvWj2EQKB4Z52yta68xiyOO5XnrQ5K8vlajk5uodkQea6YWsnoAYcTjU2A==
X-Received: by 2002:a05:693c:6393:20b0:369:f291:49da with SMTP id 5a478bee46e88-36a4243f71emr27802086eec.40.1793868324397;
        Thu, 05 Nov 2026 00:45:24 -0800 (PST)
Received: from homik.search.charter.net ([2603:8002:ad40:56f0:ea48:d21a:2ee:9ca2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3788bffsm14468573eec.1.2026.11.05.00.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 00:45:23 -0800 (PST)
From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
To: nicolas.dufresne@collabora.com,
	benjamin.gaignard@collabora.com,
	p.zabel@pengutronix.de
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kees@kernel.org,
	justinstitt@google.com,
	morbo@google.com,
	Mariia Nikitash <nikitash.mariiaw@gmail.com>
Subject: [PATCH] media: verisilicon: Replace strlcat() with seq_buf
Date: Thu,  5 Nov 2026 00:45:18 -0800
Message-ID: <20261105084518.386234-1-nikitash.mariiaw@gmail.com>
X-Mailer: git-send-email 2.43.0
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

In preparation for removing the deprecated strlcat() API[1], replace
the strscpy() and strlcat() calls with seq_buf operations when
constructing Hantro video device names.

This preserves the resulting strings, including truncation
when the compatible string and suffix exceed the destination
buffer's capacity.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
---
 drivers/media/platform/verisilicon/hantro_drv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 26e5d5547466..2bfcd45cc55e 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/seq_buf.h>
 #include <linux/slab.h>
 #include <linux/videodev2.h>
 #include <linux/workqueue.h>
@@ -883,6 +884,7 @@ static int hantro_add_func(struct hantro_dev *vpu, unsigned int funcid)
 	const struct of_device_id *match;
 	struct hantro_func *func;
 	struct video_device *vfd;
+	struct seq_buf s;
 	int ret;
 
 	match = of_match_node(of_hantro_match, vpu->dev->of_node);
@@ -902,9 +904,12 @@ static int hantro_add_func(struct hantro_dev *vpu, unsigned int funcid)
 	vfd->vfl_dir = VFL_DIR_M2M;
 	vfd->device_caps = V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_M2M_MPLANE;
 	vfd->ioctl_ops = &hantro_ioctl_ops;
-	strscpy(vfd->name, match->compatible, sizeof(vfd->name));
-	strlcat(vfd->name, funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER ?
-		"-enc" : "-dec", sizeof(vfd->name));
+
+	seq_buf_init(&s, vfd->name, sizeof(vfd->name));
+	seq_buf_puts(&s, match->compatible);
+	seq_buf_puts(&s, funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER ?
+			"-enc" : "-dec");
+	seq_buf_terminate(&s);
 
 	if (funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER) {
 		vpu->encoder = func;
-- 
2.43.0

