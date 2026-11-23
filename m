Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443587;
	b=AeKhNFqF5a47OMLrH1yyZc1llJb3tF0SRMGiTVXCrVVCOsUX9RTK+8079sRW4wdwlY4y
	 t1ZTrZKNw90xpW7l/QKm7F7HKHnc7Yzn9x8hjsNIfF71erZFnU7IRxldKW50tViSHYbax
	 kpKw/HGdZiIKhnONG5lxI2aYX4vVDgz7I+xxW1jKsqv6N3jqpy5OG61ssn01UdE6Oqz9L
	 6nEwl0Bwg2npRodp3SbYLSfXJ6RENx1OFQppnAS50uo3MnPXGxwxegRhWOkvllcXGMfTT
	 A7/1v8xGAUewQ6q4dr6cd32qYGc6d71mv47YnBACMq3Tb5PS2kWSWnY4YZ7QWQ2rjOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QkfpB6aPJNVrsOpvuqLtkcdraYbSYI467HC25kQ7nfA=;
	b=h3G/wn4Vahc4+rsigqjakc3UkH/Snj518TmD5cRLxJ/2vUjMk0I5fgOpHYIrREQFMzv+
	 3GGBE2HNe3JW/U2hq3TqEAve/BHPYCxcTckkZYZp8UeVS8p/8l/VJ18s8oePJ4/FYYAOz
	 w58oOk+yY9r45kh4fsqIkTAsiEj0RUAF4Q+h9fTHSKo214rQdl2QrPB5gO4PsEqqgvxwU
	 0fLxvop4/N2k3VVCYu9NghQ3RPnSkON3Xh2iGs4Kt6o33p+tZp3ZZyAZgsE/IaibDRS3w
	 rYtMhQyFiau0pkoJJokzTEFq4AGxN6xhIiZqPa1g5G1DZwhCwsWCobZL/fI9yaCwM3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ex+6J2Q+;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC6F606A31A
	for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 14:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CC6F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ex+6J2Q+
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso7204130eec.0
        for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 06:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443586; x=1796048386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QkfpB6aPJNVrsOpvuqLtkcdraYbSYI467HC25kQ7nfA=;
        b=ex+6J2Q+kJIWVNtXyW+FJJalU8fFHwVJdnc2q1Dz5lsH+iChahTQYfnTKY/hN3spQB
         noM2EP2I8buPfvagx4GIva3BscwG0/DHRUW/a0ThRFc9JpvFyTIyqLxR8zqbMpEOcQQd
         i/dAOmYIC9HB28xKCVbewoqwFa3YwVV45J47Tp7JSBrg/aEa4etPXYP1+likJgmMqy76
         YEv2UB3UtKuuATWdj6N8qnoTXbqpzcbJYk27i873yKvVabOUzphFw2TsJCfVc5PLI9zG
         HZ+kCSQG3CRv9lxp6q8BxUkJz5ueNW6KmGtF9AV27AB36WyE+ADD6dp66faVbS8Uxf/p
         0w/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443586; x=1796048386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QkfpB6aPJNVrsOpvuqLtkcdraYbSYI467HC25kQ7nfA=;
        b=xgih5Yr3akUKWyxoyFVkMj9RHyohmKgTkPMI5Xmo5xH7YvsZH5rRhQObxtSPElzBAE
         aLQmc9rEgWHBYx3ROJpX7AmU6tJcgFh07Ml1FPm2+q8O86R042jK4EySalDJqkTWGyS/
         ngXdu7M6AO0rgG3UdRV4YW54oMNa/4Xd0WC7Sf8S4VbicYBrW4IDJKRp3REzeOJrnzXs
         zX6WTTFF6pvJhszdvGg0JxkQFEyaAHDmByrRqGhm9lRvAgEUL4K/Zhp4R9A5xj1i6hEW
         1Etb7Aq1lT4pFyAgjFyrDPAId6Xlojri7HbzfffRUF4e04PactmV8hbfA0ZoisjZWkxT
         bdaQ==
X-Forwarded-Encrypted: i=1; AL+hErH5qw1PZiGMUiSlI1yK2mJDIznjLHieQijIyRBUzcYwqSuP+OcKc3i2Zq0y3fyxjUcd3CdGyE6gyx1CaIOjAdg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+a+NGzovZpHNc6H3qx8raPcH9L1LQQYyBdB36tOgFuaUyPUE6d
	mYsWljQgOLwf8eF9dUJRuAX8rT5indb87Bd7Nycnhl6lh+QyILAgBOtO
X-Gm-Gg: AZFdTZeRp4SFffG1bwfXwlacLSutOBi9618JVX+gCnL7HNKxN8A4rsU+qPLrCp/Ekem
	dfNH79D0DyojoNvm+uRklnxivrdUFc8Jojmog8+mIESEQ3581Io+LnjNA8d4CouUtNtJKlFow4d
	hCuekYUgEeFaVRHj3/UOKIRNdncZCmIn3dJylbotvwZmWDLGfuQ0gQy2PtIB5ocey14TlKCAEyo
	gmWAaO+msQMZLhuZSd66DJcsCSeM2MI8ucDcHnlGjXF9SwEyNuCgqTz2vgSvvoUcafDhcvJr1xx
	0wcIdSSTaU18fQe6vG2OVCQu33i7X8gt1NAji7ItwKKn8+bBYzp5myzHt//ljFpJqcPkDR8IkNV
	Qt0pWkBOgISgccwpTaL7iA+iRNiTsVRrrmxxob/cV4KvCtqU4hwtHJF2GSYQuQOgwzo638XvTy4
	dRnIQWGjC/IPNZRySUZOZH+yPY6vguPeQIiPwD8o6WfkCQUvz6akOFwtdUyK2p/aoW0lOU9quGy
	yU13OCtej3NMks9r6vsBpg8IGFERwByfHdp2TI1SFo5JIfxcFwT1vT8iQbxObVfAu0fCQgplHQb
	mqP5bC3NoehQLTF0BvZp1gurUl8V0o3pQZdknLUVFCKqnnMSOYKhLbn5IRYedSPFlXV6
X-Received: by 2002:a05:693c:880b:20b0:386:b025:1e1e with SMTP id 5a478bee46e88-386b02522d2mr3390054eec.16.1795443586180;
        Mon, 23 Nov 2026 06:19:46 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aa203267sm12602179eec.0.2026.11.23.06.19.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 06:19:45 -0800 (PST)
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
Subject: [PATCH v5 16/19] mm/swap: reuse per-CPU queue readers across priority changes
Date: Mon, 23 Nov 2026 22:19:35 +0800
Message-ID: <227a1e9b7213652ee5eca947d2f1c3da88462dde.1795439990.git.lianux.mm@gmail.com>
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

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 7d932035c961..0c4452fa53ae 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -201,6 +201,8 @@ struct swap_queue_cursor {
 };
 
 static __percpu struct swap_queue_reader *swap_queue_readers;
+/* Keep the high-water capacity until the last priority ring is removed. */
+static unsigned int swap_queue_readers_capacity;
 
 static inline bool swap_device_masked(struct swap_info_struct *si)
 {
@@ -240,7 +242,7 @@ static bool swap_queue_needs_readers(int prio)
 			return false;
 	}
 
-	return true;
+	return swap_queue_len >= swap_queue_readers_capacity;
 }
 
 /*
@@ -288,13 +290,15 @@ static void swap_queue_reset_readers(void)
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
 
@@ -430,7 +434,8 @@ static int swap_queue_add(struct swap_info_struct *si,
 	}
 
 	/* No ring at this priority: insert a new one at pos. */
-	if (!*readers || nr_readers <= swap_queue_len)
+	if (swap_queue_len >= swap_queue_readers_capacity &&
+	    (!*readers || nr_readers <= swap_queue_len))
 		goto failed;
 	new_queue = kmalloc_array(swap_queue_len + 1, sizeof(*swap_queue), gfp);
 	if (!new_queue)
@@ -458,8 +463,12 @@ static int swap_queue_add(struct swap_info_struct *si,
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
@@ -502,10 +511,9 @@ static void swap_queue_del(struct swap_info_struct *si)
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
@@ -548,7 +556,7 @@ static void swap_queue_del(struct swap_info_struct *si)
 			swap_queue = NULL;
 		}
 		if (!swap_queue_len)
-			swap_queue_install_readers(NULL);
+			swap_queue_install_readers(NULL, 0);
 	}
 	spin_unlock(&swap_queue_update_lock);
 
