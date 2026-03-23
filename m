Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610EC27FB3A;
	Mon, 23 Mar 2026 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286236; cv=none; b=MayvA7CnIPj/bOedwsEATdcQeLEbec1xlNhlmI4VI7h2emZ4b86RZbokQdP5U/um+9a+yBGhENuqgFU6QAOtvClt5+3jVqVRNpaUC0+v9dTMsp2+qw2v/11tGq30TwflTeMl0VUoahxq1mh+4AG0fggu3BhQj0ixIMmx0NnyNps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286236; c=relaxed/simple;
	bh=/eQUgT1KQXGq96zk0iCPYppr6SLqEvcqyZ2k7p/CtOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fEQpPbrFlXbcyzYCnoLVhZnAMb5R1cXOBsa8Y845u2Q0NfWDVJXjI8qptQQuZfwoOtNin1LM7OBkoXnmks31L1tFr7jkaetARp0S88wbgxhXpYFsLC3s796O1msnXXclpmgFuGEGHZqIlXMcC1YiDUXjqhABv4U7+Hw3Vj5v3Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4DDdkC6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4DDdkC6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28BCC4CEF7;
	Mon, 23 Mar 2026 17:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774286235;
	bh=/eQUgT1KQXGq96zk0iCPYppr6SLqEvcqyZ2k7p/CtOg=;
	h=From:To:Cc:Subject:Date:From;
	b=g4DDdkC6w1WJFMCU/T4Xpy8/sePdXBZACqBz8WwS3gsJTlSp1ECyYaieX0vf6ycrm
	 ITHyzD3QBPbMiJnH0f7EmT2FNv+/EvqWNi46e7NI80OPg9bDUba73ndT5rJ2gK37tv
	 Zy8bS2OAO/GPVlXa9E0wkLnlKcK8lemlHzkv8ZpjN2oNyWfb0zVzsCziDalB8JiDvK
	 kf87j9bXA6c2ZZYCYg1v/lCmgSJtRvJ5enAiZXqt84+Qx6NI5h4H/66HqO/J4+ruUX
	 7eg45LooGu6Jg5jeDZzU0XuYH+5+mTT4+OFkAnMA6sM3100NeQNixUDCZD2yHZT4V3
	 Hhfj4fY5KfInA==
From: Kees Cook <kees@kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: Kees Cook <kees@kernel.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] um: Replace strncpy() with strnlen()+memcpy_and_pad() in strncpy_chunk_from_user()
Date: Mon, 23 Mar 2026 10:17:14 -0700
Message-Id: <20260323171713.work.839-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1982; i=kees@kernel.org; h=from:subject:message-id; bh=/eQUgT1KQXGq96zk0iCPYppr6SLqEvcqyZ2k7p/CtOg=; b=owGbwMvMwCVmps19z/KJym7G02pJDJkHS2cubda4P9PlpD7/5/thd8udtuZ3rheWfnLuS9+TK bkLblxY2VHKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjCR55IM/3Qn7/t6+5LcPn2b mIbfP87d6fOZKh9xa/X6e5tZviTMNohj+M2m+nO1gGPZ8y08MfcKRCvedtQfyuucntd1vuOz3su Z8nwA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Replace the deprecated[1] strncpy() with strnlen() on the source
followed by memcpy_and_pad().

This function is a chunk callback for UML's strncpy_from_user()
implementation, called by buffer_op() to process userspace memory one
page at a time. The source is a kernel-mapped userspace address that
is not guaranteed to be NUL-terminated; "len" bounds how many bytes
to read from it.

By measuring the source string length first with strnlen(), we avoid
reading past the NUL terminator in the source. memcpy_and_pad() then
copies the string content and zero-fills the remainder of the chunk,
preserving the original strncpy() behavior exactly: copy up to the
first NUL, then pad with zeros to the full length.

strtomem_pad() would be the idiomatic helper for this strnlen() +
memcpy_and_pad() pattern, but it requires a compile-time-determinable
destination size (via ARRAY_SIZE()). Here the destination is a char *
into a caller-provided buffer and the chunk length is a runtime value,
so the explicit two-step is necessary.

No behavioral change: the same bytes are written to the destination
(string content followed by zero padding), the pointer advances by
the same amount, and the NUL-found return condition is unchanged.

Link: https://github.com/KSPP/linux/issues/90 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/um/kernel/skas/uaccess.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index 198269e384c4..caef1deef795 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -170,8 +170,8 @@ static int strncpy_chunk_from_user(unsigned long from, int len, void *arg)
 	char **to_ptr = arg, *to = *to_ptr;
 	int n;
 
-	strncpy(to, (void *) from, len);
-	n = strnlen(to, len);
+	n = strnlen((void *) from, len);
+	memcpy_and_pad(to, len, (void *) from, n, 0);
 	*to_ptr += n;
 
 	if (n < len)
-- 
2.34.1

