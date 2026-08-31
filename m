Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC57279907
	for <linux-hardening@vger.kernel.org>; Mon, 31 Aug 2026 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175077; cv=none; b=pMdJyRSbPHim3IeW3mEfdi9RWfJEPwMCH13w2wgfSsuP683sEZJxTrX3OaEO862FsdC4t1X9hEyAamcPHvlfy0ODMHzoylK7ajmVcOzyCnHb6H+B2EfheS5WG5nh2rcODLEwe/ixbamHY9DFsof9XeUmeqT7rab4xhsR9Ph4EBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175077; c=relaxed/simple;
	bh=1tzC160XRVFTBUvqo0eRGovwFSfOVpQWnrqojoT/RKQ=;
	h=Date:References:To:Subject:Message-Id:Cc:From:Mime-Version:
	 Content-Type:In-Reply-To; b=DkTBkzR4uNdFZJsyZq08gyWf+dkVTp3iVtbO+EYzDFQ2IB0p2ZbWUl1g9V8dEcEyyXVtmAzI6CYOdnrhwFbmu2vcscuQYJK6H2X3BxdEAsQYexBArTftbZC15cN5lnqAvQvZBHHU0H5iYaP0FNpOZFsYxp4As/1zfSlPZtk5INI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZSjj+9VM; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZSjj+9VM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788175070; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=sk7m5/tft/ydmLxoPchPzp52VQWS3uxvgVEj6+c0Gmk=;
 b=ZSjj+9VMeeuWNpBfGx3lAGCEVlhJlNVXtKe+VLWAelV20xB1RCZ1dgBvFCCj5BBvcyWIl1
 xviQHKThsjiW46lgL9dr0m3II905ybp3ia4wMgRLrrXzvZ3hgaJhDo9e8uiVcXRDkTDakE
 74lhNE+3u1KcB7WW0wnJNuTNLbNmMERgd0dxIu6y8/JO3wvKZQpzExPhquch2LkpQsdiqD
 s9ts9u2m6SL3L/eNdS+axFiTGtgTuBMGibeuzJjNwpSF34CUqX5PjkYioDLFFi2Q1WqmtQ
 oZaVKb4M0X32K+JQ6J6OmEEZImPxRjYxuNNffOlaS9svZ0bxR0Alm+MKWyFfnA==
Date: Mon, 31 Aug 2026 19:16:32 +0800
X-Mailer: git-send-email 2.45.2
References: <20260831111638.76012-1-lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <rppt@kernel.org>, <tglx@kernel.org>
Subject: [PATCH v11 1/7] mm: fix stale ZONE_DEVICE refcount comment
Message-Id: <20260831111638.76012-2-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a9562dd+5a6432+vger.kernel.org+lizhe.67@bytedance.com>
In-Reply-To: <20260831111638.76012-1-lizhe.67@bytedance.com>

The comment in __init_zone_device_page() still uses the old
MEMORY_TYPE_* names and implies that FS_DAX pages regain a
refcount of 1 in the free path. That no longer matches the code.

Update the comment to describe the current policy correctly:
MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free path,
while the remaining ZONE_DEVICE types start from 0 here and raise the
count again when the allocator or driver hands the page out.

No functional change intended.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/mm_init.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 1533aebafb68..8f73d5850db2 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1000,13 +1000,9 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
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
