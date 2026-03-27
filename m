Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B246834CFCF
	for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 03:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774580611; cv=none; b=K1efz5ILzlheOxa0zM7EkTl8r8aWuUR1okxgLY1WHxUaaPRpQT0lo7YtKN08dZSqhJeuCfn2yzRCthcd2gErBQE04jouI0dWqX8a1Py+OpcR5hvO8qiMK0HsaUIzuakspgJy3gFuPnTBdV1HPOHBIJUoFLWmlfVebkT4p9Vmrr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774580611; c=relaxed/simple;
	bh=GWG5hZy1veFdtnzqyHdYWLrPolKgR7bSn7NtmrJOIFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwoDT9UZEsfYPbFiLa5OBMPnBGkSoUR4XQRT6TUAiRjwDzA4yojzCzcXkpDeLEkNkuiEhGZGdSQGSpXnYZ+2r0mgybQLQBIvasiIy79lF2/dBILjYe+dlLu/lglLC2TnUKHDS2P0bMA5GSI8E1oBwKUjA04vlqCQ0bF5D7tgmZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTOFxOjV; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTOFxOjV"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1273349c56bso2120303c88.0
        for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 20:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774580609; x=1775185409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vSaSNFof8LDeaSt87Ybd7wXF7naIBHoN3VgDG9Jp8yE=;
        b=LTOFxOjVus0teg82jxGyS+KYCrJ1FWKK2MI3ZpSsJcdm44SAy8XwVrunuRYoaMjyOD
         66LZLrMxg2MdGRYrlfsqso8yOxkJgweF4tdZ0AXkunF2+2piCWZsNULhR5XTejHEcBUO
         NMevfhhjdVLsbRn3NIezCSUPoVt/utHQFJ10ZU2gk34siaTEtFMfv1c7iuut1Qjz2NCF
         Lhpk6hOjln/LepNS/NrXPBvg4hjMX6NQgfAiOMqh0YgUF+NFJ/8BPyrZZd3ZYOv/6uxy
         9sswud72udfY5zmRaKZFWYESRdgQZI9zP1ERFzRALhGD70OUTWhz1zxR8hk1o+EdieKn
         lR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774580609; x=1775185409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSaSNFof8LDeaSt87Ybd7wXF7naIBHoN3VgDG9Jp8yE=;
        b=Z1k32q7F7SjjofzFroDFJGzOpD3a2FsIyob7+Wdo8b+IlmTVGU9QuJMfxS8k8Ji9k1
         fspRCQFgc05DjOEttFqv0PYWr/sSOSKb9mXZZ4J9udVedROAua9h7XjNS+hzPn7vDNcU
         Ht1A1jA7O+7jqNamNmMYxcIRc1fy9GHdqXhB0vOioThWGLQ6gW7Pv1tbjwFM2fT63IwO
         fLK8y88uPpS2ibKBhfsmZI/NCO3FKQNnX3+ld7uKSCjEueQjQZOoQPXRUCitrZ5t5kud
         R6/XfCmdSGl/WWJF4aQH+pw1pjfcqSmOiGwuHM6EnMYRuy33+f+Lt5Ap+eYGkiN+SvCX
         wvIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMr5NuDIGanPxKl70jv15FVFcgrBzKvJDG231KZeNZnvgaGmefHHnBzWBFlV2V8OVYkSy6Eb2hFrsgcC4oEBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhVqyevWxDiA3FW723iJjCExP977fmqg2CWzuHUBZpaVqGE4V+
	Ci7kUU7cl3TLSLpTNWwhA7nPmK/PE6ADGVshVqGwvnJKZZjCClbnCKZZ
X-Gm-Gg: ATEYQzyyZID+nxElhzElGoBCb1AmKi/jyWd7ZYy8KngD4WkQAKXQPEYOGiGvILt63fP
	OF1q7Gg6COqEv95Jyx7t1FBIUh7zeVooYs8egvbFeDmJwEvPZR88/PE2q/JfOxWQIO5E8UjLKdq
	gLrQKr3MEBKVooJ77yVoDkVv5EtFL9GH955ylrNxFov7qZzzgN/lex0CEqocjwbxXgvsJcqf/wB
	c1ZmlddslI9ZLeKVNHHRZYlYign5FDSt1emKq1DR5nIHHQ5WqbKLbrdiqMvHfteqRHbgrWOD4sy
	XSXZ0d8bL051dCD9lEyun9FL+9jV5s01W4ztW9x0TtmGkJ7UXqcIOv1JOEYKyFX5xP2WAgKBQVD
	E2EbWfB4mCPJWJaWj9vMCLdvcEuyph1JNPDYHQ31adLFzZkSv8gIbdD/XVEKR0NRa6/NaRKd0bb
	ai4PUO6wBZanFu4b7ThSatBW2sBAkOB3Ja0Yayz4hqlTq9cuux5GiFycU=
X-Received: by 2002:a05:7022:220a:b0:128:d7a7:526f with SMTP id a92af1059eb24-12ab284be71mr452177c88.4.1774580608570;
        Thu, 26 Mar 2026 20:03:28 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aa78462fesm6576388c88.15.2026.03.26.20.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 20:03:27 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] i2c: atr: use kzalloc_flex
Date: Thu, 26 Mar 2026 20:03:10 -0700
Message-ID: <20260327030310.8502-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.

Add __counted_by to get extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/i2c/i2c-atr.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/i2c-atr.c b/drivers/i2c/i2c-atr.c
index f9fcb4793aaf..e6d2af659d81 100644
--- a/drivers/i2c/i2c-atr.c
+++ b/drivers/i2c/i2c-atr.c
@@ -49,8 +49,8 @@ struct i2c_atr_alias_pair {
  * @shared:   Indicates if this alias pool is shared by multiple channels
  *
  * @lock:     Lock protecting @aliases and @use_mask
- * @aliases:  Array of aliases, must hold exactly @size elements
  * @use_mask: Mask of used aliases
+ * @aliases:  Array of aliases, must hold exactly @size elements
  */
 struct i2c_atr_alias_pool {
 	size_t size;
@@ -58,8 +58,8 @@ struct i2c_atr_alias_pool {
 
 	/* Protects aliases and use_mask */
 	spinlock_t lock;
-	u16 *aliases;
 	unsigned long *use_mask;
+	u16 aliases[] __counted_by(size);
 };
 
 /**
@@ -137,22 +137,16 @@ static struct i2c_atr_alias_pool *i2c_atr_alloc_alias_pool(size_t num_aliases, b
 	struct i2c_atr_alias_pool *alias_pool;
 	int ret;
 
-	alias_pool = kzalloc_obj(*alias_pool);
+	alias_pool = kzalloc_flex(*alias_pool, aliases, num_aliases);
 	if (!alias_pool)
 		return ERR_PTR(-ENOMEM);
 
 	alias_pool->size = num_aliases;
 
-	alias_pool->aliases = kcalloc(num_aliases, sizeof(*alias_pool->aliases), GFP_KERNEL);
-	if (!alias_pool->aliases) {
-		ret = -ENOMEM;
-		goto err_free_alias_pool;
-	}
-
 	alias_pool->use_mask = bitmap_zalloc(num_aliases, GFP_KERNEL);
 	if (!alias_pool->use_mask) {
 		ret = -ENOMEM;
-		goto err_free_aliases;
+		goto err_free_alias_pool;
 	}
 
 	alias_pool->shared = shared;
@@ -161,8 +155,6 @@ static struct i2c_atr_alias_pool *i2c_atr_alloc_alias_pool(size_t num_aliases, b
 
 	return alias_pool;
 
-err_free_aliases:
-	kfree(alias_pool->aliases);
 err_free_alias_pool:
 	kfree(alias_pool);
 	return ERR_PTR(ret);
@@ -171,7 +163,6 @@ static struct i2c_atr_alias_pool *i2c_atr_alloc_alias_pool(size_t num_aliases, b
 static void i2c_atr_free_alias_pool(struct i2c_atr_alias_pool *alias_pool)
 {
 	bitmap_free(alias_pool->use_mask);
-	kfree(alias_pool->aliases);
 	kfree(alias_pool);
 }
 
-- 
2.53.0

