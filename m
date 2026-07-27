Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593892771B
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 00:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785112160; cv=none; b=I/6U07cyfGwd5MEvnl/0j0sQSSCemdKrswG6FEjPZ8Pu9xMAr2TUfaCGKHft6HCGB6zjgdTAMIx+/ODDExVzCHGg9rutbPNDK0rw7TqNt4BTdWga3W0BqswIXRTobrbDVdBxExcGvWxAfT+mXcKrCnoKZjKQCw521cWuLF9RANg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785112160; c=relaxed/simple;
	bh=8QXnkeE8oX0SGRQfzCAWUoTMRzu3W0XnVIT46kceEEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2feC12O1F4WmhJqlhTaUYLScZkazKpkknbsSmoHeI12FU99cYfFIsQyCiDm2KCwh9q0CVjz+AGxJnssSKrqAAdYKhr7Xd2m0bsiKgUlHlhPd6oDA6ZYcSYdcSwuQXpQRJwQQ1IojE0peM8JOc26CooAoPU8RLIMSMrY8vEIS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FL9OWcnZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FL9OWcnZ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cea3004256so22119045ad.0
        for <linux-hardening@vger.kernel.org>; Sun, 26 Jul 2026 17:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785112159; x=1785716959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HGg+8z1r0Tll2j8ZTquwQJTj91H/jfRoN35vbaME2+c=;
        b=FL9OWcnZmTU8LEnRZhBWLAEPoeBzeNN1/YRxv/4CEdRHQoAq8UG7arrpB6x2DZx151
         S53Paiaglnk/KC2T79LF9ljndcLb8jXz/5+dIy94gx6aJ9gmcGlY0p1KI7HYIpiYyqhg
         tN99j9NgLwN/pPeTXMpupMOSCACcKejZBiZ8HqrDk1nH3c0gyFMdecB8d+MLAw1zq81j
         3saTHNjYRD0JZXH7S4WaAZb86vwnyalTnNkyOcBfcRvLwWn6179oq5LyLwP4PGrsvQPX
         pyFLESfXVyGWCRIcM+ckCHR0clxuoppCUBfvB52cuAw5/VKJldTQVyfyq6BGRu/g82Zt
         Hf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785112159; x=1785716959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HGg+8z1r0Tll2j8ZTquwQJTj91H/jfRoN35vbaME2+c=;
        b=JXVhiySBJ1Ffmfv1GrcTsjm3041yGr31HeZCRGnNQN8TWbB1REbLc4appiKxnzJEjL
         nucbIXpfhVxiTQbbJr5nIpu09fUgtoiWiO0AwpIX8wtbegyfNzuwY+0H4WMX/fAsCIl/
         Vfe8OTkSXqCNKLmn2ADKOn8NbH4MI4MRimASWubs7iJNeKGf+V+knchbHKLMzkAZ0Nx2
         BYMFheJGOzT2y6cOVmcEOlaWOIRTI/+jPoUvBSj47aj7gQQMBBTymwlVg5UpvQI8KiYI
         Kxd+ugPkMlbm8MZjJ/ZMHjfzdumKIGiodY2Fx/SVxTT8QDNn7AfpFxPOl2XLn+NB7mMD
         5inw==
X-Forwarded-Encrypted: i=1; AHgh+RpkGcKyzyIEuPPFmKcjBS0WmKI9VxxRJ/bh0twsF64zoWrW++KDquOmVqoAUdvnrVdx0iVgrN17Kuo+oPS6YQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHg05i25C5LAyyoNCt4F5zUGVyM1AOgPLXjGVmUtpnn5ryWfN7
	bZTjvoMiKBKzsi8SAXHG/Sdn8vFr9pgum+6V2fkG6vL7bpn4R6DQsHtp
X-Gm-Gg: AR+sD11sYuLZ76zjKi3L1eHEuYyuSVHbs5TJHdvV7KTLitKVf5/vMdYCy99CQZNH9es
	8cDmC1EfN0Jd10+nDjTrUKZqXAURUKZy4XZ5a2z/4D8P89wI2hBzl1l7e/sp4anqTFyqcN2Sr5K
	IOpng8U32JLAd2hqSJ/+WQSMNeCXy3sr/ccLwEBUihvb/iSRc7ty5v1tP3oFUD1Fcq+NvVMNT1U
	HkrlP6fe1MM5u5OX3/QNSnmsldnmAGqWqyOO5PoftjrJqgzlDPOl+ROe6sw3gj1mBXM7WbPcKgv
	sCSO8OPNRRAinlEN8LDPmcGgiYFFUSZWR3tD7a00J7Yq7LAGVAHtbFJi+jeEjfaOCueEbkSttso
	HoqReetcnnoRVqjmmDrxFTGgCLWbxMbvzhua0ehCBrJjdwJU+hoqiZU0ozGSkG0q6JFEe33hKBT
	W7+GBazaTojLIEr3hfDO/Omkabn33BPx01JTpoUoGlP7OePJo4MSksDmIMtlljb6KCNiYfckOwI
	sxuZjnZb9qvgQbekR0EFgR+eL1nqwgGuNs8EFjNn39f7sywVU58iJw=
X-Received: by 2002:a17:903:124f:b0:2cf:477f:57cc with SMTP id d9443c01a7336-2cfde687d8fmr59514225ad.4.1785112158717;
        Sun, 26 Jul 2026 17:29:18 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7da81bsm24839795ad.60.2026.07.26.17.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 17:29:17 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jeff Chen <jeff.chen_1@nxp.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH wireless-next] wifi: nxpwifi: embed rx_reorder_ptr
Date: Sun, 26 Jul 2026 17:29:16 -0700
Message-ID: <20260727002916.117754-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rx_reorder_ptr is a dynamically allocated array which is done near the
main struct allocation. Combine the two to avoid freeing separately.

Also fix the type to what it actually is. void is normally used to avoid
casting but there's no need here.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.c  | 19 +++----------------
 drivers/net/wireless/nxp/nxpwifi/main.h       |  2 +-
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
index c5819f89b08c..b2fd624497a3 100644
--- a/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
+++ b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
@@ -171,7 +171,6 @@ nxpwifi_del_rx_reorder_entry(struct nxpwifi_private *priv,
 	list_del_rcu(&tbl->list);
 	spin_unlock_bh(&priv->rx_reorder_tbl_lock[tid]);
 
-	kfree(tbl->rx_reorder_ptr);
 	kfree_rcu(tbl, rcu);
 
 	atomic_set(&priv->adapter->rx_ba_teardown_pending, 0);
@@ -273,11 +272,13 @@ nxpwifi_11n_create_rx_reorder_tbl(struct nxpwifi_private *priv, u8 *ta,
 		nxpwifi_11n_dispatch_pkt_until_start_win(priv, tbl, seq_num);
 		return;
 	}
+
 	/* if !tbl then create one */
-	new_node = kzalloc_obj(*new_node, GFP_KERNEL);
+	new_node = kzalloc_flex(*new_node, rx_reorder_ptr, win_size);
 	if (!new_node)
 		return;
 
+	new_node->win_size = win_size;
 	INIT_LIST_HEAD(&new_node->list);
 	new_node->tid = tid;
 	memcpy(new_node->ta, ta, ETH_ALEN);
@@ -311,26 +312,12 @@ nxpwifi_11n_create_rx_reorder_tbl(struct nxpwifi_private *priv, u8 *ta,
 		new_node->flags |= RXREOR_INIT_WINDOW_SHIFT;
 	}
 
-	new_node->win_size = win_size;
-
-	new_node->rx_reorder_ptr = kcalloc(win_size, sizeof(void *),
-					   GFP_KERNEL);
-	if (!new_node->rx_reorder_ptr) {
-		kfree(new_node);
-		nxpwifi_dbg(priv->adapter, ERROR,
-			    "%s: failed to alloc reorder_ptr\n", __func__);
-		return;
-	}
-
 	new_node->timer_context.ptr = new_node;
 	new_node->timer_context.priv = priv;
 	new_node->timer_context.timer_is_set = false;
 
 	timer_setup(&new_node->timer_context.timer, nxpwifi_flush_data, 0);
 
-	for (i = 0; i < win_size; ++i)
-		new_node->rx_reorder_ptr[i] = NULL;
-
 	spin_lock_bh(&priv->rx_reorder_tbl_lock[tid]);
 	list_add_tail_rcu(&new_node->list, &priv->rx_reorder_tbl_ptr[tid]);
 	spin_unlock_bh(&priv->rx_reorder_tbl_lock[tid]);
diff --git a/drivers/net/wireless/nxp/nxpwifi/main.h b/drivers/net/wireless/nxp/nxpwifi/main.h
index 4abf80771be2..349dfa4d3f85 100644
--- a/drivers/net/wireless/nxp/nxpwifi/main.h
+++ b/drivers/net/wireless/nxp/nxpwifi/main.h
@@ -656,10 +656,10 @@ struct nxpwifi_rx_reorder_tbl {
 	int init_win;
 	int start_win;
 	int win_size;
-	void **rx_reorder_ptr;
 	struct reorder_tmr_cnxt timer_context;
 	u8 amsdu;
 	u8 flags;
+	struct sk_buff *rx_reorder_ptr[] __counted_by(win_size);
 };
 
 struct nxpwifi_bss_prio_node {
-- 
2.55.0

