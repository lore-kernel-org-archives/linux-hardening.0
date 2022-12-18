Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06850C4332F
	for <linux-hardening@archiver.kernel.org>; Sun, 18 Dec 2022 12:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiLRMcd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 18 Dec 2022 07:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiLRMcc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 18 Dec 2022 07:32:32 -0500
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08212BC28;
        Sun, 18 Dec 2022 04:32:25 -0800 (PST)
X-QQ-mid: bizesmtp91t1671366705t90nn764
Received: from localhost.localdomain ( [113.200.76.118])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 18 Dec 2022 20:31:43 +0800 (CST)
X-QQ-SSF: 01400000002000B0D000B00A0000000
X-QQ-FEAT: 3M0okmaRx3gbC4OVuUY0z+BVAZLPmxZcAXXWoPgJkrW6IAgAdHBU/h9y0nu7D
        NQ36j+kwQWe5ZwXnc1v8TUiJH9QkRhlI+b6DaENkNQduG1ekmejzwvjVeAYEUQQdY47vkqz
        O6EwJcQLflI9Zb1Il0UnUPZd7bcZWT12KjR44Cc4UEEnMLfbF+GmdLi9Wn7KpMtJadhe3Y2
        NieKbWeugJevRA+BWKcoX3v6GVtltZqAHyuxftuNNORgamzohpGVNhpUyOir0NxArj6AHBF
        XiGFDBC0gbAqIMbaZgdeey61qYDTD/1hjwG5S7lPcu+ohOBsa8B5QXQUSF0aWxZHEtWXvHX
        kB6vZY9PaloVsD9hzYm9Eerw6hClvXF8v72L2y/i2MVEEq0QQjSWni7ozsncpjte9RWwNd+
        z2VZ8m/AyyjSnfeaCvE2sUrUqUh/2MyD
X-QQ-GoodBg: 2
From:   gouhao@uniontech.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, mingo@elte.hu,
        Gou Hao <gouhao@uniontech.com>
Subject: [PATCH V2] mm/slab: remove unused slab_early_init
Date:   Sun, 18 Dec 2022 20:31:27 +0800
Message-Id: <20221218123127.23810-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr7
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Gou Hao <gouhao@uniontech.com>

'slab_early_init' was introduced by 'commit e0a42726794f
("[PATCH] mm/slab.c: fix early init assumption")', this
flag was used to prevent off-slab caches being created
so early during bootup.

The only user of 'slab_early_init' was removed in 'commit
 3217fd9bdf00 ("mm/slab: make criteria for off slab
determination robust and simple")'.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slab.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 7a269db050ee..ede1f29fd81c 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -220,7 +220,6 @@ static inline void fixup_objfreelist_debug(struct kmem_cache *cachep,
 static inline void fixup_slab_list(struct kmem_cache *cachep,
 				struct kmem_cache_node *n, struct slab *slab,
 				void **list);
-static int slab_early_init = 1;
 
 #define INDEX_NODE kmalloc_index(sizeof(struct kmem_cache_node))
 
@@ -1249,8 +1248,6 @@ void __init kmem_cache_init(void)
 	slab_state = PARTIAL_NODE;
 	setup_kmalloc_cache_index_table();
 
-	slab_early_init = 0;
-
 	/* 5) Replace the bootstrap kmem_cache_node */
 	{
 		int nid;
-- 
2.20.1

