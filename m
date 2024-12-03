Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26DA38DDB
	for <linux-hardening@vger.kernel.org>; Tue,  3 Dec 2024 02:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733193150; cv=none; b=TakiSU5D2dE9DLr/aj7FFrY4aNxi3NY/BYT60Eerz4ZJyYUkiLLhSHldmyRdUif8AVMNtzQyYZ09r6aI6UpzDW58QuF/cPrUqS3917zI74eS5c9kKnKP98ZiBPyAAm2YmVyrnsIpnyELSJXSfA6ENEqf26WSnvYTE++d80UJE10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733193150; c=relaxed/simple;
	bh=1C2FCbeU2DRCs1n1HftBzdyMXZ2OXbGj+CpIvefL/U0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZecEKRrulyyhoGZfl/nv9yCMBWn0azBHunYoWUHzPu26NEB4R65BniSJCEkD3Jf5wkGAgK3+p1BYhWo2wigVmbtH1oiN/9ZSZJSxIg8tIU8OWMKQConAX3u/awbiRzlAL9bJhfZZzFCq+Duh/yWEdyYATBuzMqk2t1trHKj2M7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Y2Pkg5qgPz11PYg;
	Tue,  3 Dec 2024 10:30:03 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 6318E1400D4;
	Tue,  3 Dec 2024 10:32:19 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemg500008.china.huawei.com (7.202.181.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Dec 2024 10:32:18 +0800
From: Ze Zuo <zuoze1@huawei.com>
To: <gustavoars@kernel.org>, <akpm@linux-foundation.org>
CC: <linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>,
	<willy@infradead.org>, <keescook@chromium.org>, <urezki@gmail.com>,
	<zuoze1@huawei.com>, <wangkefeng.wang@huawei.com>
Subject: [PATCH -next] mm: usercopy: add a debugfs interface to bypass the vmalloc check.
Date: Tue, 3 Dec 2024 10:31:59 +0800
Message-ID: <20241203023159.219355-1-zuoze1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500008.china.huawei.com (7.202.181.45)

The commit 0aef499f3172 ("mm/usercopy: Detect vmalloc overruns") introduced
vmalloc check for usercopy. However, in subsystems like networking, when
memory allocated using vmalloc or vmap is subsequently copied using
functions like copy_to_iter/copy_from_iter, the check is triggered. This
adds overhead in the copy path, such as the cost of searching the
red-black tree, which increases the performance burden.

We found that after merging this patch, network bandwidth performance in
the XDP scenario significantly dropped from 25 Gbits/sec to 8 Gbits/sec,
the hardened_usercopy is enabled by default.

To address this, we introduced a debugfs interface that allows selectively
enabling or disabling the vmalloc check based on the use case, optimizing
performance.

By default, vmalloc check for usercopy is enabled.

To disable the vmalloc check:
        echo Y > /sys/kernel/debug/bypass_usercopy_vmalloc_check

After executing the above command, the XDP performance returns to 25
Gbits/sec.

Signed-off-by: Ze Zuo <zuoze1@huawei.com>
---
 mm/usercopy.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index 83c164aba6e0..ef1eb23b2273 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -21,6 +21,7 @@
 #include <linux/vmalloc.h>
 #include <linux/atomic.h>
 #include <linux/jump_label.h>
+#include <linux/debugfs.h>
 #include <asm/sections.h>
 #include "slab.h"
 
@@ -159,6 +160,8 @@ static inline void check_bogus_address(const unsigned long ptr, unsigned long n,
 		usercopy_abort("null address", NULL, to_user, ptr, n);
 }
 
+static bool bypass_vmalloc_check __read_mostly;
+
 static inline void check_heap_object(const void *ptr, unsigned long n,
 				     bool to_user)
 {
@@ -174,8 +177,13 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 	}
 
 	if (is_vmalloc_addr(ptr) && !pagefault_disabled()) {
-		struct vmap_area *area = find_vmap_area(addr);
+		struct vmap_area *area;
+
+		 /* Bypass it since searching the kernel VM area is slow */
+		if (bypass_vmalloc_check)
+			return;
 
+		area = find_vmap_area(addr);
 		if (!area)
 			usercopy_abort("vmalloc", "no area", to_user, 0, n);
 
@@ -271,6 +279,9 @@ static int __init set_hardened_usercopy(void)
 {
 	if (enable_checks == false)
 		static_branch_enable(&bypass_usercopy_checks);
+	else
+		debugfs_create_bool("bypass_usercopy_vmalloc_check", 0600,
+				    NULL, &bypass_vmalloc_check);
 	return 1;
 }
 
-- 
2.25.1

