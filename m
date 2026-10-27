Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117648;
	b=3SFUUizyJIS5CvWuzOu9Y2mzJ1u0g7ihMG4gm4UezTq/6H4jTW6LE3YY+1cS8YfsFhMe
	 iuoCdgS30+UaiGGzpDLeMPXBrX0lfC1lSnIy1E0ox00wUt8JWiq1Yvt1cBgjGUmtrZGKb
	 NDPhMa5INOpgd1difaHlFrKeBBtjzUgSDA/CI0s1HLQc7HKyzzhEsPM3zW1ePoP8DTjnl
	 AwJG/Mh6w/LEJC8YBUvGzSK8EeRVhE+goH4Qt01GZHsk++4pTTOXjHouottIKY1J4VuaU
	 IRXEfQ5EQk/mw7fPrVnkMufZq7OBxmn/+UyUOE4JUjvSKvSwvOyJt4lN+kGuB1UErFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=toOq0XEZ4M3UIbIsRm37gKrEflyWkQwIZA2AGozjzx0=;
	b=lTBwrd7yENWgaBL0RrP7t8GGt0f2csYVvNEwoF9tlVhF8tFMJOOCWKqPkUFw0mzGS/5O
	 y1dS97dJ5o5+vhsmCqtuFkGtnoqvWXVFhUw+jxzWdT5xXPJmrqumFv6xGKwuvBiANz8zA
	 rXz502UKUtx36kxyyHYq0KjaL2/mBvW++Q4Vy2ZkQLLovOy+tzmWjeEJ56rle/LHdSoGW
	 NFF7lTwCtShdM5PqWTwzkhUqh46lqxYT9gSo186AmMO+R/2MCQyuQVOqKwi2GB6LbbxlX
	 TSTl9FL98cffKMJDe543SbN+xQFzdObxJzvRFPOcmTyzxRU/4sQ1Jho0vXByMGucdAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mHn0C1mT;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7427D606A31E
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 16:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7427D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mHn0C1mT
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ea0efd636dso35180895ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793117648; x=1793722448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=toOq0XEZ4M3UIbIsRm37gKrEflyWkQwIZA2AGozjzx0=;
        b=mHn0C1mTsr5R+NeQ9MfIk+cOrVZwhjLS694g5z6BnC4yQya4ZkRKKax43UExLBZdeS
         X8Mgv/GkWnR62c5TgNWAoiYkXUpEz9QbwS3AbniQfRIEewdtF5mvtwy0/8Ivc9hbXE2p
         kW+p0A8Fm5nORbO1uEQ7lPnGcZFnvu1NqLncBZi6y0j1Hr+3UKIFsgD1WoOIBsO5wqqh
         yv8AzCWyTihb9tk9jWeadRLE3weqs7eJ7a40D6TAe2BVB0dX3Na0HVefAd/WYu0Q/y09
         Zu4L6SucoyrmFwvSoA+toz7mY6Cw0fjiMXGL8jWGjiOjc4SPRLCQjz/h1UBB4az3qSd8
         MQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793117648; x=1793722448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=toOq0XEZ4M3UIbIsRm37gKrEflyWkQwIZA2AGozjzx0=;
        b=I/fGiowYqZrQtNsIpx7MdsybyO1s+AjPaZ9JhR7Mg4Ltw+4qNYdEkWscdmw8qesQrF
         APCp2eG0sC0qPMvVFugMbUaFic9q9XUo18BBl+I5U/auSdx0ErW7MTN5BeUY53HtO0cD
         QlEQ+0V/Yj4ZAp9GpXXXeCfU2rbGf/0ukT3HKmVkjHGIexalo6tx1upPiN9WnDYN8LNz
         nHbg+Llx/hgsl40fDGORd03z+9MyXXPa3Cfx/rvrkWyZzIWnFtV4pp1w4bk88Sx9y2Mx
         x23reHZlmsgqy0U5W9sKY6wrGsPaQXKTAaAUYQnsYpiKTVJj3779YY8L+csS80VCPYFR
         WNOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwqUmrYqeMwMYlELy3qum0kH3ISiWxjUWbo0W18lN31jPAK3pHXc9RM1BSkIe3WrHylZm+eT9vno14pRJNod5E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEUqIlnnRhIRUeQMOQsRA80Nm2TKOxJzM+ytuYP2YUgwWWdR/u
	QvY7/TRWEqvujsyhYGjKEO2pAX4eyf3Kj3L0+QKp8BwR3EuYjyazdpJv
X-Gm-Gg: AYBFou1r0cWuewyadCN9jGUARWmuwY4B1hKuJ59EdiqmKSq1wxYMYru9ewgcBHwGSw8
	mNrxSjZz980X56bWpwlJpEqfeRuYYWuCKBjj7YANvnfYGX8mX5kNuL1hMUmwd3iWEZkq+SixO/y
	aCBpZA8yvn6OwTgwgAO1S910fxNRy5VaE6Nyp/g8ytlwvFuPosn1Y4wolB3H5kUqOiNPKSmLXTz
	MGoYkWWmqRfEEOdzmCHjk/6F0deFIKMPHsmmhAN+XCSlDeIMStrSpjByhUt0HCuOmEd2iSDDDCy
	sAeeEBQlqKxNRNVAcbktpFEMtZfJZeQcfOIb70NvBn4A/HUVMsTbt8Bz9IqQWmjo0POngJpOE09
	GOVJAoEhjWz0wBST+sMv7NJpn3sMOMtCWQcoHrpGVkjw+g4SOYwCW+Agy2B9YH0cIExqRMO7sQZ
	Dz0FPoI3YGB743+nTPO4dCB7fdz2YReb6syiQr+Aqv7tTwdw/zBvwWj5Ybuh8Qwf+6iDsEs7Ivf
	L470adgSDGwqKkCSuIAJZ9EGgOthfYin/3VSRCK7aixEceErchNhuOPNKPozknuOOke+//nXhmc
	JlszwRiYCq11QZRNdZ0=
X-Received: by 2002:a17:903:2389:b0:2e9:6788:9379 with SMTP id d9443c01a7336-2ea9c821072mr82928135ad.32.1793117647793;
        Tue, 27 Oct 2026 09:14:07 -0700 (PDT)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6455a00sm12395875ad.2.2026.10.27.09.13.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 09:14:07 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	chrisl@kernel.org,
	nphamcs@gmail.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	youngjun.park@lge.com,
	shikemeng@huaweicloud.com,
	kasong@tencent.com,
	linjh22s@gmail.com,
	kunwu.chan@linux.dev,
	kees@kernel.org,
	gustavoars@kernel.org,
	tglx@kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RFC PATCH v3 17/18] mm/swap: skip reader rotation for single-device priority rings
Date: Wed, 28 Oct 2026 00:13:30 +0800
Message-ID: <a2183392a7222d0a6070639a0a45ca86e2d922ae.1793106426.git.lianux.mm@gmail.com>
In-Reply-To: <cover.1793106426.git.lianux.mm@gmail.com>
References: <cover.1793106426.git.lianux.mm@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A priority ring with one device cannot benefit from rotating its starting
offset or maintaining a quota. Read its only entry directly while the
caller continues to hold the topology read lock and migration protection.

Consume the cursor attempt and check the full/disabled pointer tag through
the common path. A masked singleton therefore terminates or falls through
with the same bounded behavior as a multi-device ring. Keep the existing
large-folio same-priority failure boundary.

This removes reader-local state updates for the common single-device case
without bypassing device lifetime or availability checks.

Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index bbd114f043ab..9e90f815f99c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -333,6 +333,11 @@ swap_queue_get_device(long nr_alloc, struct swap_queue_cursor *cursor)
 
 	/* Consume masked peers too, so every walk remains bounded. */
 	nr_iter = cursor->nr_iter++;
+	if (ring->size == 1) {
+		si = READ_ONCE(ring->dev[0]);
+		goto check_device;
+	}
+
 	local_lock(&swap_queue_readers->lock);
 	ri = this_cpu_ptr(&swap_queue_readers->ri[queue_idx]);
 	/*
@@ -362,6 +367,7 @@ swap_queue_get_device(long nr_alloc, struct swap_queue_cursor *cursor)
 	si = READ_ONCE(ring->dev[dev_idx]);
 	local_unlock(&swap_queue_readers->lock);
 
+check_device:
 	if (swap_device_masked(si))
 		return ERR_PTR(-EBUSY);
 
