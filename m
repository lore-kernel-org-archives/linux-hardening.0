Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181A5394481
	for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 04:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774498454; cv=none; b=kHuUueF0VX6j1xFWAZKndBfHjIgCiFb1rrPXG/x0piSitK3qaXyw6zq0ufLHz3bLDJDMOYSGPHqMFZv+MH5rRP9Kq1Vp3uKSZuEb6JZ3IoP02ifh7jdqzJ3iWwuwSp2aBr4Y4+GZXSyUKW/2Dh6lBo1BxjkeoqVDK3Enf4cwXy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774498454; c=relaxed/simple;
	bh=DyQeCFKi9GZc/taP2lccAYrEAdGOXF5bfDvpSUu3F/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3NsN/JoXy0TSPnL+dxXxUV33j+T+UiTBLkkhs2JtdBryEZsYQPVKTCRPw3dzxtPl5l4eGtNX2GRnL5+8uCGr+W+ucbj6u0FVB3mXgAeWwRx8yg9Nex+gkBH50zHMgAdtDhzCpFzGRfZl2wW/lAnS4KQHUDRpoXAUxjBB3+07/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNTy3Pql; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNTy3Pql"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829a9d08644so279164b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 21:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774498452; x=1775103252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=22US7uthXpFUornciEIu45mKxTqm34WwP4xBdw3Eh7k=;
        b=nNTy3PqlkDpb7r5iqvN0Te0ZSpGLLy3YmrJCeapRHMa0RQq1ndl/Ss2aNlbdAi4zYX
         qSt+au6YceSVeuiaDpllyJcwHXjd+CynBJKJB3iwxjpqAfVe4yydkSFyJsLFyZfc2HvG
         uyfwzZ43U1oSpgjUE/D7EVTIxJOAtIIglnYV8DDrsev6xDV70MEDVlXyTpX+NvDPs8sl
         mwERxyT4+qBeivktGMhIoMkyE8jxamyNfMDCRPvJmJ5JLbbUwnlr06PGF1yG+X5q9n/R
         LOUOvYIi3PlTbMHWRD6Yw2qkmVPCxIx2jm4NJ3XJMxO2vKLp3GNOIdzUNlNAwtLDR+u/
         5S6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774498452; x=1775103252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22US7uthXpFUornciEIu45mKxTqm34WwP4xBdw3Eh7k=;
        b=Q0tR2XQLYyJoZ2mcTYqB74WzydoS9nY6XHIaG280BbROC5m2462r1lRLnqwA+K0TWS
         tJXu0ThzhOlkFZEzG5exwPzqL93Oq4Eggdq+KYrby2vROu059vNi+HmxdGPrQzN8GRbn
         pTVytEEZE+KKTZ0Hekvgnt/xy/dIdCMbGQp/XKJyR6lRYM+hQfsI5941npUuZFasNBDt
         ibrPOHjkO311CMZybf+fw6IWLrbIEZXXZyVFU4IL7WLeetVp7g7Rc+yK5VEaCfHTKlp/
         tCFpQSaZBpPDzEdKl7O1NA+eyfFipGa5rL761UVNZKeyD5VxKgbGi4xwsB9tlTY9b/LB
         S+jg==
X-Forwarded-Encrypted: i=1; AJvYcCX6ffhAmps26IjO0NAKTvq+QlY2elMoZcvh4bGCgwnJKittkpwesTFTfL1bXoPszFd+uP0d1VPDuKxhqQ5XAfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI1WjJmZk5fFtDYGdguXMuKFsdcHXokJVymPMQ9mAeYXloIN3t
	7WPIYvU1X1GpdYsQCljQ9AayK/2Dw9gF7HogoyF51l03jMhofZtBtdRW
X-Gm-Gg: ATEYQzwFo909DoInXZ6VD7Jh15CQ4nUz97uvZeMD03/Oae/tCinUdrTQ0r/tv5CQX5D
	TilS+/NYc7X59vmVmXwekZHiJ8dwfnO4rNgDmpchTlYJOlF4sg2j+8AWKQVnsTZT5HFwewik5Um
	+1ljSwiAftkV6Dx6e6TA7x/weRG8xcQ9eXbqBO7TRY9jLLPO4vtD8cr0y8sn8K4vfBPQCSuazxW
	j8YEImDMb/tZKi1wlrNeogpuaeQPQ0bFfHYE+TR/q/LUEh4TDE7H00bCG+fu39j51l4523FUbos
	uriAKrYM9G1/6O48wHmyY8EHe8Um1e7TXcxcBLrtGAG5bVMBUeepiIIx84NqyAt77+LtJ3M3f5d
	VF2/m0hSY902NbJzVlA1NeZu8sHhfVv5IYGaHioVY4gOW9TtJ96h+8Ael203oGJZeYGjM2tCQWN
	eF6WKi5hN+EDNSdjCtQb7UAks0Z3AbkLft5XbbfUu59d7L86fWtAxai9Q=
X-Received: by 2002:a05:6a00:3d0b:b0:824:188b:c173 with SMTP id d2e1a72fcca58-82c6de8582amr6139470b3a.5.1774498452427;
        Wed, 25 Mar 2026 21:14:12 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3bf324sm1335527b3a.40.2026.03.25.21.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 21:14:11 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dm-devel@lists.linux.dev
Cc: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] dm-bufio: use kzalloc_flex
Date: Wed, 25 Mar 2026 21:13:54 -0700
Message-ID: <20260326041354.70229-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid manual size calculations and use the proper helper.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/md/dm-bufio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 60f7badec91f..26fedf5883ef 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -391,7 +391,7 @@ struct dm_buffer_cache {
 	 */
 	unsigned int num_locks;
 	bool no_sleep;
-	struct buffer_tree trees[];
+	struct buffer_tree trees[] __counted_by(num_locks);
 };
 
 static DEFINE_STATIC_KEY_FALSE(no_sleep_enabled);
@@ -2511,7 +2511,7 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 	}
 
 	num_locks = dm_num_hash_locks();
-	c = kzalloc(sizeof(*c) + (num_locks * sizeof(struct buffer_tree)), GFP_KERNEL);
+	c = kzalloc_flex(*c, cache.trees, num_locks);
 	if (!c) {
 		r = -ENOMEM;
 		goto bad_client;
-- 
2.53.0

