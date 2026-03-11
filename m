Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18772F5487
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 23:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773271345; cv=none; b=fFEuqpLEAEoWoUFsqSjRsqWhrMaQ35D6ueLDG11Hrjx+pXSEGm64ya5QiWbnmLNDGKnsHR36O0cQpe5YOtF/9Cl5ioA60DNKyfUnpTBv6KZouAHVJzJT9hl4U+bRvP5GtOBzyDm9dk661CniVYx5/0H485rylgXNlI9SqHFv64Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773271345; c=relaxed/simple;
	bh=3b/UX2M7aFcJWInuUSq55ZwYF94bNSeG7Wja6ecHKnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=es/fHIaUe27xAdSmtwmFzy5TrEUKBHiMz8WgtIkGdghtQyL7C2xDy8P5OPX9FyIdQNsX5ytLZayjs1JhEzZCDLG7YEv8dudQrLA2SKaDn2Pzs0V0WG+9r8yIhCNkBvS7C8Kq61lSfo8i5Ro0/zPGBWYyuI1Ns3VhwJMcTvj7v0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ij2E9rIO; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij2E9rIO"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35990245493so219240a91.2
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 16:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773271344; x=1773876144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/y9dleBR2reXEEDZPM2b1qrma+w8Y5dsVKybDsJlCkg=;
        b=ij2E9rIOE3cyTQ1BBG/rXGGHkdfv4vGCnm9tmxa5aX9g7FqyCKdiiWcVtC5wnw4dj1
         V+nqnMvIedzyhd9DCeX4duCGPGXxPp8Dtak7Kdps05Bx97vmZvsOTNXy/NzKBy7Se0xO
         aCmbhV4MylpY6YJIN+hQeU9VbC2eoPN+gckYeuZAwFk2hDblaTkhoMChG1JX5Yb//ikN
         gAK7dMyoXp/OnnZVIhclm7qqtLvCvnu7+HPG1YJvgTsSTB9nv84pB/7EJm6L5fI64K0o
         w9JPNrg/rGr18h9PVrDHnzZOLAIz9YT1t++3nfPZnGwbzx4vlHu0cJLJPm7x3Ehxu+YW
         htYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773271344; x=1773876144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/y9dleBR2reXEEDZPM2b1qrma+w8Y5dsVKybDsJlCkg=;
        b=on5KXgHADZX3TImqzKHVawyhqwGFK9lZb4rBcjBUY7atwVB5suktvQG5pTYHbQ3V52
         bI0RKRz0/ZOcrtSV8dWfSF1jc3gx0Pky/Go5x5Z2LbF2RdwTgUNi2eqTebjTiKUwx7mp
         +TtdNUDbKWpPr/Ym4ZTwhhVmoIir5RWHABF0KHAvFk94kqA1VoGohzJk9Z9UUsIuuVHX
         l+z1vpjuRa3K/0CNjRAd8D/Tu58rB9vKyxfVxaOhrSsEL9YKX8H/z8PUd+sF0NVjHH9z
         DPsJvkRg4fEywSELgpEF6GsPOJ9akWAmPZzd86K2nHMRUBfkD3S/DxpWxMkrbFifdMJG
         1dlg==
X-Forwarded-Encrypted: i=1; AJvYcCWALuQFv0p2URHIET7O0bcNgoAseT3Yll/8Dm04wYC9hEE7ndQEUpemhvrxe4cn7HLTCfKF20jl2mm2aXuG/S4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9h1G2KHZ1qEa96s1gUQzTcHeLfU6HBKOoITESsgS5ITSObUAU
	tQnxGkIQ0VQQmLY9FG+EqBWI0npzLRXetU9aVgYHPBKcmOY1GUQfQR9F
X-Gm-Gg: ATEYQzwoeSeFZeiR3yBjGBVqjQZ4tUz9cOmwz3H1OLCCWMtcowerTBq4Qq+nUt9UgWZ
	binwi8bXQYPR5j4mYTW5tZxaiAIy4a8Y1jboh1KzltTwZnN2/ZMKXpJ0MXuPBN2nf9Kp2aTSIXu
	hHXQgC4Y0JzZ9kYnCcPcguo9CFmMSQdFrr/RiGuH17ZnqcUlBM3KZ3Z8iyAO7KRyurT9eXMDkVi
	xf8brGmgFLLclHIfsqp7olbvS+E0/NBKra8X1WkM/hr4QQtLndg1DQiO4Nipxk9jbkdRqNxXKUN
	DcE7mcfUXqbJIHO9lb/kZVuRe6ixecg0T0z0LjFBwgN80m1AxG/urW4LoZJtviMY3KRIHiIMMvV
	Za0NTQTDjLc5p/Kr4WWeegXqW5Wbxwy/8TxX8gb8kTGNNNuihojczDhglxiR6oxWyb6qJ1VKe1u
	qGMTateeAOs14tRCwaXjOHfaT/8Oy+RkRjcvD53t+rzklxFK7ImH/dTQ==
X-Received: by 2002:a17:90a:d446:b0:356:2c7b:c026 with SMTP id 98e67ed59e1d1-35a01301cf1mr3659933a91.23.1773271343988;
        Wed, 11 Mar 2026 16:22:23 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a031aa12dsm1290014a91.10.2026.03.11.16.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 16:22:23 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-usb@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] thunderbolt: use kzalloc_flex
Date: Wed, 11 Mar 2026 16:22:05 -0700
Message-ID: <20260311232205.18137-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocation by using a flexible arraay member.

Added __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/thunderbolt/path.c | 24 ++++++------------------
 drivers/thunderbolt/tb.h   |  3 ++-
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index 22fb4a1e1acd..3af5d263ac74 100644
--- a/drivers/thunderbolt/path.c
+++ b/drivers/thunderbolt/path.c
@@ -150,22 +150,17 @@ struct tb_path *tb_path_discover(struct tb_port *src, int src_hopid,
 		num_hops++;
 	}
 
-	path = kzalloc_obj(*path);
+	path = kzalloc_flex(*path, hops, num_hops);
 	if (!path)
 		return NULL;
 
+	path->path_length = num_hops;
+
 	path->name = name;
 	path->tb = src->sw->tb;
-	path->path_length = num_hops;
 	path->activated = true;
 	path->alloc_hopid = alloc_hopid;
 
-	path->hops = kzalloc_objs(*path->hops, num_hops);
-	if (!path->hops) {
-		kfree(path);
-		return NULL;
-	}
-
 	tb_dbg(path->tb, "discovering %s path starting from %llx:%u\n",
 	       path->name, tb_route(src->sw), src->port);
 
@@ -245,10 +240,6 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
 	size_t num_hops;
 	int i, ret;
 
-	path = kzalloc_obj(*path);
-	if (!path)
-		return NULL;
-
 	first_port = last_port = NULL;
 	i = 0;
 	tb_for_each_port_on_path(src, dst, in_port) {
@@ -267,12 +258,11 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
 	/* Each hop takes two ports */
 	num_hops = i / 2;
 
-	path->hops = kzalloc_objs(*path->hops, num_hops);
-	if (!path->hops) {
-		kfree(path);
+	path = kzalloc_flex(*path, hops, num_hops);
+	if (!path)
 		return NULL;
-	}
 
+	path->path_length = num_hops;
 	path->alloc_hopid = true;
 
 	in_hopid = src_hopid;
@@ -339,7 +329,6 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
 	}
 
 	path->tb = tb;
-	path->path_length = num_hops;
 	path->name = name;
 
 	return path;
@@ -372,7 +361,6 @@ void tb_path_free(struct tb_path *path)
 		}
 	}
 
-	kfree(path->hops);
 	kfree(path);
 }
 
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index e96474f17067..4e66b53860dd 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -440,9 +440,10 @@ struct tb_path {
 	bool drop_packages;
 	bool activated;
 	bool clear_fc;
-	struct tb_path_hop *hops;
 	int path_length;
 	bool alloc_hopid;
+
+	struct tb_path_hop hops[] __counted_by(path_length);
 };
 
 /* HopIDs 0-7 are reserved by the Thunderbolt protocol */
-- 
2.53.0

