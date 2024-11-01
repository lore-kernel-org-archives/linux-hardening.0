Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57A1168DA
	for <linux-hardening@vger.kernel.org>; Fri,  1 Nov 2024 20:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730494503; cv=none; b=CKlU5IhxOXb8w6XbVtBdUgfiUuzh5kziwBRh05RIknI2XuecQUeOQBQXqdW8XdDJuJ1eSiYbVWRfwV6pDg4oFjXm8nLleAhTbJhRB0KSETVc6u2+um6Oo9T0oKg06jEG1d8ZsSmIHFjHPQF2nYG1ab+nJ9CyL86WfEnkAP8hi5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730494503; c=relaxed/simple;
	bh=4RROoxRB8fpvFTHrKZ9NejmpNSX4yec1eT70eaOuSC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZPw76Qzl8vkUGuET+Tn9UltOH+ts2woVsfnwsGHBG53bNDmTaSE6Fo7w129aPUfS0Cd9+APnvQXoQDTc+IedO2O/fbXCeMEIBfNNsO4J3mRpjLLJhRBPbnG7N9STXW69ozwZnX4oXrdAnI7nTWW0FfVeP4UHJ0Y9GKcpdqCxWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vX8Rsziq; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vX8Rsziq"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d49a7207cso1541837f8f.0
        for <linux-hardening@vger.kernel.org>; Fri, 01 Nov 2024 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730494500; x=1731099300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jLTdEDXvDx6C1+kdRWN0DBnWkM5vnWkdpplvs2TB8+4=;
        b=vX8RsziqWL/e7Ct70aTRl07kmCtIghKq7bQ46IWWc+WBabbjSOAbSUsG4CvlKzJ+G0
         KLtTJXY+5sfXVsISW22XNeDwbOSuIQgllkok1jePycHTJircSuXVmUCPnsvZt8M2wrgj
         Ojb/Asq98n4VFs8bIW2kf228G0hw7OBp6CAnckOwiiI2ud5Ba2hoUBtCvnV4QLWh0yU0
         IGUWczfA43tY5tur24rX6G/IlDyqBlYyhqwfo1XD6rq7Icyva/4lcJQvEbnRrdD379rw
         uJ0tZrlWgyMqf54aB0M7X7jNT6lH4KqYy2T1sdF9HtgpTQ3+/SNG2N2u6kIBF5qeFHZH
         BRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730494500; x=1731099300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLTdEDXvDx6C1+kdRWN0DBnWkM5vnWkdpplvs2TB8+4=;
        b=UbGIz6MsATQDkmS7ieGcN4GgLul+gQB1ovp5PzTx8PE2qAbPo+SrfPg1Hw1BXDdXr5
         ftI0Sqf4Flk6/9B8rLg9c3EKBB4UcXq4Q1gTjvjVsdfOvJwQG80hxf4Ur4e+oES529E+
         eyQzWENJAxLz5OG2M0Bm+unrtue3XyTTb/3+TUmaGr421csQwGVqBX6pCj7d0vl2ltOL
         wPkR2yd8K7oWxF/gphMqrYjd4npDZB68YwHr27Ee1T88LrtNuCe3c8916XknJmHgTgL2
         kg4cDC4P75VSid6B70MjXxLPtvJsAneL2Xbk4sxVt3jSo5nTDG2FdREFGC9/v//BnwHI
         WgVg==
X-Gm-Message-State: AOJu0YwH78ki9iZRicuE11Q0jcxdKKgtvpX6nQVYnpT2I8+TbyKEh25r
	2GO4YL1SJq2LRiVsmy6UdMf3Vqx9hSzFoz3lyMbpS3aFDRoYA37UrVOVPXXhb/s=
X-Google-Smtp-Source: AGHT+IF9SJTbl/9ym3H2HLLhqsElg5KmBrO4oJDVweH5FkNcn4aOm7mRNyiEG2gDz6qmQ/+JagSV1Q==
X-Received: by 2002:a5d:59c7:0:b0:37d:4fb1:4fab with SMTP id ffacd0b85a97d-381c7ab739cmr4123785f8f.57.1730494499960;
        Fri, 01 Nov 2024 13:54:59 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7e52:b53c:229:e024])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116af7esm6153480f8f.103.2024.11.01.13.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 13:54:59 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] lib: string_helpers: silence snprintf() output truncation warning
Date: Fri,  1 Nov 2024 21:54:53 +0100
Message-ID: <20241101205453.9353-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The output of ".%03u" with the unsigned int in range [0, 4294966295] may
get truncated if the target buffer is not 12 bytes. This can't really
happen here as the 'remainder' variable cannot exceed 999 but the
compiler doesn't know it. To make it happy just increase the buffer to
where the warning goes away.

Fixes: 3c9f3681d0b4 ("[SCSI] lib: add generic helper to print sizes rounded to the correct SI range")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Kees Cook <kees@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
Changes in v2:
- improve the commit message

 lib/string_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 4f887aa62fa0..91fa37b5c510 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -57,7 +57,7 @@ int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 	static const unsigned int rounding[] = { 500, 50, 5 };
 	int i = 0, j;
 	u32 remainder = 0, sf_cap;
-	char tmp[8];
+	char tmp[12];
 	const char *unit;
 
 	tmp[0] = '\0';
-- 
2.45.2

