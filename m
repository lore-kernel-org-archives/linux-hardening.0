Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485E5315D58
	for <linux-hardening@vger.kernel.org>; Mon, 16 Mar 2026 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773685300; cv=none; b=S2PIzEt5kayK6WEP5Mf+wpkx8vcHgyb6qqva/w+4ByA0MnnCcvo4RHMUoRkCXGcKP7vUnCZoDyViX3adr/Uh8T6XTqeJDOslu/Mz77oBizYasFMgCfNwAMakOUF95ZNHmUYV1DanCKqSLnFitzRgR5NXMoNEWmz6/JvAqAQm5C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773685300; c=relaxed/simple;
	bh=wyoEhbH5vEmoe/FvNNWLblsq3Yj00zp3Hzhb8lN1S9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dv1Lem1YhE1iXMQXS7+r9ve21/hugLbDcbZWjqeCOZtxkxZ/g89IqMGxrUz/t0fPnuBIzuqLsdHL9PrTjcw1BLyjm996t7mbDKFi6e9ucrcH+WZGeH9+reknu2pwvwQRKRk/aV3yHoHbXiRqxS/mSUk+ZX4tatFd822JlslBznM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gML1drS1; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gML1drS1"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-824c9da9928so3151712b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 16 Mar 2026 11:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773685290; x=1774290090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ffmkfhN6IZVcQX8QYVniegQEwjGmXttuPdYtjponOMI=;
        b=gML1drS1cxujHW6+jEH+RoV9YKcV/WIyxim42MQEKud+pZQnCnvJexH9YEg7lQjfaM
         H9fNz9abjHJ+iSdftB3tr8q6yLQwH4+f3VXbLyXTkO87KmhXoenLFLiQ37wheXwRlQZA
         t3sLHKuuSypWuWpdn7XXuDK+dCpLEmi+KbdnhrH8tTgGNtJWb57lfLmVMgZiqFeAi+mj
         1l+OYPNfhoFcBUMbs5MUhtrGnV76e2zZ/RH5hrt3iHMTOlrJ6TFSVqkoZMa+ercvRb7L
         HBIcW5tkXBhEO5L2TMf01wgG8wB4jpKeeYI2haMYKojc9RdzFFlkXSiecOXxREitVSDu
         Kf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773685290; x=1774290090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffmkfhN6IZVcQX8QYVniegQEwjGmXttuPdYtjponOMI=;
        b=Vk+c76d1LlHmU17dCb3QsRDq937CpdZrun4CjbMwDffJUD7sF1sqYfvYt/J+VaDIwV
         jPDd4brPySdWQdpmPM31xGYfuEgLM+Vfy/5I+cLjCl9PwTLV28nKXwUZlmh8vC61Bxun
         EP8FuGMk4TuidlnXh5TeDPC94l2f7qbj3enDM+QFy2dewnAiL8hKU+l80amsPNUa4kGB
         7O6COwl5gZrAnR1hDTf5ROKhVgi9Exl2Ca/wocme/tJaT5MKRGgbpqP4jPXbzCZsqAEd
         JxR0hJQBQTSZNPiXTF1RLNd2wy9LebhxIvuemCRcKm9YW/hq7e0eG5StD6gcAp2vq3Dt
         K+nw==
X-Forwarded-Encrypted: i=1; AJvYcCWyA7gxTN0JZ0omr+PUgJnkTp8x6R8s5HDN/1bS0Qtr7ewOG8AD7tupPxXBWvTfVcjna7qkQV/UWimr07b0CEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxANOBFSGNYRQfcab7ingIlwsL1waP70nFZtj2zKXxFx2wGQ/jf
	gXtgYVY4aaI82/icPnuvZ2EQTK0EcJ4hz/CHwbjJ1gLTYTSeLI2dPTeI
X-Gm-Gg: ATEYQzw3b42B/jlS7Q9kDzRfaXIK8OHdYqSsBoTBYO7gGQ8B0XS1uJOtZ62pQR/IzuJ
	kr0gBl6fQyHd/Iw1Z1bnRjum5pTZJL6Kbj4W4531uJc4xO/EWH7EDRSX+k/DCtzMwmo8GXxkF0N
	wy1Ki7XOM4vhooC0JVboPHgZR1xxZxgrWflvahsRNtPEplAcTlzz2fSf9HUuONRhWj1uAl3HcRT
	jVrJY/dEN1Pj1OWU74FJx7QPwK3i2/4N2/Bj4DUy/wTZWgxhEYhAvktwBCxmVpbT+MSiXvZxVy9
	bcg8XrxNEs/ucyGygVCc3kId/01aapOrSrpRR9CNzq5zSn+xfm9DmzcbRi8E2YkbB4etjRzr29b
	U9TEDWx9Q5gDEg3At/M7PE+TmtbAfDIPlpAHfchcd1WBMAdlClVfzSOenHKDMWb8/WHOwYmYuB9
	5M8BNEsUq2UbO2amOkVk1knBNNU8/tt524LeaWUHpz0+5iG9Dcd56H86k=
X-Received: by 2002:a05:6a00:aa0a:b0:81f:394a:4897 with SMTP id d2e1a72fcca58-82a198fd351mr12387566b3a.44.1773685290281;
        Mon, 16 Mar 2026 11:21:30 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07341ed1sm13602575b3a.33.2026.03.16.11.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 11:21:29 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-usb@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] thunderbolt: use kzalloc_flex
Date: Mon, 16 Mar 2026 11:21:12 -0700
Message-ID: <20260316182112.8682-1-rosenp@gmail.com>
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
 v2: remove extra kfree to fix kernel test bot.
 drivers/thunderbolt/path.c | 28 +++++++---------------------
 drivers/thunderbolt/tb.h   |  3 ++-
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index 22fb4a1e1acd..8713ea0f47c1 100644
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
@@ -259,20 +250,17 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
 	}

 	/* Check that src and dst are reachable */
-	if (first_port != src || last_port != dst) {
-		kfree(path);
+	if (first_port != src || last_port != dst)
 		return NULL;
-	}

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
@@ -339,7 +327,6 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
 	}

 	path->tb = tb;
-	path->path_length = num_hops;
 	path->name = name;

 	return path;
@@ -372,7 +359,6 @@ void tb_path_free(struct tb_path *path)
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

