Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6223141987;
	Fri, 11 Jul 2025 01:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752199017; cv=none; b=hu5qAe5PIPMq76KHTdfLigKrmw4JvyHUMHdYZCoQ/YYHOnGmAcO9wWdaQZFmFMK9QPMYg2//oaBeQ+5/qP+XwJzYhYvCuXU6WqOnZnVToX5T5Q4+oARLeLYAWz6iJhnSKasJS5Bs6fc5+IxnUktGp7Sluzk3OFK9h1nN8m64j7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752199017; c=relaxed/simple;
	bh=ZJDxyoHVxpXrXiiFeB/cS1+32e1KaIZe9xa0hULilH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q52P7NhHzy+b13ULzea8g6CO4CCh4asTFwIYTmaC9QNjWUfTvlWACdH0RWvmYGTBNs6R3N/Y8+OO9BAOLxMiinzw8SvyDcgKMig22YtA8bJRlzLT10UyM0K3NQvT52alHIC9ueozxtpoi76P2cLkgA5Fv6qay2GTJpiw9il4/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ts7eRZFX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ts7eRZFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC406C4CEE3;
	Fri, 11 Jul 2025 01:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752199017;
	bh=ZJDxyoHVxpXrXiiFeB/cS1+32e1KaIZe9xa0hULilH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ts7eRZFXC+hTZVEFRgDt2D9q5siZFqf1bAIA+BV4yYoGKyCqhum9H5nH/wnnDWLuD
	 AxlWW10ozY+fZ27zw6+BLSbjLzvoaCnD2qpZ2PS2TVPhJe84p6N4ZbzQcf9q69v0pH
	 MHcofgmtzyrHi+wlXAYO0i/jjiGwAQWS4hTjnH9Q+qz6qMyv80CUFhD/YMW/naL4xm
	 Lzl6Ob4LiiYFr7qFiuDb8A7U1f4s+9k+ph3bBe4ulLHpnd3rEDF8tDu0h0sRbjbyrH
	 IY11kxEVhLQLSk1SSGfq01IKieR4Co0wn1vDOig6r4P2VEFzFpJQaHRak/PBPOHy3a
	 WglLx3iQ0L3Dw==
Date: Fri, 11 Jul 2025 03:56:51 +0200
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
	Al Viro <viro@zeniv.linux.org.uk>, Martin Uecker <uecker@tugraz.at>, Sam James <sam@gentoo.org>, 
	Andrew Pinski <pinskia@gmail.com>
Subject: [RFC v6 3/8] sprintf: Add [v]sprintf_array()
Message-ID: <9348d5df2d9f3a64be70a161f7af39ba30a0edc2.1752193588.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.0
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752193588.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1752193588.git.alx@kernel.org>

These macros take the end of the array argument implicitly to avoid
programmer mistakes.  This guarantees that the input is an array, unlike

	snprintf(buf, sizeof(buf), ...);

which is dangerous if the programmer passes a pointer instead of an
array.

These macros are essentially the same as the 2-argument version of
strscpy(), but with a formatted string.

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
index 8dfc37713747..bd8174224a4a 100644
--- a/include/linux/sprintf.h
+++ b/include/linux/sprintf.h
@@ -4,6 +4,10 @@
 
 #include <linux/compiler_attributes.h>
 #include <linux/types.h>
+#include <linux/array_size.h>
+
+#define sprintf_array(a, fmt, ...)  sprintf_trunc(a, ARRAY_SIZE(a), fmt, ##__VA_ARGS__)
+#define vsprintf_array(a, fmt, ap)  vsprintf_trunc(a, ARRAY_SIZE(a), fmt, ap)
 
 int num_to_str(char *buf, int size, unsigned long long num, unsigned int width);
 
-- 
2.50.0

