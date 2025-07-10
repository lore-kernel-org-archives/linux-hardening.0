Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811C27FD68;
	Thu, 10 Jul 2025 02:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752115744; cv=none; b=SXRWje9M7KiySRYms2IJSq55fOy+9B25alm52w6Cn0Eb7l8dUsjC0HDOJMB36f3oKKCzDdbaeHVeBbWZYuAOM+82UswKVuDPDDJu0OR408agFnVo/jMG346h5tZd6oDvKyoW4bEcxpP0um3slG3Ydd0+Kn0lmZP793oB6GLnC/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752115744; c=relaxed/simple;
	bh=bnX2EO5r+pqFtMRMv5EjlC3aGlquhrBGrjRfqkZ+Q4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBBVcphIHhodVFvIuGNrSsiXyYG/gmFf5DVKk/Kgd5x9ObvYExJcPhA9HYYZ2ddQFmn5IyRnkuib8xUhcfE4eTXQmGjTcxQs3wOD0j1n0qls26QdtG5bc0H+oKmSO8hrTnygw6v1dMDQLGPTaA+ANNW48+mXY5O4+iCAPhXbF+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3XJL0VW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3XJL0VW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AF5C4CEF6;
	Thu, 10 Jul 2025 02:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752115743;
	bh=bnX2EO5r+pqFtMRMv5EjlC3aGlquhrBGrjRfqkZ+Q4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3XJL0VWa98yMD+KVZAyb+ZWjgF4nCzXocP5panSiFMJTI6BBx+tioK7gpXbtXdRa
	 9gmf65u9aod1uBDEOmNuIkPaWskc7Qamg1NtYETrPhmbsX0/bE5LS6ihmNIprt0HAM
	 OQqVxElMWeExQdu9FWCgqejKvctDCJtCiBDkQeev9hoRBe2/3M9NduTGx3xb2RmYAh
	 6P+9WMVVSARkiwNZnChurBRLW5pqd9q0n2PhPE/+9hH3M2TdTRsDh/W9rHtXQtIOpW
	 MHVz3EUT/Ch2XNMl4LjWHqxWcgMeSCUYrOySerOqT4Y44A7goUdD09KmNKYXkxoduw
	 L0fhF/Aqu48yA==
Date: Thu, 10 Jul 2025 04:48:56 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-mm@kvack.org, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [RFC v4 6/7] sprintf: Add [V]SPRINTF_END()
Message-ID: <0314948eb22524d8938fab645052840eb0c20cfa.1752113247.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.0
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752113247.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1752113247.git.alx@kernel.org>

These macros take the end of the array argument implicitly to avoid
programmer mistakes.  This guarantees that the input is an array, unlike

	snprintf(buf, sizeof(buf), ...);

which is dangerous if the programmer passes a pointer instead of an
array.

These macros are essentially the same as the 2-argument version of
strscpy(), but with a formatted string, and returning a pointer to the
terminating '\0' (or NULL, on error).

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Marco Elver <elver@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/sprintf.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
index a0dc35574521..33eb03d0b9b8 100644
--- a/include/linux/sprintf.h
+++ b/include/linux/sprintf.h
@@ -4,6 +4,10 @@
 
 #include <linux/compiler_attributes.h>
 #include <linux/types.h>
+#include <linux/array_size.h>
+
+#define SPRINTF_END(a, fmt, ...)  sprintf_end(a, ENDOF(a), fmt, ##__VA_ARGS__)
+#define VSPRINTF_END(a, fmt, ap)  vsprintf_end(a, ENDOF(a), fmt, ap)
 
 int num_to_str(char *buf, int size, unsigned long long num, unsigned int width);
 
-- 
2.50.0

