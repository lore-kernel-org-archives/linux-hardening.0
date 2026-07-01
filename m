Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E6E3C108A
	for <linux-hardening@vger.kernel.org>; Wed,  1 Jul 2026 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896831; cv=none; b=mqdf+x0xmhGj358ttfxraYLlfRcd0RG4ShZWxXkWJ1r5lB4GWj2aKmdNmqpEZyY+9jC3+zdbScquJnniHHnaiW9w822Wg/zcbimVEkUe5kqcLf0wKEMRr8I9uYqmzofxEg4Y/m3TNpRUI9NsPzMPlf6AKaB/RxSDmMqAgSCCfz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896831; c=relaxed/simple;
	bh=EoBjH2jLYslgDYjCkeXHpyOLGrF66OVw+LkY79wubG4=;
	h=To:Cc:In-Reply-To:Content-Type:References:Mime-Version:From:
	 Subject:Date:Message-Id; b=IB7KyVcWRxC3uFTy9BHV3pSb2Uahw79FitvsKRTLRUM2qp1K64FPQ7oQx3PPPFuBze3kctO787dBK56U3MYBNAhWgAGMKw5vYIEQ/tNqQ0uW2cAN74NzSDgGFbdHT/mBehySopMKyjqSbUQIxW9XplW69dIgLANzrUjgjLuRd8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bsCCCdBP; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bsCCCdBP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1782896819; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=cw8RUZDrbGyYvSpodoREqJP0rpdEJgSnGPHDt2WkK3Q=;
 b=bsCCCdBPxtBVmu7ZWEt0Ym/PjwZO9bGkSbMcgD44w4DY4lRzDxlX2PW6rh3foewsUlkPNl
 0WHyZ448DCmLZEBHa+zFl6BAuoDWa89bIawjo+cSBkfUjD03WOaP9CTI5Gdf5ct7r1nzsk
 GW1ClmgmJU+dQ3phdp4eLh5bYu/wWcRzjDi+7aN5nqkzq/d+nA4Cs3zDWjJUVdVuphhmnv
 Wj5PFEcqX3lJr0wmQUkafsTesrsKf6NLoyoWlrcBkyZVmq9uLGmvkWWrGVcdvz6BwcwJlv
 Nzwj5pbEz6pXlpSCooHE6hTIhCkqPVtkfJIW+4wVgNZmkl9rZhck0Ww9/z+zhQ==
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
In-Reply-To: <20260701090553.62691-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a44d8b0+eae4de+vger.kernel.org+lizhe.67@bytedance.com>
References: <20260701090553.62691-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: [PATCH v5 1/8] mm: fix stale ZONE_DEVICE refcount comment
Date: Wed,  1 Jul 2026 17:05:46 +0800
Message-Id: <20260701090553.62691-2-lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>

The comment in __init_zone_device_page() still uses the old
MEMORY_TYPE_* names and implies that FS_DAX pages regain a
refcount of 1 in the free path. That no longer matches the code.

Update the comment to describe the current policy correctly:
MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free path,
while the remaining ZONE_DEVICE types start from 0 here and raise the
count again when the allocator or driver hands the page out.

No functional change intended.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 0f64909e8d20..95808ab5cfdb 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1030,13 +1030,9 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	page->zone_device_data = NULL;
 
 	/*
-	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
-	 * directly to the driver page allocator which will set the page count
-	 * to 1 when allocating the page.
-	 *
-	 * MEMORY_TYPE_GENERIC and MEMORY_TYPE_FS_DAX pages automatically have
-	 * their refcount reset to one whenever they are freed (ie. after
-	 * their refcount drops to 0).
+	 * MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free
+	 * path. The remaining ZONE_DEVICE types start from 0 here and raise
+	 * the count again when the allocator or driver hands the page out.
 	 */
 	switch (pgmap->type) {
 	case MEMORY_DEVICE_FS_DAX:
-- 
2.20.1
