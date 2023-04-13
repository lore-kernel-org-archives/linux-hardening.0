Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568E6C77B73
	for <linux-hardening@archiver.kernel.org>; Thu, 13 Apr 2023 14:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjDMOmx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 13 Apr 2023 10:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjDMOmv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 13 Apr 2023 10:42:51 -0400
X-Greylist: delayed 439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Apr 2023 07:42:49 PDT
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93034C3C
        for <linux-hardening@vger.kernel.org>; Thu, 13 Apr 2023 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1681396563; bh=MbAmcnG2CXhNY1EHnQtPRAGFD2rG2vh6+CqnhkUIkDg=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=JvOgqw6hQO6n706BQdyO1B5LykXqDdOsxC0Bat5AR7nSJZ3p1SJ3qIl3wSiTXSFyO
         wVvA9qtPK016jKajDu3n+P0tiMWM4FMq28xZnd7xUYbY/MPwODpTNsD7xkcEblz6Et
         QrfwEr+Zf5Tv3QDroo6WkXUc2MqwJ9yYBfeltVVuofA1zyEk+trEPIDlD20sMFsc85
         AQr3Gqz4B7MNDCJ6Ei4lch97oAxilcSTnaezMb9H7+j6jJXRdeUUbIn1geZQpfs9sS
         ul0O/SS2Xizt0f0davmFhyeq88cIzma7kCuo0S8OQaGOjCHbSQJMWN7k/80Na58tgj
         XJl+AQFv11KZw==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id A6CC818099F;
        Thu, 13 Apr 2023 14:35:56 +0000 (UTC)
From:   sxwjean@me.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
Subject: [PATCH 5/5] slub: Don't read nr_slabs and total_objects directly
Date:   Thu, 13 Apr 2023 22:34:52 +0800
Message-Id: <20230413143452.211250-6-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230413143452.211250-1-sxwjean@me.com>
References: <20230413143452.211250-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nAzode42SKfbD2lWdSEdjskVbXveXf7e
X-Proofpoint-ORIG-GUID: nAzode42SKfbD2lWdSEdjskVbXveXf7e
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=683
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2304130130
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Xiongwei Song <xiongwei.song@windriver.com>

We have node_nr_slabs() to read nr_slabs, node_nr_objs() to read
total_objects in a kmem_cache_node, so no need to access the two
members directly.

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
 mm/slub.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 33b4fec6bc7a..2c3af399d9d6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5157,9 +5157,9 @@ static int validate_slab_node(struct kmem_cache *s,
 		validate_slab(s, slab, obj_map);
 		count++;
 	}
-	if (count != atomic_long_read(&n->nr_slabs)) {
+	if (count != node_nr_slabs(n)) {
 		pr_err("SLUB: %s %ld slabs counted but counter=%ld\n",
-		       s->name, count, atomic_long_read(&n->nr_slabs));
+		       s->name, count, node_nr_slabs(n));
 		slab_add_kunit_errors();
 	}
 
@@ -5443,12 +5443,11 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
 		for_each_kmem_cache_node(s, node, n) {
 
 			if (flags & SO_TOTAL)
-				x = atomic_long_read(&n->total_objects);
+				x = node_nr_objs(n);
 			else if (flags & SO_OBJECTS)
-				x = atomic_long_read(&n->total_objects) -
-					count_partial(n, count_free);
+				x = node_nr_objs(n) - count_partial(n, count_free);
 			else
-				x = atomic_long_read(&n->nr_slabs);
+				x = node_nr_slabs(n);
 			total += x;
 			nodes[node] += x;
 		}
@@ -6387,7 +6386,7 @@ static int slab_debug_trace_open(struct inode *inode, struct file *filep)
 		unsigned long flags;
 		struct slab *slab;
 
-		if (!atomic_long_read(&n->nr_slabs))
+		if (!node_nr_slabs(n))
 			continue;
 
 		spin_lock_irqsave(&n->list_lock, flags);
-- 
2.30.2

