Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022776;
	b=H/hGC3QfQ8OOsGpDO7z6muFc3Ulxjb/7y+oiPpRL9pgDVY8sxxBXYcULDbqq0XY0boL1
	 GTov2wFAI1IcPqGdUAa/ue5Y0roXbMqsImKW7OMAQ2kPWKFT7gZQYWOH0cpkDZglaCRAA
	 NA5qaMZnFGB+5QRROLZvhLTWQfe1PEnJYV+e8vNad77LlIrs4zOhMx2o0Dcntf7QOm/vT
	 gFFpxYqEfX9siKx/hIg/2myCkOiO6xEXMO2pyEHFqXNkSypRK0iKT1r2G0BDH2kAOHfjU
	 acrim3SCP6dfPFezoJoHHylKP3MyZjW2AqWo1cEqeSv0ZfuK29dzGIYsm1ILG2W0neQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Sde4rWYPzlk+BjvGEtm/0bEjWk4rqiDVQzGqAxbKKl8=;
	b=ynKhoZXGZqixbWpTpcoaoZbL2QXxfFjS29yAfBgzIXnDiwkfL7BeqH/3TMmTBOzgJeXe
	 z2jTlGPfSt24UXgDNsyCgVWhGUsL13hpanDsjkm4je/T5GQf4Ndf1VKWYlJFR1Sp7WvMF
	 My4OOA8dtGNN0A2cG4911pUVS67RUcwkieEP/tPigaD77jRRPIFbkRInR7Kc4A0P70l8d
	 6CVCTB9NKz+o5euomL9VpMRek92N2LgCdq3lyuy9G1ScMaMdJGQAna4scVRBo6I0yo1Y7
	 Ex7Oeuc8+cP9f6v046XoNC/3jqh4zG6jE0BiUj4C0U5jdscqOFqRMsw8iZBjrBvaBCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DvtMkzgz;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A13606A32E
	for <linux-hardening@vger.kernel.org>; Sat,  7 Nov 2026 03:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94A13606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DvtMkzgz
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso1946560eec.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 19:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022775; x=1794627575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sde4rWYPzlk+BjvGEtm/0bEjWk4rqiDVQzGqAxbKKl8=;
        b=DvtMkzgzjLMcaDQoyNjMQKjUQqxyzlLBiQUkoif9cFrK4HXhCvPfUWH4F4+h+8f5HW
         +NYmIIMExeqOloneuyGJPB53Xjg+3mlvtFzXNhw+1Mhg/Ay/fE8H1TazVpzMYFLmGp8U
         IoOIkP6qV4Mybf2IeOVuYOXhvi2F7j4ej16WFry6WxxSRSOCo68sMiZIstPgpuYCh0Mj
         J4NuXpfR2jhLFwL09bkvkL/gW76a+/8SP7X9ysVqq/y+2J509YDGFZZ6x/BQGQ+sauim
         l5/Aatx7kFufP396rJ3KVLrv5uwLI9zyY7c/NMYY8oTc/QDMUreCN/46UrKltJeyzqP1
         tgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022775; x=1794627575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sde4rWYPzlk+BjvGEtm/0bEjWk4rqiDVQzGqAxbKKl8=;
        b=npeHEkmZjRZBaZ0gYIUQqAOLCUUM40/S9ZK2HssGIaNjbFK9Gu6GF2dzCBSs+TfrKs
         Nu2UXA32vu3aIiqCrZ+O1vgx5SFj3KfVij/u8Jj8nyiOmgWBQrpWb4ESTjYkGN9VZLwo
         ifweNovHIXqkfI/J3Bg6PKPWvnO5gECycm6LPpbJaaO5d6RErgSFv+uXo+9foVZim0m9
         EnImVy88YEUQ2m4e1+o1X/ol37O8MTlY9YBTKPoCx1bgJYErtk3E/XcFZ8KL2qhNTAv2
         H70oS5+qLNwfIW7ZsxEd/atcw3t9aB0OKUkJ9dtJzal9Tl3b+nOgQRZ4S2uBh7zbzUpK
         q2gQ==
X-Forwarded-Encrypted: i=1; AL+hErFmwX7zpOQ/gnreI8Gz+Jcdl2njpPI6bp888jJgHNWIjzp3UvvUuBer5nDacClM1UhMSwT+8BNeAxUVo6GR+eo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bEm3ZQzuuHtx1qjLhTOMYjTHw8ASd0SYClkaswtzkepwqE2v+
	AL8MCBk8cV/FoG4gCpY55Otz5krxFJ+B0J1+ASpKrnXT/WVR4i4lCN6a
X-Gm-Gg: AYBFou0JWLaZvQDb/d3pV4hhlsaQNJLMFx0OinExcacIBlkz5NAJ+11v6dpmKAMBGLH
	FFx3SKps3hGEyyCYeT2UdN8E7s+Pa/RyHcL3O7gWHEvyP/RBotEVPBGD8ZsCJO9p5O2OKv5iwq/
	T27oC+5qE8G6bEFP24rOcxxItuVhMRm06uetl/IbXjaSeM5D4QiypXlPw5WBiNBVJCwareqCCMz
	GeRPf8Gu+Bi0rWMTqJeEUDpaJvBA6CjHYOlysgnnnhM7a6dr06vUHdwFRtnYhnuwO1FDc4ZRWI1
	BHgQ1jSwzDI/CrqWsklMfnSZuejxosHSjQgume5SpMZpq4pGR0beNSH/zHxceyn+y7eaMo5Qmvo
	F39bY40GnYZkik8TY1UT7++TjgwEaecYQxCmMefCT+FNxkWeN22zAI8baSvfGCghM38OoY0FvYK
	iahMwkyv6aGjBwcJsWKkKj+0UDDWcuplUxsgGUu0DUgfLlgV99KJMSNaJ8yetuTV4hts+/hOmrd
	iZLZ5PbyxcuXc57s7T2+jndAwN+RufPlNweOte3pudeyW8x/Uct5juc4RUK3LE+t/jkBcA8pkqG
	G3fc2ozAhX8ptBfb2wH6E+7PpLj/62J+L5R07y6gcX6QasLOjyURn9+J0zQ=
X-Received: by 2002:a05:7300:10c:b0:36a:1e9e:ae61 with SMTP id 5a478bee46e88-36f7710a6e3mr5903376eec.38.1794022774554;
        Fri, 06 Nov 2026 19:39:34 -0800 (PST)
Received: from homik.search.charter.net ([2603:8002:ad40:56f0:e335:1852:72d2:7bdd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa922c6c7sm13790821eec.10.2026.11.06.19.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:39:33 -0800 (PST)
From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
To: mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kees@kernel.org,
	justinstitt@google.com,
	morbo@google.com,
	alx@kernel.org,
	shlomojune6@gmail.com,
	Mariia Nikitash <nikitash.mariiaw@gmail.com>
Subject: [PATCH v4] media: siano: Replace strlcat() with scnprintf() in sms_ir_init()
Date: Fri,  6 Nov 2026 19:39:28 -0800
Message-ID: <20261107033928.13891-1-nikitash.mariiaw@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104090239.311074-1-nikitash.mariiaw@gmail.com>
References: <20261104090239.311074-1-nikitash.mariiaw@gmail.com>
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
the strscpy() and strlcat() calls with a single bounded scnprintf()
call to construct the IR device path.

This preserves the original NUL-terminated output, including partial
or omitted "/ir0" suffixes when the 32-byte buffer is too small.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
---
Changes in v4:
- Replace seq_buf with scnprintf(), as suggested by David Laight
  and Kees Cook.
- Remove the unused seq_buf include and local variable.

Changes in v3:
- Replace snprintf() with seq_buf operations after reproducing
  the GCC -Wformat-truncation warning noted by David Laight.
- Drop the previous Reviewed-by tags due to the implementation change.

Changes in v2:
- No code changes.
- Remove the statement about buffer capacities from the commit message.
- Add Reviewed-by tags from Alejandro Colomar and Shihuang Liu.

 drivers/media/common/siano/smsir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/common/siano/smsir.c b/drivers/media/common/siano/smsir.c
index 283770d583d5..6952871c5816 100644
--- a/drivers/media/common/siano/smsir.c
+++ b/drivers/media/common/siano/smsir.c
@@ -55,8 +55,8 @@ int sms_ir_init(struct smscore_device_t *coredev)
 	snprintf(coredev->ir.name, sizeof(coredev->ir.name),
 		 "SMS IR (%s)", sms_get_board(board_id)->name);
 
-	strscpy(coredev->ir.phys, coredev->devpath, sizeof(coredev->ir.phys));
-	strlcat(coredev->ir.phys, "/ir0", sizeof(coredev->ir.phys));
+	scnprintf(coredev->ir.phys, sizeof(coredev->ir.phys),
+		  "%s/ir0", coredev->devpath);
 
 	dev->device_name = coredev->ir.name;
 	dev->input_phys = coredev->ir.phys;
-- 
2.43.0

