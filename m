Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD402FB2;
	Sun, 17 Nov 2024 05:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731822768; cv=none; b=F0SmJzM9xRIEfCKzhqAM2C+CgbzGyKr326hJj6cdibaS9460k90isROfaiwkJHxcV8nfswddkyBe5eOK+RoeBj6gIjGtwEDLhorB7a8wFAyY16ygJQ6a1nMAGVYTDqoNJVPc7wKpIujitaM+5WHQJH4pS0+ESmPHNRUL4SOz8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731822768; c=relaxed/simple;
	bh=lJF35G3iawF9neNf2TiAhh320szRAcoG/yrAEvImh9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WyNgOrJxlyDLTPaba4gDEqWYRnThzZDD+t/p2WkkADGpXQtP1M0/03/O9QLlFbuVAhN49WDX0ZGY/+ULzM6sMqLBthwrCmC/MPc8mAx5Ku4R+/mo9KnnKCpCbGxE8HRUhQTb9nzKwhxm8mafYFSWyM2a8gXfuRn82GTrEs1w01E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqgPBW2m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqgPBW2m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BDBC4CECD;
	Sun, 17 Nov 2024 05:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731822768;
	bh=lJF35G3iawF9neNf2TiAhh320szRAcoG/yrAEvImh9A=;
	h=From:To:Cc:Subject:Date:From;
	b=ZqgPBW2mUQKQGrZWQMHb6934mIVxGzPX+/a7Kzuaman5pmp2OSbEDIb7FgOHi+yvD
	 zQdSozklXiiyqzXw7LQZ0L5fX/Tqa4XTjRFTzlT3uq0cVrmpYTVLv5Pdd/E1d8w6ZI
	 pPLSqXOFlZ1GBvP4x95j+ETDMoM04chyg3D911AOGK+cAhlGPnitf1KFESlovvqF/x
	 kclMhk/Zz8x5y6m0I5TiYCyhCjrYUQNz6wBvIWh2ln8WK6VkuNthxiW3eJK6+dwXzj
	 aguKJAWzFl8grh4Lqv+lWQoE4R8VrqHH0rciiRarfadGoVDBO6ixusUxs9D7NsKT+2
	 5/hO6rkVB9s2w==
From: Kees Cook <kees@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] mm: Handle compound pages better in __dump_page()
Date: Sat, 16 Nov 2024 21:52:44 -0800
Message-Id: <20241117055243.work.907-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2294; i=kees@kernel.org; h=from:subject:message-id; bh=lJF35G3iawF9neNf2TiAhh320szRAcoG/yrAEvImh9A=; b=owGbwMvMwCVmps19z/KJym7G02pJDOmWLavfcJ7v+JuzaofVtBfmuo+sN4iHNB68t/Xnm8lbv MuebzLa3VHKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjAR/0uMDGvPNcsunP17/sPA CRMeVFmoFsdvO3whYNaxMA8pKaf+jRcZGV6ycHHYFThYlu06KB2fsOX78ykx+68UNn1/8jHoWPg zUz4A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

GCC 15's -Warray-bounds reports:

In function 'page_fixed_fake_head',
    inlined from '_compound_head' at ../include/linux/page-flags.h:251:24,
    inlined from '__dump_page' at ../mm/debug.c:123:11:
../include/asm-generic/rwonce.h:44:26: warning: array subscript 9 is outside array bounds of 'struct page[1]' [-Warray-bounds=]

(Not noted in this warning is that the code passes through page_folio()
_Generic macro.)

It may not be that "precise" is always 1 page, so accessing "page[1]"
in either page_folio() or folio_test_large() may cause problems.
Instead, explicitly make precise 2 pages. Just open-coding page_folio()
isn't sufficient to avoid the warning[1].

Link: https://lore.kernel.org/r/ZkN0aSE9zAB5aXvM@casper.infradead.org [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 mm/debug.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index aa57d3ffd4ed..7ea396e8c143 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -123,15 +123,15 @@ static void __dump_folio(struct folio *folio, struct page *page,
 static void __dump_page(const struct page *page)
 {
 	struct folio *foliop, folio;
-	struct page precise;
+	struct page precise[2] = { };
 	unsigned long pfn = page_to_pfn(page);
 	unsigned long idx, nr_pages = 1;
 	int loops = 5;
 
 again:
-	memcpy(&precise, page, sizeof(*page));
-	foliop = page_folio(&precise);
-	if (foliop == (struct folio *)&precise) {
+	memcpy(&precise[0], page, sizeof(*page));
+	foliop = page_folio(&precise[0]);
+	if (foliop == (struct folio *)&precise[0]) {
 		idx = 0;
 		if (!folio_test_large(foliop))
 			goto dump;
@@ -150,13 +150,13 @@ static void __dump_page(const struct page *page)
 		if (loops-- > 0)
 			goto again;
 		pr_warn("page does not match folio\n");
-		precise.compound_head &= ~1UL;
-		foliop = (struct folio *)&precise;
+		precise[0].compound_head &= ~1UL;
+		foliop = (struct folio *)&precise[0];
 		idx = 0;
 	}
 
 dump:
-	__dump_folio(foliop, &precise, pfn, idx);
+	__dump_folio(foliop, &precise[0], pfn, idx);
 }
 
 void dump_page(const struct page *page, const char *reason)
-- 
2.34.1

