Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CC8274B46
	for <linux-hardening@vger.kernel.org>; Sun,  8 Mar 2026 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773003241; cv=none; b=TtG59I562v3uWP72bHnH46UpfujxMKditn2HcHaSn7fDDPekuVh23lC94wKXjZJygnUjxvPvok8v1qKeMPBPvE/CBmXg0CxPiEi2EE8c6rFuBvVxDyanECbbWPx5dBRyRQ4pmLEtk01I0OFIdpPDnjlClkr1z13r0L/PgD18SCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773003241; c=relaxed/simple;
	bh=PylX8IEChGBaGlHqXEbfqUg1n2BDvKGc7VXqNccsPWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CK6l5hOXXpDsphmGxXS/AZC2LhASjZoJnNoHc7rubC38sED1jLABHzdFsUp1wbPPzZtKRTwA1KGwkTKSoVRRfqc2B5X5bOW3oU70Jw0YHy9mvYPYvZi4nUo4+vegZXQx6wMXmLdjU3nbQ99ulo/ORuvIExwkKXDXsOguiE2Sjv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgRdaOI8; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgRdaOI8"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-829a27414a3so1238945b3a.3
        for <linux-hardening@vger.kernel.org>; Sun, 08 Mar 2026 13:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773003239; x=1773608039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TeShWZUkCPM3Ka2Jx58JiwWvMzj51hGgMlQCsJB6FhM=;
        b=GgRdaOI8PRudmy0iq8OE3OInK4/1aPxbmOSWN6tCCkgcmmwew9he1dGINYqJ53jGmE
         SLJ2FRd5nCEc09yS4Ci8DUKc8Wkyj7n9HkFMyMz94RbG+fL2aADBiYUqPw17Blfs1JQx
         4YOOD0raN/CeXHpTat73UnOF0Gt7pu6S9jxaG66pl0MelfI2J0/QzmUXLMXjPZ9sLWGj
         DPQyCFSkWHNStAuGxPuXBpnIHZKhVmjrpP1/95JaOjvceIzieDK3EQClYmihbbWZGUHf
         i1igUTpev7S7BzyJRMiV7LRXGhAkqtOEQ2+G+nv74/6DFZzaE+Ji1jEHa67PtPZ0G0tu
         a1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773003239; x=1773608039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeShWZUkCPM3Ka2Jx58JiwWvMzj51hGgMlQCsJB6FhM=;
        b=ZxNuW21ZkB1RG1PiGUT5A6HOIJu1yDd/rxWUuxUwHHLmYl+awNGOvbCM4+q8aExZBo
         FjnkBjrHoTI67VNxmajWGtbTcCUA+ZuhkXGyAo3i4+vaGhffjf5dTTwMIDl5XDMlJ5Dh
         lT1/LwpSkU8SXv0y4dGXx9cGYqsN2rRPfaN1fTmOaJUBWYFZnufbAc4Lw59QhAFMOSj6
         G1YnxoTExLOrKof92nO0ImOKa9hbggVr2tGLiWeffC7R/pJ/U9QQ8RnEYTYvch1tosqh
         1O072fqQkOVbdWUbA2hNqti+FID8JnBX1mQzWmElKhC12g78Gtvwl7/MSWUORMvzscSH
         6XEw==
X-Forwarded-Encrypted: i=1; AJvYcCUGR1McfHLyNcEQXLdljJq08D4gbCJ+vjWjCDuJeE5SfDXqs4r/jDmOZkzf9/rAO4QuxQtv5ePfTofPtF8x+fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/vicygc5Ero7eR+xaXkAiu/Y7rqq9H0Lj9beD7Dn4npQPLixi
	YMNinhaKF4svamhxdTwQeiCbPQfVm2UarGB5NNuqMlcTkJJdkNHxNtk2
X-Gm-Gg: ATEYQzw3wKkKgZvDk7xPwW7uMSHSJO0FNMh0GtZs6B9r3Xh37Mu2AYNQ41IbsJlZxoh
	TylXCDGB7QCRciL7AjKsjxReAgkzWk17fjCDLk7OxW/dyrPl6T0cDo6n/d099ECaoG2rWd4kiGf
	U6yy2sMeNMxVk0CB/M1xMfNvKjF4u+9qjXDlloNAhU/O/u6buo9oXyZ/N+TKFotQDYpJJY3nQUl
	nygV5I1yqW5+nxfz1/jeRb4svuVgwvNz13uIqdG8cFbivKWbchFk7iPJXAoPJVLjZWRqCK+GrKR
	RgtlqmMT8lszPG+KGYD7OJBsEk2MsKypgWWCS07RLn39ocaNjyaq5jxS+a8p0cZQN3hwfNirB/k
	DYbtQHnzkQuPqfmvOQzkPbwu4Hl1iS2p56CgcovUsxDz9GtmaeSyPQjbv8gxWZsKABJCRGmvHqt
	6kbj2D1h/8e+MoxdBqLQqDTZmVXy90kBcyYcDK982egGcxJpNsuxn/JQ==
X-Received: by 2002:a05:6a00:2346:b0:823:8a5:297f with SMTP id d2e1a72fcca58-829a2de2ab2mr6966782b3a.16.1773003239273;
        Sun, 08 Mar 2026 13:53:59 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48d3621sm8722968b3a.62.2026.03.08.13.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 13:53:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] btrfs: raid56: use kzalloc_flex for rbio
Date: Sun,  8 Mar 2026 13:53:40 -0700
Message-ID: <20260308205340.24208-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocation slightly. Now stripe_pages does not need to be
freed separately.

Added __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 fs/btrfs/raid56.c |  9 ++++-----
 fs/btrfs/raid56.h | 12 ++++++------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index baebd9f733e9..d74ae380265e 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -151,7 +151,6 @@ static void free_raid_bio_pointers(struct btrfs_raid_bio *rbio)
 {
 	bitmap_free(rbio->error_bitmap);
 	bitmap_free(rbio->stripe_uptodate_bitmap);
-	kfree(rbio->stripe_pages);
 	kfree(rbio->bio_paddrs);
 	kfree(rbio->stripe_paddrs);
 	kfree(rbio->finish_pointers);
@@ -1070,10 +1069,11 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	ASSERT(real_stripes >= 2);
 	ASSERT(real_stripes <= U8_MAX);
 
-	rbio = kzalloc_obj(*rbio, GFP_NOFS);
+	rbio = kzalloc_flex(*rbio, stripe_pages, num_pages, GFP_NOFS);
 	if (!rbio)
 		return ERR_PTR(-ENOMEM);
-	rbio->stripe_pages = kzalloc_objs(struct page *, num_pages, GFP_NOFS);
+
+	rbio->nr_pages = num_pages;
 	rbio->bio_paddrs = kzalloc_objs(phys_addr_t,
 					num_sectors * sector_nsteps, GFP_NOFS);
 	rbio->stripe_paddrs = kzalloc_objs(phys_addr_t,
@@ -1083,7 +1083,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	rbio->error_bitmap = bitmap_zalloc(num_sectors, GFP_NOFS);
 	rbio->stripe_uptodate_bitmap = bitmap_zalloc(num_sectors, GFP_NOFS);
 
-	if (!rbio->stripe_pages || !rbio->bio_paddrs || !rbio->stripe_paddrs ||
+	if (!rbio->bio_paddrs || !rbio->stripe_paddrs ||
 	    !rbio->finish_pointers || !rbio->error_bitmap || !rbio->stripe_uptodate_bitmap) {
 		free_raid_bio_pointers(rbio);
 		kfree(rbio);
@@ -1102,7 +1102,6 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&rbio->hash_list);
 	btrfs_get_bioc(bioc);
 	rbio->bioc = bioc;
-	rbio->nr_pages = num_pages;
 	rbio->nr_sectors = num_sectors;
 	rbio->real_stripes = real_stripes;
 	rbio->stripe_npages = stripe_npages;
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 1f463ecf7e41..dbe6b7a2e194 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -194,12 +194,6 @@ struct btrfs_raid_bio {
 	 * allocated.
 	 */
 
-	/*
-	 * Pointers to pages that we allocated for reading/writing stripes
-	 * directly from the disk (including P/Q).
-	 */
-	struct page **stripe_pages;
-
 	/* Pointers to the sectors in the bio_list, for faster lookup */
 	phys_addr_t *bio_paddrs;
 
@@ -230,6 +224,12 @@ struct btrfs_raid_bio {
 	 * Should only cover data sectors (excluding P/Q sectors).
 	 */
 	unsigned long *csum_bitmap;
+
+	/*
+	 * Pointers to pages that we allocated for reading/writing stripes
+	 * directly from the disk (including P/Q).
+	 */
+	struct page *stripe_pages[] __counted_by(nr_pages);
 };
 
 /*
-- 
2.53.0

