Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C9129A31C
	for <linux-hardening@vger.kernel.org>; Fri, 13 Mar 2026 00:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773361408; cv=none; b=Uap6n7PK72lUyj4duLYEm3/WeZ+YTtmo0TduxlsewLfzu3SZTffs73MuNITqXnkJBgiBZtU/s5gtvSAE8QGjN3TSKAnK9VpLYqrN/cd2+sWTZ6GTDQwgeu79PsGLc915PTEPZpEwPoylSN+zKV4Qm6dyPodWAgLL43s18JOq6NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773361408; c=relaxed/simple;
	bh=DAOotS0+fJKT3Knk+MeZ7HSRumsv/xP9lPM/rU63+iE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mjxo0PWOyivElvEMmOBnyyZLIYV8kbGx8MD8jdJFS3nTM31uD+1Waw36+SfPi4KYrTK8lB3xoTO1mv01hJX29M65PMKI5J1Q0PpPWLDGtDz7K9wzx4bSuip+ze35+BaV+RdvlZHhGw4pqAvVQJxaHjP7o5ocFsW1SzzlRaFxPYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBbm3S5X; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBbm3S5X"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7986c7b8076so18699747b3.2
        for <linux-hardening@vger.kernel.org>; Thu, 12 Mar 2026 17:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773361407; x=1773966207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bpGg8KlAOke1kfXQdKS/v1oPTBpVb3phcbFoPsToyyw=;
        b=kBbm3S5XfkOimj5j68nNMgRHRssj72ZnCsTjJGIPBtmQ+uRo3fBIHz7BbTMChu1hV1
         X10KojimkhYYp82RwZ3cKhnkFuxu+IJ51oECy6cJr2ntxYwzoCVtBvhFabfODfzUrobp
         gS/zg/q6fMz9gGS7v8aqFlqvL/PX2Ov41xnGzAkcSKOrP9HriaGICwQ+znLdEMJa9p2Z
         ggr3b5IEaboFi+v6dLG+jA/BMEexXxDS/kntRWV5BwvqgQCr1zTnV9k/hJg0+vj2hpSa
         fb9PYWrsgD+mOG/5SCYLRmL4Ov/LszwmqIJjbMnOfPW6wueVcz+SFhGqEzadpNo65K+J
         58+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773361407; x=1773966207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpGg8KlAOke1kfXQdKS/v1oPTBpVb3phcbFoPsToyyw=;
        b=GDUITZ0XnKWicqU19nSgKf76qrozdcSs9KQbuwIAlvzvfaYNbgzOSjd6CJ4zS62bM0
         ybdMC0WO9pvbOdUAuNLFltb1cxy0Wx0uWDr2NFJuoxKplMW24BEuBk/X7FO0/M9RehwP
         ndwkRf12YtuJEk8OO5IcykJGF+ZwUIo9MGDk/4aq6XfvulljVbD1l/1SEvceNqm2RDVm
         /5+0d0ZmU6dTQpf83wK3puoiPgcbelnPrsY88YXnxfO0MQLQ+qCgaY/mDom2nFYj9Unf
         eNs3H0x7JSbw8hneoq7BWZbhPWbtcdu4SbGbvSm/m472HV/2dA5Yziu02LfoQoHAxTkf
         8oCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV1BblFIMoQdixrB09VlRhgCyzqs+jFMVOZGHY0kfAIKZR3fQURPCJ2fsJXDkpJjzXvsCNuVjfr0kKd+H8wro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr6NFYd1lVUU4a/VMZRc9bxP3uc/+Mp8ZEjBH8qR6R7ILXqDJP
	BAXWIoGfDvVUyInxdCwE71OQhgP+kZzGjxkIdYrB1alaAc4o4BgdKo9L
X-Gm-Gg: ATEYQzyyHawkjzNH6+CX73pqShPs8GIBjIPqu8IimCg9SSP6u8k1QMDES1KvfbNk4G7
	fzw1MrYa3tZglLQC4axC0Io8pKrUymk8omZcVl31dEz1lPp9xNn/cvdKnsa6W29ao5kMOdQxi4W
	h+wHPOBSMkRgkmb+Bw2HeMUvRntNfJRraE1vJt1c/qoBk7KKieJDR8tpIA3j6kLFQvjyiOXtET/
	98JIkw/nLOzrPhYglW8YrvwvLXkovWUZOoocFAGhtSka8GAfhEwXHHuYLyKz0p7pJnhJdchgjH7
	JWqN5aMq4o82eHqOJuxA5kQexuu6fXWSGzTuviMRTrUGEx7qorgjd/1SEQAoMuXlRT+9svHQP3O
	2kg8rRj2GjM9VU+M8bfbmncH3byNvk8bqo4bbnKiSpOsRbx2vVUcH5MBQdqmqi81ewjUNPwS9Bx
	usqP6vPRhxcN6+X3Now7O3qFZ02f9FMmea8qeh4bF/fP72MJKbQor8Gg==
X-Received: by 2002:a05:690c:ed5:b0:798:ff7e:96a6 with SMTP id 00721157ae682-79a1c23cd40mr16090467b3.63.1773361406680;
        Thu, 12 Mar 2026 17:23:26 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e65b67185sm152768d50.19.2026.03.12.17.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:23:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] i2c: atr: use kzalloc_flex
Date: Thu, 12 Mar 2026 17:23:08 -0700
Message-ID: <20260313002308.119343-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.

Add __counted_by to get extra runtime analysis. Move counting variable
assignment immediately after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/i2c/i2c-atr.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/i2c-atr.c b/drivers/i2c/i2c-atr.c
index f9fcb4793aaf..b0aedcf0bf71 100644
--- a/drivers/i2c/i2c-atr.c
+++ b/drivers/i2c/i2c-atr.c
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

