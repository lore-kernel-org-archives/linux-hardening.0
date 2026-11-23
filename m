Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443615;
	b=GWHaFmZJIVLGYd7aifp0GXrQDu1T4ix72W5zhVkL3MAGi64FBWmiMAPYxtOO/zsGI33a
	 0jev7zv+B4QXZBhFRmJKaporAruN9NAd66zXl6UjniaBlbP0qwDiWTlhTGnOZfbw3MwvY
	 2nu51Xa27PwKuxBuXsbOIX3S7039FqQPYRnDeIJksVjEKPjyZhp2iwFyraa34zTJEa6Jw
	 6/0Cjybpko91rw5uqGBauQCT3frD7czxd8Y9WKR0N27exO785XiibyWB0qJFYMBwO+9C5
	 OgNIOinZCIt2GSTM2T6ToaiztNhP9CtMe/neiSejnerqJLQ/TE9E/It2khYIoFYDLtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mXV6+GG0z8PCuL6UAZBUPBZ1GbikKdS6r0oEptKGfNs=;
	b=JUKK28glm2gBgLplQ1PRyxKvnFYR1PGBS/brLeXd+aihWf7Qg5Mhv4izh/0nvS4WGlDS
	 N4fJrsZXsqeH1qI494pyYW//jIJ6op4S27+tdYhlDH/8fdz3rxupSUf7sdM6aB5CmOYW8
	 Q1KCkeuFLTsdc4W1Z6FKwsPvsFntSp3MsIk8ZF1NVfmjSlMjY523OCz3TEnWFGtTeO+8+
	 +vAN8WyJfVvPZ3w2Mg38Iy/4fzevPksh18KdMkWMA5yNkJuTeNW1kWoQMmmz4ESAPJaFb
	 C0LWpisQxLacqWh7edIAd8fSk50FQ2eTI7M//ZAzvRd54Jgo9lXt+69iWyfL305dv8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="f/1w/QGj";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153FA606A31F
	for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 14:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 153FA606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f/1w/QGj
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38644aedba1so4957685eec.0
        for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 06:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443614; x=1796048414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mXV6+GG0z8PCuL6UAZBUPBZ1GbikKdS6r0oEptKGfNs=;
        b=f/1w/QGjFccaJiFG3HZ+rpDXw8L2xJoQ59v3syiXQZY4NsO2GBB5fCINp1CyVmMYVF
         E9mRDiMfjxXdSkoOkf31pz0pJ4TxvwcSoDtkhvk6Qvl+yZe+u8JVB9mW6ybge9moTFE6
         RppaxbBG5SuEGZm/X7BWDXr0w3ewh7diGkdvyp6O3LZZO64Lg8pMYB80TI8mMSavlKWj
         R6d4YdSKvDxLHn73RWCVywKgKVQHiAHLH/IVtVvoS1wEAhKPEj6b612KuELFS2sttqdx
         dfKBjN3hoL4uDPPb1NyELWshyIDzXmci4MqwL3adOt/e0UzHzLY+nfzRAVgttazdZFa9
         Y6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443614; x=1796048414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mXV6+GG0z8PCuL6UAZBUPBZ1GbikKdS6r0oEptKGfNs=;
        b=VsS/5slTJE68ilptnnbBODFdORfajKPUg4MJ2ouRKhpW+aPpR7lrk8dMphJzZmMtbL
         N7sQ0PjJkv2r35NRkPwJA0vFhOj3JyjklWdIrBHK9jxqO+VHeIz30rnVdNIKvz+a/dmB
         N/yQBLszEy6yfmBxloUoezpN/fFQ4h/jgutpeBizRgpNAllAtGSTiEGMAP9j1r2fCGwS
         m3D0Ugh+S8+/QZA/NxTUJoQ2g/Fp57j4wHRN5numUYFnTjn+GDu4qzeC1Cc+ZJtaVumb
         ZZAUtt556CMnfBLVBjJYPFwXxRfOZtK7HWte3nmWMAFCJ1lhdXtn6AzvESXPR77MbLqg
         ChSg==
X-Forwarded-Encrypted: i=1; AL+hErE4eq/0klCX4EUNFySLXXYuGnWecl89NuhWEhuyfPG4KRpzxvjabDdDODvC1OgwvhOFBLyCbaaXLnjyNFfXSdA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tFarSYeFfR2zvOEgJAOz7zT8JkecCsv3EwKFwdt598gb2MqYT
	I5ucNptprJY+bCx5VAQr2TrZhi0RLGI9yLxYNkUjwK190672WE/wHc5j
X-Gm-Gg: AZFdTZc7Ti4y5cY5KOdRo4OMPcsaDj+7c2YJNZxYgpYf10Yna0LnfONnQapjimd5zi1
	TOyEl5pOst5NGsdxA78QtOl7rc565p0va+I2xILnZMLx306iwZd3a2wN4L2ZLvJsJLdxRMbDV3U
	EgG6amqAV+rdpbRZt/Pp08Rdu5RYXGonMcnDmqRt24nwhe+Klz0YWM2SLKtrqi1ARSIDbRi9w+/
	amlIO5NPRrI1gDdOs6XWwxCo1SYkfx1xSoQthBGK6SfIw/v9t0+LYhrl1rFDBumvpXUrE3dgoOJ
	UruVYfeM4mLqrpuwY1+HYFItO/A61iuRcgNEgKOuF8pftBv/DnTBKMsSQQKIq05RX8HY7PZrbKi
	/xDduuhztPCGOFLGkRYs42Rwkt9TU1PIizGWYLkJYuu0Ot1ohjhFh6QuiYDfZBNAqH9HUzlY4+Q
	TnBvPeR6ukJfQ+EaUPr7+GhVHxmfIhso0Ydp8jHgsmdqPASagYc81HS2MpdzL+ZjBN44NpAUpEA
	T+Av7jxLjLVeUqz7gTwYkLSgcqcrry3k9Y2FqxZkcJbVHOD/s5GBa06ONH98WSlWOsT/483c64b
	nPXezveOMrl1L+8vavc1jscbl31zIJfs2vETiz2tfQGLDU1Cw5h3zRu8JEuoXNcHZETb
X-Received: by 2002:a05:7300:8282:b0:385:af7b:d788 with SMTP id 5a478bee46e88-385af7bda3emr10643390eec.2.1795443614142;
        Mon, 23 Nov 2026 06:20:14 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38577214c2dsm35579857eec.17.2026.11.23.06.20.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 06:20:13 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Jihan LIN <linjh22s@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v5 18/19] mm/swap: skip reader rotation for single-device priority rings
Date: Mon, 23 Nov 2026 22:19:59 +0800
Message-ID: <e2a77e8a6c81c5cf56694b18f8e27b038055ddd4.1795439990.git.lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795439990.git.lianux.mm@gmail.com>
References: <cover.1795439990.git.lianux.mm@gmail.com>
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

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5a8663e9f954..91de93043500 100644
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
 	head = this_cpu_ptr(&swap_queue_readers->heads[queue_idx]);
 	/*
@@ -361,6 +366,7 @@ swap_queue_get_device(long nr_alloc, struct swap_queue_cursor *cursor)
 	si = READ_ONCE(ring->dev[dev_idx]);
 	local_unlock(&swap_queue_readers->lock);
 
+check_device:
 	if (swap_device_masked(si))
 		return ERR_PTR(-EBUSY);
 
