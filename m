Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114F114EC73;
	Sat,  8 Feb 2025 01:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738978658; cv=none; b=KPVavjPYqHnIF+/sqb1s8eK4NXN6q2CCH8xjHMaG5MSaEpkJqwWyzpTeQrxVDyzH3/SMZZfQ50UdGkhdzAWzxuqMYxH+VD1hIg/W7+8RUl2ciNL+vCGpWJA5jeeS7UZBBwYDlkFzcR4O7tzNa22hKN4fCXFAtWn8klirYyTO+bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738978658; c=relaxed/simple;
	bh=RGFwYDd+EiBu6gmkUm1IoGn060IVM7htNNhjXAVgf2I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sc8MKO5cENpgDiVW1lMbBQK65Yi1yqjFhcb/sNq9At2o4kw6uxnK7394zyjJMxL6+eC/4UqnsPnc1zlVZvW+npjANmrxJPeLbAGUAcrrlR9PEhHVtQia5bVWV0vW/pnzLjNiQfCn/Z0/vWfpD/PLyjdrCn5WD2WVRDg7cR76HcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YqYKF6SZlzgbrQ;
	Sat,  8 Feb 2025 09:34:09 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 836EF1400D5;
	Sat,  8 Feb 2025 09:37:28 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 8 Feb
 2025 09:37:27 +0800
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
Subject: [PATCH v2 0/2] Refine kmalloc caches randomization in kvmalloc
Date: Sat, 8 Feb 2025 09:47:21 +0800
Message-ID: <20250208014723.1514049-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
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

Hi,

v2: change the implementation as Vlastimil suggested
v1: https://lore.kernel.org/all/20250122074817.991060-1-gongruiqi1@huawei.com/

Tamás reported [1] that kmalloc cache randomization doesn't actually
work for those kmalloc invoked via kvmalloc. For more details, see the
commit log of patch 2.

The current solution requires a direct call from __kvmalloc_node_noprof
to __do_kmalloc_node, a static function in a different .c file.
Comparing to v1, this version achieves this by simply moving
__kvmalloc_node_noprof to mm/slub.c, as suggested by Vlastimil [2].

Link: https://github.com/google/security-research/pull/83/files#diff-1604319b55a48c39a210ee52034ed7ff5b9cdc3d704d2d9e34eb230d19fae235R200 [1]
Link: https://lore.kernel.org/all/62044279-0c56-4185-97f7-7afac65ff449@suse.cz/ [2]

GONG Ruiqi (2):
  slab: Adjust placement of __kvmalloc_node_noprof
  slab: Achieve better kmalloc caches randomization in kvmalloc

 include/linux/slab.h |  22 +++++++++
 mm/slub.c            |  90 ++++++++++++++++++++++++++++++++++
 mm/util.c            | 112 -------------------------------------------
 3 files changed, 112 insertions(+), 112 deletions(-)

-- 
2.25.1

