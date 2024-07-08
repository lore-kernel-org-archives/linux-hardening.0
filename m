Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07C14C5B5;
	Mon,  8 Jul 2024 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720466321; cv=none; b=bEEoXSH7vyATM2dSYcLk3EsYw/LRGVGE+j9HJc6IvUC/HK6+XH17BQtJIR521pNmfprL2/YNER/+u+AnVZMIRcSqLpiXNne0Yw2kbs9ISkihO1d6jFprvyRc1xAC0Ea1rq0No1yMeDq7Zr2SNhThWHYNMz5mbTD6Xq+FwVTYnLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720466321; c=relaxed/simple;
	bh=fvRlIwowaF9/LBzfEGVnkRN2BeFqeZ8hAGZLXhTB0Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gq1iJv5bh3fEvEcAa66VChUf1oNnwtY84MG5AbloHKBWdjq0Rb8Xu7COwWz7cHeXRfR8/a/pDnPMhr0GVrn/x7uUjxGnZ8NdyNfaIwQsHIvC7AHE5nBAMw5Ys1xActShYn8vpvNGR1aY8LYjEBBZJsN1p/NkrlM2wpSoIkRIkJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfAubh4v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfAubh4v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAEDC4AF17;
	Mon,  8 Jul 2024 19:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720466321;
	bh=fvRlIwowaF9/LBzfEGVnkRN2BeFqeZ8hAGZLXhTB0Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gfAubh4vdFbZlhDJOkduJGAqtq4TRKB8ZZxx7chKka/17RGOfga2LdRJPnigStdgh
	 aqSD1mvdHlQqjsXnKH0lMRKL1O1re3Jhnol8lNR9YLyzZVXbE9NQ5kLZ4X37DQh8F/
	 KosUIK5QKo63xy9213Pq1FOZ+SC+Qfs3Sy/iuSNU6Z8PopCvsGEpAtAH1WR0a2BLpF
	 lEbEReGdJ2aai8mgey5MSf1XlyKHHsduE7kPsOj72eUSM3y7eHfzeyH9IYY0KFrlIJ
	 rIdfaUlYSw+WMXmtO5GNJ6LQ+NCAygm3NHCFbKChlkh+papvqh+3tTjcKNHL4NfAkr
	 1o0EbCNw6xKYQ==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Marco Elver <elver@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC][PATCH 4/4] pstore: Replace classic kmalloc code pattern with typed argument
Date: Mon,  8 Jul 2024 12:18:38 -0700
Message-Id: <20240708191840.335463-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708190924.work.846-kees@kernel.org>
References: <20240708190924.work.846-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3200; i=kees@kernel.org; h=from:subject; bh=fvRlIwowaF9/LBzfEGVnkRN2BeFqeZ8hAGZLXhTB0Rk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmjDuOIMJSOfezmI7F7aWAtc3Jd3uJ1pxI/qwE2 X/jjfpapACJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZow7jgAKCRCJcvTf3G3A Ju/pD/9jE2sUjkU0LDQMn2KwGX2yZsbWJ5NO7+g3aGS+vs2V//QT/bnGfFzfd1De6giGp0M2kHm P0ODwqfZv69aT5o0x9p7Hb393ZH1Bbq/3ATW79p6VHI85Blp6qLckXX9HkdcdAMCBsQo2Xuj7Wd IX634YZ1O8v+G8u7LZvqYndpeVOeCa9oPw9S5XCCHQ0xv+ViQ8cip0Bk/ctV/zeEyHX0eWjGtJF 8dcGd2uslfUqdLlyHhJFrHJxQx1MsSOKWygJ5m0lnD25WD5V7jmoRJBW6O05+R1rrRnXDYbSKPm rdnkT0OnLjJQQq9sLSBIlqYDGE4Df9H9H2L+atoDC/NXyB0T7ovyJUomc1xqB8SwuV0MpGF+YYv Z5U8TN5M4I0yojNTfsQXnLl3xNbIKvL2/3YWgUIBgNKiAMF+PW7OhsAOf7DffaT/Rrt2lEPCkRN R3mwvksK9PqYinrloTlRfVGth1VEUmAwk1HJP7AsLvierItqfSxtTMjFQOipLcrZOJM2fZ8KXQH oQS0dWvgNmyT70TKWTtW4mevrcJg7FBIinAI4QUch3X/b8ZrnBTlTVaNwHLjZusj/a/2VU+TjY+ dy6GwLfOgm71EQqo+Pt/X9+FaWC2Q6mNvKmpnxFYR6DvBelFg+qFu3/7iz7wLW4yyXq58WazK1N 26/45pC7RBdRDmQ==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Using a short Coccinelle script, it is possible to replace the classic
kmalloc code patterns with the typed information:

@alloc@
type TYPE;
TYPE *P;
expression GFP;
identifier ALLOC =~ "k[mz]alloc";
@@

	P = ALLOC(
-		\(sizeof(*P)\|sizeof(TYPE)\), GFP)
+		P, GFP)

Show this just for kmalloc/kzalloc usage in fs/pstore as an example.

Doing this for all allocator calls in the kernel touches much more:

 11941 files changed, 22459 insertions(+), 22345 deletions(-)

And obviously requires some more wrappers for kv*alloc, devm_*alloc,
etc.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Tony Luck <tony.luck@intel.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-hardening@vger.kernel.org
---
 fs/pstore/blk.c      | 2 +-
 fs/pstore/platform.c | 2 +-
 fs/pstore/ram.c      | 3 +--
 fs/pstore/ram_core.c | 2 +-
 fs/pstore/zone.c     | 2 +-
 5 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index de8cf5d75f34..7bb9cacb380f 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -297,7 +297,7 @@ static int __init __best_effort_init(void)
 		return -EINVAL;
 	}
 
-	best_effort_dev = kzalloc(sizeof(*best_effort_dev), GFP_KERNEL);
+	best_effort_dev = kzalloc(best_effort_dev, GFP_KERNEL);
 	if (!best_effort_dev)
 		return -ENOMEM;
 
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 03425928d2fb..4e527c3ea530 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -682,7 +682,7 @@ void pstore_get_backend_records(struct pstore_info *psi,
 		struct pstore_record *record;
 		int rc;
 
-		record = kzalloc(sizeof(*record), GFP_KERNEL);
+		record = kzalloc(record, GFP_KERNEL);
 		if (!record) {
 			pr_err("out of memory creating record\n");
 			break;
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index b1a455f42e93..a0665a98b135 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -228,8 +228,7 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 			 */
 			struct persistent_ram_zone *tmp_prz, *prz_next;
 
-			tmp_prz = kzalloc(sizeof(struct persistent_ram_zone),
-					  GFP_KERNEL);
+			tmp_prz = kzalloc(tmp_prz, GFP_KERNEL);
 			if (!tmp_prz)
 				return -ENOMEM;
 			prz = tmp_prz;
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index f1848cdd6d34..01ddf1be6c3a 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -588,7 +588,7 @@ struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
 	struct persistent_ram_zone *prz;
 	int ret = -ENOMEM;
 
-	prz = kzalloc(sizeof(struct persistent_ram_zone), GFP_KERNEL);
+	prz = kzalloc(prz, GFP_KERNEL);
 	if (!prz) {
 		pr_err("failed to allocate persistent ram zone\n");
 		goto err;
diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 694db616663f..8df890bb4db9 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -1165,7 +1165,7 @@ static struct pstore_zone *psz_init_zone(enum pstore_type_id type,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	zone = kzalloc(sizeof(struct pstore_zone), GFP_KERNEL);
+	zone = kzalloc(zone, GFP_KERNEL);
 	if (!zone)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.34.1

