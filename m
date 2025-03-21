Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B739231A24;
	Fri, 21 Mar 2025 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589669; cv=none; b=JSLkWMjp6xmWw80YLVfC5fIPd3eeUlr2RKLD47SseQhBJCHnFuDAAK8+/WxjO6idGclBuQTbd//KuQad9LXTcAFw3ofdeshOM/LUKhbXSqFGnHxNkz2SfcAyv4iZyuov3tMg2PJZeIvSD1osxaa2DPtVzpQHAE3/oAy19HfNVRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589669; c=relaxed/simple;
	bh=JVAu52DHGpijIKeMcuzb7s5YInM6xKk7XO0za9QqBbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BwP6Gcd1m6X13QfHQri06l/r0jbtyBcXy078l4b22bTexI+PmG0AV5EulVYeiDrAnSR0ttLVjHbZq3RzdZuFoegEJ0SdvRARyXLnnTaLqbnlOurn6u/j5VkwjhmLcNZ9TyVulxz8ppsmXCRwRQOxltTJtQmiU7eeOnS43cXV30U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxz0E025; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxz0E025"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8979C4CEE7;
	Fri, 21 Mar 2025 20:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742589669;
	bh=JVAu52DHGpijIKeMcuzb7s5YInM6xKk7XO0za9QqBbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gxz0E025PiYrfenRJPrd1ufKEJqvcOTAsfkSMzPCpgltkP2SUgsQS12N2c8EljgSz
	 zgiVI09srPYhEvOSSgXs5ROaeBYP6SZ7+Fw2YfxQY4i6Ba+7+YcK8mAt2c5d8HuHJ0
	 Tqh1R3CWTFRJqO4UmegO0hwzusA2xwrmzI9ZQw8roHcweLlbDqkvi+6xBnrniP2oAU
	 BtFiZ+/kQKLLAtFQoGjWoycNyW6GcrT2YXFTX09LE9fFdBY5FGbtkTS5xP5QB8sNqK
	 GMxxzC1y+w8ynUfTcHOa0OSGAo1vnpeMXTa4QG5mmenTP67xq+mJahEu6YMIhSoi2K
	 J59rxHLdvxdcw==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Marco Elver <elver@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/5] treewide: Replace kfree() casts with union members
Date: Fri, 21 Mar 2025 13:40:57 -0700
Message-Id: <20250321204105.1898507-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321202620.work.175-kees@kernel.org>
References: <20250321202620.work.175-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3631; i=kees@kernel.org; h=from:subject; bh=JVAu52DHGpijIKeMcuzb7s5YInM6xKk7XO0za9QqBbA=; b=owGbwMvMwCVmps19z/KJym7G02pJDOl3z922vz9LcHfWgx0Ss1JsLgmpPp+5tXNXes5RydM5O qfcave4dpSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzkhC0jw/9bu8RStOIP8nvI Tuat5NF6IfXqVwb7L4WpryOU8ibcqGFkeFnXW3rnoek685fphrnRuqmihr3NCzmtNWMdb+wo3vG NFQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

As a prerequisite to being able to optionally take the address of any
lvalues used in a call to kfree(), replace casts to the kfree() argument
with unions to include an actual pointer.

This is an example subset. There are another handful remaining:

$ git grep '\bkfree((void \*)'
arch/mips/alchemy/common/dbdma.c:       kfree((void *)ctp->cdb_membase);
arch/s390/kernel/crash_dump.c:  kfree((void *)(unsigned long)addr);
drivers/crypto/atmel-sha204a.c: kfree((void *)i2c_priv->hwrng.priv);
drivers/infiniband/hw/cxgb4/mem.c:              kfree((void *) (unsigned long) mhp->kva);
drivers/isdn/mISDN/fsm.c:       kfree((void *) fsm->jumpmatrix);
drivers/misc/altera-stapl/altera.c:           kfree((void *)vars[variable_id]);
drivers/misc/altera-stapl/altera.c:                             kfree((void *)vars[i]);
drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h:                        kfree((void *)x); \
drivers/net/ethernet/qlogic/qed/qed_main.c:     kfree((void *)cdev);
drivers/net/usb/cx82310_eth.c:  kfree((void *)dev->partial_data);
drivers/net/usb/cx82310_eth.c:  kfree((void *)dev->partial_data);
drivers/scsi/snic/snic_io.c:            kfree((void *)rqi->sge_va);
drivers/scsi/snic/snic_io.c:                    kfree((void *)rqi->sge_va);
drivers/staging/rtl8723bs/os_dep/os_intfs.c:    /* kfree((void *)padapter); */
drivers/video/fbdev/grvga.c:            kfree((void *)virtual_start);
drivers/video/fbdev/grvga.c:                    kfree((void *)info->screen_base);
drivers/xen/grant-table.c:                      kfree((void *)page_private(pages[i]));
net/ieee802154/nl802154.c:      kfree((void *)cb->args[0]);
net/sched/em_ipset.c:           kfree((void *) em->data);
net/sched/em_meta.c:    kfree((void *) v->val);

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/netlink.h | 1 +
 include/net/pkt_cls.h   | 5 ++++-
 net/sched/ematch.c      | 2 +-
 net/wireless/nl80211.c  | 2 +-
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index c3ae84a77e16..26eb9eea8a74 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -295,6 +295,7 @@ struct netlink_callback {
 	bool			strict_check;
 	union {
 		u8		ctx[NETLINK_CTX_SIZE];
+		void *		ptr;
 
 		/* args is deprecated. Cast a struct over ctx instead
 		 * for proper type safety.
diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index c64fd896b1f9..4faf8d6eed1d 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -403,7 +403,10 @@ struct tcf_ematch_ops;
  */
 struct tcf_ematch {
 	struct tcf_ematch_ops * ops;
-	unsigned long		data;
+	union {
+		unsigned long	data;
+		void *		ptr;
+	};
 	unsigned int		datalen;
 	u16			matchid;
 	u16			flags;
diff --git a/net/sched/ematch.c b/net/sched/ematch.c
index 5c1235e6076a..f4b00e7aca6a 100644
--- a/net/sched/ematch.c
+++ b/net/sched/ematch.c
@@ -411,7 +411,7 @@ void tcf_em_tree_destroy(struct tcf_ematch_tree *tree)
 			if (em->ops->destroy)
 				em->ops->destroy(em);
 			else if (!tcf_em_is_simple(em))
-				kfree((void *) em->data);
+				kfree(em->ptr);
 			module_put(em->ops->owner);
 		}
 	}
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d7d3da0f6833..b5a3ae07d84c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3270,7 +3270,7 @@ static int nl80211_dump_wiphy(struct sk_buff *skb, struct netlink_callback *cb)
 
 static int nl80211_dump_wiphy_done(struct netlink_callback *cb)
 {
-	kfree((void *)cb->args[0]);
+	kfree(cb->ptr);
 	return 0;
 }
 
-- 
2.34.1

