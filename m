Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0520342076;
	Wed, 19 Jun 2024 20:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718829071; cv=none; b=sGi3/KNmaxb36Xc/HF2Nue7xKohjInwcg7fxvd3XJ+UjR8/czYLJJ9fR61XcK/xULUsUFL9wp4oIkmL+UGCxWLfdgRmZ47JwzJLCxaGiVIKzII3/PoeVN6QiqXLwR5Qf1cKTvsIUsOsBtoSfvMEpFJwyI/inO/Uc+Q2BLUxLvD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718829071; c=relaxed/simple;
	bh=u7rX/TB4U+kCNMNoe9DkxIO2rGa9I6NzR1NwrVSRhCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BFf/Z+AufTLHQhye0OFqxbpT5rIGKPkEFc3X0KVpipfIptfbb5saf4298zYe6VyRq74sRw0pLadosnXwceyoOspTte/QHb3q0dH+Y8xzRTvo4/VwaaG4Jceqnd2SqK/UeFBA0uEshQdwZqnDfdcQfOH84S6kVvEeHZKU8eTWRYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nc5COZoR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nc5COZoR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD39AC2BBFC;
	Wed, 19 Jun 2024 20:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718829070;
	bh=u7rX/TB4U+kCNMNoe9DkxIO2rGa9I6NzR1NwrVSRhCI=;
	h=From:To:Cc:Subject:Date:From;
	b=Nc5COZoRDiejQQzwO/HzSuKgLcx9f5o7CQYrgEbXp5xYlZwII5CbtCrmfp+dGR8pg
	 3/v1c5tpufqGZzlejWVsvFghbPxQbFj0cmDBs4myQmNYY/vZJmgju/Mgy62qsmp2jz
	 aVDJWhKPhAVeBHtqSYGDxH8nK8sey1qo6+hq5EwTT9yEWdPTgkvF+J7Y365vyEKmBN
	 On5mGCF11XNo6cAlIw/lAK9caacOYi97JdZUGIN/BOQ41D5CvCp/96FBHutHh+kh5m
	 vpmN2n4xF4KH2fiI1yu/mpQm3fElBA3EJTlbuFTIU1m3gsjpUigpDcZwfqQqhak56/
	 utbo9NNV/ydLw==
From: Kees Cook <kees@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fortify: Do not special-case 0-sized destinations
Date: Wed, 19 Jun 2024 13:31:05 -0700
Message-Id: <20240619203105.work.747-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2377; i=kees@kernel.org; h=from:subject:message-id; bh=u7rX/TB4U+kCNMNoe9DkxIO2rGa9I6NzR1NwrVSRhCI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmc0AJQkmpvpcd5b3UgWkyXO+RDMr5U+4eqezxt fgcLjpG6MSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZnNACQAKCRCJcvTf3G3A JtMqD/9q2Cps3ZOkNn/N2QUvIFofPzk022PBaXC1oiMdSy9vQxwgFd87RKBvIhOXFcb+GEF1Oti gP9LRvmjYeddQd4XliZrk3Gp/fC4ED2LT7gnlZFRb6yB48t0Nj3UrZ+tl4aEG4bOmjR1rRRgTbs d1zNdBNdheaADvGJO0Raxeiw7mrBt2WuQveucSAFMnxeuj7mIM/RiaitH39Iyg/3jbyST4oMeuz zDyR4/Z8RirFAWn2olYn8zCm56vggiZ+hT5GgdkOK3nApwJX77fdeZHSBMZAApbDPV2mOlv2nZ4 uEnWykJvha83rtFqCj/r/aaqNZqT1yLokTqKDIJh51bzbbYOHLKTQ4PopP1j2JROvM0p0UDKikm Y6XFmYq3/38TBXPfQRqrVaoYVJpq73kTGN63MSCZ/FPgpfMOyj6EiQj0DcMoW+CT15DN+7VVx4U 0FXdPqg2lNYeM0t4UvLtNq5X6kxrq3oI6UqxW9WMCMWX6kP4zAZD+PvsD7p7RIF0mvr8S/WNROZ VCNkjgA0vCHKRkU9qLskTf/Dzm+BWUQbuKoTAVVT/DNm5LaJ8m2JZVq8FyKEVDnPZ8LlmHIQ1Ku ZwpRyaXugXO83VuHUJpuuGkf3J1FpL+NBB0begSylRmYjUT71C+6Jtq4qCGyhnceFb83Ho0pmHC 2mzNNALJsoC+E
 rA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

All fake flexible arrays should have been removed now, so remove the
special casing that was avoiding checking them. If a destination claims
to be 0 sized, believe it. This is especially important for cases where
__counted_by is in use and may have a 0 element count.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/fortify-string.h | 8 ++------
 lib/fortify_kunit.c            | 3 +--
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 7e0f340bf363..0d99bf11d260 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -601,11 +601,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	/*
 	 * Warn when writing beyond destination field size.
 	 *
-	 * We must ignore p_size_field == 0 for existing 0-element
-	 * fake flexible arrays, until they are all converted to
-	 * proper flexible arrays.
-	 *
-	 * The implementation of __builtin_*object_size() behaves
+	 * Note the implementation of __builtin_*object_size() behaves
 	 * like sizeof() when not directly referencing a flexible
 	 * array member, which means there will be many bounds checks
 	 * that will appear at run-time, without a way for them to be
@@ -613,7 +609,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	 * is specifically the flexible array member).
 	 * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101832
 	 */
-	if (p_size_field != 0 && p_size_field != SIZE_MAX &&
+	if (p_size_field != SIZE_MAX &&
 	    p_size != p_size_field && p_size_field < size)
 		return true;
 
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index f9cc467334ce..f0c64b9e9b46 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -910,10 +910,9 @@ static void fortify_test_##memfunc(struct kunit *test)		\
 	memfunc(zero.buf, srcB, 0 + unconst);			\
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);	\
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);	\
-	/* We currently explicitly ignore zero-sized dests. */	\
 	memfunc(zero.buf, srcB, 1 + unconst);			\
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);	\
-	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);	\
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);	\
 }
 __fortify_test(memcpy)
 __fortify_test(memmove)
-- 
2.34.1

