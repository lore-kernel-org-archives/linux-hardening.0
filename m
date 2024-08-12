Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D0016FF39
	for <linux-hardening@vger.kernel.org>; Mon, 12 Aug 2024 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459023; cv=none; b=PvwihCZKGJ2EZVCRTAM/rWN8uTzC+0vy7I01XZSsycwpQfKTSd3GWxakvIab1HRfzS6lEIt3e8D0hw3piT1nQtbVhfFwkIuvUDbzHzmm1vnFuVcdTxocWzmtC/9B+jS7DGYvjmX2GXsg2+mluYRgVN0gbB3JkK4/9jg5Yswk7D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459023; c=relaxed/simple;
	bh=8+LIWnQdrWxt7ycwt1k5XvF80HXWWgVGtbMU2iI1TG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n8MN2qVxRKwYUnVtVeKvL+HABBej1pVC0g5FryNnryNtVeIRTQn0eWqHE7cBrHhWzgauR9FSLjqMwHxZMcD+NU4dbBf1FbPQ2UtVHx8HDfhjalPJZCHtPIJpycn/+KktlBwc3aKCcdRAUgBdn+J2UcFEMC3r2V7SoQWp0tvY4cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=p9AlzTWV; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="p9AlzTWV"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52efd08e6d9so5234469e87.1
        for <linux-hardening@vger.kernel.org>; Mon, 12 Aug 2024 03:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723459018; x=1724063818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+NHXPZC38UkK7O5TEx6SvnlkLMGTpM5Jg04F0VTZcmI=;
        b=p9AlzTWV+bcSvn84piwSb0GmqMCIJsSZl99LRvJfjrfZ7l7a9JqrpT2U/Ol/H/2cUo
         z1OUx8iAQopfRHe1J5Lb17mzJjVf9BAxRbaN6kUrKe9wccksq2TOrl0dNvVftvwG5de1
         GUYYdLAQMg/ko6jDTXlq83P1U/wxgiizbkRsIpLLKJ+ekmu8vJqmMizJcDbPtvIlgu/z
         C9gOtikTLNZ//PdMlPFHcI3liL48XcbFngJJCjJFFecNqs3e9qGAP1EqgMnBSJUC3L0+
         6cEW/bX3JCFjSFFJgenkZBvnxlbvmZhckvcPGR9vLlbyiIrstFAM3GSQOX0HN7DOOCzI
         nMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723459018; x=1724063818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NHXPZC38UkK7O5TEx6SvnlkLMGTpM5Jg04F0VTZcmI=;
        b=grSyiPeJWIZS162OkoDhRMiYAQUBZ6X7YmL5Hgv7/aZLBj1oM+Wbyg0LGx0xwFyFPz
         X5n35MIh2ZRsYN6hpTQXDauii8SgkE53VCRNBEUzHLG9bucmDvK9+iDPH5ANwunXEwYJ
         7OVbDHXELbRQWttt86zzmIDmJdkfmbap0A1/P7kwyWPYgCxP/GJIis9ErhRIG+FNJ3o6
         FxPFFcL6L4cwvnPwbew/f5EpV+8piDZX9KyyYGXH34QcPva1AXWAr8+Q0ocgH091scWL
         N9HRSmfg2Jg0WVjpCu3/zt2ipo3C7z3E202AbUW9AY66pU9FVuNv6fVy3AhJTq7D88p4
         3HKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf9T2xCJYUoxn8n7CGEjAloF6D4iUbzy9qdN4EKgtC1I22YOrWYMxYdg8m8LhGDbjnkonV3IS0ZVcXqEYqGsA0f1Kg6tdqR1hRauAhuH1B
X-Gm-Message-State: AOJu0YwQ6YP7/QHdEQVHszfZBvPks28qtk7A3RokOsTOIx1Fh618KM5n
	Wy7kGv7qfUM7hUIAyBVwDxXjTzTVzG238Kxw0lJiBoTDLIq5gsQQFLMIw4IyvZA=
X-Google-Smtp-Source: AGHT+IGhryedRog1uNgUMvSTTd6FzO5BP4X7rYeAgqKS3aPe96HVq3jG2s3kGS4P92rT09XMfGeoLg==
X-Received: by 2002:a05:6512:398c:b0:530:daee:cfb0 with SMTP id 2adb3069b0e04-530ee9ee3a3mr6043926e87.52.1723459018211;
        Mon, 12 Aug 2024 03:36:58 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb1cce87sm221661466b.101.2024.08.12.03.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 03:36:57 -0700 (PDT)
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
Subject: [PATCH] btrfs: Annotate structs with __counted_by()
Date: Mon, 12 Aug 2024 12:36:20 +0200
Message-ID: <20240812103619.2720-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
stripes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/btrfs/volumes.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 37a09ebb34dd..f28fa318036b 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -551,7 +551,7 @@ struct btrfs_io_context {
 	 * stripes[data_stripes + 1]:	The Q stripe (only for RAID6).
 	 */
 	u64 full_stripe_logical;
-	struct btrfs_io_stripe stripes[];
+	struct btrfs_io_stripe stripes[] __counted_by(num_stripes);
 };
 
 struct btrfs_device_info {
@@ -591,7 +591,7 @@ struct btrfs_chunk_map {
 	int io_width;
 	int num_stripes;
 	int sub_stripes;
-	struct btrfs_io_stripe stripes[];
+	struct btrfs_io_stripe stripes[] __counted_by(num_stripes);
 };
 
 #define btrfs_chunk_map_size(n) (sizeof(struct btrfs_chunk_map) + \
-- 
2.46.0

