Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AC0335BA8
	for <linux-hardening@vger.kernel.org>; Sun,  1 Feb 2026 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769952164; cv=none; b=BwE3ngb5Dz5wxnYQ2Z3qpWtRkJLSye00BdYX9eE27QKEZxCYqaHAu7NXdwmNKm4MVLXFbEtkdx4+d5B9lo2AmbC42sYwC1I7PhbvDU8mL7Mddo+ve8I9tNerseuglAlEjh0xno3nEVl6bcisaTV7CutOcmT0uhbphhcxBqYIrDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769952164; c=relaxed/simple;
	bh=whaSL81KwS/fiw68Cl8rxBwbDrJF+JXFC07BGw2yzDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jP8x2q60b07hfAgkmyZL/HCTO/A92lTpc/8jg6EEC+PgmhdxuUtckipCg86TiqgHqDR6ddd53oFJXoSYpM9A7sr/jqrP1zu61kPT+nBBxJjQ9CnMTtoIV4kvLg5PGHhPJCRYU5tpOtr0JyqipZlmdqG79kjHqbnBeX8LGoyG7n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iq0pmD+2; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iq0pmD+2"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-790b7b3e594so36493597b3.3
        for <linux-hardening@vger.kernel.org>; Sun, 01 Feb 2026 05:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769952162; x=1770556962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7a7p4/y/BHQxkvFbtwlRAV/7isrEcljAgUdtq1UtJI=;
        b=iq0pmD+2lkzgamH99+ASy7h2olbuLnSd7nmamGoYPvl7xTTFj3Lb8kEOaGZEU+5Lrt
         Dux2x7CcR1Yk94sOn4v2zxG62cIM7KS+YILaTHs+MFnz9ZPUzrog5J4VmzEq1UmvLtPc
         fjTcPcVqvr3jAbxdx8R47BjBibJJuSTOE8biyRvV8aBCffHw6tnfeTXiphxGzpK3ul2s
         RRCIQvuZbCLAoE159/cMBZkv+eOupS1c44KssnOhBC2g7Ml9XGl741mbg29JQzGPTZvE
         qfefehLXcIbMX8WpYMOnQUNC68uFJYHOpn13XcM+/ovteuZ6UIok45MamyrvfZGWtgeR
         v8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769952162; x=1770556962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T7a7p4/y/BHQxkvFbtwlRAV/7isrEcljAgUdtq1UtJI=;
        b=LY51k61yRzUEl8k7qhvpvYWD8YgHSQiwwWWyhCQhd25Xke6nYTRdu3UhFpXeGTtW8S
         L5N9sSrcHz9/JqVcR85PnbH7LCiOx9PAAqgHjPPjmdSmIZQ2Qzj0+4zJhVvK/VAuHfa9
         9VTaFavMlAe0775iudLWYiaMGTu+rgBaSEZD55hF/uNxiDEmsK7IRo1T52Xqzn+FpSYs
         9mC53joZVoG0FJGlogz8Op1R1EyYgSCT4x+hdYET7wYGt1vT7owocXrVd5NVRt2/TV3L
         1zTlDjzYzyQvQMpujw0ejvtDwv/H4JSkK03YZBzwqW0aG6RCMWxHmNP87LC2TW4F63kh
         N5zA==
X-Forwarded-Encrypted: i=1; AJvYcCWrrJRIPZcO4Od3/DJOEU6vxEoeRf3m5mjMytVuqE90kMSz4LSERwi2NGHqrnA3U4m3Tg0h/1OnGawmkdW2Pq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeDKad32FAMKohxDvDOsZByclE+UaEUnsgZclwlmboQtVfCvbH
	E2BtEsIgqycZ7zb0RlgUlW+02ZVv6Sn3tyQZq7j7RKRV/4PNQ4J7s5W2
X-Gm-Gg: AZuq6aLxgTRwcPWuc13izlPWpF/nfScYTh+oIJTs8ElKx4vYrcBgA3QGhZZSL+zT0Im
	NbtDhEpIiL0AT6B3ZE1rxssJcSejCZFE55EnINdGwS95kI+duEKEXZlbPviFU4RnEWTFXtBT1VK
	uoCsdjoJ07Ig9M57Az1vrZXWnVM0/coX0yXoL2lwtPBrYxm2bfVB8syLhMOXu1X5Hhpi1n/T8QW
	U3htqMvbhNPZecStXsX7vGveoosrpFsEWNGsN9AdY0n5mUc4aT4wSeZr0Dp2Jw8CxVfPqFfhAVx
	p/d4rAGDDLMvscUJs6Zt8dh4GawyJstYqAdkU45UuV3Kc5wqEcTgPxQPlqC7n98yaTKtpm3qtkE
	wl5T7wnBLHEj4M1FmxxJz0UVp4ZRAuvEpt1ZovYCW78aNejsvOthsRAecjbzBYDh5gkv2D4laNL
	uHvZY14c8wmCYvQ/iRQVXtusk=
X-Received: by 2002:a05:690c:4992:b0:794:b7f1:59f1 with SMTP id 00721157ae682-794b7f15dd2mr35296067b3.66.1769952161640;
        Sun, 01 Feb 2026 05:22:41 -0800 (PST)
Received: from guava.tail5f562.ts.net ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79482762e59sm62700987b3.7.2026.02.01.05.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 05:22:41 -0800 (PST)
From: Pwnverse <ritviktanksalkar@gmail.com>
X-Google-Original-From: Pwnverse <stanksal@purdue.edu>
To: kees@kernel.org
Cc: gregkh@linuxfoundation.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	anton.vorontsov@linaro.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sai Ritvik Tanksalkar <stanksal@purdue.edu>
Subject: [PATCH v2] pstore/ram: fix buffer overflow in persistent_ram_save_old()
Date: Sun,  1 Feb 2026 13:22:40 +0000
Message-ID: <20260201132240.2948732-1-stanksal@purdue.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <SJ2PR22MB4268740D8B115ED88EAC4959BE9DA@SJ2PR22MB4268.namprd22.prod.outlook.com>
References: <SJ2PR22MB4268740D8B115ED88EAC4959BE9DA@SJ2PR22MB4268.namprd22.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sai Ritvik Tanksalkar <stanksal@purdue.edu>

persistent_ram_save_old() can be called multiple times for the same
persistent_ram_zone (e.g., via ramoops_pstore_read -> ramoops_get_next_prz
for PSTORE_TYPE_DMESG records).

Currently, the function only allocates prz->old_log when it is NULL,
but it unconditionally updates prz->old_log_size to the current buffer
size and then performs memcpy_fromio() using this new size. If the
buffer size has grown since the first allocation (which can happen
across different kernel boot cycles), this leads to:

1. A heap buffer overflow (OOB write) in the memcpy_fromio() calls
2. A subsequent OOB read when ramoops_pstore_read() accesses the buffer
   using the incorrect (larger) old_log_size

The KASAN splat would look similar to:
  BUG: KASAN: slab-out-of-bounds in ramoops_pstore_read+0x...
  Read of size N at addr ... by task ...

Fix this by freeing and reallocating the buffer when the new size
exceeds the previously allocated size. This ensures old_log always has
sufficient space for the data being copied.

Fixes: 201e4aca5aa1 ("pstore/ram: Should update old dmesg buffer before reading")
Cc: stable@vger.kernel.org
Signed-off-by: Sai Ritvik Tanksalkar <stanksal@purdue.edu>
---
v2: Fixed Signed-off-by to use real name (was using Github ID).
    Resending with proper mail client to preserve tabs.

 fs/pstore/ram_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index f1848cdd6d34..8df813a42a41 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -298,6 +298,14 @@ void persistent_ram_save_old(struct persistent_ram_zone *prz)
 	if (!size)
 		return;
 
+	/*
+	 * If the existing buffer is too small, free it so a new one is
+	 * allocated. This can happen when persistent_ram_save_old() is
+	 * called multiple times with different buffer sizes.
+	 */
+	if (prz->old_log && prz->old_log_size < size)
+		persistent_ram_free_old(prz);
+
 	if (!prz->old_log) {
 		persistent_ram_ecc_old(prz);
 		prz->old_log = kvzalloc(size, GFP_KERNEL);
-- 
2.43.0

