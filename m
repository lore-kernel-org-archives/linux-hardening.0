Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7341F37D8
	for <linux-hardening@vger.kernel.org>; Fri, 27 Dec 2024 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735319127; cv=none; b=R+rSZIX1uibDMFTFPG/nYOU1hpxFcidP2skxIZ9KVLQq0smLlsqkfBNJAQ3HIF/R7nM30pzqCKYOZ8eeyV1Dga9CjjufGHvIGfBatzmgHC5eGMhwMlr7IXt5KhNZKui4Y2WWaaZrmt2hQJb2NJ9wKbl3DiL+3YQFXhqcjmew/gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735319127; c=relaxed/simple;
	bh=GuA0j69T1D3jsUbbW6hksH4jvBM31k0+FtA0xn79RIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJGFOs+Dz6+QIfV5fYYO6LzvIhOZTlbgprNJ6yakKZqn1LN8EYBVyDWd5o44mrXRcxKfaEDRLyLE6NaMW/0vkGO1we8M1RKO1tPwkaOle/Led3IOAdE42KLrOyy+3Xeu3Vy7X4glCeyRN/k2mWjuqPg6SFH5FSvyR2OL/uwBVvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ElvslgJ6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ElvslgJ6"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361c705434so53843335e9.3
        for <linux-hardening@vger.kernel.org>; Fri, 27 Dec 2024 09:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735319123; x=1735923923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xMcLNXQnlCH4FzJqvPVgoMuXM1P9VXAukYFlxhbLbv4=;
        b=ElvslgJ6n+OOcn1vMYLG1hXY956ZV+MLavuC0EZwmoH4qMStj5I68A/oZbO8dZDwwY
         fbp1AgQZM18uCLY+fAyZ4JsZvEIfkGKfQB0T1N1CdhMCgiqpvHAARxPfR9ceScFUTY41
         GATV7/fqo+378+KbXajffsQcjPDa+TNo1kBDwzNcA0bCzVFLWUAQZW9v0J49r7LEjohC
         Ei8Y68fFJpSScMFDE5IXdq5mivzFsDB2VYyjfcjIsQusygabEDhhvwKV54ml0mo7SjOL
         Dr35V1j5x8hObCFSm5hPixCmL+y+c2ShahugMezNtZGWYrsKfT/IYGlyKgEQDxENNsM5
         NZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735319123; x=1735923923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMcLNXQnlCH4FzJqvPVgoMuXM1P9VXAukYFlxhbLbv4=;
        b=MDXIXBfYckp3gRLmswPusZZUwd8ZC/nr5uvN5JoMWwu+MoeXhsFZRkPVGvtlMj48vp
         LTuugwtGw/ITgyK7WEFo5VYHj1N2IzLOICw9pLjTF4Kwsop1Rt0oZAawmkUIfvWy6TOJ
         UbWjyfDJbmlzHYP5yn6ftuFmCV1DiZnDKPISjCN6unH76ZkFUNdlyEi5X941NuTpZtBg
         X2/zH8A2PnF7NahjNlseuToK/XtV2TiHFdsYChgszbM49IlcEy329ZbKP+7xLkiP0Q6F
         aNCrYUdm4/h/CWSw/wNe+nBX/eaeRTxEXDGBpyNG1kdhROP2zRCZc6WJonn+U1FLeJvc
         +b6A==
X-Forwarded-Encrypted: i=1; AJvYcCX/WPrxHGULbv0bOAi3VEjnizE2dBmRNeD2yl9/rjOGtvRoRagjmtyqIfXyY/1EvqvTKXndTIIV+aMAVXRbItQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBaOGSxnbtnBDmJ0M3p3mrCI5VjIQdxeNZC4KOg4JHdpWKs1Sr
	q679HwBPUc+WiJ3RVWDDYHUMXfrlA4PQepr3aO7ikVE63b0K5pwXJi7yksafgj4=
X-Gm-Gg: ASbGnctXUYkvIGLlOCni7VkEhmxPyxBSGQqCrq6KKWxezw6xgvUI3uegyYINY+2nm7q
	feLp5G0E6yqGM9dUP+7KTb+vH9J6OUSFuJP12M1rBmO2g0cqr8/fplyGjuyUT51M8Rj/b/AQLOy
	Vi0XVBuwM2a3Qs0MJ+DhND+7jiGq7hbyXGlaswOs9aesqo+wANxB0C6x556Vdhb4qMeH+Sa1UKP
	XDDzc30ui7RPJeXm7cv1F770VFx+91Fpoj07sQrW21aFdkbZSdOcT3kw9QOcQ5XJ2XUSGwwBbJt
	Ptb1KAH2D/vYr6hdtz0FAA==
X-Google-Smtp-Source: AGHT+IFDU3ZkOXqXKFiTO0JarT+esB7agCTxP4IpEOU+r30w/WDOsLDilqrQ03YgwQwyYEZl9A2yJA==
X-Received: by 2002:a05:600c:3b02:b0:434:f609:1af7 with SMTP id 5b1f17b1804b1-43668547462mr226847995e9.4.1735319122787;
        Fri, 27 Dec 2024 09:05:22 -0800 (PST)
Received: from eugen-station.. (31-15-52.netrun.cytanet.com.cy. [31.153.15.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c639sm268216695e9.31.2024.12.27.09.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 09:05:22 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: liaoweixiong@allwinnertech.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kees@kernel.org,
	gpiccoli@igalia.com,
	tony.luck@intel.com,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH] pstore/zone: avoid dereferencing zero sized ptr after init zones
Date: Fri, 27 Dec 2024 19:04:59 +0200
Message-ID: <20241227170459.622630-1-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In psz_init_zones, if the requested area has a total_size less than
record_size, kcalloc will be called with c == 0 and will return
ZERO_SIZE_PTR.
Further, this will lead to an oops.

With this patch, in this scenario, it will look like this :
[    6.865545] pstore_zone:     total size : 28672 Bytes
[    6.865547] pstore_zone:     kmsg size : 65536 Bytes
[    6.865549] pstore_zone:     pmsg size : 0 Bytes
[    6.865551] pstore_zone:     console size : 0 Bytes
[    6.865553] pstore_zone:     ftrace size : 0 Bytes
[    6.872095] pstore_zone: zone dmesg total_size too small
[    6.878234] pstore_zone: alloc zones failed

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 fs/pstore/zone.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 694db616663f..50a765999b54 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -1217,6 +1217,10 @@ static struct pstore_zone **psz_init_zones(enum pstore_type_id type,
 		pr_err("allocate for zones %s failed\n", name);
 		return ERR_PTR(-ENOMEM);
 	}
+	if (unlikely(zones == ZERO_SIZE_PTR)) {
+		pr_err("zone %s total_size too small\n", name);
+		return ERR_PTR(-EINVAL);
+	}
 
 	for (i = 0; i < c; i++) {
 		zone = psz_init_zone(type, off, record_size);
-- 
2.43.0

