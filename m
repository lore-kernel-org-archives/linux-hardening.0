Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793938621;
	b=nu4/5XT2usYfqJRMs2gM5nL/E/R9SDbgUR8g3CwkFTF67cws4GIrg1ssXeD3wOySfX/N
	 zse4sM5xewbRlhHZ/tjtyqmTRgzShxBc/hkXi6hJPwdGz7h3OQqAKoNK2w7pY7PtI+FiH
	 6n4FLS7C0+v7jj7b4hPM2Il+e8w1oUUNlk0J6DR1Yt+XhDbulNLb2YuCKHVbN+9dBqUqo
	 S8oD6mT6ETjAFaMH0vcbJqr72aprEUPzzlhDjIKCsYJUfQced5EcBs7Tbx4GGYJ1cVUDG
	 FWr0eZq/5nWAYfc6FDhz4//MsoFhK9AtnnjxaTTZ+MFIjDgKSdVKMQTKIV4QG85Uj/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IFRCE426UTc7sdwYXe1TU+8o/imwLSKisQnbNMcuaUE=;
	b=uUqT1jiSDd3XFiyIosMUPus+OLKlzaUL5AR0FehWLpmZPX0xTWEiYw4D42KEWsUinFnV
	 7MzQLGxg/wD71HRpfPLSDVW/zOYjyWsNH7LBTA/9tx1GESxEiVBj4cT1sOJilhGD4Bcnz
	 x/8d9yv3c2EfNHr2NHaQpBkGqIpARDOKXugXe7UeITeAliZhn4/V7gf5sy+tiXqpgJKhX
	 n/dZLoWR8IQASF/c73dBTTwYVGGsYGktCEntESOmzPlGDbOrOyQ+qmY3v9SpZzRl/t8j3
	 JGlgZWDWAVbIwmR/QMvzcYR6gvlY9JxVHKzV3qe3QTeru2EKh9SvrSCe7IAxfEc9vkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="0PSuoYQ/";
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E7A606A326
	for <linux-hardening@vger.kernel.org>; Fri,  6 Nov 2026 04:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70E7A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0PSuoYQ/
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-14394530ec6so380874c88.1
        for <linux-hardening@vger.kernel.org>; Thu, 05 Nov 2026 20:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793938620; x=1794543420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IFRCE426UTc7sdwYXe1TU+8o/imwLSKisQnbNMcuaUE=;
        b=0PSuoYQ/sCYEOgxrzrYUEjIs689Jf5aIAV/ibbqqocYuVykp3jPiOXUR6N8O0mRQ0g
         FxYoiOcpXXbj5DwaFwQIjWrFFbCgpi7EjrwRiykn3++Pj6+twbNrTV+jEtawKZgMlJFM
         SwhNl7gijMdnYJV3vldVZmtExXfOMWiSQCxMqOPwAfo9oN2/yxsGZivmuhmpeCGZcJM5
         WnBB0Sd2hyIYoHY89EYpDJ5cvhBnQ0glC22sFfqJWndLiUm+Sm/o4DpbJWrtsza/bVq+
         bx2zNKG6oJoTLNX6cuojFw16Lu7tNewxblxsSmEy75pjOQYUhzcpB/+WIZGXgzDjbWJ0
         55Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793938620; x=1794543420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IFRCE426UTc7sdwYXe1TU+8o/imwLSKisQnbNMcuaUE=;
        b=Z/ja8i9iBNlz2tjbuZkArJttaTRRwTgQJlONgN6fIqTgSKJg7p0u4w2g2LTgtOb7ec
         xODVTR5llHsHXyFq1/CvXjfIhjYxEZCkrFwJKShQ86jRahwntJ/cCh0kMH9QIiyW/6sz
         PfGJQT4mRscQrV8ziWhO2KyTHXtsL5Gxktp4ydV81ooWiUS6uJqjDKiTs452uJLx0WJb
         jI3VDjNww0PG4kbynRCeE/tgDOwWW+RqMsxE84nlY1KfgUDxc17o3fVFmjUM3pQy6IRN
         0E3sGdHCwA8oq8C8tRbWKrDxZrEZRbM8LzR3+wgYP0yWyOeQyK5YzT1YYperSHjLsNh1
         zy7A==
X-Forwarded-Encrypted: i=1; AKwUvBySGbChUL54A/pg63NdE0741O4meulBTYEP1uPw7LID9YFx3i3WEnSzMTX39nH0wxA4e+Gi39i1WFaO16+HfY0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OlNvlaCHMMTIirW/buEo8991sYu045lJHVuLs0fBEE2uBIJAm
	lU5wqezK1AflcqWA3Ry7EVE2lDEWsnAMDZcKB12ygB23SLlR0CZMd2lt
X-Gm-Gg: AYBFou00kXf9mzS0Tf5qN9WewZ3h9xKwCJ+GsAXRBesOKBMtLS8E8K/4drx7IKEMFEX
	j3eIGaWbywkuPyxEFtNbQtmlNtmp3vUwSfxiBzYvL94f73y42e7WqBRwN6f95RM8i9sg9/vE3fK
	wvoAW6pSvVvF6VODjPWsKFcfxXrPy7trXMhgN6/hi0VXEW6MRc+JIrjOo/J/dsy9gNTsOJrdxL6
	MnW42R799YYgw9GEYgPE2zWARL9BNq7d8tAgLvANIUfGrDV+/Q5JIxXE/+r8yDTtIlSRWaKwfQ5
	XdII+XdczwfR11I8d32QETY0Wxvf16VxmTDNOaaHrRjCpQ8O++g9S3aPj1Gb8ZfzbCMuHzeHygN
	MSCsgEBzvV9E42TTZgwL8ll94VRJ586P6uWaffzEVYyAkMdad9VWHIfDH5Cac0I/tUb30e3+sHU
	Rc3T0e0ZK+lZmAB0GoSHXQQz0B6jnRuw78i3UBIhYG1nTf5aOWlJMeLOFvQSU+A48S55ITRrYC6
	UwR3otnHBxM5tgVS5TSsQwTwfjbzhzQQwbIYEBJxz0CNUjhNKq0a6kbSroyryVKO37g4mvxqoW4
	MCeuclmO/kUjgkp3wB/gN1hoznRN181+fE6zZExJzgBXI/b3N2W2klrzJ50D
X-Received: by 2002:a05:7022:5f1a:b0:1b2:4e79:bfb0 with SMTP id a92af1059eb24-1b25d31aafcmr1190947c88.23.1793938620004;
        Thu, 05 Nov 2026 20:17:00 -0800 (PST)
Received: from homik.search.charter.net ([2603:8002:ad40:56f0:5644:8cb0:c50e:37b6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4f03f5sm1698464c88.21.2026.11.05.20.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:16:58 -0800 (PST)
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
Subject: [PATCH v3] media: siano: Replace strlcat() with seq_buf in sms_ir_init()
Date: Thu,  5 Nov 2026 20:16:53 -0800
Message-ID: <20261106041653.439536-1-nikitash.mariiaw@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104090239.311074-1-nikitash.mariaw@gmail.com>
References: <20261104090239.311074-1-nikitash.mariaw@gmail.com>
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

In preparation for removing the deprecated strlcat() API[1],
replace the strscpy() and strlcat() calls with seq_buf operations
to construct the IR device path.

This preserves the resulting string, including truncation behavior.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
---
Changes in v3:
- Replace snprintf() with seq_buf operations after reproducing
  the GCC -Wformat-truncation warning noted by David Laight.
- Drop the previous Reviewed-by tags due to the implementation change.

Changes in v2:
- No code changes.
- Remove the statement about buffer capacities from the commit message.
- Add Reviewed-by tags from Alejandro Colomar and Shihuang Liu.

 drivers/media/common/siano/smsir.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/common/siano/smsir.c b/drivers/media/common/siano/smsir.c
index 283770d583d5..faca379ceebc 100644
--- a/drivers/media/common/siano/smsir.c
+++ b/drivers/media/common/siano/smsir.c
@@ -12,6 +12,7 @@
 
 #include "smscoreapi.h"
 
+#include <linux/seq_buf.h>
 #include <linux/types.h>
 #include <linux/input.h>
 
@@ -41,6 +42,7 @@ int sms_ir_init(struct smscore_device_t *coredev)
 	int err;
 	int board_id = smscore_get_board_id(coredev);
 	struct rc_dev *dev;
+	struct seq_buf s;
 
 	pr_debug("Allocating rc device\n");
 	dev = rc_allocate_device(RC_DRIVER_IR_RAW);
@@ -55,8 +57,10 @@ int sms_ir_init(struct smscore_device_t *coredev)
 	snprintf(coredev->ir.name, sizeof(coredev->ir.name),
 		 "SMS IR (%s)", sms_get_board(board_id)->name);
 
-	strscpy(coredev->ir.phys, coredev->devpath, sizeof(coredev->ir.phys));
-	strlcat(coredev->ir.phys, "/ir0", sizeof(coredev->ir.phys));
+	seq_buf_init(&s, coredev->ir.phys, sizeof(coredev->ir.phys));
+	seq_buf_puts(&s, coredev->devpath);
+	seq_buf_puts(&s, "/ir0");
+	seq_buf_terminate(&s);
 
 	dev->device_name = coredev->ir.name;
 	dev->input_phys = coredev->ir.phys;
-- 
2.43.0

