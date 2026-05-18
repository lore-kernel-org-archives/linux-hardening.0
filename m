Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676F0328610
	for <linux-hardening@vger.kernel.org>; Mon, 18 May 2026 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139127; cv=none; b=XdNIhuoIfDaUls7CI8PM2db+z4NZB0JceK5l/KVsiM+pWwL/dGtRWTROzpyAeUZMrKhTe9TwEH/YET2JlX/kzt02jWFl7HThPNkmUB4Xew+JTEH5NU47j3DSzRTQBVpBdVs65ib3f8B2wzs1MA3aotahR4kzTo7g/jg7jvzvfq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139127; c=relaxed/simple;
	bh=g/xJZ+OYh1mkHmn3+sQ2z7XA33HLjy2TXP/ltrNVdjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NqIQh0DNAsZ4NKrCX0Ea5Xkh1MmpK4Qro9TkpOBPLJVkLs8pFPJTiZd6jS+ELLEbHRxxG5ZtQxVQ0O17/Nvn+37a/7fLAdD8uVHjklowqudz1i9trvEm7jtQN2sytpj9Sg4pMbHwqfqJ/4jc/Z34MtCH/R7EUyY6r9lyFRLH+SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTzT0fqj; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTzT0fqj"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36622412e97so2044471a91.2
        for <linux-hardening@vger.kernel.org>; Mon, 18 May 2026 14:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779139126; x=1779743926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DYl12Kfn/OxyVfyG979gVQDEq7mBiScEt37GaLdil1A=;
        b=QTzT0fqjDQ4fTAyk9w1haDp2lZCCvtTO7OejfYejXr4K0qO4DM/9DdZsgTStecQ33L
         D+AYq+1pzMi0nWRnAPeoxDxqeJx6aqaCcLtoAOrcUEF+uAStgBwhX7KhYHGSywcnj9vg
         vxmn0XDQDOsiupxpFGyYnEfxw3Y4W/xB0NnAGmQo6QJcRPDAiNhvCmdZmRLCJ+Uj/1uU
         iN1p9joGHtNmKqt8D2yM1aVPhGSPbX6acurkcEh68Ow5OYNEqDzDCHtcx+EQ72vjQsoE
         vqnasDsmBLj6GAFAg+0Jxur20JwRT9GMhb344dAnvHE1aVklxmxPz98md6Ot6HnnzVeB
         65jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779139126; x=1779743926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYl12Kfn/OxyVfyG979gVQDEq7mBiScEt37GaLdil1A=;
        b=ATHR60stPy/2l1EvKDMbK2Y9zAfN2VHt3dqPjtda0MO5rH+qFqAwZxCIq6crEHOxJF
         jMGZpuHA+tBFuEXJLPgni2DsorRxQWQd2Q5ipWYPE5n/CWv4I97Tvk/pLaG3L1q56Has
         AkrRjeBA3iVkFejPNWJutkpDW/OajtBbk9+sp893RlxCniSghL58e+IhrUs4pdQTz/bv
         mc0B3NBrzB3eSEXNN8YaE1o+uYoWYfcfeyLjcjNDSFp+ScU2vH5G9VargiAkvfEjVsZo
         m53j5JrJoI7fQx8ROiD2CSnoKVS3pZs8OzQM4CCZn1eJUwraYj3j3yFTI8ktjCc0GPgv
         H3ZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+s10Y9285F0H4tMlGlravhGmqhcuKawvGxTEM/NSvA1ro+4EHzswxj2l1P7XtgN4saQh7yQE49zZuynV5zhf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTOqx/qaTXB9H9Nv5MS0T7PoPScDz2PXx2CwGRWbBBj6lTZXAg
	VpnQqdwpbFhFpKOzSicodLok1yMTypNdVWAXaJ1dGXHxT0F4uGcq+rnw
X-Gm-Gg: Acq92OHou0kNPWUhuKDLpP4qbYT4QAQALY2vhIMtlF7Rwp7OPRMpF1GkOFx6KE9qUkZ
	SZwS+7xHOf7TiiPBvVya7uWkgty/O9fqxLcvUwWGYWbIt958PkBNuLPp+OKd9rs/b8fgVEWQ3ZT
	dpcQBLRWApE/1J+cUZBW/j5Pj5AWN/arV4PWkeeqVaPtJ0xoOg3yK387B35DtXPFGYEzLOMLtHz
	qf3e+ACq5PxhXDcoPUgmXSCQ/gO5jFb0AFpknA2OJnQbcvK1azXeYiyu/3W3dxHGaa+UGekhBy0
	A7cMFor715reFdGZOU70Z4tClqMezAm3yH8hBUy++iOIYEjfvwkvpG/PxosU+M0n6YE97VSsveB
	1buJ4l03a0Q6vRVUzQAbFt1A/MnJP1vaNyhqxdr4AkzKrx8+IY1GQ+p0+1yF2RLLurPtL4bm6tO
	Tz78bowSNXxCMefzk/Nx3ytqx7NIbKfqNsdeexzxhu1WaS3zOew4P1fyTum2VueksXZUSx4J9TX
	FE2wtAYXCnge6GVADJyESkMSCUNdryl9rY=
X-Received: by 2002:a17:90b:4c50:b0:369:d7c6:450a with SMTP id 98e67ed59e1d1-369d7c64a4bmr4286889a91.0.1779139125662;
        Mon, 18 May 2026 14:18:45 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695157d963sm11466999a91.6.2026.05.18.14.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 14:18:44 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH wireless-next] wifi: mwifiex: Use flexible array for RX reorder table
Date: Mon, 18 May 2026 14:18:26 -0700
Message-ID: <20260518211826.11245-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Embed the RX reorder pointer array in struct mwifiex_rx_reorder_tbl
instead of allocating it separately.

This ties the array to the reorder table lifetime and removes a separate
allocation and cleanup path.

Use kzalloc_flex() for this and move the counting variable assignment to
after it as it does for GCC >= 15 already.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
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
index 27559e2ddc31..67da5daa48b4 100644
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
+	void *rx_reorder_ptr[] __counted_by(win_size);
 };

 struct mwifiex_bss_prio_node {
--
2.54.0

