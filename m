Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794667936;
	b=hI65BgbFe3OFHc23bOaIM2fi9aZZ5PWlvsOegiyHhFLxIbD37AAngQM7Tmg/aj9E7g2w
	 y0r+FMqZBsdAIrLdqwrymYkVi2QvQnb+7VBUg5DxTRywJs0zQaP/1eCbwnWzUQqzMU/Lp
	 tm7yTaK8eJZR3RtGIRE/dER92tTbou77BIuxLY4RMnmSQg83COdvEziR6YRV9vgdnMaYh
	 Z77Xffz9akkte1zxT9mSE0kaqHVRREJk6fRJcA70W4ogzqn7RrKC0D8f5fN23r2NfEvtY
	 Xbv+HAmzEWNVcs2FEKc30yxSoEbdWKpNJmoIp14Qqxs5WSnATWJX2LfukqS6yPHHQsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794667936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ftZ9KCAoOVfHj2aG9QGbjRXPabmKfwf/abxcx+jklUw=;
	b=nQpeMqeJBpeWOH8CvHzmzxDO4aMcvuagSMk8C9ZMkpbio19U3LP5X9NCKrmkmdGWelq+
	 5P+JSrkd9ZVDbfe975pQv7P2qNVe10SvH+x13k7735kyZxPNTnoDkmrRDUAojsm/d9WKA
	 MoZZNklC+YQWPc8lPi5ZtXree7e0uwZBpceeOU5lN8NAQOjpUDhujai7c60T9KuV43MMs
	 hlScuJYzetu2WpzefS+hPn5n9S0llGD00QbC1QbC/9BS0T1Z2B3jHEAcwZfCBxA0tSBPA
	 ZWUuuIzin4nIkmzrwcT4CUYuQvIcJXY7qKcMfuul410LX5mY72xnb2/92PdwsRs8xXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lMCET2HL;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5407606A8A6
	for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 14:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5407606A8A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lMCET2HL
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2efa9addec5so293035ad.0
        for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 06:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794667935; x=1795272735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ftZ9KCAoOVfHj2aG9QGbjRXPabmKfwf/abxcx+jklUw=;
        b=lMCET2HL8+waVHPTmBoDPbiq0Tpj8VM2mCKRgKDoRbCwHbTgMVwW8Mvk+Pt6q4NBNd
         KbcE8tipIrlpz1h2BIkmfJm/9L7uhso3KrpU1KkIWThk2bthPy6S29RqvdDx7lNi/zBh
         t7yJJAFcX88RNF6H06BsykN/uUyAQ7bofm4ou+wz/qokDY/G7jzRXVA9AbklNtX+ZOAW
         9zubVoH/QOV/tzZadKs0BkAOazWhm+PzKQ/M2hfqoLEfMn0rGzstMF+5D8dB4d7D++SW
         n0exONb+H6/ZiFg2Kn2RQz0x2WMHK6HJFL76tA8Rx02xkskcBNWUchWNqpgjkIIPZmCz
         BeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794667935; x=1795272735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ftZ9KCAoOVfHj2aG9QGbjRXPabmKfwf/abxcx+jklUw=;
        b=cMCOrQfhqRr6XyqEYx+6tdfUHgsrPi+sQ6G37WIAbYaKGTpt1G8LpwGIljmIm9Qc7+
         qGdJBY42eFBeXBZXIVJb4r2f07VuftqtnDcALBpyz+p1TRAQ97b5afXJWIDOKYeJ4pW3
         JKwVsaGdIom41C3oWptIY09qRkeI906dJg05FgGzLBD+HyW+/phQpjgWaYuZL3ppQVuO
         0FRTZefLZtP2m+bzwUkfhYlB4JSWFz+hyyXXDIrUHFnzv9qiubHv9qhQgLkKRNwsweZp
         fsH1dpQFyFd5hStJZRQM/RYRtaI6xfi3aAIJfh4SVr2QZYDrdqHH8wiFpe3liHs1J+m6
         LNcg==
X-Forwarded-Encrypted: i=1; AL+hErHSkmYl/PRhSK9JQP3/N1F9Wt44eDO3jcgS46aLZ206vdSgVEbgyyCzbf2uQ56sesdg7RNvY/9PPCQ64a9AlJc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8NQgyTYuxXtk1BMGGrqK8iKZ1iBYlUIg7JReiJgNidJXcEjAM
	TBxAY2Rht964cm9Q++PyAtXamo61TCdMWfrdpn/4mYz93R20i1mZF/EJ
X-Gm-Gg: AYBFou3XWNBM8T6FXZqEzweOJyc90yEDhUF2OOpki8SrPDxKpF2G4h2vhiTxbSfaVmI
	ez9VNi5UMqYkkQMxhR7//nnUzZ6ImfVOf7GhWCISr/GdW+g/qsEVTALOKa1el2GIxXbolJ7HuQh
	6K2oiM8L4NDyj5unk2K8uflxONQySEN+Dv0gZ9fsrvGahBLi37Z39dpHvLkCU9NxnWoqOYt4zd6
	/+OqrkGQUgtQyW2ILCR2VsBGqTEJK8NQEDZ4rcXs8kZPVLjzZ77DWvWV6YImsRY3gOfv/RmiFKK
	JSg0soo9CYHOw0WWPnLvBkLuy0dzX0ejck15bDOjnvBgA5nVIxmin2MrjWlohHSZIE7C0kWw36+
	IawCR05hMn2ZEfVijaDaMwPAO6kcNtRaLcHgPJiNJgs5HFbK42IRxwOExlwJfJoubPFURYuz385
	YqhfRhCZiUYLutimZwcC05mgwMLBb7A7pMz6+UPTho59w6m7CiBtRnDx7aJSeus7K8OfoMPTIPN
	ADzY9oomsAqh4DkatAq/zYx8O4/grRDLTYgu1+voLPHGhR1MLRPpC0sho3XsUcqFHzDnqViqC4d
	1PvgdZJl0hZ83kWF5qKWbnCjejk5z8XeMilNj8oq+vO7Hg9kfW6Owdp/6g634w+C6fXA
X-Received: by 2002:a17:902:f70b:b0:2ed:537d:f00 with SMTP id d9443c01a7336-2ee0dc95988mr49994515ad.56.1794667934899;
        Sat, 14 Nov 2026 06:52:14 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f224370sm21342815ad.0.2026.11.14.06.52.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 06:52:14 -0800 (PST)
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
Subject: [RFC PATCH v4 14/18] lib/plist.c: remove requeue function
Date: Sat, 14 Nov 2026 22:51:58 +0800
Message-ID: <f513864653d62e4ce8095af9fc1275081d1d1c81.1794666741.git.lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794666741.git.lianux.mm@gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com>
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
