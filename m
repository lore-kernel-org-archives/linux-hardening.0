Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793951221;
	b=vxVGtpCdbBITbhaU+mkfDZTzbeSj2Ru5TjQ469fxMAl8qOGnbhXWJAG1fSDNfALEuIZJ
	 LtDy4aY4lAS/ptJ4tj2/XOZ/I+mNNpAsfXSv6ng1UOE145u0JAY1oBUx1fDkPd03zw9rr
	 YX6PGMBGWfQbky+VjaRSxpXwxeYJ7CDtz8OCHSPpEV7zODk/hY3JTkB9P/3vWNIUVB76m
	 dUT/yeG8pOqDMj5XylX2sSU/0RrVZkgkJ6vzdEf1ysKrcxuKuG05g/i5M2wjm8UxVyf2R
	 S/uQw/UGnw+3mwBkA0NDez5XP2yNWHXOSInSb3k4FMQT+je7sl/d5tORvZOM501o+Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CuJmOzkn/aajdKzupwKXYaLbxRN7lmDJXXx5kcYCJHM=;
	b=mBGKvLtLUusDpGFrikXalzf9d8g23cv1jccHkcml4bcbMjspJJpg2DxJWA6SfmclYlvN
	 4IwmAVv05LOb8dMTrB1x714i4JPk6WxGFJ5VMmH+bZ9aO6MGG7Apzwc7ykZA5txvgDrR7
	 wpxFvKoy86mHA/VyY3lZvCt/bOYzGmHkesgNi7aGKubLg0xhYcHV8fiHhoUn/FJG74TCf
	 ilZwG2o2v8wxuBCyiho1Cc/fd4mL8wa+ewjqKXqkwzKGwnfk0oyx6cPXfjUXE88BrciIt
	 F/EYZvtyc1C2gjda06/byYyxVWkH43mrt8Vf6dqNXyhBeqwpiHKXVtlto1MW0cTuJMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x6WIGICk;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEF5606A331
	for <linux-hardening@vger.kernel.org>; Fri,  6 Nov 2026 07:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DEF5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x6WIGICk
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36f8cdd30beso857820eec.1
        for <linux-hardening@vger.kernel.org>; Thu, 05 Nov 2026 23:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793951219; x=1794556019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CuJmOzkn/aajdKzupwKXYaLbxRN7lmDJXXx5kcYCJHM=;
        b=x6WIGICkrsqiieFicNlGJmFPW4aEQNGk69o+2wmMufM0fNx2hU9/SpfVwQZ/ggkb4E
         lFAGbZjwWyP57KOsh7SN8BNeBSOENVOg5RRoFIWaG3Z+KPxOAHsvi+m42Ts3lwL26oZc
         RjNooBOyLI8fXnb2xCXfKoqHM9GKC+sN+zXjSZ+UVOWIhtyhooABhiW1WdQJ8qxQZT4y
         AV4Fyndf3PSvS8AlJ+xRP9mrLOCCpW0+SX7Ou/xXevWzxSm9dDG7FUvEExEMe7YrbnZT
         6Pqq6TL80tS2mVsWLrNOZWe4RyGY0AeZvP6jKzBlP1ieoS0pVX0NigOhILu5ij0Y5ZVn
         ky8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793951219; x=1794556019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CuJmOzkn/aajdKzupwKXYaLbxRN7lmDJXXx5kcYCJHM=;
        b=Cz6nOS79gXwpxI678XAT1PfWONBOOvTEqdMREQS5d9mxrVHH8QpWBBaSCRxl048bTE
         AJWl5yubdzON5a1BSZgif8ATZZ9xDfyOcjYUEWAXczb4JQqmVImJOgwhBbMkwEsmQc62
         qzmJlgxHQ6AgsthuNUDaiyXSXX+icq4tfHgxgrTlV6aOeJfgxsJz6ohOEcbkI9DWUXyj
         W9I0NEiq0WF1fNxoywsO1c/JvmWR7kAxc9Iq881Wt54HspCXU2lQ+bvgILJw5bejt68H
         Oeld62PEv7bUvQi8iMWecfopN7Va+34Ma+KeJc5JgmenfaQ2J1AfwilXaulpQn339olz
         8EZw==
X-Forwarded-Encrypted: i=1; AKwUvBx3PrsyyjF1r78FPWyyX6BYkc5QQcRd/vhz5p10G87o7bt8m3J9kCQbUQMC1q95dVHTzexkBaJakWs5BrTOAyo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kkniFaFjmWFVIFqYbMZDp50SHkUAubnX/6ujcqY1jqbiTrtms
	ETPHgDGcDGvHbGu8Affc9RYrijcIlJX/MgL/A0PyJD6yocV2UV/VMYer
X-Gm-Gg: AYBFou0molSaV0qJdRZecPuLXWJD480WsDvQLGTRN9GeuvEtwwBfK76+bP28tWJ8enX
	kwsEs0m7o6XSQRw6NWS9FmEEOKISJk1oyiN5WVfBmTRp21bienSQkaS9WgvQlDugpG3PUNbHMOA
	z8xkmYKdEGz/E7VcuwbzTRF3Q0pERiDsWrBEHpDfVC1BS+Ai+odLhDQGlnqrIE3GDVDFEFkETPF
	/roD48Jy6xIOA/By0OpL//hkRKbpC8JRJuz05fJFOHpLhnsgMuQVyJ612sUIh9ZJoRpuirOAJJ5
	I5Ge/Td1UsFk7aXvEE5HtiKuXm8+k0/Y5K/i9bo5dRYNyU/YeBYn4vu0J02qmJOaSwKVEjfjMN/
	ZErahxb6W2UW2/ETjHxVC9EFgcdYggxud6+wUOJk7ZxoIv97dNOlIk0ijJVWk/50m+r+tAiUfCb
	owO8z+DVq+W0RfmKu+LHa5aifZCCwmYZ45xuaVAhnRlbXYmwibgLumBmnLZy+m/UsJpkwPeV9i4
	wxx6COQ7+6MLlUHkNvKSzAPpKd0m6aPziJUN9pZM2XZ1Jkv+b84kpWjU7mmHXyvnyIO/xjDMzsn
	orpP1BitXGk+NnbuL+CaU1by8delrlNdBDCT+NjoZjtOTPbAWPNZlQsqbJ0=
X-Received: by 2002:a05:7023:a86:b0:144:c127:dd1b with SMTP id a92af1059eb24-1b25d36f504mr2959762c88.39.1793951219227;
        Thu, 05 Nov 2026 23:46:59 -0800 (PST)
Received: from homik.search.charter.net ([2603:8002:ad40:56f0:d023:a7eb:667a:a3c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4a610fsm3040853c88.11.2026.11.05.23.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 23:46:58 -0800 (PST)
From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
To: hverkuil@kernel.org,
	mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kees@kernel.org,
	justinstitt@google.com,
	morbo@google.com,
	Mariia Nikitash <nikitash.mariiaw@gmail.com>
Subject: [PATCH] media: radio: Replace strlcat() with seq_buf in TEA drivers
Date: Thu,  5 Nov 2026 23:46:39 -0800
Message-ID: <20261106074639.452630-1-nikitash.mariiaw@gmail.com>
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

In preparation for removing the deprecated strlcat() API[1],
replace the strscpy() and strlcat() calls used to construct
V4L2 card names in the TEA5777 and TEA575x radio drivers.

seq_buf tracks the current write position and remaining capacity
across appends, avoiding repeated scans of the destination buffer.
This preserves the resulting strings, including truncation behavior.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
---
 drivers/media/radio/radio-tea5777.c | 10 ++++++++--
 drivers/media/radio/tea575x.c       | 10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/media/radio/radio-tea5777.c b/drivers/media/radio/radio-tea5777.c
index fb9de7bbcd19..2b1c7f6ddd60 100644
--- a/drivers/media/radio/radio-tea5777.c
+++ b/drivers/media/radio/radio-tea5777.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/sched.h>
+#include <linux/seq_buf.h>
 #include <linux/slab.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-dev.h>
@@ -255,10 +256,15 @@ static int vidioc_querycap(struct file *file, void  *priv,
 					struct v4l2_capability *v)
 {
 	struct radio_tea5777 *tea = video_drvdata(file);
+	struct seq_buf s;
 
 	strscpy(v->driver, tea->v4l2_dev->name, sizeof(v->driver));
-	strscpy(v->card, tea->card, sizeof(v->card));
-	strlcat(v->card, " TEA5777", sizeof(v->card));
+
+	seq_buf_init(&s, (char *)v->card, sizeof(v->card));
+	seq_buf_puts(&s, (const char *)tea->card);
+	seq_buf_puts(&s, " TEA5777");
+	seq_buf_terminate(&s);
+
 	strscpy(v->bus_info, tea->bus_info, sizeof(v->bus_info));
 	return 0;
 }
diff --git a/drivers/media/radio/tea575x.c b/drivers/media/radio/tea575x.c
index c37315226c42..e49228eb7c46 100644
--- a/drivers/media/radio/tea575x.c
+++ b/drivers/media/radio/tea575x.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/seq_buf.h>
 #include <linux/sched.h>
 #include <asm/io.h>
 #include <media/v4l2-device.h>
@@ -221,10 +222,15 @@ static int vidioc_querycap(struct file *file, void  *priv,
 					struct v4l2_capability *v)
 {
 	struct snd_tea575x *tea = video_drvdata(file);
+	struct seq_buf s;
 
 	strscpy(v->driver, tea->v4l2_dev->name, sizeof(v->driver));
-	strscpy(v->card, tea->card, sizeof(v->card));
-	strlcat(v->card, tea->tea5759 ? " TEA5759" : " TEA5757", sizeof(v->card));
+
+	seq_buf_init(&s, (char *)v->card, sizeof(v->card));
+	seq_buf_puts(&s, (const char *)tea->card);
+	seq_buf_puts(&s, tea->tea5759 ? " TEA5759" : " TEA5757");
+	seq_buf_terminate(&s);
+
 	strscpy(v->bus_info, tea->bus_info, sizeof(v->bus_info));
 	return 0;
 }
-- 
2.43.0

