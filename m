Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192241537C3;
	Tue,  4 Feb 2025 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691120; cv=none; b=gr3gMx0am509tCyznY+74EMsNMoOpvsXvu5ywAYrw18u10vXJXAqc/Vh+iJHXeLIBKJ8iiQk7As8kGMvxtjZZ2uzhMYIZ4BJ/RcdLYvXbJPVzB8oQczcLKkiTZ2oqIrcTRDvcVbqlSE+qLp2N+nfEsyojmNpgYZB7Pyfsl68e6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691120; c=relaxed/simple;
	bh=x2IO+Pjykxnr/uC9RswsA7Eu+lOp2iUnyfap62xp7zE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lwERmFT0w7LZqVaMMXXYZxT8lWT7SLHHqrP75VuUS/yl5EDUgB+fcjPdwisXtUqvdGcxREzPAiwOgYcq8NpkT9ZTcMUlapb3fDl9tfur256CDvspf7x2obuyN5dGapSmZPlVJ32eluTsMAztCLkA292UCxEH8FF5AXtojQZawsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIAOpewg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIAOpewg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B712C4CEDF;
	Tue,  4 Feb 2025 17:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738691119;
	bh=x2IO+Pjykxnr/uC9RswsA7Eu+lOp2iUnyfap62xp7zE=;
	h=From:To:Cc:Subject:Date:From;
	b=YIAOpewgcNpAtB0sfW6L77Clwe9GlmQymUFSkBcZAOTbXKnQdDAWvEd8q7Pct5P/K
	 W4eo5yIF6xRWDk1YqCZNG32SaW1Lvv7L2i/XMTnHw8GWSKmbKf6ymRsRswXgSIPnQI
	 M12gsKNdTGUgxZ9lk921i5D8LZfsVmmNy/+0HQSKXySp0kcShDvgd9TKxcf+22oGye
	 N4hhZqKT6N4PZEYnCVwa8h0lZcKMWgaa4y4cy8fbY6Ufln77RzG179qgKXkV/sjj18
	 c4Zc/fp/2GrCejbnuLERAjMnqdhefgqOj2iFG3Oz6aTRQ1JqxnXOd9nPln0twy0gN4
	 nD+Y8ffnBXB7A==
From: Kees Cook <kees@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] stackinit: Keep selftest union size small on m68k
Date: Tue,  4 Feb 2025 09:45:13 -0800
Message-Id: <20250204174509.work.711-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242; i=kees@kernel.org; h=from:subject:message-id; bh=x2IO+Pjykxnr/uC9RswsA7Eu+lOp2iUnyfap62xp7zE=; b=owGbwMvMwCVmps19z/KJym7G02pJDOmLgjQXvN6W2hJ0X+bnYcG48sR2i6gqvTXd2SnReacyF h44FSHSUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJEdCgz/M1Jv1GXk/ctVPHVM NvOk0XPnSKYfXDd3qfz6Mu+/9/zSL4wMT85vP8+/cGGWTMjf5iI+ieIdUoH5IcYC33g7WivMejo 5AQ==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The stack frame on m68k is very sensitive to the size of what needs to
be stored. Like done for long string testing, reduce the size of the
large trailing struct in the union initialization testing.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/all/CAMuHMdXW8VbtOAixO7w+aDOG70aZtZ50j1Ybcr8B3eYnRUcrcA@mail.gmail.com
Fixes: e71a29db79da ("stackinit: Add union initialization to selftests")
Signed-off-by: Kees Cook <kees@kernel.org>
---
 lib/stackinit_kunit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/stackinit_kunit.c b/lib/stackinit_kunit.c
index fbe910c9c825..967b345a98fd 100644
--- a/lib/stackinit_kunit.c
+++ b/lib/stackinit_kunit.c
@@ -75,8 +75,10 @@ static bool stackinit_range_contains(char *haystack_start, size_t haystack_size,
  */
 #ifdef CONFIG_M68K
 #define FILL_SIZE_STRING		8
+#define FILL_SIZE_ARRAY			2
 #else
 #define FILL_SIZE_STRING		16
+#define FILL_SIZE_ARRAY			8
 #endif
 
 #define INIT_CLONE_SCALAR		/**/
@@ -345,7 +347,7 @@ union test_small_start {
 	short three;
 	unsigned long four;
 	struct big_struct {
-		unsigned long array[8];
+		unsigned long array[FILL_SIZE_ARRAY];
 	} big;
 };
 
-- 
2.34.1

