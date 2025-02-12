Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904151DF751;
	Wed, 12 Feb 2025 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739347507; cv=none; b=N2l6grbVAUmRoyfQR8LpgT3nSWIxpDaNkLbHXd6tLWC7CtY2umOLE6o1Qs8azfKuWLgB8nWOwB/t9U71KpeJd/VTLGkMGyEYGOj5uo+SMYslmHF/myKpEmEmh9aWamlPVXu02mO3CNzB06GsjacG3wzZPehQm7S+ennptQXx8X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739347507; c=relaxed/simple;
	bh=EtkqaO4zBNpebP2SemeA/84KgY/u+we+cSwF4JjZSAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZU6YFLMSJ7f21Z/TTYGoihJpNpwpIbzmKqOb41Pvs+7ggVKJtLdlZjmNSRDZL9+YFesPQHnbHT1irumWZ7SZB+KhxYfe7i1hM3CamuH2Y5VRQqjKq8ShAIv/YQAVX4AqVlsv33xG2vy+mZGxOdRw+Q5kWTMhKYI+c3V7a2w3rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Yt9py3ckMz20qK9;
	Wed, 12 Feb 2025 16:05:30 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 1540E1A0188;
	Wed, 12 Feb 2025 16:05:01 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 12 Feb
 2025 16:05:00 +0800
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
Subject: [PATCH v3 2/2] slab: Achieve better kmalloc caches randomization in kvmalloc
Date: Wed, 12 Feb 2025 16:15:05 +0800
Message-ID: <20250212081505.2025320-3-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250212081505.2025320-1-gongruiqi1@huawei.com>
References: <20250212081505.2025320-1-gongruiqi1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
this hardening non-functional.

The root cause of this problem, IMHO, is that using RET_IP only cannot
identify the actual allocation site in case of kmalloc being called
inside non-inlined wrappers or helper functions. And I believe there
could be similar cases in other functions. Nevertheless, I haven't
thought of any good solution for this. So for now let's solve this
specific case first.

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

Link: https://github.com/google/security-research/blob/908d59b573960dc0b90adda6f16f7017aca08609/pocs/linux/kernelctf/CVE-2024-27397_mitigation/docs/exploit.md?plain=1#L259 [1]
Reported-by: Tamás Koczka <poprdi@google.com>
Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
---
 mm/slub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index abc982d68feb..1f7d1d260eeb 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4925,9 +4925,9 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
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

