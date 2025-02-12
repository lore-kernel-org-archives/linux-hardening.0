Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250A9204C06;
	Wed, 12 Feb 2025 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739347533; cv=none; b=QmUpnxnXlRqMFL0Y2NMPOd3+HtgsoTipz5kJqfGFf96lBIUaYO2VAkOxBEJ0843AhGM5SwTbMVz3XTlgzEGOxQ6pPhaGHFPZdk0HtNp3USpGr0eAIg6n9SrGuPPv5+X5a0fdZrPZeB9jb5ItV0he8QT2RtM0nnQA+eXKjDO+vzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739347533; c=relaxed/simple;
	bh=3rJjgGCuY6TDIwhfXdqGd1ug45pCfUF4NevCnDbz0sA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EgWWVycI7CisKoQRnBiA+TP14snoV3xT0WXqtP67S9rb5C+P4dKoxUbIAIbjhF9ctddbAiJCG3HE6+JhPJw7nfGm4X18OKmKv0N/ZH/CoPrcsyMBoZ7CXld/SuDoEpUQzrkIT01Y8vOvQyVioI/wbY0j8AmRaGspjmjb84zDTZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Yt9k20gx9z1ltb7;
	Wed, 12 Feb 2025 16:01:14 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D753140383;
	Wed, 12 Feb 2025 16:04:59 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 12 Feb
 2025 16:04:58 +0800
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
Subject: [PATCH v3 0/2] Refine kmalloc caches randomization in kvmalloc
Date: Wed, 12 Feb 2025 16:15:03 +0800
Message-ID: <20250212081505.2025320-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
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

Hi,

v3:
  - move all the way from kmalloc_gfp_adjust to kvrealloc_noprof into
    mm/slub.c
  - some rewording for commit logs
v2: https://lore.kernel.org/all/20250208014723.1514049-1-gongruiqi1@huawei.com/
  - change the implementation as Vlastimil suggested
v1: https://lore.kernel.org/all/20250122074817.991060-1-gongruiqi1@huawei.com/

Tamás reported [1] that kmalloc cache randomization doesn't actually
work for those kmalloc invoked via kvmalloc. For more details, see the
commit log of patch 2.

The current solution requires a direct call from __kvmalloc_node_noprof
to __do_kmalloc_node, a static function in a different .c file. As
suggested by Vlastimil [2], it's achieved by simply moving
__kvmalloc_node_noprof from mm/util.c to mm/slub.c, together with some
other functions of the same family.

Link: https://github.com/google/security-research/blob/908d59b573960dc0b90adda6f16f7017aca08609/pocs/linux/kernelctf/CVE-2024-27397_mitigation/docs/exploit.md?plain=1#L259 [1]
Link: https://lore.kernel.org/all/62044279-0c56-4185-97f7-7afac65ff449@suse.cz/ [2]

GONG Ruiqi (2):
  slab: Adjust placement of __kvmalloc_node_noprof
  slab: Achieve better kmalloc caches randomization in kvmalloc

 mm/slub.c | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/util.c | 162 ------------------------------------------------------
 2 files changed, 162 insertions(+), 162 deletions(-)

-- 
2.25.1

