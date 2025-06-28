Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D6D217737;
	Sat, 28 Jun 2025 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751154042; cv=none; b=WSRWglQN/2irxz6KAN95VgpfPNFJkFtmcSX4A5npFOKbN8O5mggqDnLJj7fN4s04iBNI80QI6nsJ9K3U16Hr7guOaIbdHZzWttSJZMRFZXNmLVVUN3L+74lxiFBx4xM5Iz8LofumqwXJlhL1aaizocBmGTF9UBMQd3rEzVYrDUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751154042; c=relaxed/simple;
	bh=P/RvNkMSAQeQBPjrlKokt7Nces9xjj4vKLh9m4xqU58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Vk+c71RrTO6BsEdxKCTLgXSUtQ8hICVJR9j7lRhKwWMOthrRfy5rJBX/B6k0kuGOxaILhybxTPUmAaN/qaaHHvk3g0nhhr4jybtxXojQA7gfNUAl1fbR3wqfGZYAN4axQp7vcttu9LGpZnhmIZZve7M1NXIs7z7+GsiBoMndZ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZeC64k8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZeC64k8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D6AC4CEEA;
	Sat, 28 Jun 2025 23:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751154040;
	bh=P/RvNkMSAQeQBPjrlKokt7Nces9xjj4vKLh9m4xqU58=;
	h=From:To:Cc:Subject:Date:From;
	b=lZeC64k8S3hd9Xr+qm3sIquoVIDV777wnaYxYAaC+SwIa1rlGpV5WqQFa+12vnPa8
	 Usmb56cvKYgrxL5V8va1j2+QL1ihntOU3on6AYDbJGkUQKimlmI2YhNqSKMuhBTDx/
	 0IE0KZTAOcP851cXhJ6D2ZVsYwwFlxxzSkLBIYBYqQmWUzFWgBqHho8JAlgRTv/Lxq
	 X+VV0erEHeVfGuB2UGRsYi5jdiSIITUR3fxcaiqMWYdyWImI92jcVxBuTZD47cxKA0
	 hZyvrwkRH03x5xvCmGCASr8ITT1RC8hUt9RieigW438riLtOIzgb4TzFio8QIidTBL
	 PVkDMHdYdRsJQ==
From: Kees Cook <kees@kernel.org>
To: =?UTF-8?q?Jannik=20Gl=C3=BCckert?= <jannik.glueckert@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] kunit/fortify: Add back "volatile" for sizeof() constants
Date: Sat, 28 Jun 2025 16:40:38 -0700
Message-Id: <20250628234034.work.800-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367; i=kees@kernel.org; h=from:subject:message-id; bh=P/RvNkMSAQeQBPjrlKokt7Nces9xjj4vKLh9m4xqU58=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkJtaUH7CMUvCsWzt/JcjK+rZ6pZFmnbuDuhw/EVSTji 6dF8c7tKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmMhKa4b/sX0N/uLppVe3zrMI OF8v6nY/8Sxj/fE6zq+u94M7BJfFMDKs5z05ryv39CWN8srzckwXXGe5frrAYqPnUa/A+730720 OAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

It seems the Clang can see through OPTIMIZER_HIDE_VAR when the constant
is coming from sizeof. Adding "volatile" back to these variables solves
this false positive without reintroducing the issues that originally led
to switching to OPTIMIZER_HIDE_VAR in the first place[1].

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://github.com/ClangBuiltLinux/linux/issues/2075 [1]
Cc: "Jannik Glückert" <jannik.glueckert@gmail.com>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Fixes: 6ee149f61bcc ("kunit/fortify: Replace "volatile" with OPTIMIZER_HIDE_VAR()")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: <linux-hardening@vger.kernel.org>
---
 lib/tests/fortify_kunit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tests/fortify_kunit.c b/lib/tests/fortify_kunit.c
index 29ffc62a71e3..fc9c76f026d6 100644
--- a/lib/tests/fortify_kunit.c
+++ b/lib/tests/fortify_kunit.c
@@ -1003,8 +1003,8 @@ static void fortify_test_memcmp(struct kunit *test)
 {
 	char one[] = "My mind is going ...";
 	char two[] = "My mind is going ... I can feel it.";
-	size_t one_len = sizeof(one) - 1;
-	size_t two_len = sizeof(two) - 1;
+	volatile size_t one_len = sizeof(one) - 1;
+	volatile size_t two_len = sizeof(two) - 1;
 
 	OPTIMIZER_HIDE_VAR(one_len);
 	OPTIMIZER_HIDE_VAR(two_len);
-- 
2.34.1

