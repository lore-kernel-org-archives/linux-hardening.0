Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364B0C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Jan 2022 01:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244429AbiARBjv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 17 Jan 2022 20:39:51 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16719 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244464AbiARBjL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 17 Jan 2022 20:39:11 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JdBDG1mSTzZcw4;
        Tue, 18 Jan 2022 09:35:26 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 18 Jan 2022 09:39:09 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <gustavoars@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH -next, v3] sched: Use struct_size() helper in task_numa_group()
Date:   Tue, 18 Jan 2022 09:39:37 +0800
Message-ID: <20220118013937.129318-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worse scenario, could lead to heap overflows.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/sched/fair.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 095b0aa378df..1a21bb33a4b2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2437,9 +2437,8 @@ static void task_numa_group(struct task_struct *p, int cpupid, int flags,
 	int i;
 
 	if (unlikely(!deref_curr_numa_group(p))) {
-		unsigned int size = sizeof(struct numa_group) +
-				    NR_NUMA_HINT_FAULT_STATS *
-				    nr_node_ids * sizeof(unsigned long);
+		size_t size = struct_size(grp, faults,
+					  NR_NUMA_HINT_FAULT_STATS * nr_node_ids);
 
 		grp = kzalloc(size, GFP_KERNEL | __GFP_NOWARN);
 		if (!grp)
-- 
2.17.1

