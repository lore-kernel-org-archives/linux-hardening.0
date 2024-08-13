Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9173419AD6A
	for <linux-hardening@vger.kernel.org>; Tue, 13 Aug 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546416; cv=none; b=tM14ubuc6TLc5eZri9DfJfGDgCRryfpWnduYQP37dzcBCAko2bBDpiMuVWjYdY+kFJzTy+lxIoRAinI4xqq5dtQ3qiRpjswcSsdfbMWtMtP+dOrKKZ8cCYjCWIcN3lRGgu+ufhZ7Ci/SOkJ/HilrKPyKctTvsneztfHjl59eMOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546416; c=relaxed/simple;
	bh=afPCevgdcFFsmtNXdZ850iNIr+9bwUzdnNja76MSoeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KZwu1Ga0Hai5VhM4ut7xPoENViCcpBd+OFr6qyU8NiBpJjLGgsSDkio6QQTp1EGJjt+isThHWnDryDb4h2kh86ef6AtOKlp7hNSrtJk+3eJeFEf+zqXE+JYkY777YTmnL86WNd2aSlH4cbqKKPtLKcj8YB0qVXFu1LUhNHW91Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Xzery2+L; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Xzery2+L"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bb477e3a6dso5129805a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 13 Aug 2024 03:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723546413; x=1724151213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mL6WsGMZ/qoNr9tALWa0VvXLLfikjSA2GI/ckscWigM=;
        b=Xzery2+L9GTbsweFcu9MEniP2hfFSf8xyyAKRIn4j/ABH4kn0U7g8HCMj8Rf39GNU1
         7GW0SBzSD+eBXHOrfaNxH0FfcY8x0s4P3bbn603Cx6szkM9Rb+LJXDw1rD8SFRxu7vyr
         8kbDh2aDgPLBRRLD7LaWE2b1f6+DsAFSBOHkVTLUUFd4PA9hsXqNM8cH3edEVOnXBAy9
         NBnqz13xo+BU15CBwFD+Ie+plgALGT5NJe1+qDC++vBBlMaWZ2c5n0yDBYdFZNp85KGm
         z37hc9IZg3vqHzUDZYuupdYY1F2LWiKHs/XctM05/z87CsUCU8aCszO3AQekXVbHZGOY
         oAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723546413; x=1724151213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mL6WsGMZ/qoNr9tALWa0VvXLLfikjSA2GI/ckscWigM=;
        b=J2XoSC7Cnn1Nw13dCHnivRBBeLW04qO8u1SgJl+zF77oZW2bqVFTyLAnhna7cb2+oi
         h0UPKlOg2k+aJHkxA9mIXb8Dxcurv3vpp7d65COt/2PfOKdQoVUX9hLZ6PoOmGYgjOae
         jGvABShcuT7t7B+MrwwkbUgq+ZqjgpXfjmtO5rZkRt8a3SQ8coyPjCkocH30cGq4wt1m
         RPMscl/5D3yCNOgsWD9JGdI1uMEBnr0viaW1i16tf7xM7ytR7UCOTlaZacslZ32RQj/N
         0DY2UPihVZetQgZNnwB0AxnChLMDxgrQ3Je9g6G+D9U0B35Bl3suGskrxskhqbPlWaDM
         7jIA==
X-Forwarded-Encrypted: i=1; AJvYcCWLsxw+Q6+h3W72oKd5ry6nPUN/qx2I6vtIdJ/OlDQLhBiEqc6pUXB1Otv27650YumWYy2yJD68eXjezNJ1I+vQYMh5nH0+su1UYtiX6nUC
X-Gm-Message-State: AOJu0YzZRB3QydeaXDvLKJFOPU7C6dAUswTA/6e+WKlPbcO5az1Oc7jV
	6M8MQLEtrSG2vumdoSuxCUAkD2wQ8j9UTM5JgielHQCxOGAwU7fJazr8VO9pwwA=
X-Google-Smtp-Source: AGHT+IHVjFzXHfV3YKBeYS9Fv1QrhBgZvi3taudAr8E7H76pEBKVWSjmLKsj+27p/1JROgS8BDE4Kg==
X-Received: by 2002:a05:6402:5112:b0:5a3:55a5:39f1 with SMTP id 4fb4d7f45d1cf-5bd44c274e2mr2274219a12.13.1723546412549;
        Tue, 13 Aug 2024 03:53:32 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd187f2c82sm2847889a12.14.2024.08.13.03.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:53:32 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] btrfs: Annotate struct name_cache_entry with __counted_by()
Date: Tue, 13 Aug 2024 12:53:15 +0200
Message-ID: <20240813105314.58484-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
name to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/btrfs/send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 4ca711a773ef..de185b23cfd0 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -347,7 +347,7 @@ struct name_cache_entry {
 	int ret;
 	int need_later_update;
 	int name_len;
-	char name[];
+	char name[] __counted_by(name_len);
 };
 
 /* See the comment at lru_cache.h about struct btrfs_lru_cache_entry. */
-- 
2.46.0

