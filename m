Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFB33E639E
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 06:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790143282; cv=none; b=WO/O3OYL3PjFHkwqvVb70V8iKZjDBiVmQY+3suPI8xWL9r2nXbrBIgzKcVAmHRAmMYBt25Bz9kRF1VRlwFc1e/1xUMhsaZMuubIpp92dkbs7dSetqTvs5k9HbkAnZ272aqKKw/8Aq+kqQ1PAcK3frjCyccUcGpHdH25Y/cuXmiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790143282; c=relaxed/simple;
	bh=pteB5a4ppTtEC+Qr6+ZHmeG6rGYW4XCAWYqIiSDQpOw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=N0/2wF5UAjaj3W1II51bhrgf13+NDDjpueT17UwFPuM9cQzmTJUKo3iHO+LRx9jFiA2X2mMVl6vxGYNlzeYsw+JSMCc1iAYvGDrpHocjxjo3ZTDvy6r/Aix5NCeu7Rtdao8fpogoUI/mEVxfGL15i1BbFkNFqALmDCBcjj63j7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H+BZrR3v; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+BZrR3v"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-86a43fc3527so1925801b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 22 Sep 2026 23:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790143280; x=1790748080; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8hrAtPjqsJPtZ07wpmzE/ZnFtTfixynLllFoyC+ikp8=;
        b=H+BZrR3vytDRhkE+KMnlH7liPYsWLNgPCTpzKgIrAuqKdVAWQsSck+jES8AQEaC+EV
         7mPfTsUOPpcn2REnXq8DuaWVM7c7n5II7bhByApl2t+2i8q8U6L6USe9YT3kgK5Ml3HR
         6qXtMa8G6NtM6z2uHkE0M5vAdWV5wvirQtZHLHVe+PTO7PNea4gqgJnZXImpF8vXTFio
         /N3ECHp8Mvn7ATlcRhZ4vEA63dSw4MLUyAhUZc0xRSzNI3Z7tZ5zm6KgMKPtoTEqGT+U
         mdXP9WRAH2tXlAnAgmoi4osgzq8QgqIT3NQv3qQ2qh9CJ0WAz0pT+4x1d50nXlZ0lrAZ
         D83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790143280; x=1790748080;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8hrAtPjqsJPtZ07wpmzE/ZnFtTfixynLllFoyC+ikp8=;
        b=b3yaWa8jcl4Cc9qAGjwSEaCKy3mFzJwDn1ZsODVY8Py00S/3axkDEjZWfd4o4FzTmo
         +XIucqDt9O5Hi1rMcox+p90whf3ccT04GQu/EoE0i5Ykwap7suG7eHy4fJ9OC4fnv7mw
         uGu8UysAdg9aUYgjUzndVhsW9lp9i+iSpiam2tM+1VYlazolV//0nqjAfU967cguBq4B
         /zQRDijBXPPi0IOsbcGLLwPqhN9BDHQDtnRA39Fxlc7QkfpfD0uce45sPfl8i1k9DClj
         r/m0QUki1TqJ96Pc9TVCq35ExJpCZnan0dgLwak5kHLjhSHMj0kE69zkPoPmCVx9vRL+
         J3Mg==
X-Forwarded-Encrypted: i=1; AKwUvBwtVkBVfgMWAgEifPQljrkwW7ZDOtmr3SHTRUuC5RVH9qTMdMwBnY9qs1k7GuQS75fmYS8MYElr7BnzNvNn+WU=@vger.kernel.org
X-Gm-Message-State: AFuF++lhaLKMDQv6hJhKrXNfamNTSvbV2N1gCgcnVemk7t6+Asiwnv0V
	8gWhPzkq++MRfgseaSpcD3Vzb7Fuh9/GarN7YRJ0JtsQ6y0sw1ukVCGn2eGW+vDWV6EuqyFQuRp
	k
X-Received: from pgdg16.prod.google.com ([2002:a05:6a02:51d0:b0:cc5:1163:519f])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a347:b0:3dd:65a5:a33
 with SMTP id adf61e73a8af0-3ddf7f6f170mr1230569637.10.1790143280074; Tue, 22
 Sep 2026 23:01:20 -0700 (PDT)
Date: Wed, 23 Sep 2026 06:01:14 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923060114.2605310-1-morbo@google.com>
Subject: [PATCH] crypto: hisilicon/qm - annotate cap_tables with __counted_by_ptr
From: Bill Wendling <morbo@google.com>
To: Zhiqi Song <songzhiqi1@huawei.com>, Longfang Liu <liulongfang@huawei.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Weili Qian <qianweili@huawei.com>, Zhou Wang <wangzhou1@hisilicon.com>, 
	Chenghai Huang <huangchenghai2@huawei.com>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"

Annotate the 'qm_cap_table' and 'dev_cap_table' pointer fields in
'struct hisi_qm_cap_tables' with the '__counted_by_ptr' attribute.
This improves bounds checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE, allowing KASAN and compiler diagnostics to
detect out-of-bounds accesses.

The 'qm_cap_table' pointer is associated with 'qm_cap_size' which
specifies its element count. Similarly, 'dev_cap_table' is associated
with 'dev_cap_size'.

To ensure safety under compiler instrumentation, the assignments in the
initialization paths have been updated to set the 'size'/'count' fields
prior to setting the pointer fields. This prevents any transient state
where the pointer is valid but the count is 0 (or uninitialized),
ensuring that subsequent accesses to these tables do not trigger
false-positive bounds check panics.

Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 2 +-
 drivers/crypto/hisilicon/qm.c             | 2 +-
 drivers/crypto/hisilicon/sec2/sec_main.c  | 2 +-
 drivers/crypto/hisilicon/zip/zip_main.c   | 2 +-
 include/linux/hisi_acc_qm.h               | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index b6903fce6071..4a1b2de476f5 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -1234,8 +1234,8 @@ static int hpre_pre_store_cap_reg(struct hisi_qm *qm)
 		return -EINVAL;
 	}
 
-	qm->cap_tables.dev_cap_table = hpre_cap;
 	qm->cap_tables.dev_cap_size = size;
+	qm->cap_tables.dev_cap_table = hpre_cap;
 
 	return 0;
 }
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index c01966a4a33f..7d13476451e3 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -5743,8 +5743,8 @@ static int qm_pre_store_caps(struct hisi_qm *qm)
 							i, qm->cap_ver);
 	}
 
-	qm->cap_tables.qm_cap_table = qm_cap;
 	qm->cap_tables.qm_cap_size = size;
+	qm->cap_tables.qm_cap_table = qm_cap;
 
 	return 0;
 }
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 752565200c16..ac423d016998 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -1285,8 +1285,8 @@ static int sec_pre_store_cap_reg(struct hisi_qm *qm)
 				     i, qm->cap_ver);
 	}
 
-	qm->cap_tables.dev_cap_table = sec_cap;
 	qm->cap_tables.dev_cap_size = size;
+	qm->cap_tables.dev_cap_table = sec_cap;
 
 	return 0;
 }
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 706a73656977..10091ad4a6a8 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -1400,8 +1400,8 @@ static int zip_pre_store_cap_reg(struct hisi_qm *qm)
 				     i, qm->cap_ver);
 	}
 
-	qm->cap_tables.dev_cap_table = zip_cap;
 	qm->cap_tables.dev_cap_size = size;
+	qm->cap_tables.dev_cap_table = zip_cap;
 
 	return 0;
 }
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index f7570a409905..8dc49fa2123b 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -332,9 +332,9 @@ struct hisi_qm_cap_record {
 
 struct hisi_qm_cap_tables {
 	u32 qm_cap_size;
-	struct hisi_qm_cap_record *qm_cap_table;
+	struct hisi_qm_cap_record *qm_cap_table __counted_by_ptr(qm_cap_size);
 	u32 dev_cap_size;
-	struct hisi_qm_cap_record *dev_cap_table;
+	struct hisi_qm_cap_record *dev_cap_table __counted_by_ptr(dev_cap_size);
 };
 
 struct hisi_qm_list {
-- 
2.55.0.1082.g2b9226bbc0-goog

