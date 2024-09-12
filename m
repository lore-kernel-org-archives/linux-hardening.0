Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C01B4C26
	for <linux-hardening@vger.kernel.org>; Thu, 12 Sep 2024 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164338; cv=none; b=l7kqNhvamKLgU4qX7CspdDceZO0jgocFm+CgABq3Sr2Tps9OOOZcfeZMfqWIWx4H+fqrfw0+i3DF1FBWgycQYKehizY6XBSsPwSqvM6e1rxTW0wmFHki74j609SFB1NuX4aGSrShe0Gu1ouDrOJB7B0n8vFzx7VYC5SxS6yH1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164338; c=relaxed/simple;
	bh=RV2uWN8soq+fqpNsT0C8IJeLAsSUXVvFEfelGbTZnco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N7zYGkzaLY/O9UwSqw3qlK2f0k4gNx8BV7B9rUQrzQb0vvTsKV2uXHEbyVYLvbtl+VL4pfztjrvH9AR8MkxLgrqb7hO6sV74Cxf45IH6QsEO87gm2tNZlKmwN04AWsbv2KAnkD1DSuXX15/PqcU3Bp6mlccEnknKPKne6of/9po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=QzBGhaXr; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="QzBGhaXr"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374be2ad12dso117416f8f.0
        for <linux-hardening@vger.kernel.org>; Thu, 12 Sep 2024 11:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1726164335; x=1726769135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tTvQ0neig09rznvCNXv5+GeGKEb4Q79dd3N/fQCyhE4=;
        b=QzBGhaXrieXC9BReBy+dqqlstJmWYMxAFZ0qEQ7T3KaiyHBdonWJZ6nts9CkUa2/H3
         bA78dcKRQAGVIMWdIEQQgUcj639EGMRqIQMIYkT6TIOkywDf2nygnFs4D5mYjx4Ug/U3
         VMaedeXsM9U1LNx/5z7IOkbfTGAvagm9cWVotGrZBxkScI4SWUusNBEHfat6ZC4lmHv3
         IXcmPPH2QiqIEUhUGPLO/eEK1ewqBBhDnCnk05q3KKcA+YqjGNZsFTVKs19ljcEpb9y0
         cR1PnXBXEBf39X8kJvnfokTU+q5W3Gnlyh2WFS6Aaaw/JOGH4JucvMx2qXyip4k0fSGy
         bexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726164335; x=1726769135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTvQ0neig09rznvCNXv5+GeGKEb4Q79dd3N/fQCyhE4=;
        b=u/hnAt8yAt/nOzw4E9pzHRkb+SiSgBl1fVgc9G5dQw+blsdJaEvH+cXSynZGXj3mP6
         F6VPFRK0HlUTvVCAV012PBw4LYJkTixE09TOI12Tv475e6f/AU7oLuXGUafmIGmTZLNU
         G5OLLAd0TajlOdREoKiGRd37+cGqjDZ8pbHvWtYBfglP6aUk779OLZBUgNa4PeE4hjpZ
         Edr12G1iEeyKsLILCniPfDpvmqfIShJqYa9bMJxXyOk2as5ariZIRtbgx5Cws99WsK4l
         mKRSD8vN6UCwSSXFzejZ2t40DxJ3LBYZ7kKyzN55wK2aoPfYxOGjpP9w7gbiWfkMFgu0
         vGJg==
X-Forwarded-Encrypted: i=1; AJvYcCWyenFmUwJ7+JsVc2v6lVrhRf36dTPoYNM1CT7NTGRKJ12EpL9t0zyh3FFVSrrykkg5D/uSiLfqtUM8WJTlkaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaveKohtUgDZE7PryXRhbWEki7e7X/9pS0U2Kq0OHlDOMSdI5R
	9e5/2BY/WnzfhGDaCWz4LBsZ6VIpLIP/XlngYQhJIFYW89Bb85ZhbX4/b5XPToU=
X-Google-Smtp-Source: AGHT+IGI3Bj8ICk5AfYRfmtbq2hL2SaATJflcUcHDHijwEfXwXqS0qpG6ijSsUG04+DM1VV9SB4CnQ==
X-Received: by 2002:a05:6000:2a8:b0:374:bfd1:a786 with SMTP id ffacd0b85a97d-378c2cfbae9mr1356222f8f.4.1726164334620;
        Thu, 12 Sep 2024 11:05:34 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-212.dynamic.mnet-online.de. [62.216.208.212])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd41c36sm6819472a12.2.2024.09.12.11.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 11:05:34 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: kent.overstreet@linux.dev,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] bcachefs: Annotate struct bucket_gens with __counted_by()
Date: Thu, 12 Sep 2024 19:51:24 +0200
Message-ID: <20240912175122.112625-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member b
to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Use struct_size() to calculate the number of bytes to be allocated.

Update bucket_gens->nbuckets and bucket_gens->nbuckets_minus_first when
resizing.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/bcachefs/buckets.c       | 13 ++++++++-----
 fs/bcachefs/buckets_types.h |  2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/bcachefs/buckets.c b/fs/bcachefs/buckets.c
index 721bbe1dffc1..8e8ec400b9ec 100644
--- a/fs/bcachefs/buckets.c
+++ b/fs/bcachefs/buckets.c
@@ -1252,8 +1252,9 @@ int bch2_dev_buckets_resize(struct bch_fs *c, struct bch_dev *ca, u64 nbuckets)
 
 	BUG_ON(resize && ca->buckets_nouse);
 
-	if (!(bucket_gens	= kvmalloc(sizeof(struct bucket_gens) + nbuckets,
-					   GFP_KERNEL|__GFP_ZERO))) {
+	bucket_gens = kvmalloc(struct_size(bucket_gens, b, nbuckets),
+			       GFP_KERNEL|__GFP_ZERO);
+	if (!bucket_gens) {
 		ret = -BCH_ERR_ENOMEM_bucket_gens;
 		goto err;
 	}
@@ -1271,11 +1272,13 @@ int bch2_dev_buckets_resize(struct bch_fs *c, struct bch_dev *ca, u64 nbuckets)
 	old_bucket_gens = rcu_dereference_protected(ca->bucket_gens, 1);
 
 	if (resize) {
-		size_t n = min(bucket_gens->nbuckets, old_bucket_gens->nbuckets);
-
+		bucket_gens->nbuckets = min(bucket_gens->nbuckets,
+					    old_bucket_gens->nbuckets);
+		bucket_gens->nbuckets_minus_first =
+			bucket_gens->nbuckets - bucket_gens->first_bucket;
 		memcpy(bucket_gens->b,
 		       old_bucket_gens->b,
-		       n);
+		       bucket_gens->nbuckets);
 	}
 
 	rcu_assign_pointer(ca->bucket_gens, bucket_gens);
diff --git a/fs/bcachefs/buckets_types.h b/fs/bcachefs/buckets_types.h
index c9698cdf866f..139292e3f2fa 100644
--- a/fs/bcachefs/buckets_types.h
+++ b/fs/bcachefs/buckets_types.h
@@ -32,7 +32,7 @@ struct bucket_gens {
 	u16			first_bucket;
 	size_t			nbuckets;
 	size_t			nbuckets_minus_first;
-	u8			b[];
+	u8			b[] __counted_by(nbuckets);
 };
 
 struct bch_dev_usage {
-- 
2.46.0

