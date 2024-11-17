Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758B37DA81;
	Sun, 17 Nov 2024 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731843499; cv=none; b=f0zxCycVZr3uIFDsH5D9eIVJwB22ZZagsSImjN36n09ayPOTyLl0GH+5B6rgrYRL8RYvc1wsSOwDFkd6uYqwWqP516mIwq/7bVBGEFJMJ7UEgguhX21m+KJmEirMwfc7SHcuIePbMl/Swy/8cxxJc77AWE4UEFOYtpCb2Ihan6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731843499; c=relaxed/simple;
	bh=J7vEzRU8lz9iNRbd604M9EU2pO8dzBbGk4lFRttDnwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Okoouwvm70DeIB1kGy9+MVXPRxU0dLDZnnMjzsN8OrHECmXvBP9Wo1UGbbWzYbxd6Up5ehmABYozwZFX0u4BVl0rq7WWFv9gAt/wY8sTbm83JY7MhgAZiLB7vb8DnvRNiwRUz+Gd/oZhijNnaFqc7Bs4RqsZNsIXlvxAq4OAZRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwZxqQcV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwZxqQcV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE66C4CECD;
	Sun, 17 Nov 2024 11:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731843499;
	bh=J7vEzRU8lz9iNRbd604M9EU2pO8dzBbGk4lFRttDnwA=;
	h=From:To:Cc:Subject:Date:From;
	b=cwZxqQcVAOsGBRbHovm6/9xNrWIdwylQuEP6y8gEftq/Y96CL/374eVrRaFPlCmk8
	 FnsnJ+UScGIzHJ+wI2x+ZAsK+t6LEOohVyvP4shQR+Ufds8nQpfXz97a8OUCkqAiRf
	 Tmy8YIJAALZezAHzVcFu5FhDFLjWvYH7YDyNxTCBAh0ifi8Xqb3V3kxidx4eXv7QeX
	 J1F3/RIook9w7ZGx/JkBWDh06Rxn9DuwjkbXW7kCriV6/mgAGhagXcX9LE505NctTG
	 a6bmnpRa1PAJ+r0bOpA3AaDsf7LH8AvWNvbO1xxoXAuEUuE0xPVIvNKTEUprbf9hXE
	 5jFCRqLooclhw==
From: Kees Cook <kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] lib: stackinit: Hide never-taken branch from compiler
Date: Sun, 17 Nov 2024 03:38:13 -0800
Message-Id: <20241117113813.work.735-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1382; i=kees@kernel.org; h=from:subject:message-id; bh=J7vEzRU8lz9iNRbd604M9EU2pO8dzBbGk4lFRttDnwA=; b=owGbwMvMwCVmps19z/KJym7G02pJDOmWV5cyevGFBbhPZ0h3bumOybrx7nOcUoZcGYPIKhbza Zzx7K0dpSwMYlwMsmKKLEF27nEuHm/bw93nKsLMYWUCGcLAxSkAE1nSyvDPxm5p75Fg9yZ27VIH h4+v1Vb/fHo7RGseq+iSe/fulPEzMTIcyJ5bdYiNhePoLnvji2L/C2NydvCqlHztF86PSZ6+w48 HAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The never-taken branch leads to an invalid bounds condition, which is by
design. To avoid the unwanted warning from the compiler, hide the
variable from the optimizer.

../lib/stackinit_kunit.c: In function 'do_nothing_u16_zero':
../lib/stackinit_kunit.c:51:49: error: array subscript 1 is outside array bounds of 'u16[0]' {aka 'short unsigned int[]'} [-Werror=array-bounds=]
   51 | #define DO_NOTHING_RETURN_SCALAR(ptr)           *(ptr)
      |                                                 ^~~~~~
../lib/stackinit_kunit.c:219:24: note: in expansion of macro 'DO_NOTHING_RETURN_SCALAR'
  219 |                 return DO_NOTHING_RETURN_ ## which(ptr + 1);    \
      |                        ^~~~~~~~~~~~~~~~~~

Signed-off-by: Kees Cook <kees@kernel.org>
---
 lib/stackinit_kunit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/stackinit_kunit.c b/lib/stackinit_kunit.c
index c14c6f8e6308..c40818ec9c18 100644
--- a/lib/stackinit_kunit.c
+++ b/lib/stackinit_kunit.c
@@ -212,6 +212,7 @@ static noinline void test_ ## name (struct kunit *test)		\
 static noinline DO_NOTHING_TYPE_ ## which(var_type)		\
 do_nothing_ ## name(var_type *ptr)				\
 {								\
+	OPTIMIZER_HIDE_VAR(ptr);				\
 	/* Will always be true, but compiler doesn't know. */	\
 	if ((unsigned long)ptr > 0x2)				\
 		return DO_NOTHING_RETURN_ ## which(ptr);	\
-- 
2.34.1

