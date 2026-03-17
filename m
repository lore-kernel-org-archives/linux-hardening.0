Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0441A6802
	for <linux-hardening@vger.kernel.org>; Tue, 17 Mar 2026 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773717379; cv=none; b=ZPGZf+J7EOalFFB4OAzDE4ijyhNdLTSF/uTol4ttsX9QSfG9Ybye2EW30YVjD4ftP7SZbQC/4clkYHr2PTjBXpwVCA4rleYgQ7sGd1bgfWoc4EX6S4JxQniTt/5ad+UqfzCS130IE11caGdUmakbJwpWFe/iIaQHQP4pyw3Rrac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773717379; c=relaxed/simple;
	bh=FT+P1EjJH92wXZ+Pu26PhT7dHa3qO3effDC3eHCTM/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E4ATUHHYmydzSUUeDEw4XBQVCfcCysamah/w90/ZEPRtr4yibRTke5iEbu24SrtL5sGMb4xJv2ezTwNP1SdQgxj+B2hM5P60agZOz6FOwtfiYYfHPzB17EM+oX5b3wWc/qfTY7yD5btG+e5zQGlh/ZnP6P/aUJM1wj1FpTST6Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yk3k5mc3; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yk3k5mc3"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so1846510a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 16 Mar 2026 20:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773717377; x=1774322177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=krJBNPXzL7F/I+YTsM1rnxuBWgcuv3E638XkCseP024=;
        b=Yk3k5mc3I7yookttuPSOGu8EZfUVDmZP/VVUTQyLFf81LE3ryPpHST2L6ZFo4SDhW4
         Dl5BoEa/O2pqRjti8dPx8KJQtcc0TjSYuL+QEicWodHznof/BoqAD61K+XBDL35xKg2r
         8PTNal0RdRBE8Hnbt6uQtQvByr5FHjN3iUHKdtd8GL/qPEsff4ntts0vzwlU3AlS7MuR
         Qgpo/m9POcYy6uii1r/ccJoWVX9ehaTcSFbV3Vitpel1PlGZsLohspnmsv4JLW4PcM2b
         41Tu997+///2V+wsyLUAxkmxg66DGTCWqPNthPjiTsrj3SKb7MqTmoDY5I2ir2rsBBau
         XF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773717377; x=1774322177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krJBNPXzL7F/I+YTsM1rnxuBWgcuv3E638XkCseP024=;
        b=hP7PFkyPxpsxmBW/SJ1YTOj9Tun2THJlYLTLjmbDHFAJzcDZkINC5UZGVfuKTjlpZl
         YyvODV5oPWwczwuFIKOI1mL6TUrxdt8TQ0vnUM6mTgysGNWeSwXoDdPcnU4ANKZ7+sTV
         b7Gtb6r7ULp7I5H9BSdCYnd8/n2saWY/yY4F0X9+os3Cisea5Fh8zAnDQ1u/t0y7at6y
         dfB4Fv+e3V+CxIXXx1xkY6bv2233hfuv7UBIOjPLQIb08nGOQxQvRezS1ZZoYNgpN1fc
         OthtKYDxF8k3f6arRi6kkSrPVoPzaUB6nbZWMxyAwWx7yn2n6+c8g+u/7rdsJV1PCEte
         j1PA==
X-Forwarded-Encrypted: i=1; AJvYcCXhrIB9IMrx7tmiuVOqD9XaK/6n0fh+5DCaK1vq7/EIF8Pi89vCR+P4dmgtBAuNbIxKden5NUu+IvDPy3iersc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5A+MAVp1kwTD0VU7n0AqqJC6Fl67JNXhYE242U3Ymn9Qg7Efd
	wL0Xh//TXMuKMNHJC4P8wkvuijpYW9uDASNIi3CDtFnJLYyD82RRa4+/fj+tXeM5
X-Gm-Gg: ATEYQzxBwe9zM0LC+RP9f2wON0iJYnJpyZhQAb9sLkkdukmXmOcE0HbVXY5W7wWFHpb
	i1W8LHWqdsU84zZM0zAcCwpJqhpbcL5bWbbcFrq58sMrB3Rm2rZ4nhdlPl/5jWRH6TsZ8Jz4bLg
	LCVE2R3KjB+fk7+qAbqo2xfEOQsiQUkJPcAxz/k/4/c9vFfFiwv2fqpw1SEliNpZ2aqF3G7oWTe
	b4O74N8W0w7Ca7Jd70tgJeNEdbG6jVrmv3ssTDn445qOiXv0gUkgsV9U7OkaCjOHyAGweYzO3PW
	MYFrELoJdSb8QiVVDhYT+Hhi7m9b1veniEo/B74F9dQgLSrpdm/bLAnTB88MNHMjfbEq/1XqLfP
	7nU9qyagO734mVE83sDh8rtzY5qvsm89jHfexGJVZ5bJXYLqA3HCYm1WeeWK8OxJXCqUGUuqKq5
	XQnQE88v7eVPyYgdSLqbCK39ibDscai5ah33V4Wzvz/SyXXmOYIIdjZoudFAFPy6Iv2g==
X-Received: by 2002:a17:902:fc43:b0:2b0:60b2:4dc with SMTP id d9443c01a7336-2b060c14bdamr28923445ad.15.1773717377286;
        Mon, 16 Mar 2026 20:16:17 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece83188csm125178245ad.75.2026.03.16.20.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 20:16:16 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] lkdtm/bugs: combine allocations with kzalloc_flex
Date: Mon, 16 Mar 2026 20:15:59 -0700
Message-ID: <20260317031559.93544-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid a separate kzalloc_objs call and just use a flexible array member
to do so. Simplifies allocation.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/misc/lkdtm/bugs.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index e0098f314570..938916e5b53c 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -515,9 +515,9 @@ struct lkdtm_extra {
 struct lkdtm_cb_ptr {
 	int a, b, c;
 	int nr_extra;
-	char *buf __counted_by_ptr(len);
 	size_t len;
 	struct lkdtm_extra *extra __counted_by_ptr(nr_extra);
+	char buf[] __counted_by(len);
 };
 
 static noinline void check_ptr_len(struct lkdtm_cb_ptr *p, size_t len)
@@ -533,17 +533,12 @@ static void lkdtm_PTR_BOUNDS(void)
 {
 	struct lkdtm_cb_ptr *inst;
 
-	inst = kzalloc_obj(*inst);
+	inst = kzalloc_flex(*inst, buf, element_count);
 	if (!inst) {
 		pr_err("FAIL: could not allocate struct lkdtm_cb_ptr!\n");
 		return;
 	}
 
-	inst->buf = kzalloc(element_count, GFP_KERNEL);
-	if (!inst->buf) {
-		pr_err("FAIL: could not allocate inst->buf!\n");
-		return;
-	}
 	inst->len = element_count;
 
 	/* Double element_count */
@@ -564,7 +559,6 @@ static void lkdtm_PTR_BOUNDS(void)
 	ignored = inst->extra[inst->nr_extra].b;
 
 	kfree(inst->extra);
-	kfree(inst->buf);
 	kfree(inst);
 
 	pr_err("FAIL: survived access of invalid pointer member offset!\n");
-- 
2.53.0

