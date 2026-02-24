Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014863624BF;
	Tue, 24 Feb 2026 23:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771975494; cv=none; b=FXqwV8jMZciqZmtU6PfQt8r+r/fFifsGX3Y7h0i455HiKxbgz3ibh0JoCapRVxLE9kDXvB6+KlO6cRUF/Ri9C31DFso9OsCBQbjq9yUXxnFIRRxTSDAX5TXuCHhViQHBCgsPdbyTBvE/2TblNiUcI/H+nLZZCqpLBJEpJwiNjew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771975494; c=relaxed/simple;
	bh=Zb5/X17aJ72rdh5HOLDMEtXv+izvsrKiff1u08L/ddY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G4M7yhbdAyl+NrXWJX2st3K5a2CgWfKfBhd4NGLIT+Rr7eLb/amsVQ2AsTjq2CMMvMPh2jjydhjyXCZ72w0W+79DqaM4Zvbp/BfIUCq78+2UiVStG5F7YHXdyHHe6zRDhgtd8asGhmD3XG3gmhgHHM6s1aRPHKHRj52/WSMDS+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpbVm1mg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpbVm1mg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA80EC19423;
	Tue, 24 Feb 2026 23:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771975493;
	bh=Zb5/X17aJ72rdh5HOLDMEtXv+izvsrKiff1u08L/ddY=;
	h=From:To:Cc:Subject:Date:From;
	b=lpbVm1mgrYMkInTriIaor41Z39nlkG70uJ5rZV/KgVDrzz9uAmBQvTlToz2X6ztK7
	 Q1jEkq/w4x1c04UZPi06HIT/Pxlb3GK28iMY+LBBBMc6TblxcunexTtpaaCzKfwTQ6
	 ULLragJjNrnvmmNC8rdDPX0fWKb0uK4D5C/A3kXRwSYBat2og7sTnKYyo4NmmSMF53
	 dn7gjagD9FFL25RNuvJ+vhs7s0uziNUR3IpW3GZiw6Bw9Gpi4u5fIN6JnCBFGvKFLc
	 6UQa6xRLoYgnPQHBZNFpWEXftot93WY/ZpDqfKUIy4v3aRXX0LbrnfY4qTLWBXnVsU
	 SwvM+BSOSYFfA==
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] overflow: Make sure size helpers are always inlined
Date: Tue, 24 Feb 2026 15:24:52 -0800
Message-Id: <20260224232451.work.614-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2366; i=kees@kernel.org; h=from:subject:message-id; bh=Zb5/X17aJ72rdh5HOLDMEtXv+izvsrKiff1u08L/ddY=; b=owGbwMvMwCVmps19z/KJym7G02pJDJnzjF1OlXq075PZH9uadoL7+N6zvJOuaoo+Ldkh6aMhv Knt0QqpjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgInccWRkOPEl1cZ/pv+Zo29f 2VuL+nO7z6r43lbYvCozsUzE8PXSs4wMvWvd9uSZnLrwf6OXct3tE6dYHfgPLD36U6xhzV42GQc fVgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

With kmalloc_obj() performing implicit size calculations, the embedded
size_mul() calls, while marked inline, were not always being inlined.
I noticed a couple places where allocations were making a call out for
things that would otherwise be compile-time calculated. Force the
compilers to always inline these calculations.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: <linux-hardening@vger.kernel.org>
---
 include/linux/overflow.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index eddd987a8513..a8cb6319b4fb 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -42,7 +42,7 @@
  * both the type-agnostic benefits of the macros while also being able to
  * enforce that the return value is, in fact, checked.
  */
-static inline bool __must_check __must_check_overflow(bool overflow)
+static __always_inline bool __must_check __must_check_overflow(bool overflow)
 {
 	return unlikely(overflow);
 }
@@ -327,7 +327,7 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * with any overflow causing the return value to be SIZE_MAX. The
  * lvalue must be size_t to avoid implicit type conversion.
  */
-static inline size_t __must_check size_mul(size_t factor1, size_t factor2)
+static __always_inline size_t __must_check size_mul(size_t factor1, size_t factor2)
 {
 	size_t bytes;
 
@@ -346,7 +346,7 @@ static inline size_t __must_check size_mul(size_t factor1, size_t factor2)
  * with any overflow causing the return value to be SIZE_MAX. The
  * lvalue must be size_t to avoid implicit type conversion.
  */
-static inline size_t __must_check size_add(size_t addend1, size_t addend2)
+static __always_inline size_t __must_check size_add(size_t addend1, size_t addend2)
 {
 	size_t bytes;
 
@@ -367,7 +367,7 @@ static inline size_t __must_check size_add(size_t addend1, size_t addend2)
  * argument may be SIZE_MAX (or the result with be forced to SIZE_MAX).
  * The lvalue must be size_t to avoid implicit type conversion.
  */
-static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
+static __always_inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 {
 	size_t bytes;
 
-- 
2.34.1

