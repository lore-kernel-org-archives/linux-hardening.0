Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A2C346FD0
	for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 03:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774580503; cv=none; b=CuWD9p5HIyOYN7J0+vdydGgEkEdfTQPeIQkoew7R9C7sSvRmtRlidkUvh5Vbm17Y1+JBzJ3nsWA1+dqIchHEf47wwwTW59/kHerWGnv/SQ6/QTOO3oFTUDWcEFLXGBPgNlMFNqc1lquFl1Pbik2hZyVqlwX2EEpiXMC/sTU2hQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774580503; c=relaxed/simple;
	bh=VHq0T2QBVW1p5Prt7mcDtEz31yyWzofOyZqE5hZN2Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iglcd9Lb1sBaeiQ9qsDex4/QKsWMzNXE8CozlqgEb5AlIT5IVzL9gtYbQSpFHgHMssjW/6qDGqNjeL7wJWWGBzxCC2SAijNYtlIsQHCvLlUubNliU3CO44tAu0kZ6qOmSv62Jr0GKyP/tHUHMfeP0QRdCNbyJmP7qqpJrKEqmyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTdW/sg8; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTdW/sg8"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso1080408a91.3
        for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 20:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774580502; x=1775185302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lYnk1jno8htp2F2GI4xAOL67IOVcynZ8tz2xKscYSYM=;
        b=hTdW/sg8UJho5IaEI+giCWMySJ3kMNQJnQSTkdslI23aU0tyOeehRguvxpx1diZmby
         3O7ILBVmL05J06idPLqa+PcUnce1EYGgg4Bs77lQK0/weCeLq8BP2/amo8wfqVldUECQ
         3HH7qd30fjkFS4HvXWM40+6Ub9sL9QplSHzqlaEZodBpz0GxybytmJVmJE4xdl2xRjlA
         3uUwSzjJ1AvH9Wg9sR4f/ilY4ut8PF5RH+EI/yla9WN3It/c/oKzG1a7YQPl0osnkBFM
         HrCgXjf+PqtJL+7v3y3BJND1OHnto0kZjn96U2Fic1ydu7h5fIVrmKrm29r8Ms2+KWWh
         TrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774580502; x=1775185302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYnk1jno8htp2F2GI4xAOL67IOVcynZ8tz2xKscYSYM=;
        b=DQIM8g01xfiAiMHZ3YkJuHbeaC2zZr18flTm1ptGTKzD4lN+xFZPgouOCIwpTIuprz
         VE9qd5cWwjxpezOvUkAeZg1c3SK1njz300BrVfvhweMRTAGpgmeSY+riAx32Wza2ITa3
         emxd0dgIFWsIbGkMRXQVcPj0jTPB4p9wG4Acqn1KzmSp4wqEojvOd79Ace+2qVtbZm4n
         5OsuMLJvlPgXJdZxaBKY3ssE1Pjjo4EIhoMx/B7imgClXgqHDWz3Xw6Ia5UOy94uUKFr
         MXngw9qvCcwmLqyHRFOffa5TtcSg0M9NJr94pjgci2FWBlm/pTCkc8Pj1AdBDBe2iS4i
         xqcw==
X-Forwarded-Encrypted: i=1; AJvYcCXxLxaJt+PyV3gFEfZaLiVWfH6X7cjqJaArviCC+T2QcARIxFYxKAp+2PzoSBBpynCHbP9o1fHwn7bIzkgbNdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztV8ML8M50oz6xyADzXJ4SqzwmMvc8ieJXWcDLJB54dLQJzLLS
	qe+sOHmglBbNt1SWBSCbn1DQ9geuLwDmnE7GP/gKkeeasRrGvqjlQSnH
X-Gm-Gg: ATEYQzzps2UMNtFgm+2JSS/SYoCpwUMj0rZ5CXMUhmh5aSa2ywbtz+MtiMlSu0tT6lM
	RJOGBq0TJ63tBx30uGbo7CzSCMnZcfut7MtQQC1Tqm3Z6Wd5VxaTzKeZffRm39HsqUlYrCgDJTs
	FpmIJMewHjTSlalF41EYE0sty4rcia695PfTRZRBuOQSF5wGYR6fHg+yiLNawWdILbJU4EVPf+e
	PFiNSF1tK49udRbiq8nucoDAONy903y/WIYie4UI/veF+vCWwBn2ggSQbxRHx4U0xrAHk4vS9+S
	XjpqqSvX5T0kuYwXssglVctRjGTvQpUIldY4UJV5yrHlmL37U93yxffQftT13D7RW+ynLOWXQuR
	olr4a7RyYlfpua4XJxivaktP1Qe48GOH5BvFkno9xXYIYogICA6ZW3oLsOeAXJewH2rW36rNmyA
	rsWQPI/q7mOhs+aZgtliXxvrHR2PmjYtzxXOx2i3zfWWds3tfE5Ljjknw=
X-Received: by 2002:a17:90b:394f:b0:35c:f09:a4fe with SMTP id 98e67ed59e1d1-35c30146e81mr837202a91.31.1774580502174;
        Thu, 26 Mar 2026 20:01:42 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a54ebfsm3208675a91.4.2026.03.26.20.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 20:01:41 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] RDMA/core: use kzalloc_flex
Date: Thu, 26 Mar 2026 20:01:24 -0700
Message-ID: <20260327030124.8385-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocations by using a flexible array member in this struct.

Add __counted_by to get extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/infiniband/core/cache.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index ee4a2bc68fb2..896486fa6185 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -116,9 +116,9 @@ struct ib_gid_table {
 	/* rwlock protects data_vec[ix]->state and entry pointer.
 	 */
 	rwlock_t			rwlock;
-	struct ib_gid_table_entry	**data_vec;
 	/* bit field, each bit indicates the index of default GID */
 	u32				default_gid_indices;
+	struct ib_gid_table_entry	*data_vec[] __counted_by(sz);
 };
 
 static void dispatch_gid_change_event(struct ib_device *ib_dev, u32 port)
@@ -770,24 +770,16 @@ const struct ib_gid_attr *rdma_find_gid_by_filter(
 
 static struct ib_gid_table *alloc_gid_table(int sz)
 {
-	struct ib_gid_table *table = kzalloc_obj(*table);
+	struct ib_gid_table *table = kzalloc_flex(*table, data_vec, sz);
 
 	if (!table)
 		return NULL;
 
-	table->data_vec = kzalloc_objs(*table->data_vec, sz);
-	if (!table->data_vec)
-		goto err_free_table;
+	table->sz = sz;
 
 	mutex_init(&table->lock);
-
-	table->sz = sz;
 	rwlock_init(&table->rwlock);
 	return table;
-
-err_free_table:
-	kfree(table);
-	return NULL;
 }
 
 static void release_gid_table(struct ib_device *device,
-- 
2.53.0

