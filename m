Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AFE3C3450;
	Wed, 18 Mar 2026 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859215; cv=none; b=OpdqzVKtgpibfTkVugF0DOsD2pNdriWVEEk3H7IKO0MwCyzDBsG+WVDeUY2LXDC/EyOpKKnmQ+j+8ez9ansiLoJBC6JBXyPWU3pgVqkcOUXu9h0uhRG8TJDFTZGwsGtAp5dF8wjIMGzvdHKzFfOtFgAlqQsWNB8Sw97zIZ5sGh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859215; c=relaxed/simple;
	bh=4eaO4k7qDAfhmNFlz4m0Z+1y1kj9od+IKNtEkD0bc2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bfXOsppmZrnFnLCFfeRO4YJoR10MR/MC+dTw+Y0P3hky6rS+eEMIzMs+zPBIi4hPUfMEeDferhI4ThSOg8gpfUQtcwCJStEGU+ueEnBWJVPksRXQkKvwSsUAHXAVZsDjNZrzBKqO5ja69fCPVL5HxjeHMkTEJkHUWkkJgf0W+ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBznw79N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBznw79N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07C6C19421;
	Wed, 18 Mar 2026 18:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773859214;
	bh=4eaO4k7qDAfhmNFlz4m0Z+1y1kj9od+IKNtEkD0bc2U=;
	h=From:To:Cc:Subject:Date:From;
	b=KBznw79NJWQf505ci3L/JWi/WsMsWPBTjpFNIDsPRY9b3t6cXgT4Jm/hiD7rRqvNZ
	 cknAgZkLDGpUofaa/vzpdbWnbBzdDYh0chlRKPMjphlG66jHWXOP9dMV8cAsa4/tiL
	 rVvA/+UY1qieVwLTTuacCsKdzQDfT+XSW5VW63UNtpF8iBy+IPIHvcmVIUM/usZWLA
	 tLPFgzzxilqNnMzfSvgakuD9M3PE6GjtXJ8kuICt52lX36oFB+Yzk6uZ9vJ5xU6eRC
	 R0yvZUWWAdTzhib8XXwAE1AKMr/PcDyKoN8eeXGSGaKVh/eHei5oMKJ1JA2Ms4JAgs
	 0rUXE/4v7X0rg==
From: Kees Cook <kees@kernel.org>
To: linux-mm@kvack.org,
	Guenter Roeck <linux@roeck-us.net>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] fs/tests: exec: Remove bad test vector
Date: Wed, 18 Mar 2026 11:40:13 -0700
Message-Id: <20260318184009.work.411-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192; i=kees@kernel.org; h=from:subject:message-id; bh=4eaO4k7qDAfhmNFlz4m0Z+1y1kj9od+IKNtEkD0bc2U=; b=owGbwMvMwCVmps19z/KJym7G02pJDJm7PvZkOeVsPvjERCFu66m1x+6+2vhnc22d9fQ/m9fW/ 1eoexW0vaOUhUGMi0FWTJElyM49zsXjbXu4+1xFmDmsTCBDGLg4BWAi108y/GZbLuaaURM5fWPd rpQmni1HJ9aUpNfHF4YZyM75MOPhs9uMDN3eG7c1LLr+9GBVXNIJla4yy81bO88cdYrfvcR0xkW faFYA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Drop an unusable test in the bprm stack limits.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/a3e9b1c2-40c1-45df-9fa2-14ee6a7b3fe2@roeck-us.net
Fixes: 60371f43e56b ("exec: Add KUnit test for bprm_stack_limits()")
Signed-off-by: Kees Cook <kees@kernel.org>
---
 fs/tests/exec_kunit.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/tests/exec_kunit.c b/fs/tests/exec_kunit.c
index f412d1a0f6bb..1c32cac098cf 100644
--- a/fs/tests/exec_kunit.c
+++ b/fs/tests/exec_kunit.c
@@ -94,9 +94,6 @@ static const struct bprm_stack_limits_result bprm_stack_limits_results[] = {
 	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 4 * (_STK_LIM / 4 * 3 + sizeof(void *)),
 	    .argc = 0, .envc = 0 },
 	  .expected_argmin = ULONG_MAX - (_STK_LIM / 4 * 3) + sizeof(void *) },
-	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 4 * (_STK_LIM / 4 *  + sizeof(void *)),
-	    .argc = 0, .envc = 0 },
-	  .expected_argmin = ULONG_MAX - (_STK_LIM / 4 * 3) + sizeof(void *) },
 	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 4 * _STK_LIM,
 	    .argc = 0, .envc = 0 },
 	  .expected_argmin = ULONG_MAX - (_STK_LIM / 4 * 3) + sizeof(void *) },
-- 
2.34.1

