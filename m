Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EF528507E
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774904843; cv=none; b=kGv93tEH6BntqNzfVP1a5jomwzcQcfYo70WSlGkT6KdonDfGG9KnHF962IQ7xZg2pugra/+ycotNfB73H2MK5Z+7U/EqhUc7ttZ9Z9qtGKtG1vJ0ormrb7FNR7Ur9mxj41G740Fy5CEFZmXkpe/uKGTA1fBZ1iLGaH0PoO00maI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774904843; c=relaxed/simple;
	bh=QpZtDQ2tAWRJHE/3K+afYt1HU8XGkF0gE5uP3vEh0L8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fyh/KcBDbEwubQCUuL1CmtBP+fIbOSxiLkSnyUIOrE3skezBu9DkoMzNPMQyLpkklkGAyRcMamJiL6le+460oMb6MsVgNgmy+OwjMNi6muaRtublUWPNOCpmbT3GDn803NaUhI3SRtbiGdYceSDQV0lSepSNK98+prO2ZXDrrTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFZlBjcf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFZlBjcf"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82cd9d0eceaso74111b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 14:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774904841; x=1775509641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wfYhu3goSRUoYF3KrZUoCVBHuxcKznqPMmyxD8YhPO8=;
        b=KFZlBjcf/RBddG0PvIj2nJlRfigIP1YZGGiGlPLG3Hl7gQbTHPxgx8KQMPGC3P7MEr
         D6tnoVvNjh+jjWimGOmnxYNFV78qGlOuarQiUSi9YWoc/otS14QTDwcHlucs8GChr6xw
         WUgjyt7KTNI5/bXuuxf+trYAeIs0GDAjt9Tk3xVa9nfd5m35sr4TlWd2BoYd+/MiBHQM
         kzzVdteWWl6Z+SkKiY6R4vm1qZPWx5CLWPtYBfLkgL3+z3I1vSDjWxkSXKQ58uGcyOj4
         47QJzrDY1lgrYEOeArq5o3AGhr5frWQ7UiCw8p4LtEh5fq9r63cn55hwGX4SHzWDtJwE
         kc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774904841; x=1775509641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfYhu3goSRUoYF3KrZUoCVBHuxcKznqPMmyxD8YhPO8=;
        b=g5a58Wg2/BVvXgabOIL/MT9/xRdAfqhhxNcaj83RjVnn/hYGdnLEEcbRdvHhrZ/m+p
         Yv+eidroQZulSufaNsJb5mVEWTahmjjVlDLS3WR+RFXM8BEFEe1pl3SZlsE/FjNxMMYp
         IuQVWJx00N5TvLR08bbraELlt3qegUG8Lagx0aAPiddnADewoNrnGb4wiaUnTlsfRJMt
         j2ZfJnoeZxjbCVm+JccXINEQQkkLQshWbsTDYLam5COOLKCSZ7GzSeh8tRhfchJsgjRQ
         lDppq/QC5gii1OcLgjw84BqfNBiuGYmMfBP924jaNqvb4JqM59bKOLNhHjSGmdWD7YV2
         t40A==
X-Forwarded-Encrypted: i=1; AJvYcCVpGLZowWU1Ly8XHsD7HSrQA1S0Pm2kmB8Ju8uaPGPWjt96g+D2LObgBlYD7d02jGhF5bpqhY2Zu4l2KrfTnFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3dKYLETgDVamMlIi0/yZBA0KCERL5awXaQaDiHalewdW278tW
	HZFw2UoTGWKaq18CBMvBStwnSdDkQXFpL6TbpGozNKt02DyxhGZIY07+hmnXmw==
X-Gm-Gg: ATEYQzx2IxPdfHehCWxJxQcL8mVd7jBePVARHMGgV+j4yZflu9L0UDP34uOOt7mq+c3
	9ZsL4Qa4JhU7Eu1SCu6bT8QjMjXimqEAULy+M3obBFNv02tUIJfPZjGQXRTxhMxwTT+WufI2HrO
	iWBg4tMn7ULYCMRmsEOLZaf0O4Yly6zXe7KR2R/+1ojk05YotXSb1e2TLpIMwnMyzrYZo/nRQ1q
	z3GzLLi2IGvx8BuT6zb0Bhf+MD+VlfeSptcBEjkodID87arnZ8yYDbZIZfWfFoQpSWQmQ1rr7Ol
	I4TL2wp7Sb9KxX0PKL+db1S6Jt3QmN9azObtN3UXJiENJwg3UQ6KwSW+Ghxt9DPn9tpgiM3nzTF
	ZhzA3UPrgVgVhzgeMMDPynTZ0AR5DmtsSYSIIYF9i9cyyr8x+eH9xrXmHeBcUmrG+wpLF72hToW
	mj4L6ikKgcIqaRWk5qXoX9xRgSR9qbAwXqNPh440CbKB7NDb6VV4JLOwA=
X-Received: by 2002:a05:6a00:4091:b0:81f:3cac:38a1 with SMTP id d2e1a72fcca58-82c95c19210mr12662926b3a.6.1774904840991;
        Mon, 30 Mar 2026 14:07:20 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82caf97abfesm7146335b3a.1.2026.03.30.14.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:07:20 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] Squashfs: allocate entries with cache
Date: Mon, 30 Mar 2026 14:07:03 -0700
Message-ID: <20260330210703.11645-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member with kzalloc_flex to combine allocations and
simplify code slightly.

Moved struct as flexible array members require full definitions.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 fs/squashfs/cache.c          | 13 +++----------
 fs/squashfs/squashfs_fs_sb.h | 28 ++++++++++++++--------------
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/fs/squashfs/cache.c b/fs/squashfs/cache.c
index 67abd4dff222..1231667b59e5 100644
--- a/fs/squashfs/cache.c
+++ b/fs/squashfs/cache.c
@@ -210,7 +210,6 @@ void squashfs_cache_delete(struct squashfs_cache *cache)
 		kfree(cache->entry[i].actor);
 	}
 
-	kfree(cache->entry);
 	kfree(cache);
 }
 
@@ -229,22 +228,16 @@ struct squashfs_cache *squashfs_cache_init(char *name, int entries,
 	if (entries == 0)
 		return NULL;
 
-	cache = kzalloc_obj(*cache);
+	cache = kzalloc_flex(*cache, entry, entries);
 	if (cache == NULL) {
 		ERROR("Failed to allocate %s cache\n", name);
 		return ERR_PTR(-ENOMEM);
 	}
 
-	cache->entry = kzalloc_objs(*(cache->entry), entries);
-	if (cache->entry == NULL) {
-		ERROR("Failed to allocate %s cache\n", name);
-		goto cleanup;
-	}
-
+	cache->entries = entries;
+	cache->unused = entries;
 	cache->curr_blk = 0;
 	cache->next_blk = 0;
-	cache->unused = entries;
-	cache->entries = entries;
 	cache->block_size = block_size;
 	cache->pages = block_size >> PAGE_SHIFT;
 	cache->pages = cache->pages ? cache->pages : 1;
diff --git a/fs/squashfs/squashfs_fs_sb.h b/fs/squashfs/squashfs_fs_sb.h
index c01998eec146..344b78b23f9d 100644
--- a/fs/squashfs/squashfs_fs_sb.h
+++ b/fs/squashfs/squashfs_fs_sb.h
@@ -12,20 +12,6 @@
 
 #include "squashfs_fs.h"
 
-struct squashfs_cache {
-	char			*name;
-	int			entries;
-	int			curr_blk;
-	int			next_blk;
-	int			num_waiters;
-	int			unused;
-	int			block_size;
-	int			pages;
-	spinlock_t		lock;
-	wait_queue_head_t	wait_queue;
-	struct squashfs_cache_entry *entry;
-};
-
 struct squashfs_cache_entry {
 	u64			block;
 	int			length;
@@ -40,6 +26,20 @@ struct squashfs_cache_entry {
 	struct squashfs_page_actor	*actor;
 };
 
+struct squashfs_cache {
+	char			*name;
+	int			entries;
+	int			curr_blk;
+	int			next_blk;
+	int			num_waiters;
+	int			unused;
+	int			block_size;
+	int			pages;
+	spinlock_t		lock;
+	wait_queue_head_t	wait_queue;
+	struct squashfs_cache_entry entry[] __counted_by(entries);
+};
+
 struct squashfs_sb_info {
 	const struct squashfs_decompressor	*decompressor;
 	int					devblksize;
-- 
2.53.0

