Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4D0547077
	for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2026 00:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791159108; cv=none; b=F9VOLdfIEspUmIfmVW+RXbHVs+MNVHmdxYx9kdmJWTwlCq/HyHnXtG+BcYMxQrLhMD6E4SxcEbia2bNRspVufv4Y2ozfHSs7F6THThu3S7axogyLWu7dfgdUQIu3T+0wsyXwb6V6Hcm/4UhXq/vy5Dh7s61GHDO3BTZ/drNABAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791159108; c=relaxed/simple;
	bh=296SdEqVR+pPMlsK/a0UhLFwbJBWB82EbfeBWYgP+e0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DxJ5HPO+7sEOOJwz1qD3nterfE33bMvb4dQR4nCf4y6efpo86LXHrnRtkCbHnAN4Hsx3rncgZAqh7Tf6/83zGH0cZyiz0vF1w5t7NzAc9sC546ZALs7d/ZFWWjvRos+dNC5deuPIpQV3Lf6XY2Hr+xACThXSaHzOMq1yQ13j9eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kB4fhWe3; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kB4fhWe3"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-34b1743e9c7so1066658eec.3
        for <linux-hardening@vger.kernel.org>; Sun, 04 Oct 2026 17:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791159106; x=1791763906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LFk7ga35z3NrHS6umKXq0xUG3dzK46r7JSMoXY1ndGw=;
        b=kB4fhWe3L92jaSWIfsZjF5T1rpLcyzIHHJ0ZAJC3lBVd+pHqhxdAHf1ogAxNZEdAPc
         VaWWQj064PwGUvNMH2QB9zSimpi0FRl5XYsUOwJV0qRoWSivVTsxUTaJlirq+eNWmAxk
         pw02/aXmfEtNRBVzUsKaoZMgsMnjWWncXDaaZF8x/RlESdEf9FPd348hoJQyf0VvK0r0
         skf+QB4UFtv+LzDOhhw4Jms5+ouYlqYlwXltz+ICuR8u0suBkq9j/9o90k0rPOjs0BT9
         aT0h+hLt3+xyFD8J2Dtd0CkGG59ZM+K3dBCcudAunuOPEfKWWlC/2N7pLKFAYS3LQi3z
         AiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791159106; x=1791763906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LFk7ga35z3NrHS6umKXq0xUG3dzK46r7JSMoXY1ndGw=;
        b=CyUpAJHLnwZcTgECMQvQ9aAwm6Nf/jotZoeT+GdC3wd+Pty/yo/4hxqWG35qxTOREt
         TB37Yy+81UxIO/MVt92zCClo/Emq6F0812xomCLdrUFeKzPydUnsvqceZ3EtBW9rZfcz
         l6FMKJZ8uA4VEi1AN3AAHDFi2n3pxIX40Tjg/GqywdUud/gpFYyLJleU5E53AV+iW1Dj
         n87elKkwAI8M2xNRvVLwhARaA/TO1+AG+eKRKQ85HrVeC9FoGVz404yrpyMc1WvvIaF6
         g8Cmr/6RE/hTN/LazsNN2eyfezkk+Y1vVHcddfHcpx5pDRReiUkZjDWXaHkD2JqudHyH
         seqg==
X-Forwarded-Encrypted: i=1; AKwUvBwutvLaJwzKSqyGMcENIEKzvQJ2kt4KDDB4EjhpWdjEimbQjZMFxt+HjWwj9SZv1VNDZ0Ik5F9IkJqJu2EK63o=@vger.kernel.org
X-Gm-Message-State: AFuF++lci9oQxu3HvQbAOgXxG/pWgxX5Ne7KWocEpPPrdp5SS3MEdQdJ
	t4EsP4cuBuJcfXgnu/CYGYAFNcC8BJxyINbYXrMbG5im0WqjcaafR30h
X-Gm-Gg: AYBFou0kE9ZTrtKYdkaG35eTxGFV2QFGCGkKuaf+h6NHWgtNwZdidEfmYqiOo9Bpvsw
	4HaBn3genZPii6Dx5mUxNuGN+PBmI5nrfNu3mEb27rLRt8e2uq3QlHQB0HBZ3x5qKNygjatx0gv
	OZjQY5lPnWN8YCm+Hz/C4FAzJtsP/o3291AMMdUnypPJTaLLaUNA3XHRqSwwiX13gz9XWpZEFD8
	BK07kHjoDQqeZg+/n2YWGYVriaRqrQ86IfrSqRv4d3+xM4O9REo9Z3xWbuHAXupj/GufOweTHeG
	7joBJjf+ckuaNSrlMNXuqNPxCI9UaE5a0YyM8fPvuLjjwo+TWACd/v5DoLkg8GKKNDFs6kKooyP
	RqWQuHafaAAt7MNog+qQMBCF2YfFpGZWIfPu6byhS779Nw+lhgKRWimP7KQ6ZTDrLBrNlOpomeH
	YtfvQOEVPJtzzihLiO5sRL0bp+Jb5S2Nu8pKZJLcVnY64hKk57MQ3gTpwtGUGslONHNBl517I3I
	aMFdQWmnFBh6N+A9aPCjIv/iBTxG5sSC/Nkj1T1yeyLnUt6Qcov2kWo+boBhD5eWR2RHJA4mVlh
	MDgXaTZB0chDSMHIim743I2sK1V8wai5Dup62XQqBMFAq/j7
X-Received: by 2002:a05:7022:eb47:20b0:143:7001:7643 with SMTP id a92af1059eb24-14f5cdc92f3mr12086833c88.46.1791159105797;
        Sun, 04 Oct 2026 17:11:45 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fc39a6cbsm16540732c88.5.2026.10.04.17.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 17:11:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-samsung-soc@vger.kernel.org (open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH] drm/exynos: gsc: allocate formats as a flexible array member
Date: Sun,  4 Oct 2026 17:11:43 -0700
Message-ID: <20261005001143.576737-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The formats array is allocated separately with devm_kcalloc() and only
referenced through the gsc_context. Make it a flexible array member at
the end of the context and allocate both in one go with struct_size().

Annotate it with __counted_by(num_formats) so the array accesses can be
bounds checked with FORTIFY_SOURCE and UBSAN_BOUNDS.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_gsc.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index d9637ddfcfc4..f1807ef664e1 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -99,7 +99,6 @@ struct gsc_context {
 	void		*dma_priv;
 	struct device	*dev;
 	struct exynos_drm_ipp_task	*task;
-	struct exynos_drm_ipp_formats	*formats;
 	unsigned int			num_formats;
 
 	void __iomem	*regs;
@@ -110,6 +109,7 @@ struct gsc_context {
 	int	id;
 	int	irq;
 	bool	rotation;
+	struct exynos_drm_ipp_formats	formats[] __counted_by(num_formats);
 };
 
 /**
@@ -1222,21 +1222,19 @@ static int gsc_probe(struct platform_device *pdev)
 	struct gsc_context *ctx;
 	int num_formats, ret, i, j;
 
-	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	num_formats = ARRAY_SIZE(gsc_formats) + ARRAY_SIZE(gsc_tiled_formats);
+	ctx = devm_kzalloc(dev, struct_size(ctx, formats, num_formats), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
+	ctx->num_formats = num_formats;
+	formats = ctx->formats;
+
 	driver_data = device_get_match_data(dev);
 	ctx->dev = dev;
 	ctx->num_clocks = driver_data->num_clocks;
 	ctx->clk_names = driver_data->clk_names;
 
-	/* construct formats/limits array */
-	num_formats = ARRAY_SIZE(gsc_formats) + ARRAY_SIZE(gsc_tiled_formats);
-	formats = devm_kcalloc(dev, num_formats, sizeof(*formats), GFP_KERNEL);
-	if (!formats)
-		return -ENOMEM;
-
 	/* linear formats */
 	for (i = 0; i < ARRAY_SIZE(gsc_formats); i++) {
 		formats[i].fourcc = gsc_formats[i];
@@ -1256,9 +1254,6 @@ static int gsc_probe(struct platform_device *pdev)
 		formats[j].num_limits = driver_data->num_limits;
 	}
 
-	ctx->formats = formats;
-	ctx->num_formats = num_formats;
-
 	/* clock control */
 	for (i = 0; i < ctx->num_clocks; i++) {
 		ctx->clocks[i] = devm_clk_get(dev, ctx->clk_names[i]);
-- 
2.56.0

