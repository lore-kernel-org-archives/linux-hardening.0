Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794667783;
	b=bEGCNN5yeZx0Of7s2dA98grIxNWY2YfhRfvVyim4hitt94j5q7jJihOL1hPTbSXpG4vo
	 5Pdla/Qbwj6+/bknrSaFycoOYEqLCgqCDc9+XUCmuqXV7WUo6V6dAzFEyjjaK/+DTSBO7
	 Y5IBLjuCY6rrwtLwvW5r3efV5dpdR+lPTIea4fUYruCO56ghtGhvk2ra+weg+iRswOHgm
	 aGU5bq7xpKvRzt0qCgRWJbbnC2cTpGYUv99kfMqo3mclXREEUDv8A4hgdFTOFVX/sbHA/
	 5M/MM24MD4K9K+ByLZYiqD9javYA/66iox2KNMIRSJZU9UMbvsa/qQ5fAH1fy9885Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794667783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/xmpeLN3tjFh9PjQPZhkSHJLU+h0hkIrqBfSHYgvILA=;
	b=fsH4uNbos5jJwbUEY7jsbW+JYJrsRImrf7uZGIi0CM6aQm24s0oqYHRfYA8C/CRctuG1
	 A/AdhFQjbLtijBXtePnHGX3nFIN/xSQVZt1yG2tKp8/yD5zmBYxBvWvvqVtJ8XRUjh1UO
	 XbSbwRF6YF7t7KOTW2iLrZ3k5Bxy3JxzNmx9SXDixpKf8YnhrEcJHHjznGtzJB8utFTNF
	 BJKdIzSy5ftFgWYPPd8Cm4KksGxtlGD/UVz2c46r7MJE6BEva2O/kbuKju//5Ro7vK1bk
	 49YAGGGgBLFiCa9Fj/148MKy8bfPLvTGHasxywjfDjIGxhcdkcCI2mHYYdMRmIhiP8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xvSrzQr1;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17E5606A330
	for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 14:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E17E5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xvSrzQr1
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso1872180a91.0
        for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 06:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794667782; x=1795272582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/xmpeLN3tjFh9PjQPZhkSHJLU+h0hkIrqBfSHYgvILA=;
        b=xvSrzQr15yBbBkoCVHldwhf79lFc8WFa8qYZ9BhcIC1lSRdTaaHE9LofdyHQK5LoMS
         d6E+UdH4ZrmgOysq4v2uLVGRsUA7+0DyPeRr+s6cZlvV16+Uc15dfXrqBAiOGYsL4fjv
         PrFstX7L50odIlfYlo+MYEgLlWrVXhwsbca5mdIw1lhCXDUbMds5TECm2nlKA+Ktwfya
         DFK7SM3exSYIA8G0YHhqeCCQd1zlTYTKOjpufKquiQxoo8lsfZM3D89BTTZW3Z4PuUpG
         A5X/IRIWSQ4KjruBC/a6RE/Qrnw00rVV4vwPvTyRh9lB+gQGIN24b2JkdQrj4lCaakB2
         zi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794667782; x=1795272582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/xmpeLN3tjFh9PjQPZhkSHJLU+h0hkIrqBfSHYgvILA=;
        b=yrAcDtwkDukaUyaw29T6J6HL74ja2QxCdJOxvQmTSUeKb7XNSciW7atEzkphgILBh+
         W6Tw9lY6aOCqgmbziAgaRQiRI9ZGFNQbESoR6N4F3jZ4mdx/gz1CTGyaIdP+MJmMkydT
         4q9vs6dbKKqz0w9WF0E7TKHfOduRH1QYCmVBhXl5mXoZc4bHISmPppwoJqNryD/c+R3M
         lSqO3EpCBVXUZWRha5oZSp0ZWehpb9TDMNfqyIpqVRMarJ07r2oP5oX1OjMiO10E2YKt
         itXXrRkfSqTVgVZGK1faZowVbmny1ceLwGRBXh4Jgz7BYx8nK1+dhr8nINxMBQ1t5ZaH
         6b4g==
X-Forwarded-Encrypted: i=1; AL+hErGQ2EL6jJaPKEbSFquVOKD3j39aVnGTISQtjqFOWYcqV4i5QPctNvCWMrmeZgOaSSnvN9SJJzQwgvuE5KDdtgo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/FcsuYyo313SEs4ToPnz0IRVMboCCv2aoVPSo1BAR7WLPSQeVd
	TNyh/Dl/nnEymRgkt/ncoiXPdTl3FZF//zzK0a5isHUu8A18wRALiuky
X-Gm-Gg: AYBFou0We2cSCEahOyzNA7tutF/QsrtEzaDTwFdZ4EBvNtLhWy7RmwGSJMnCfAFoz0U
	XRCS2J79myO7qM4RFtsFfmMV6OIMqkQgNf73jt9kRDT/Q+DFegQgVP93AGsF1kbnHv9VqP/gOGG
	dzQCDHs4Uq1FJMYdtFD6WK1reOiX7YYCyGL6hAUavk9I6xemJMpOq6s09Fm6XLgD4b3q5FjnH9J
	zN5KjrfqJGDeokBVQ2tb4Ccj3JP4FgDnxdcdnluk5K4Vf6CCQvi9os5D1prrr9qzkcWYhv6Gmff
	XAz77PThSas/8E9U25fct9qJlU8LnxZat5ENovbPbFK1W8/EO4+8lfi4jtII0VxGxCSNKdeJS6F
	73K5rw9TPXt5cTqR5QL8d+LO+9Tbeae03/daI0q/OlNmWzeEEzr9dWkU7Cik32o5tOjnktGSmkk
	gp5bepFKTsg8CIaxmqiLMz+AsYNJoHJAGbLjzpteq3xh8nhRhv0hksilm96FrfMTxrXeqFrswfx
	KiAYZi/EYm/Or1EGb9imMj2yWP5fkN/r+1T1N0lhPKD4rbWcjBqiPvxgYNpwKA8TpC3Z3sqeQfS
	hkW5HWb0nf6j7BEa+HASMxVOsjYPr+4nlHBx+IbKQsLH3wpxkNB21UKg+gUao6yMUcb+rUUrSUm
	pMDp7294SN5sPGw==
X-Received: by 2002:a17:90b:17cf:b0:3a8:9d4b:2788 with SMTP id 98e67ed59e1d1-3b197d30295mr7107823a91.12.1794667782210;
        Sat, 14 Nov 2026 06:49:42 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18c800esm2419014a12.29.2026.11.14.06.49.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 06:49:41 -0800 (PST)
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
Subject: [RFC PATCH v4 04/18] mm/swap: introduce swap device iteration helper
Date: Sat, 14 Nov 2026 22:49:31 +0800
Message-ID: <8e1766da4ddbf22e36f8689360dfea64377269fd.1794666741.git.lianux.mm@gmail.com>
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

From: Kairui Song <kasong@tencent.com>

Several swap users scan the swap_info array to find in-use or writable
devices. Add for_each_swap() and for_each_avail_swap() with SWP_USED and
SWP_USED | SWP_WRITEOK filtering, and use them for hibernation lookups,
drain_mmlist() and si_swapinfo(). Keep the swap_lock requirement for
iteration.

Move the live-reference warning from __swap_type_to_info() into
__swap_entry_to_info(). The iterator must inspect descriptors before
applying its flag filter, including descriptors whose device reference
is dead; entry-based lookup retains the warning.

Signed-off-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swap.h     | 12 ++++----
 mm/swapfile.c | 77 +++++++++++++++++++++++++++++++--------------------
 2 files changed, 53 insertions(+), 36 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index d488a69c2809..70fd3ab655ff 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -108,16 +108,16 @@ static inline unsigned int swp_cluster_offset(swp_entry_t entry)
  */
 static inline struct swap_info_struct *__swap_type_to_info(int type)
 {
-	struct swap_info_struct *si;
-
-	si = READ_ONCE(swap_info[type]); /* rcu_dereference() */
-	VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
-	return si;
+	return READ_ONCE(swap_info[type]); /* rcu_dereference() */
 }
 
 static inline struct swap_info_struct *__swap_entry_to_info(swp_entry_t entry)
 {
-	return __swap_type_to_info(swp_type(entry));
+	struct swap_info_struct *si;
+
+	si = __swap_type_to_info(swp_type(entry)); /* rcu_dereference() */
+	VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
+	return si;
 }
 
 static inline struct swap_cluster_info *__swap_offset_to_cluster(
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6485c8020d3a..1669a46515cd 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -106,6 +106,34 @@ static DEFINE_SPINLOCK(swap_avail_lock);
 
 struct swap_info_struct *swap_info[MAX_SWAPFILES];
 
+static inline struct swap_info_struct *__swap_iter(int *i, unsigned long flag)
+{
+	lockdep_assert_held(&swap_lock);
+	while (*i < nr_swapfiles) {
+		struct swap_info_struct *si = __swap_type_to_info(*i);
+
+		VM_WARN_ON(!si);
+		(*i)++;
+		if (flag && !((si->flags & flag) == flag))
+			continue;
+		return si;
+	}
+	return NULL;
+}
+
+#define __for_each_swap(si, flag)			\
+	for (int __i = 0; ((si) = __swap_iter(&__i, flag));)
+
+/*
+ * for_each_swap - iterate through all allocated and inuse swap devices
+ * @si: the iterator
+ *
+ * Context: The caller must hold swap_lock. The lock may be dropped during
+ * the loop body but must be re-acquired before the next iteration.
+ */
+#define for_each_swap(si) __for_each_swap(si, SWP_USED)
+#define for_each_avail_swap(si) __for_each_swap(si, SWP_USED | SWP_WRITEOK)
+
 static struct kmem_cache *swap_table_cachep;
 
 /* Protects si->swap_file for /proc/swaps usage */
@@ -2284,26 +2312,18 @@ void swap_free_hibernation_slot(swp_entry_t entry)
 
 static int __find_hibernation_swap_type(dev_t device, sector_t offset)
 {
-	int type;
-
-	lockdep_assert_held(&swap_lock);
+	struct swap_info_struct *si;
 
 	if (!device)
 		return -EINVAL;
 
-	for (type = 0; type < nr_swapfiles; type++) {
-		struct swap_info_struct *sis = swap_info[type];
-
-		if (!(sis->flags & SWP_WRITEOK))
-			continue;
-
-		if (device == sis->bdev->bd_dev) {
-			struct swap_extent *se = first_se(sis);
-
-			if (se->start_block == offset)
-				return type;
+	for_each_avail_swap(si) {
+		if (device == si->bdev->bd_dev) {
+			if (first_se(si)->start_block == offset)
+				return si->type;
 		}
 	}
+
 	return -ENODEV;
 }
 
@@ -2470,16 +2490,13 @@ int find_hibernation_swap_type(dev_t device, sector_t offset)
 
 int find_first_swap(dev_t *device)
 {
-	int type, ret = -ENODEV;
+	int ret = -ENODEV;
+	struct swap_info_struct *si;
 
 	spin_lock(&swap_lock);
-	for (type = 0; type < nr_swapfiles; type++) {
-		struct swap_info_struct *sis = swap_info[type];
-
-		if (!(sis->flags & SWP_WRITEOK))
-			continue;
-		*device = sis->bdev->bd_dev;
-		ret = type;
+	for_each_avail_swap(si) {
+		*device = si->bdev->bd_dev;
+		ret = si->type;
 		break;
 	}
 	spin_unlock(&swap_lock);
@@ -2996,12 +3013,14 @@ static int try_to_unuse(unsigned int type)
  */
 static void drain_mmlist(void)
 {
+	struct swap_info_struct *si;
 	struct list_head *p, *next;
-	unsigned int type;
 
-	for (type = 0; type < nr_swapfiles; type++)
-		if (swap_usage_in_pages(swap_info[type]))
+	for_each_swap(si) {
+		if (swap_usage_in_pages(si))
 			return;
+	}
+
 	spin_lock(&mmlist_lock);
 	list_for_each_safe(p, next, &init_mm.mmlist)
 		list_del_init(p);
@@ -3997,14 +4016,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 
 void si_swapinfo(struct sysinfo *val)
 {
-	unsigned int type;
+	struct swap_info_struct *si;
 	unsigned long nr_to_be_unused = 0;
 
 	spin_lock(&swap_lock);
-	for (type = 0; type < nr_swapfiles; type++) {
-		struct swap_info_struct *si = swap_info[type];
-
-		if ((si->flags & SWP_USED) && !(si->flags & SWP_WRITEOK))
+	for_each_swap(si) {
+		if (!(si->flags & SWP_WRITEOK))
 			nr_to_be_unused += swap_usage_in_pages(si);
 	}
 	val->freeswap = atomic_long_read(&nr_swap_pages) + nr_to_be_unused;
