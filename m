Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443575;
	b=vFzBY08GRXvDVsohSQtf1iXEIg2BfUJ3p7/CmIhtQEZbNSU5yerQsoXExyflIgp01FRP
	 2PyBhoajV2JxgqNTSRh4pcKoX3Z11gknKxdFYeAeVr85b3UW5tJsBoHOHhaqcl4Pm7zFU
	 f/nzwg2QjZvAxRBftUC4xvqSucdW3+B+a+363DfX3WEsHpgBkM7IxTgXWWVtRqjX00bb7
	 HhzYbXELBpU2ine2USVaYJbZFdQ8nGj94NeYI3kkRW4KK7k07uHPs6JdsZz6Dl79N8Bnu
	 VYCDpNpp7qC5Up8rCO2FiiKqqaWSnnkt8BnNvWaFBNgDwPDonrcEBcjd9nV2l1JK5EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ftZ9KCAoOVfHj2aG9QGbjRXPabmKfwf/abxcx+jklUw=;
	b=ZswVlcvVVVBGzGoiqfUUcIkzltbK7EG02tCsHa/q2NlAoGFuI0xuaLTK7TUG2sX8Z39U
	 CBYfulae+FfRj2CoMZRgYN5uB/drIu5gzqavclTMwdTSABLuUx5+t6GOlqjCjmpOeN8nE
	 aLMY/mABzd/pXXFsi11v90SWD5R+Wlj8J2TU+03Rquxv4aEo0PbL5xOOPbO0gU4UIkss8
	 NoKJqRwLyplNIqwh6Sm1f3zyyWkIltr55qnCEYiK6KI3NSQrwu6nwL8QdJptSxV2RM57p
	 IHN6tdfm7L7piV9VYw/oL1S85KygIMdEUmE/EkZjh1eOJC5CS1YMVRImXA0QTaEr66g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S7zoOqzV;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBC0606A31F
	for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 14:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EBC0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S7zoOqzV
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3863db981d4so4467505eec.0
        for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 06:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443575; x=1796048375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ftZ9KCAoOVfHj2aG9QGbjRXPabmKfwf/abxcx+jklUw=;
        b=S7zoOqzViDn+yU9dg2xSqiVB1z6BVKr5t/5aI3YySLnbWrAQAimJNsiRJtOwZw8A9X
         un6RP6LT6HCkrArcaTiPEMtJvHhfRpB8etWrOl0byiDSF8DvVMHQHiAi8p18di0wzpNZ
         MSP++IXHXjljw/irrPKHoaHWdYg9va8QD1sc3+SyJ0noPQ5jzc84PYOzcPB9G/T6wnAq
         lEDMzVtWc30/s87xk+cWQVXR9yqxCh2xNSaTqHmFBrSK8d35zDt7QUk6HakdYQBgeNoz
         LAw+gAXAAeuW+69PmvUxUqYdt70kmsIdP3FoxMhv/+xIRlkJMyPvy9ODSwf+vSYHhAKw
         48wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443575; x=1796048375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ftZ9KCAoOVfHj2aG9QGbjRXPabmKfwf/abxcx+jklUw=;
        b=ggNQKainYrnQl1iTaFCl3BdZcw1YmIhohKkKqSYUYk+D2U5ZmUzfnF3DtoliwaH5up
         aikTsn3jakfzSaOBYh1K9kaG6bOVR65cvZrfYiUH6nIrjGDQF00o+W1C821BFWLbVtPu
         0luo5m80+W8ZZmWirimZZtsP8j/K5ofb6JkxfDpSekv3j8azM3j1ecKDUuWUOOqvwCY9
         pqiCIm5JdbvxLw8/OLdcQDhIOqDd8hLgxFbEg3vBam5GbORl595X1xE1kt9iZF7UqmPf
         b4G6pZuIsuRBKWZqJl0cnF4B2BQVDIiOumeSuL32foRxYVS30s3SBVAerUyhyOnTijzg
         Le2Q==
X-Forwarded-Encrypted: i=1; AL+hErEvpmVamHfitFc1jhAUBlNyecdyQxbLecsh5Q0TVP7tBuTwFW09y42ePWlVaLcQbPUCinLfAwPv+L28H1oNw/k=@vger.kernel.org
X-Gm-Message-State: APuU4Z84X2NNGmIBE94+xXEHl3SiPChTHTNFGwmwRDo2Jutj7M1GWi4J
	t70iUDOlI5P49N44w0rkOAp/Hwi5qYJ1pn5Mw2DbJigH8bKMvyz7aljI
X-Gm-Gg: AZFdTZc27w+bnYgamyGjsjxAJKaOOP125/mzfTcXPTT/bGLsVX6ihMgLV+Us1Oz4AWc
	9XQByV1pNPdnGgclOUvAZ5WoZz5fU4RBJP5KW4uUVd6YYiL6A2bjzpGOWFl1+PtLpw4OcmSicHt
	2Ay3zZgK/ErAnHYizQpC0BWmRVnHUUChDXN+ZS0YGAeGokY4oWcG0mrQKSHXfW+R/k+85RXcYJJ
	HJO8LXGQM8TIRCYJdjLPJLVuWAGyEZIwQHZ3QkPJC7KujELhiHJ+PoWCBayKikuGdV9hVmAZsQy
	CPBL34GDiSZt0xkVRH+AB5eVRohlYP0/PR3stLC3DolCWcxpefIBiiHYvh97YSYNaJyUDabPRH7
	6qvT2KT36/50/w5v3fcoyx+ohEY5STHg5h7ViGKXkaZRnJUcKIH18C5Jjry5/DgAcaIZDaT/F2b
	4rpWSFDDKONzkvunL6eIVFjn7lbWSMaT2cLA7J4QQpZFCt7E7/ZqfBfm/e4siZJIAhqOaEUgb4T
	M/fr0j8M+TuYwyzwBZrBKSm8VKK05nLBXChrpq1qIiDCJ4AVPMov1aFE1F0hiequYE36Jrqol0P
	+sMJirhQi7CICwEDn04H21ATxcpw0HVnipwLHd40dHuvuNe5KrGoA4RvvBbf7PnU3/we
X-Received: by 2002:a05:7300:2202:b0:36a:1e9e:ae61 with SMTP id 5a478bee46e88-3857170afa1mr17567764eec.38.1795443574544;
        Mon, 23 Nov 2026 06:19:34 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm30652112eec.25.2026.11.23.06.19.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 06:19:34 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Jihan LIN <linjh22s@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v5 15/19] lib/plist.c: remove requeue function
Date: Mon, 23 Nov 2026 22:19:23 +0800
Message-ID: <939710bc5e908b4e30d86aecacfca0524ef11d6e.1795439990.git.lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795439990.git.lianux.mm@gmail.com>
References: <cover.1795439990.git.lianux.mm@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Now the last user of plist requeue is gone, this function can be
removed.

Signed-off-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 include/linux/plist.h |  2 --
 lib/plist.c           | 71 -------------------------------------------
 2 files changed, 73 deletions(-)

diff --git a/include/linux/plist.h b/include/linux/plist.h
index 16cf4355b5c1..73d359c1a053 100644
--- a/include/linux/plist.h
+++ b/include/linux/plist.h
@@ -132,8 +132,6 @@ static inline void plist_node_init(struct plist_node *node, int prio)
 extern void plist_add(struct plist_node *node, struct plist_head *head);
 extern void plist_del(struct plist_node *node, struct plist_head *head);
 
-extern void plist_requeue(struct plist_node *node, struct plist_head *head);
-
 /**
  * plist_for_each - iterate over the plist
  * @pos:	the type * to use as a loop counter
diff --git a/lib/plist.c b/lib/plist.c
index b0273533c04d..b05ae7ffea87 100644
--- a/lib/plist.c
+++ b/lib/plist.c
@@ -142,65 +142,6 @@ void plist_del(struct plist_node *node, struct plist_head *head)
 	plist_check_head(head);
 }
 
-/**
- * plist_requeue - Requeue @node at end of same-prio entries.
- *
- * This is essentially an optimized plist_del() followed by
- * plist_add().  It moves an entry already in the plist to
- * after any other same-priority entries.
- *
- * @node:	&struct plist_node pointer - entry to be moved
- * @head:	&struct plist_head pointer - list head
- */
-void plist_requeue(struct plist_node *node, struct plist_head *head)
-{
-	struct plist_node *iter;
-	struct list_head *node_next = &head->node_list;
-
-	plist_check_head(head);
-	BUG_ON(plist_head_empty(head));
-	BUG_ON(plist_node_empty(node));
-
-	if (node == plist_last(head))
-		return;
-
-	iter = plist_next(node);
-
-	if (node->prio != iter->prio)
-		return;
-
-	plist_del(node, head);
-
-	/*
-	 * After plist_del(), iter is the replacement of the node.  If the node
-	 * was on prio_list, take shortcut to find node_next instead of looping.
-	 *
-	 * prio_list is a headless ring, so from the LAST bucket ->next wraps
-	 * round to the first one; in that case node_next is the list head.
-	 */
-	if (!list_empty(&iter->prio_list)) {
-		struct plist_node *first = plist_first(head);
-
-		if (iter->prio_list.next == &first->prio_list)
-			goto queue;
-		iter = list_entry(iter->prio_list.next, struct plist_node,
-				  prio_list);
-		node_next = &iter->node_list;
-		goto queue;
-	}
-
-	plist_for_each_continue(iter, head) {
-		if (node->prio != iter->prio) {
-			node_next = &iter->node_list;
-			break;
-		}
-	}
-queue:
-	list_add_tail(&node->node_list, node_next);
-
-	plist_check_head(head);
-}
-
 #ifdef CONFIG_DEBUG_PLIST
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
@@ -238,14 +179,6 @@ static void __init plist_test_check(int nr_expect)
 	BUG_ON(prio_pos->prio_list.next != &first->prio_list);
 }
 
-static void __init plist_test_requeue(struct plist_node *node)
-{
-	plist_requeue(node, &test_head);
-
-	if (node != plist_last(&test_head))
-		BUG_ON(node->prio == plist_next(node)->prio);
-}
-
 static int  __init plist_test(void)
 {
 	int nr_expect = 0, i, loop;
@@ -269,10 +202,6 @@ static int  __init plist_test(void)
 			nr_expect--;
 		}
 		plist_test_check(nr_expect);
-		if (!plist_node_empty(test_node + i)) {
-			plist_test_requeue(test_node + i);
-			plist_test_check(nr_expect);
-		}
 	}
 
 	for (i = 0; i < ARRAY_SIZE(test_node); i++) {
