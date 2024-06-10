Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCD915A8;
	Mon, 10 Jun 2024 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718043787; cv=none; b=KPQLgAnnu/QSE7wHxyEM7KUVenEabnxaFeQAq07V47bUUPemeay4jj77DceQTP9B6IrNkGzxjiXwLzxFl3rTqZg0I3XfFC2zZe1YJdar7WKYP0rtb9RjcLVF671vOlOmLQGRnkjMGdTUgjGK+nYdXPEuaQ4sryFZe/zOUSKe4VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718043787; c=relaxed/simple;
	bh=ZmGORh3YH31z44Y7L0WKiR5FiqY0Z4/CwtRge2E5Y5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C+Ho4E+hApsGkrT2N6qLlqU3mRIdU7mEg0B2LH6H2mmd98t5yDr205eJ6od8KMcnhXzSbMB/4CsfFeYZ8sPnxDJLKItF3MPHV/fsJBpsA8ZO7xfRzjGg7WNuWtsikLUdVoCnEoy7xW5dMOKeIf3P0dD9Bpugv4u9ch4IC6CitpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azEAP7kE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azEAP7kE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18C8C2BBFC;
	Mon, 10 Jun 2024 18:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718043786;
	bh=ZmGORh3YH31z44Y7L0WKiR5FiqY0Z4/CwtRge2E5Y5o=;
	h=From:To:Cc:Subject:Date:From;
	b=azEAP7kEdV4EPjyM1Eb8MR34ixof/jQRnrDQIQDdmxAqDUbRF4lrnS0rfVYhQAPSH
	 BShHEb1DpKYa9+95/AqjShBRp1GBRHsjbR+KKsMxN/kzbWCiU0Uqp9F9IauGaRgW2H
	 nM8SWpqtZcZ+94dVzY/DwrghI5IyX4brkXFCsJMaCVLxGrzU1pAKZVNtamHHl7hzXy
	 zXKhsfuQNWWeajhN4nhPhVfHWBTUMTnem5Xj7tPHbR9+qYiE8oSeH1dq2J/aKUEIBS
	 WYnlW1hl4xc/SbB1aFqsmUO81cFoswrk5M2sW6gNmjcr1+5jrKKlt4C/Ms2M+ccizx
	 EYN1npZXYD2bQ==
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Christian Schrefl <chrisi.schrefl@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kunit/overflow: Adjust for __counted_by with DEFINE_RAW_FLEX()
Date: Mon, 10 Jun 2024 11:23:05 -0700
Message-Id: <20240610182301.work.272-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2061; i=kees@kernel.org; h=from:subject:message-id; bh=ZmGORh3YH31z44Y7L0WKiR5FiqY0Z4/CwtRge2E5Y5o=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmZ0SJEXNzrxzUXK3rna8OKkjX4K7UeFX67/tkt CTizk4cny+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZmdEiQAKCRCJcvTf3G3A Jk17D/9s1yvB8gdhwo2E/7nscHd1UBnI2uulNIIb5cllLJ+K65OSG2ePvmUn4zNDIVLH+++1OUD Q+7QQ3GZ6FaPoyckTN3FeWTNVotYdY/lfA3LOe3ENwXFxEE2EeXJoEvb2y5Uy8izUHdSFAeNdsq LH26kQZ4yC8xI3sAAlskRRJFi79QnFtgcoAuZYDm4zAUs1v/5VEXga0K+Y9ZuPkPuLi5XL3UNsE R9Zx0JLy7Q+XHKGo4D0oqrlMkO1PdHG110KPJFMmnvFyTuG7m2QSTkcgfZKWFfDiyXhwnXsULtx jMjoEeniqO+x8EEJn/k/oFRfhcnipkDQnXKPGJmhe/HwssMR9iJAftp3WxBUCMtkaykBaSHnrDD QWhXB9VOFUntstNXXOqG8/FdagXzkQqd/J9SxdFRyxuqYaKvWxAB6uARTitZM8ze4+O4uQ6jQk3 u/Cmwu69JlRjQ41Ii+LnG3Q3nu/H3b4suD7U7ihNIjOlVFr8xURY+gBQGyn+FfHdjzZYys7NXkp PKx6YWRPgU21Iqfc+1tHaw9codgFQkuQ+EDOe3uNoZHiz+bRWEBSSh61VP0nSxhZX0HzsoYX9NM ldigMk+Htv2wqxnCPXeNFlMFYZvdqMN0A9L3kaD5TCCuy4hwRbgwcflRlQLRB8Ukb620hQ4W9zd C4nBNzouEhpkg
 /g==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a flexible array structure has a __counted_by annotation, its use
with DEFINE_RAW_FLEX() will result in the count being zero-initialized.
This is expected since one doesn't want to use RAW with a counted_by
struct. Adjust the tests to check for the condition and for compiler
support.

Reported-by: Christian Schrefl <chrisi.schrefl@gmail.com>
Closes: https://lore.kernel.org/all/0bfc6b38-8bc5-4971-b6fb-dc642a73fbfe@gmail.com/
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
---
 lib/overflow_kunit.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 4ef31b0bb74d..d305b0c054bb 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -1178,14 +1178,28 @@ struct foo {
 	s16 array[] __counted_by(counter);
 };
 
+struct bar {
+	int a;
+	u32 counter;
+	s16 array[];
+};
+
 static void DEFINE_FLEX_test(struct kunit *test)
 {
-	DEFINE_RAW_FLEX(struct foo, two, array, 2);
+	/* Using _RAW_ on a __counted_by struct will initialize "counter" to zero */
+	DEFINE_RAW_FLEX(struct foo, two_but_zero, array, 2);
+#if __has_attribute(__counted_by__)
+	int expected_raw_size = sizeof(struct foo);
+#else
+	int expected_raw_size = sizeof(struct foo) + 2 * sizeof(s16);
+#endif
+	/* Without annotation, it will always be on-stack size. */
+	DEFINE_RAW_FLEX(struct bar, two, array, 2);
 	DEFINE_FLEX(struct foo, eight, array, counter, 8);
 	DEFINE_FLEX(struct foo, empty, array, counter, 0);
 
-	KUNIT_EXPECT_EQ(test, __struct_size(two),
-			sizeof(struct foo) + sizeof(s16) + sizeof(s16));
+	KUNIT_EXPECT_EQ(test, __struct_size(two_but_zero), expected_raw_size);
+	KUNIT_EXPECT_EQ(test, __struct_size(two), sizeof(struct bar) + 2 * sizeof(s16));
 	KUNIT_EXPECT_EQ(test, __struct_size(eight), 24);
 	KUNIT_EXPECT_EQ(test, __struct_size(empty), sizeof(struct foo));
 }
-- 
2.34.1

