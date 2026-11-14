Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794667948;
	b=5tSp2op+QHS4nz0lEHlgysYcvuSEnJ9ZylWBWUKTZbUGzFrUqs97of0iOeAkP0kDUWTa
	 8XnjteurdFm7xIYhZtv4ADUu5M0ZfnoKRjnqJjkCezhpU89mDEdIXrHy1pYbTQYgw/i08
	 X17sCKxpGuODEFGSTMjTOqTKfreeV9pkxcC5e5Kw6M2ax9ExiFRNS5eUXJk2vN/S7DWWo
	 tTIXeK4vzdkyKKwQ0Oo0i2IuW2bLkzTXxchZ4KAx3iRjGhyjy+U9mtG8/tEntsqwJlHij
	 dAQVvSIIO1g29gd+q70FCcul8hoGXMBep1YwQlKgVnc1NZOUVSJKx0GcatS91ONo6xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794667948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oTRaNJjnhz2jjoFCzuWRnC9Bci53/lYdl7KWMCnuH+8=;
	b=JrJxHExEMF1js0e5qNJ+fu8oYDKGhD/MgKbWbaE291PHhCNxIKVzcgcZIQQ9heNyjwDH
	 mviQkObfv69fMYf1ibtfdUH9NkS+oU5gCm+WeJwH0pko8/sRm4Fr+kLpIinEm2cB9kCkQ
	 p5qdc3rOg605H9eMkgfrlLXaViqtpBJitApw+WAC4PHKsMie0+FwhgaNBpA5SsGWwlzQO
	 kxezL9eS1uIIQlvz0fIUSxWE+K5lQQkm1cO/CL/vC5R7SRHRtEkccnCRARsha0KhuWD45
	 CFPIwfLXjgGcqKev9VeMUAr25s+edKcND5qn8TvfKiNF4pUHR4xGG2fQZBU5cBm0Juw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OwdwJbMz;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA28606A333
	for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 14:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FA28606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OwdwJbMz
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b1535be329so1663274a91.3
        for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 06:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794667947; x=1795272747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oTRaNJjnhz2jjoFCzuWRnC9Bci53/lYdl7KWMCnuH+8=;
        b=OwdwJbMzdHBy9oKyEWrP5XaQofmC6pfOfmQzIjATHeM5HWF1hSoSWb6meMMRlcINwG
         fnBgcAiuyiEWplSbnlT9aVWqzktSR/zDuOUg3vqqvUvP+S+sl7GqFtygqLjIlhcYMtU9
         Va5czVlqMEZ9FPnZxJMel3sJuFD7l3DhbC/AdGCo7zOs/DaUZ1B70ZL7d5HT9pK5gXWj
         iIQs8lfimoZR/McV1zRpC7L53Dbeh2TO2KHPwTwGCBybHTs+xIkWv4qDZ9eQBT3gU9ZS
         ozry+sIBPCqGP357Oz1FSwGW2bgWWnKhfTP/XsrE7/VP/TewmdiSn2quoVDG6JYX9B6n
         lKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794667947; x=1795272747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oTRaNJjnhz2jjoFCzuWRnC9Bci53/lYdl7KWMCnuH+8=;
        b=CFVgPN7f+lRsqrsjph6ka+WrNB2NyoOGuItQ/O2j2ZbR5dbqD2fhDtzMdiV3Rp3mM+
         d5IXnmheZ5Q4e6din0669KT8IrM6t4nSfCI29jcm5KZk4JqoLrbNPibZ9/3VhpaaTf8l
         cVX5ZJsHF+mCDyeUEcQ05ZlvojzBI/lo4nDQLTZKY7uPnJiAdZ7Zi9ATNJyeaBC94F2x
         Y99b5UuryClIP2SRwe9KrbqwnXlwUNjiUT6Dbz8HkQ++tgUd2iqjJc285FJk0IGxpegH
         /k+XiCAYJHyzpD2mf0DBeMnt/MPAzSpfNLARHa/3S+9lCr7N4TPunyLlat9AWI/tO2Dx
         BBTw==
X-Forwarded-Encrypted: i=1; AL+hErFlfw5b/347GBmzHRar8BpFxTL5PkpTh+SUpTF18WuEBG7G4Hmh+o7Si+6+jEbYA95aH6SYRdoazgSp7l9epvg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EiXGeZITMSCZcV9JL3sQNnr5SxoBzpb8++3u7DppLwIFiZa0K
	jIuRk0lQ1444lz3HceuLwD6JcuyA2GurYug3hGQCVDIj1L1o7CO8mZ8l
X-Gm-Gg: AYBFou1QTSwfcbXGO0mpYCaOEYlVlXsiV9Q9gjvfKi2mwCNZLe0W9ZemNmu4ZHvu3X4
	VXvEcQlRq2+Y8LmifqLKdHLI0F8mpJtQTVvRJlyhSXYmFaJdmrmB5PFKCaMWjgTp08WdMdrkVBo
	QucbFNPsQ+ZrrPyRuOUgZKs9K7vUGn452osKUhzNcC8DidjjjYPz2+KOtlbm9TWB4mLRecfHTvT
	P6NFXEmDYBGSAx8MjAtBzPzjnmaj4mfXuhfz8YKMshrwwWBKw42q2/Vq3CTgIDaukteEVOkovrs
	RJQRFyG07EizPDbhPZW/oHX0jJ5q6Q2oeFCASJm0WCPKGcu1/u7k8ptnGIjkDD7Mde3N1bBhhFl
	UCWWpzWuHsP0FmbKx44j2pVef70SQs4vi9FFRm4u0mDqkDtgcbi5TbADvemyK6jcGpQS15nWz8A
	ZbMHQtBe8/GLetrgUtRCIpnWZO7i3Ka5zqUJzoRRIyzCiYsyatoZ7PYRyNZDvow/YUbIErxwGI/
	UmzO+ic3wFZXHxOJq2Pn/fomDZ1ZzP26cXoML0l0C4GHN0NOzDF6agQpZMUlpMun0hjQ8T5PvwL
	Busq1SZ90b6SFFzIubIoCXoIxsg9sZiBKWsCzLduMMBuYDXa3bZI8BmoWSTN/rx2Gd95
X-Received: by 2002:a17:90a:c88b:b0:3ac:8741:e2e4 with SMTP id 98e67ed59e1d1-3b1b0a4e341mr5623665a91.52.1794667947352;
        Sat, 14 Nov 2026 06:52:27 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3f09b92sm4082810a91.4.2026.11.14.06.52.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 06:52:27 -0800 (PST)
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
Subject: [RFC PATCH v4 15/18] mm/swap: reuse per-CPU queue readers across priority changes
Date: Sat, 14 Nov 2026 22:52:15 +0800
Message-ID: <c7ee52cc6aa423b40c67d4c24dcb9d30b7e07824.1794666741.git.lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794666741.git.lianux.mm@gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com>
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

Inserting a new priority allocates a replacement per-CPU reader array
even when earlier ring removal left enough storage. An unnecessary
allocation can add swapon work or fail despite sufficient capacity.

Track the installed reader capacity and retain its high-water mark
until the queue becomes empty. Reuse existing storage when the new ring
fits, initializing every valid ring index for the new topology. Prepare
larger storage outside the writer only when growth is required and
recheck capacity under the writer before publishing.

Preserve the existing prepare/install ownership and failure rollback
protocol. Device removal continues to avoid per-CPU shrinking allocation
under the writer.

Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index bd098114ee4b..5e5c1aef010f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -202,6 +202,8 @@ struct swap_queue_cursor {
 };
 
 static __percpu struct swap_queue_reader *swap_queue_readers;
+/* Keep the high-water capacity until the last priority ring is removed. */
+static unsigned int swap_queue_readers_capacity;
 
 static inline bool swap_device_masked(struct swap_info_struct *si)
 {
@@ -241,7 +243,7 @@ static bool swap_queue_needs_readers(int prio)
 			return false;
 	}
 
-	return true;
+	return swap_queue_len >= swap_queue_readers_capacity;
 }
 
 /*
@@ -289,13 +291,15 @@ static void swap_queue_reset_readers(void)
 	}
 }
 
-static void swap_queue_install_readers(struct swap_queue_reader __percpu *readers)
+static void swap_queue_install_readers(struct swap_queue_reader __percpu *readers,
+				       unsigned int capacity)
 {
 	int cpu;
 
 	lockdep_assert_held_write(&swapon_rwsem);
 	free_percpu(swap_queue_readers);
 	swap_queue_readers = readers;
+	swap_queue_readers_capacity = capacity;
 	if (!readers)
 		return;
 
@@ -432,7 +436,8 @@ static int swap_queue_add(struct swap_info_struct *si,
 	}
 
 	/* No ring at this priority: insert a new one at pos. */
-	if (!*readers || nr_readers <= swap_queue_len)
+	if (swap_queue_len >= swap_queue_readers_capacity &&
+	    (!*readers || nr_readers <= swap_queue_len))
 		goto failed;
 	new_queue = kmalloc_array(swap_queue_len + 1, sizeof(*swap_queue), gfp);
 	if (!new_queue)
@@ -460,8 +465,12 @@ static int swap_queue_add(struct swap_info_struct *si,
 	memalloc_noreclaim_restore(noreclaim_flag);
 	kfree(old_queue);
 
-	swap_queue_install_readers(*readers);
-	*readers = NULL;
+	if (swap_queue_len > swap_queue_readers_capacity) {
+		swap_queue_install_readers(*readers, nr_readers);
+		*readers = NULL;
+	} else {
+		swap_queue_reset_readers();
+	}
 	return 0;
 
 add_to_ring:
@@ -504,10 +513,9 @@ static void swap_queue_del(struct swap_info_struct *si)
 	}
 
 	/*
-	 * Shrinking the small topology arrays is optional. Keep reader storage
-	 * until a new priority is inserted or the queue is empty: per-CPU
-	 * allocation must not run under this writer's noreclaim scope, which
-	 * can grant backing pages reserve access.
+	 * Shrinking the small topology arrays is optional. Keep reader capacity
+	 * until the queue is empty: per-CPU allocation must not run under this
+	 * writer's noreclaim scope, which can grant backing pages reserve access.
 	 */
 	gfp = GFP_NOIO | __GFP_HIGH | __GFP_NOMEMALLOC;
 	noreclaim_flag = memalloc_noreclaim_save();
@@ -550,7 +558,7 @@ static void swap_queue_del(struct swap_info_struct *si)
 			swap_queue = NULL;
 		}
 		if (!swap_queue_len)
-			swap_queue_install_readers(NULL);
+			swap_queue_install_readers(NULL, 0);
 	}
 	spin_unlock(&swap_queue_update_lock);
 
