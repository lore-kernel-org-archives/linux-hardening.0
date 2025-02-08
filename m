Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4F484A2B;
	Sat,  8 Feb 2025 01:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738978655; cv=none; b=Az+QgEQeKXavDbL6Cmu22mxhs2mfc7NWk/wDgBDr1DDDckr7CBLBcQ5yGSdmMjgjuaumF0VSEiaPocvUWSGBt+URRuIymR4+3thJMdPTJpYzeeJs4RhoX/yyn3deaYZB1+FywHT+hfYgJK25Rs5lznVpJY4xsYwpzOum2X1uTZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738978655; c=relaxed/simple;
	bh=ZOJ/WjqbvVck7jNoeLHsU7b+BfesSxAz6BbJYqFwMk4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EiYXPugiKLsCL6P++SFbaMbNVqGcaCA8z35XSBG7zQfuJfVH+nG+O/hGvDJsgn/+AsxX73O16jX3RgQe7Q/dzO6DW9hqiy5fybWdugiIAgS1BXz+ldL3M/H+cVVZEPFByd7ivhaE/gQfqjRAc2Nl1JAMg8sB2S1tDlCqXSexw70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YqYKs5pnGz22mhQ;
	Sat,  8 Feb 2025 09:34:41 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id E33101A0188;
	Sat,  8 Feb 2025 09:37:29 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 8 Feb
 2025 09:37:29 +0800
From: GONG Ruiqi <gongruiqi1@huawei.com>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David
 Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew
 Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Kees
 Cook <kees@kernel.org>
CC: Tamas Koczka <poprdi@google.com>, Roman Gushchin
	<roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, Xiu Jianfeng
	<xiujianfeng@huawei.com>, <linux-mm@kvack.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gongruiqi1@huawei.com>
Subject: [PATCH v2 2/2] slab: Achieve better kmalloc caches randomization in kvmalloc
Date: Sat, 8 Feb 2025 09:47:23 +0800
Message-ID: <20250208014723.1514049-3-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250208014723.1514049-1-gongruiqi1@huawei.com>
References: <20250208014723.1514049-1-gongruiqi1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg100016.china.huawei.com (7.202.181.57)

As revealed by this writeup[1], due to the fact that __kmalloc_node (now
renamed to __kmalloc_node_noprof) is an exported symbol and will never
get inlined, using it in kvmalloc_node (now is __kvmalloc_node_noprof)
would make the RET_IP inside always point to the same address:

    upper_caller
        kvmalloc
        kvmalloc_node
        kvmalloc_node_noprof
        __kvmalloc_node_noprof	<-- all macros all the way down here
            __kmalloc_node_noprof
                __do_kmalloc_node(.., _RET_IP_)
            ...			<-- _RET_IP_ points to

That literally means all kmalloc invoked via kvmalloc would use the same
seed for cache randomization (CONFIG_RANDOM_KMALLOC_CACHES), which makes
this hardening unfunctional.

The root cause of this problem, IMHO, is that using RET_IP only cannot
identify the actual allocation site in case of kmalloc being called
inside wrappers or helper functions. And I believe there could be
similar cases in other functions. Nevertheless, I haven't thought of
any good solution for this. So for now let's solve this specific case
first.

For __kvmalloc_node_noprof, replace __kmalloc_node_noprof and call
__do_kmalloc_node directly instead, so that RET_IP can take the return
address of kvmalloc and differentiate each kvmalloc invocation:

    upper_caller
        kvmalloc
        kvmalloc_node
        kvmalloc_node_noprof
        __kvmalloc_node_noprof	<-- all macros all the way down here
            __do_kmalloc_node(.., _RET_IP_)
        ...			<-- _RET_IP_ points to

Thanks to Tamás Koczka for the report and discussion!

Link: https://github.com/google/security-research/pull/83/files#diff-1604319b55a48c39a210ee52034ed7ff5b9cdc3d704d2d9e34eb230d19fae235R200 [1]
Reported-by: Tamás Koczka <poprdi@google.com>
Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
---
 mm/slub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 0830894bb92c..46e884b77dca 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4903,9 +4903,9 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
 	 * It doesn't really make sense to fallback to vmalloc for sub page
 	 * requests
 	 */
-	ret = __kmalloc_node_noprof(PASS_BUCKET_PARAMS(size, b),
-				    kmalloc_gfp_adjust(flags, size),
-				    node);
+	ret = __do_kmalloc_node(size, PASS_BUCKET_PARAM(b),
+				kmalloc_gfp_adjust(flags, size),
+				node, _RET_IP_);
 	if (ret || size <= PAGE_SIZE)
 		return ret;
 
-- 
2.25.1

