Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BAD19E97B;
	Thu, 18 Jun 2026 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781792997; cv=none; b=YPrzrtrVNDre9svzzojDZOFR3qjdD7VvgTKzmnFozE9+p08iWfSvboCt4tem9gGvzs5t0+zSrdqWbEUlMcMVEB+IeFeoHIPK70U+hTaLqIxuq57Zp8M1rGt4+sfyx0/05eLLXC4rahGUGjrJuoKgnZBKDKVpJbeXgcWeIPMDyOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781792997; c=relaxed/simple;
	bh=Utg2xY0LYl8MBnDmnYHRKGvpjcFe7rhfSMuYtv/HNT0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hhs5B1EowEJITl1tu2DuZ3B4bh+KD1ydsMrr8BkTmEXv6J6Yh2cCWCTd6S8M9fVq+yel/G8n0qfzQBSjHK6JHcF06jsOdPcRvl4XC9egvL6Fw+/L7jjp0G1D9TFkJ9rsV5J7rgugdC68nrUDmJQiAAZzcsuFL6BZ1SjFpLeJHwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMP/5ceG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMP/5ceG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266361F000E9;
	Thu, 18 Jun 2026 14:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781792995;
	bh=OKXs/on1Pn8IMlU4ircD80SaXql469gIyGw4pdtXGso=;
	h=From:To:Cc:Subject:Date;
	b=JMP/5ceG44xDKjEAoTCPu8h333l9oZ5XXJnFA86MDkyZYyWdOhJpsj8B24dqsw8cA
	 VY84T4jISld11/psmnGrJMuK0rpHKEJE4W6ast9QkcU459tb59dQidCj5rlXd8shcF
	 2pcT49Bnopv5x817hKdn3ihEdcZbxyo6Mz2BXVHm85lUEy8hmW4qEUu7XrLTqqwBY0
	 YfshhYMyTUqTg+qjM8dxoWyjMHB38r2ZQTPcPFye8pEfYtOP1pTuJ8VnnyX9WW7SRg
	 En9P42T711045a47CAsNcDhGviIkpeN4ev4+EpDgvLTX6T3ooYYmHbY7fdc38qigDY
	 Ic1RnxdZlsZwA==
From: Arnd Bergmann <arnd@kernel.org>
To: Kees Cook <kees@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KMSAN: fix memset() when using fortify-source, again
Date: Thu, 18 Jun 2026 16:29:43 +0200
Message-Id: <20260618142951.1739694-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Both kmsan and fortify-source replace the memset function. When both
are enabled at the same time, the kmsan version gets used, which triggers
a warning about fortify-source being nonfunctional:

warning: unsafe memset() usage lacked '__write_overflow' symbol in /home/arnd/arm-soc/lib/test_fortify/write_overflow-memset.c
warning: unsafe memset() usage lacked '__write_overflow_field' symbol in /home/arnd/arm-soc/lib/test_fortify/write_overflow_field-memset.c

Commit 78a498c3a227 already tried to address this, but this seems
to only have worked for memcpy() and memmove() but not memset(),
which is still lacking the macro definition when KMSAN is enabled.

Remove the incorrect #ifndef check around the memset() macro.

Fixes: ff901d80fff6 ("x86: kmsan: use __msan_ string functions where possible.")
Fixes: 78a498c3a227 ("x86: fortify: kmsan: fix KMSAN fortify builds")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The patch passes randconfig builds on x86/arm/arm64/s390 for me,
but please double-check all the corner cases, as it's still
possible that the #ifndef is required to work around a runtime
issue that I did not test.
---
 include/linux/fortify-string.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 5541c75ab852..5eddaefc61bd 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -506,10 +506,8 @@ __FORTIFY_INLINE bool fortify_memset_chk(__kernel_size_t size,
  * __struct_size() vs __member_size() must be captured here to avoid
  * evaluating argument side-effects further into the macro layers.
  */
-#ifndef CONFIG_KMSAN
 #define memset(p, c, s) __fortify_memset_chk(p, c, s,			\
 		__struct_size(p), __member_size(p))
-#endif
 
 /*
  * To make sure the compiler can enforce protection against buffer overflows,
-- 
2.39.5

