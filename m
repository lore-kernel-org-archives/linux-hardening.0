Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83655451999
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785350240; cv=none; b=ntH7OkWLqjb33qH7eaVBn4f320yUHGTJvTezZhF//XwL32AMYIEEwH12FSfIUgy0VVQWMZLQnGGDCDlrrT7gg9SIRM2Qh6/3FrAuq3XMS87gSUTqPZwN8JrxOC4u1njsDO2TI1yhbRcHqDSvRT77owF7ZOghSjr1jAy5lu7GdKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785350240; c=relaxed/simple;
	bh=4P98aSbKBGaFkCj+9Z8F4SQSSnqALgFeDj729JAeHgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LMoWSfkjy1NFplCzDLW65il05KtmGExPxtQWoASSSGUZbWa9KC4sdBUw+ctvaL8gO06fwLGYaW+6tmNY8sTlNMlIQd6iCWOA83U09CbqQVm5v2rn6WtJ3Mh1+N5H8wrsHp44RauL3EWtv1GpyeBgDTykco43H8cVovGyUxLss78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwEZ0xkA; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwEZ0xkA"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so870895a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 11:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785350239; x=1785955039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TKiRLVwj3NSxN3gEZDV7xpth8PKqEmNyRu0ElNGl93A=;
        b=PwEZ0xkASSYe674ENRaXsVu9D5lUQjcKXrCTNqHJLiHWX4sqo9EZ2/VomqGePiODK6
         5fFnbHWBU92MpTOkHoWgikiS+PlNqygQC/yScvv1uYyiWDSMNe5rQbImbvCZvWELQarF
         ysEgXEwzSIWf3rOYnLphsGkBrRXrxI5nEZZMs3vxX/UnRoBjS+XmocsUF+YhzGxZRyUu
         unwdwCLKwu2cfqR1GiDMWFuc8g93uB/G8EmVCvJfmpCgFyiI/02h+qico23lixDuPiM3
         5zerkbmaXFvr+uzGbTZckwdkE4HJQ73WldgkojKc6gpcFpbu8dm6lOCj+r4ql1UcUpVs
         3vJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785350239; x=1785955039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TKiRLVwj3NSxN3gEZDV7xpth8PKqEmNyRu0ElNGl93A=;
        b=Ed05HCQUjUADj1spmPj1D9wXnVVhMmpmxgQLEVFXfFZXgwiO/O88fAEdQJSFHIlSM4
         BCMiApVgHrAknCpENOvH60twPPEk2zuiFtxgbQ+r4rdRxTLWPwVXm6ugK4asHxI84p5x
         nQ7Nld5z9umSAfhdHkaevTObBB4h+n0Hb8Oe2a/bJ/qIbsn3g8QmLiOr+T7xoRdzrzhp
         mASJcBKw/B6VleRomxHOKS9UPIhdlDVbh9b1JorbO8PT/o9pE2HPar9kEd9N5A3kmyko
         Lr006Nr2Lve2FsXnwSAW8b37JcyfKthQLHBhNQzmWnpQenFqKlDiy+xZU/VXZJpXcsSp
         2TNw==
X-Forwarded-Encrypted: i=1; AHgh+RoYYFDgk9Z13NHP98y6slvnuqX0YaBFSFbdYXEBYD9/RUe8gK5TkpCPITCsU3ZJGbqXwFMYoLIYwf5aFg8a5H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQIA6OWNp/fqixUuPos+V0QSKZP/fw9fMvmlmj7mnwpMef6Y2w
	XmVjeoGuVL4foRlr7i3jCv2timc4fju1hMlU0jY+2Hwh7j0Pdtp0VtyF
X-Gm-Gg: AR+sD111uVEAqEnm1QcmNw1NDdDpwzPToYpT+Ky2haXlwmos5/l9kd2786ZmMfPrxwz
	Hstl8rEK00lHKTWL00KEihuuQ9C6rZi07VpRXgQcZ5ZlTFD6WbSLQzrksIbX7P3Syc9fp82hFIR
	lYpXI7ExQh7D+S/VS38W1PuM+MEHBIUw0xvM77MuPz+3hfipYkmpCwYlmecoMhLfcsuHE4O40nZ
	Wjnz6L1+U0MMH8uG0HN47hbXUrhF8pZdeP4MCmGaRBoa8b2/hY6fT1Tc/CmV7qcUd9sA/96p+nQ
	pNgYpojv1QBgz8sEcVXA0fT3oG+F/LWW38lTAF91wzi47H/1Gyu/orihy7Z581rHgYAEgG6LwVF
	t6qzBRkJNJa/leiuwKpRR+jhLNdlXVfv/E1dZKbF1l6MYnsYif+p+bd+CEGXBpdRX6oAwWiyFiu
	vuffu1Py45agAn9bYXpwX7Euzs5dwQ/h13easOSLVuwn63Js3FxkoCjQRknFCGsnasOTl+TTG+x
	BVS1xRrdXgIh54fyIVzulOT2sz6rxVcqL+NPkoIF/W/nWKlZgLC6esik6yVNavNOmplj9ynCfXf
	q33ryiHSmFC7zF+CoZoO58MpvNdszSE1BzeKhg==
X-Received: by 2002:a05:6a21:7106:b0:3c3:7f8f:88c9 with SMTP id adf61e73a8af0-3c8ba616cf1mr8675488637.54.1785350238739;
        Wed, 29 Jul 2026 11:37:18 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdba63d2fesm1312154a12.27.2026.07.29.11.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 11:37:17 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jeff Chen <jeff.chen_1@nxp.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2 wireless-next] wifi: nxpwifi: embed rx_reorder_ptr
Date: Wed, 29 Jul 2026 11:37:15 -0700
Message-ID: <20260729183715.691287-1-rosenp@gmail.com>
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
 v2: fix unused variable error
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.c  | 23 +++++--------------
 drivers/net/wireless/nxp/nxpwifi/main.h       |  2 +-
 2 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
index c5819f89b08c..65b628411543 100644
--- a/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
+++ b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
@@ -171,7 +171,6 @@ nxpwifi_del_rx_reorder_entry(struct nxpwifi_private *priv,
 	list_del_rcu(&tbl->list);
 	spin_unlock_bh(&priv->rx_reorder_tbl_lock[tid]);
 
-	kfree(tbl->rx_reorder_ptr);
 	kfree_rcu(tbl, rcu);
 
 	atomic_set(&priv->adapter->rx_ba_teardown_pending, 0);
@@ -262,7 +261,6 @@ static void
 nxpwifi_11n_create_rx_reorder_tbl(struct nxpwifi_private *priv, u8 *ta,
 				  int tid, int win_size, int seq_num)
 {
-	int i;
 	struct nxpwifi_rx_reorder_tbl *tbl, *new_node;
 	u16 last_seq = 0;
 	struct nxpwifi_sta_node *node;
@@ -273,11 +271,16 @@ nxpwifi_11n_create_rx_reorder_tbl(struct nxpwifi_private *priv, u8 *ta,
 		nxpwifi_11n_dispatch_pkt_until_start_win(priv, tbl, seq_num);
 		return;
 	}
+
+	if (win_size <= 0)
+		return;
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
@@ -311,26 +314,12 @@ nxpwifi_11n_create_rx_reorder_tbl(struct nxpwifi_private *priv, u8 *ta,
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

