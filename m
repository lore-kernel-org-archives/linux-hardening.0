Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363509;
	b=B4+ssXtLnKsNokOv/9GHJ479kLjKesDVCebBSjgnpDDRpGDjEcE0WFDu0WPn61KJITgz
	 E5iFG9z4OpshUqbxK78iGNFenQ3EYUCP4f2FlEd+rJRw1v6G6FNzGnTxeivOrrxMl0a1K
	 eCLoR2PbURSgwR18M6GBrv22P663IPT7CmNpELLnmVvVMvVFPwSkcBA/8Z1zIXIXkYUG9
	 qr/VfDIF9NAQo8v/eLYZNPJVQxaPMIDs7TbSEl/GXi28wrT78/2Npq2AZqUApmQefmNk+
	 2dhW0JRdk1LAwtD4DcM5kbfUN1upmsm8Q/iWzDfViA9Cqo0oY2BDOkO4zctU99AMSuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363509;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LrJY2Fwepo7894Ql+NtyrHeNRWa8RX4cvLszfyzbChY=;
	b=OOK+Cd5BLPLtr+TlQwPu+t515DgrEOIS7Q2HzjOKeGhfDTh2sGqtHGYO86ZtLsqae/Yq
	 bISTrFP0jmwVpZ4TtFkGTOfK3UOoUYHHXOpyMLDQWiGeL0AC7/96z1Tdi8n+To2VwIolG
	 oOxOyP1lUz24AF4n0b8jUAo39feTyxB2UrsOPcASovxZDETOKwul9IaHD8XZsvtipcHFW
	 4bcrBhrN+BHvl/WDql4RZjRReN4AThnqH7F51Wap7F+2SGlf1hi0Fh7adaNYSjGDXE+xO
	 dMBuDloHZz1gcxfyZ/ByXpo+LrMoBHohHi/KtEQzLQTnIfdd2X6p+PjDdr1Qbkvz/ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QTFXJwxw;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8CE606A32A
	for <linux-hardening@vger.kernel.org>; Wed, 11 Nov 2026 02:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B8CE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QTFXJwxw
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b17b277a68so390021a91.1
        for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 18:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794363508; x=1794968308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LrJY2Fwepo7894Ql+NtyrHeNRWa8RX4cvLszfyzbChY=;
        b=QTFXJwxwMGi3KYiPUC3uGm1ejP9JeD0ap+Sc+8ZKk7AA+OBcdrTjSUDDEQ80ejyupY
         tnMsX6HSAMgzQmFT6Iu5Ulyf4l14ZD1Zr7JmfVheB3rz6DhdPbG7Lari0K6dMpx3GFu4
         yrVSfdBjNtgTdM/fAaEkKnGzFyI2MFr1WprZz1tS7CiNRq5h66zNeQ/HsbmblmiTV/AR
         3MFT4TAx5h6bEzcjG3Gdx8QGBDJuOlE/yUFfCxAmlWRI8rSJ5MYrQCI0iVpLUAyDh+xH
         N4CwaLOKv1KwXRF7RsPnxQdQT1vHhtPJCeV/aF19kPrrPj4gRCFZaXYHzCkWKfIrD+Mp
         sp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794363508; x=1794968308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LrJY2Fwepo7894Ql+NtyrHeNRWa8RX4cvLszfyzbChY=;
        b=xOM1gAaFf5pBvh7MAwnJqIfwIitNRD3jvrd/JlnYZkcAbVGUBFOH0xiV6ePN5M79DU
         IjvEPboWjxj29A3NDG6AoYXKVQdg32oeruInYWvOeHQHlf1icC5gHHrp+SgKo6EMqQxn
         671MR76lEepMpd2DKa1+TylO0C0LnnTTqqh4un08UNhH+WLuUUiuYPonfmMk+5XkQPcP
         32eUqWERKBv6G3iBVz2C+rZD9Kr0EuVLXZTKHdDP/glY7PxwBic8bigck2LFM0FT5hPk
         7lMgGm9uhFRJ+xcW0PkX7nlxlgUWmtt8xlplvww88gZA3jPmKdOfVMBIt+bqP2ssD0jq
         hxag==
X-Forwarded-Encrypted: i=1; AL+hErFQ/dkT4VzgRryBDRg0tHTWgTBISfNNtXIRIZDeCz/Xnm9ht7Pc8zGBJib8NNKHaUnMK33pprJpgC68YOVszPw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Os9khYPUU0sJU2fl8J62sLULqtEliqw9n0E999uMHph1Rc9j8
	4BBL9VC7xahNuk2nwM5QT4otBK2shPb8UagBshh2OW8tdFjJSGq5LVCf
X-Gm-Gg: AYBFou2X+srR5c4hOBC/q7Vu0O00s8UWT4NZ924r4Z7/zPf44GImTyVx34VX9q3Nsxj
	nMq8kzP5zmFgFfd8UA4C9vWjWcX3GeX6cE07fBldjyM5uBP5IPvPAY7TvZcnPYPrWBC/f1kQK1i
	HiVb9krrgh4ZA+J9FdDUWAU+1lqU/3yzY5eoscgCuq/INOa8z2Xx170pMwrKViWF2hNCkXA/P+x
	fWyhzkL2uGvDwl8k28MDVoIKFewg3IQiMZiZ9nkKlRHxMHwyRMtAxP0RN1+UsRI5dLjvLaf0H6h
	3YGQxQSsUoWPFl9B9ItgOirEj9dtEBMjzDjo5UDlTB83hldZI/+x0agouSWr795DAzzaJ/dS/TV
	CHTXEHlxlQ8exzlQF1EiB1fGLeeUn7+RAExNxwiGnFQr7eU4UGpSmT8zLNL5AXBVTHZI65+ToK2
	eIWnNvEVV/lpNjmfzk8iY1aU7MZ1uoSCgOerHGH3BwM3Qyiji1LD/D7lz6sXDKWNpkYyYJHJbLC
	mKauzIm/2xCYAseTu+qbgbDO3znMYxdgQrJbLQf/+upS/J8OCaFw4AL/SkYvX/U6fwidTNUaxTG
	yQSL8eZX/3rvrpAPldsEjJmJsbA6EGd2BOVDqRToqP420WZN9FkZYXQhyKOzoisVprLc8FzfxCw
	cZ+T8rgtkwopLV66ERdEb5SgzOXGXXkbMFKIb/4+7AxVDoWBteGxs7P8a0QSZ9BjwscPoBMSQXU
	cH76noAWfVPDYIEnvpplwAHHlo
X-Received: by 2002:a17:90b:4c50:b0:3b1:6cab:f68b with SMTP id 98e67ed59e1d1-3b182ec2051mr1060564a91.11.1794363508275;
        Tue, 10 Nov 2026 18:18:28 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db9d1fbsm2034540a91.15.2026.11.10.18.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 18:18:27 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] EDAC/ecs: simplify allocation for context
Date: Tue, 10 Nov 2026 18:18:08 -0800
Message-ID: <20261111021808.60779-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Use a flexible array member to combine allocations

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use devm_kzalloc_flex
 drivers/edac/ecs.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/ecs.c b/drivers/edac/ecs.c
index 332872d4214c..e7f7e189cc76 100644
--- a/drivers/edac/ecs.c
+++ b/drivers/edac/ecs.c
@@ -33,7 +33,7 @@ struct edac_ecs_fru_context {
 
 struct edac_ecs_context {
 	u16 num_media_frus;
-	struct edac_ecs_fru_context *fru_ctxs;
+	struct edac_ecs_fru_context fru_ctxs[] __counted_by(num_media_frus);
 };
 
 #define TO_ECS_DEV_ATTR(_dev_attr)	\
@@ -149,16 +149,11 @@ static int ecs_create_desc(struct device *ecs_dev, const struct attribute_group
 	struct edac_ecs_context *ecs_ctx;
 	u32 fru;
 
-	ecs_ctx = devm_kzalloc_obj(ecs_dev, *ecs_ctx);
+	ecs_ctx = devm_kzalloc_flex(ecs_dev, *ecs_ctx, fru_ctxs, num_media_frus);
 	if (!ecs_ctx)
 		return -ENOMEM;
 
 	ecs_ctx->num_media_frus = num_media_frus;
-	ecs_ctx->fru_ctxs = devm_kzalloc_objs(ecs_dev, *ecs_ctx->fru_ctxs,
-					      num_media_frus);
-	if (!ecs_ctx->fru_ctxs)
-		return -ENOMEM;
-
 	for (fru = 0; fru < num_media_frus; fru++) {
 		struct edac_ecs_fru_context *fru_ctx = &ecs_ctx->fru_ctxs[fru];
 		struct attribute_group *group = &fru_ctx->group;
-- 
2.56.0

