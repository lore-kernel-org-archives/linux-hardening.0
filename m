Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066581DB356
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 00:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785112239; cv=none; b=LT1eNfxfMiPnVtSIdpY0snfn6hbUp9Tkgw2/6G7PnLuhHG+boPEvJElFkJvVHRTQ0M/VOOOFXfHvVZfogqCBvfEa78ac+RAfnQ79BzBBxVmt5IfIlFmMr9tkqT6VZqaqT5QF57raI4/0RyDAOY+lLGJHltqQZeAwHTKt2wtvTW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785112239; c=relaxed/simple;
	bh=zGpoeMUqWCnLlgmvPinB+FYL3e9l85Y04G+0Nvs+GEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AI1+AQdjF1v1PFUIqJ1MoyqBy0ZWEaw0CYZm7o3D4TU9+8R/Po1XPnRGmOcwzlKHD+imUVTQGIHlmQtAFtu1J4JhfmOFs/dQ0aiiQOIIxi2j40mNgjj4b90iuBQntI83kabTazXAVCnWTmTghYFOxYD51rEyBa/R90zQxfl4nMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjE7NrS8; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjE7NrS8"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8485b358552so2208283b3a.2
        for <linux-hardening@vger.kernel.org>; Sun, 26 Jul 2026 17:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785112237; x=1785717037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c+zwgRiRyLzUY+zGpFZNenRIdI2xKiE4RqGqKlfD/Kc=;
        b=WjE7NrS8A3zmPU7He2Lx/RJBH2y9j4+nLIJmx0N/G8dqOR7BG+jKqCTe/GXDjx6gOd
         RiunRdIRtLVSi1/jM4sDjG0iwj/+mYK5na8MPrK1A0LQFUYw1y3e4bb8ds7tHbClqBOD
         1DK0+C8875ZZ/xqbhhkiH0N7HDhV5QsiBKMCcQka8WQBwM1JnWc+DnNqEEK8WX/vnJWL
         Dim2lybQ6ICBiBsivZgXmrIjl95wgriSHMiKkXkkqAYCZrU+yIDNeqv6Z66auDliYIhV
         CEfF1mKga39MS1JyvTiWnpUiZSUoDHNIISn/D5+0Up2biR6cZMLAB72Kp6n9paLHydH3
         a7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785112237; x=1785717037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c+zwgRiRyLzUY+zGpFZNenRIdI2xKiE4RqGqKlfD/Kc=;
        b=aKxQLn2ULYUxktuP/0JphVEvcWYolv/AEJhVqEMvGgUUireEbf8DH1tCOCEsbo39/u
         3DYG+h19ge6Nq+9xCJmyAXJlFqPapKmET7Qy4dVU+THGG1FnDNN44gFcINfPB7+Sc6Lx
         3fQtOtzDYc29T3rK6gU1cq9aM8sRDrEO+7YXjb0rwOOnQUV/5NT90E5ZaUwNKpZyULTK
         XGOCgru2TP60vogMjSZBuxWVIgV58x+sJzksRExIcNOpv4GNX4w9o+notPszyn39pMIh
         NoYAAbYSG114ixDCsGdLzaYS3+wjd+ZTjxmJqxVERaB2tWQX3NTKBTnOYWSD0tMMJz5f
         OHJA==
X-Forwarded-Encrypted: i=1; AHgh+Rqscq6Cj4v/OHzPReYiHyTSF2jGvBl0Cghch3L4r+B5XrlEupRP9abKn4GJnFBs4da5ImhJfduHB6XMEmds/us=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhdbpf18R/4pKqGg4/n9KTIcHcaAGU71Rx2cti/sVwlqvFyF4N
	cAXiLCrPZwFLXNQbRNvUIDHePe1uUHV5IoT7kPConJnwQsI809Pj+1tr
X-Gm-Gg: AR+sD13j3OzXVFRaNxhujM7WXitpOgyQ2JXbc9J4VRhR8D4ULJ9FwEcxGt8/ky3614B
	fxBlMjRN8iSBsjQG5zO68S2SrMSqyGGWxUToUg9OdBDcxSB3e1cFXe175omFSj1a6e15/D8PMsq
	dDDg8jJkNH3Yk51vPh0OQGQS+cHw6eSycWTNCK/4ONDc9LD+jPIHbWP2tOuLU2VImyXT9Inaeqy
	x0Ez2z2Spn+hsT8mlmnTYmGpOUvVJHBrk5+nNGHLbXWmqQ0SclvGldDyn0VbGrZBa0OHc2H6LEL
	MJV6gCLGaF1TOEAt5ElJs4A23KreYCmB4YfldDoMKOrnlTc6PSLpegpH3iuhXu+PSCQieGRUOZ3
	dUsQKMwx+Q/69zwB0j/hgcCdX+6wpykovPyttABqArhb607NDSEQWKmN5BMuWc8HO12U0vtISUK
	/9l+5e9WkxPHfL5oyrl7axZKkzEb5AfFjkpW33e43/czvw6SnXMXGqUCftLo1x/hPMxP4HOB9js
	fASP3oQnOqAk245EPQE+2Kf4CweNQruO9n+ImbM8/cj31NUcyJfRitStr7If5durA==
X-Received: by 2002:aa7:888a:0:b0:84a:2ec8:fca4 with SMTP id d2e1a72fcca58-84e5956e79emr5113735b3a.51.1785112237210;
        Sun, 26 Jul 2026 17:30:37 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5344e583sm2205464b3a.57.2026.07.26.17.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 17:30:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2 wireless-next] wifi: mwifiex: Use flexible array for RX reorder table
Date: Sun, 26 Jul 2026 17:30:35 -0700
Message-ID: <20260727003035.118047-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Embed the RX reorder pointer array in struct mwifiex_rx_reorder_tbl
instead of allocating it separately.

This ties the array to the reorder table lifetime and removes a
separate allocation and cleanup path.

Change the void pointer type to the proper one for clarity.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: void pointer to proper type
 .../wireless/marvell/mwifiex/11n_rxreorder.c  | 20 +++----------------
 drivers/net/wireless/marvell/mwifiex/main.h   |  2 +-
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index 610ec8302adf..a266f09cb763 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -213,7 +213,6 @@ mwifiex_del_rx_reorder_entry(struct mwifiex_private *priv,
 	list_del(&tbl->list);
 	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
 
-	kfree(tbl->rx_reorder_ptr);
 	kfree(tbl);
 
 	spin_lock_bh(&priv->adapter->rx_proc_lock);
@@ -329,7 +328,6 @@ static void
 mwifiex_11n_create_rx_reorder_tbl(struct mwifiex_private *priv, u8 *ta,
 				  int tid, int win_size, int seq_num)
 {
-	int i;
 	struct mwifiex_rx_reorder_tbl *tbl, *new_node;
 	u16 last_seq = 0;
 	struct mwifiex_sta_node *node;
@@ -344,10 +342,12 @@ mwifiex_11n_create_rx_reorder_tbl(struct mwifiex_private *priv, u8 *ta,
 		return;
 	}
 	/* if !tbl then create one */
-	new_node = kzalloc_obj(struct mwifiex_rx_reorder_tbl);
+	new_node = kzalloc_flex(*new_node, rx_reorder_ptr, win_size);
 	if (!new_node)
 		return;
 
+	new_node->win_size = win_size;
+
 	INIT_LIST_HEAD(&new_node->list);
 	new_node->tid = tid;
 	memcpy(new_node->ta, ta, ETH_ALEN);
@@ -381,26 +381,12 @@ mwifiex_11n_create_rx_reorder_tbl(struct mwifiex_private *priv, u8 *ta,
 		new_node->flags |= RXREOR_INIT_WINDOW_SHIFT;
 	}
 
-	new_node->win_size = win_size;
-
-	new_node->rx_reorder_ptr = kcalloc(win_size, sizeof(void *),
-					   GFP_KERNEL);
-	if (!new_node->rx_reorder_ptr) {
-		kfree(new_node);
-		mwifiex_dbg(priv->adapter, ERROR,
-			    "%s: failed to alloc reorder_ptr\n", __func__);
-		return;
-	}
-
 	new_node->timer_context.ptr = new_node;
 	new_node->timer_context.priv = priv;
 	new_node->timer_context.timer_is_set = false;
 
 	timer_setup(&new_node->timer_context.timer, mwifiex_flush_data, 0);
 
-	for (i = 0; i < win_size; ++i)
-		new_node->rx_reorder_ptr[i] = NULL;
-
 	spin_lock_bh(&priv->rx_reorder_tbl_lock);
 	list_add_tail(&new_node->list, &priv->rx_reorder_tbl_ptr);
 	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 27559e2ddc31..8e6238c01aa6 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -708,10 +708,10 @@ struct mwifiex_rx_reorder_tbl {
 	int init_win;
 	int start_win;
 	int win_size;
-	void **rx_reorder_ptr;
 	struct reorder_tmr_cnxt timer_context;
 	u8 amsdu;
 	u8 flags;
+	struct sk_buff *rx_reorder_ptr[] __counted_by(win_size);
 };
 
 struct mwifiex_bss_prio_node {
-- 
2.55.0

