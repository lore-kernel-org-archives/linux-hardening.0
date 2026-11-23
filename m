Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443403;
	b=hqpUgc1zttOXSmazBnoLY3/G42fuwOUG5antHKYU/xAqvvUx9M9z6I+qsj23J7eAX0lT
	 jfodaFeFrRyq9UiyBCyK9WEhugSYwe2oelJBv5WsPRQfmRNcN0f8egIj1e/35Bzd6Q6r0
	 X8ypPfGF3gCfdL3enRBBIZhDGzIYpg1ZiR6ebZJslZqJrolRiaOXWNZTSven0xFPoRAVk
	 XchP5wxkovFtBbPHJa7wFiEgTVIMyt/NaUxeA0jNzdF6XongZ0UsfaUs1CAXqbHPwrVdo
	 hFApgGaa8VbpKWrXpf5Dm8KschDvTLdGxHizANfwjgPFQusFD8TWxbUbfg4pHp+NCvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6MB4ylRBWhpP977K7CxD8OdJrbMU3UJuzSG35QAoRMs=;
	b=14+IR+hKha2El4eAEx/XtWtWEFJni5hKJD/BsTSWch5Zud1oEz6vkASdm0baDo0o6jC3
	 QpTh825wnGfq01EEcBFa36AAM9sBoAOBy0LzgOw65zFAswBZgP+1+PG7Lc09OrkSeTiyy
	 MuH/2xs92qQB9TdTIzyeQ5f/Ehh2oVctslvtntv5Pmw22t8sFq9o6zb1HA7xq341NZ1Ok
	 X6VIkfb/5Z9qisYLp55/ghW049jnKF+hpAsxq40yIP24qo4RSbIEvEWSGNtmiUOUMRctl
	 6kAlxB10VBb0MYl2XAjEum4fkBUVAM1p4AcUIg7rTRtm9OY4vXSmGFGGNFQQbzBWYnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WcNvIfBu;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6D4606A31E
	for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 14:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B6D4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WcNvIfBu
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1ae58d17cd9so3119644c88.1
        for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 06:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443402; x=1796048202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6MB4ylRBWhpP977K7CxD8OdJrbMU3UJuzSG35QAoRMs=;
        b=WcNvIfBuosWOK4cGqzEjxYWmgvMqRbD/6GngIbnWgsHxnzAsrHyWPslnSHSkLwPk6t
         KhwakfLlqu+5UggWBnom/2zhfHmbAswOVWFMjtr8Guer0caLq1wf1p7w8K95QkaE/MCX
         lgXy8eTvtb4YsQMzed32QE41EnQC88iNvLQmgmXt9Gpqo3dmjFfrp5ka7SJ0F4gxjANx
         l433z2r0zO8Vkyz5q8qWpZeiL97K/ZqdSZrUvkzHQsry7IfCYbpKeL4/KLCWtUaR93/c
         6YvcBGH/KMMwpOJGmoZKbUekq4eo5Xgs6+5PZukMRIu5PQ4fir3Ka8D/6QBqlG7HNy98
         nVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443402; x=1796048202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6MB4ylRBWhpP977K7CxD8OdJrbMU3UJuzSG35QAoRMs=;
        b=hJWolZn9OA6i+uO5Cscb4mdiWqGa/7/B2LMe1HsxZebjIYXtHu9oQ6ptpnpW6b6X+Q
         3cJ3Y8euNtYMR/vGit5QA/NxoyCUZVLus6zmBV7zXcVU7FFle+y30Kk5oqLVZQI8c21w
         8suTdIsr8aZP2gEwUqU4glQr7/zZd0488SatvV2zLS4y7gjvu5P6dPT5be31mN18evJv
         EIF8eLgPuA7WubXrFJLV+oiTOQbW0Bzxmld6ghSWGvyzcVp6+lL7bQIz8u9FDFD7e6s1
         GEPoSDftE+rv4FW7TyqWXvy/y0i44Vib9m3x2pZrQqdFXcNKiVBz03BEQyYT/GrpXeqS
         wt9g==
X-Forwarded-Encrypted: i=1; AL+hErF6N7N79Mf3QBFi49cvcJESZL4mJQOaQhntzZhJlZra/TcLMKHaOXOv8wUD+Fik3R9dFC4Ytz1MjtbevfOgRKc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uQ6ONK5KHDHRxvHg4Xw9+Z18ibxdoGNNcZi+RFS/3AE30Srer
	nbSMFrZup8TOlilJvh2zqyR5V9DvYnMlIU8lx7o90lvQ5vAeUATYyGtg
X-Gm-Gg: AZFdTZeI/gXe8aRexOe5wpX40uqFmvfjqzIrgoTVwzRuTkbAej0e/r++tVjks9bkaXm
	PMIQcmznmZ1g6fPlWeJpATYTw669lbmylXJLM6QtB2f/6M0/tOE9AXqMaFZolWNF+5S1r3vw4yL
	MleALaF1xv2Rv5LGB+nh6t5EtoMiOO4xycwpzbRDaSC2QFA+4cb13B0V6LgWt16AS3n8JHcTaB1
	xEYKEebbJVF7tQK9RPAbG4G0521bI9Sf3/h+QnMNgvyNE7wuybPyBpy+oYCbE09JEKnuP2CEL/Z
	31ZdztD8yO1ceHAcem5rnQ+xmoBXe1TAUvOVg4Nf8BaJ3Si8Wl0xJZIotkZQdBW/43xssvGEj/4
	2IrobuIx5bhglatVpFHoJ/lgewVwKTeatAg5bTdB0lmO/udSvY0lbEtImf6wri/wx84nwb0yWso
	w1x9OIszpRKTB6Gi9RtD9mo7HoL1WxSs8C/fDH5v2rV4LsWxN4RHCHGwWYXuLfS/mjbAu5zGSWJ
	6y1pYFNlioMUHjF+3DYbbmDBemG0BdsRqsIOqKBY1USCzI+1zFXdQ8RCo6hrowsPMe1tU8/ktNU
	v49ohEZl0vGsqvHFca3wfRiePgdGbJJbPPg0LCdqSoJGYLV3M0xgUntxJBWhTC5TknKR9Hoa9sY
	=
X-Received: by 2002:a05:701b:240c:b0:1b5:7111:5c4a with SMTP id a92af1059eb24-1b571115c94mr3404520c88.26.1795443401226;
        Mon, 23 Nov 2026 06:16:41 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55681301asm28642799c88.8.2026.11.23.06.16.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 06:16:40 -0800 (PST)
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
Subject: [PATCH v5 04/19] mm/swap: introduce swap device iteration helper
Date: Mon, 23 Nov 2026 22:16:31 +0800
Message-ID: <be6ef058f4a6babd3562270daa5b61c4ff9a6a50.1795439990.git.lianux.mm@gmail.com>
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

From: Kairui Song <kasong@tencent.com>

Separate iteration over allocated swap_info descriptors from iteration
over writable devices. Hibernation lookups require SWP_USED and
SWP_WRITEOK under swap_lock. Take a single snapshot for each flag
test, since unrelated bits in the same word can change during setup.

drain_mmlist() only needs the atomic usage count; walk every
descriptor without loading flags there. In si_swapinfo(), count
usage only for descriptors that are in use but no longer writable.

Move the live-reference warning from __swap_type_to_info() into
__swap_entry_to_info(). The iterator must inspect descriptors before
applying its flag filter, including descriptors whose device reference
is dead; entry-based lookup retains the warning.

Signed-off-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swap.h     | 12 ++++----
 mm/swapfile.c | 77 ++++++++++++++++++++++++++++++++-------------------
 2 files changed, 54 insertions(+), 35 deletions(-)

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
index f22197a6286c..56b75770d320 100644
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
+		if (flag && (READ_ONCE(si->flags) & flag) != flag)
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
+ * for_each_swap_info - iterate over all allocated swap descriptors
+ * @si: the iterator
+ *
+ * Context: The caller must hold swap_lock. The lock may be dropped during
+ * the loop body but must be re-acquired before the next iteration.
+ */
+#define for_each_swap_info(si) __for_each_swap(si, 0)
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
+	for_each_swap_info(si) {
+		if (swap_usage_in_pages(si))
 			return;
+	}
+
 	spin_lock(&mmlist_lock);
 	list_for_each_safe(p, next, &init_mm.mmlist)
 		list_del_init(p);
@@ -3997,14 +4016,14 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 
 void si_swapinfo(struct sysinfo *val)
 {
-	unsigned int type;
+	struct swap_info_struct *si;
 	unsigned long nr_to_be_unused = 0;
 
 	spin_lock(&swap_lock);
-	for (type = 0; type < nr_swapfiles; type++) {
-		struct swap_info_struct *si = swap_info[type];
+	for_each_swap_info(si) {
+		unsigned long flags = READ_ONCE(si->flags);
 
-		if ((si->flags & SWP_USED) && !(si->flags & SWP_WRITEOK))
+		if ((flags & (SWP_USED | SWP_WRITEOK)) == SWP_USED)
 			nr_to_be_unused += swap_usage_in_pages(si);
 	}
 	val->freeswap = atomic_long_read(&nr_swap_pages) + nr_to_be_unused;
