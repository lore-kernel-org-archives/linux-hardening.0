Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2534430DECC
	for <linux-hardening@vger.kernel.org>; Wed, 12 Aug 2026 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563987; cv=none; b=jELnKlLMWeHiZshdq+BKXe9n/8Zg5Cym14KFdoo6H4yyWUG917umaHARJEA9kxvqh9NGX7xn5AwjPnMoXQqiVYYuWdJiNJV1K7UTmxpMiyopMK44cNgCjyNlNC8PVDt9E2qHb8LFO6ejIhH6vXDTnIAsL09wYCTUM66BrmBaRmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563987; c=relaxed/simple;
	bh=GtIsD9pilK0SNml3Q+EG+xXEnVtMBItrgeg4ymDh+9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=omMjNy2yRQus7T+7bq81c0FBa2cViAfW+NVdmv4McRgBTjiF0RaGVYJuK42axXgKE6hT1onwomPApGJ/Ub9hnfkkcoGL3sdLckKtFTwNTkvMljBC4FpDGpIqZ1RcT1GJq922MpWvnbGut2BhUZ3sN17IvNcmzjZ3T61PEY7acFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KbZPemz+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KbZPemz+"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4994d67d260so1545e9.1
        for <linux-hardening@vger.kernel.org>; Wed, 12 Aug 2026 12:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786563982; x=1787168782; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lLauo+hnjrgG9ZJXjVO0Yx2ztAEOgVX1xLL/xvR8xq0=;
        b=KbZPemz+V/1UAEocQhZbYKCizgX1A4K64KSGayuqgf4G7IV2rEQXo3VuCeQEaWaBZa
         T8hNtiuJ6YeeB/YsoaBY3fMYt4RJqzpgkEF+LJIFf7XXhuxT6T5Su+grAodI6vNaZlrW
         OynTN8D+KohlTsEP21hp94mriAl5+o+us1ALQNI/OKjwdopY0OJ6uvo2WiDdFu+HPWmL
         rcG6GrT7HEz9qd3e23ObN5FR01zKx5f0NxDv3Q8/0iEJBrWSO8AYC5e5ksldF7yYa7BE
         6OQyZnZtXBCmu+dOaYCwGezCforTJy8iw06YqtB6533huAbHHlw0u1wu8TLp7ySaTXM+
         Y6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786563982; x=1787168782;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lLauo+hnjrgG9ZJXjVO0Yx2ztAEOgVX1xLL/xvR8xq0=;
        b=f6kAvgVWt3qdM0o7nlbTW6Gu68ZoG8sKELLkW2NGZ/693XKBAENaaiJM3hz3Tp4mPn
         0lRiWuyDfXlRrTw5xiAF5BruD1tRvQeIJe5QmYBxR/S0pN5s8IFCTfLd+sHJwrCIc5S3
         gpZkG4j7pa+5VKvFztTBOFyhG7RD8StTm9VqZ9+eMxxvavAibhDQnU1zeCni18t6/ABk
         pWpCO+UF5QRCLCQev32nTg9wXqlIgXbEXP0zxND9pRUzKqIXrhZV4QdBMFfWn54ZolI6
         cQ4clnMnJUc+A/G8LjdeFqtu+BnL1JJZbB1rxv9vDFMvMy+Sxa91ZcajCl/YaBfRMAAT
         9yig==
X-Forwarded-Encrypted: i=1; AHgh+Rr5vXJc+C2W4s9nROh9LXU4sBDsby0orPcWoMN0ZR+tZPYnIwMOlbVReZ6m2blodq8Rk/C22+6bAobp1t5pZZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcifbLJSOyL/cmFE75P7/s9bQkKpD98JmZ9qT6r12lu3wzPQrG
	//es/4r66NAEdigr5jcMkFql347O2TWholbX0woH3xlHCeA2FTWvLx02n9OJT+x3vecSBQNITFo
	/yHkw4H52
X-Gm-Gg: AR+sD102mISdBDvr0eWNJv9hXgsVSW51Z5XhNA/vxMMhOL0o0h8XNNA+leHaFwN5DTC
	S2+pyDg41YzISUd/QySk0OWAYUMzkU5cqaOvi75l4Ecaj7vigC8vZYnFCBUw/dHnyED9y+21WxA
	t5IwMQ/+WP3UTJhxUNPlNntKB1STC0whesoqCwD4UOD96KiwAIzq1uTaNvQEHMWpANVbvCMqeXt
	DaPHA1d+zLoTt393BLifkhPnM5sl4UhPz0kCOZs28xA3WXxSRjvbHE5b2rf5vprGjdgVH7AcImm
	/UKH5WV+wTm4atNy5C+TvCnFJYAAKO6En0zVarACmkVY/HeZ6dIWrlrHXynjFvtOA91i0muzHtg
	Ru/guYZWFNhyQ+k8F6Wi18Tq4FI/4oayueXirTnW++VIZOLVovM51lVsTCm16RYLXqnXHEK3fK2
	QHvcm2sgBd/ig2iav0Qrq+DWzrCBscDhXFJHwFapspuJ68/6xWGqatvofS6GSwSwzZsDZttwClq
	BhtnJOtAOp54xnaoXw1NJVtKVxEcuSvKJ1PSk/2y10QGlSs
X-Received: by 2002:a05:600c:42c5:b0:495:7a0b:3b4a with SMTP id 5b1f17b1804b1-49981f9c9d6mr97045e9.7.1786563981961;
        Wed, 12 Aug 2026 12:46:21 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:d358:790c:76c6:1a58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b62894sm9412265e9.13.2026.08.12.12.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 12:46:21 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Wed, 12 Aug 2026 21:46:14 +0200
Subject: [PATCH] bug: remove __must_check requirement for
 CHECK_DATA_CORRUPTION()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-data-corruption-mustcheck-v1-1-5f59bd3bc2b8@google.com>
X-B4-Tracking: v=1; b=H4sIAIXNfGoC/yXM0QrCMAyF4VcZuTawFqnDVxEvujRzUdxG0oow9
 u7W7fKDc/4VjFXY4NqsoPwRk3mqcKcGaIzTg1FSNfjWh7ZzHlPMEWlWLUuuW3wXyzQyvZBc7IZ
 LSIH9Gep/UR7ku7dv98NW+idT/gdh237+ZdcnfQAAAA==
X-Change-ID: 20260812-data-corruption-mustcheck-c1a8f76d6e24
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786563977; l=2545;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=GtIsD9pilK0SNml3Q+EG+xXEnVtMBItrgeg4ymDh+9w=;
 b=Y3NRtAopcLAoSsP9DIwxXYLyoNePSF1VwGoE+HK3lnL79OhBo67uNhsu2FK0Y8N6pgmX+lVO8
 aKwU0DvvSM3CbeCbaKVPZ5NTbs85yL43sIcZaER0gxvRhfFDCbpg9Ux
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

There are codepaths that currently use something like WARN() where
CHECK_DATA_CORRUPTION() would be more appropriate, but it is not possible
to gracefully bail out when corruption has been detected.

CHECK_DATA_CORRUPTION() is currently deliberately unusable in such cases.
While it would be nice for users of CHECK_DATA_CORRUPTION() to bail out on
corruption, that shouldn't be a hard requirement for
CHECK_DATA_CORRUPTION().

So remove the __must_check requirement so that CHECK_DATA_CORRUPTION() can
be used in codepaths where bailing out is infeasible.

Signed-off-by: Jann Horn <jannh@google.com>
---
I think this should probably go through Kees' hardening tree?

This patch is inspired by me looking at file_ref_inc() and thinking
that that really should be using CHECK_DATA_CORRUPTION().
---
 include/linux/bug.h | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/include/linux/bug.h b/include/linux/bug.h
index 17a4933c611b..e8d1febd8ae4 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -89,22 +89,21 @@ static inline void mem_dump_obj(void *object) {}
 
 /*
  * Since detected data corruption should stop operation on the affected
- * structures. Return value must be checked and sanely acted on by caller.
+ * structures. Return value should be checked and sanely acted on by caller if
+ * possible.
  */
-static inline __must_check bool check_data_corruption(bool v) { return v; }
-#define CHECK_DATA_CORRUPTION(condition, addr, fmt, ...)		 \
-	check_data_corruption(({					 \
-		bool corruption = unlikely(condition);			 \
-		if (corruption) {					 \
-			if (addr)					 \
-				mem_dump_obj(addr);			 \
-			if (IS_ENABLED(CONFIG_BUG_ON_DATA_CORRUPTION)) { \
-				pr_err(fmt, ##__VA_ARGS__);		 \
-				BUG();					 \
-			} else						 \
-				WARN(1, fmt, ##__VA_ARGS__);		 \
-		}							 \
-		corruption;						 \
-	}))
+#define CHECK_DATA_CORRUPTION(condition, addr, fmt, ...) ({	 \
+	bool corruption = unlikely(condition);			 \
+	if (corruption) {					 \
+		if (addr)					 \
+			mem_dump_obj(addr);			 \
+		if (IS_ENABLED(CONFIG_BUG_ON_DATA_CORRUPTION)) { \
+			pr_err(fmt, ##__VA_ARGS__);		 \
+			BUG();					 \
+		} else						 \
+			WARN(1, fmt, ##__VA_ARGS__);		 \
+	}							 \
+	corruption;						 \
+})
 
 #endif	/* _LINUX_BUG_H */

---
base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
change-id: 20260812-data-corruption-mustcheck-c1a8f76d6e24

Best regards,
--  
Jann Horn <jannh@google.com>

