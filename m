Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C928913D531;
	Fri, 11 Jul 2025 01:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752199038; cv=none; b=MN9ZKOWUL2Ssf+fvFN/pUU1SPNedoP9L33oUabts5XYPdxQqEIjx8R6xWsDqYuiXpQ2RnfctOqpRBPTXKvL24CmQgyIOgBR4whOatl8GLy6tNA8LEWQJ+eEHtqGl9XH/TEDYrjm37MiiIkG4cYFPHCdSmSqc+v0BLSyI8DseMow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752199038; c=relaxed/simple;
	bh=rA+UPFYPuwoFgyGzULq9cIi8t0p+DMJsALzl86HNlek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebQjDpU+vFh9kDfsgN6dP3KHMAUyyFUxxGntk35czbu/LHE8HcTdWSdAThDp5SauF+4U9byJ2d4XyieRSA9108DQdReEPektIiRnbt1z5wkixDP3No6qs97mLIIImnxa9zVHiRTa5FC8HeH/HHbs2mGcAH/GR7lw/sqCYe6DA3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLhTvbdN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLhTvbdN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0C2C4CEE3;
	Fri, 11 Jul 2025 01:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752199038;
	bh=rA+UPFYPuwoFgyGzULq9cIi8t0p+DMJsALzl86HNlek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NLhTvbdNgrS960NEQxlWk0IVVXJt/aRKdQ8OVhbhrfIMKyoZEeIZMrKuBezSoYVyv
	 ZKzGLWxG8qRSd/nwR+JV/xwTEtjvwdwnCO/bLMSXfDmAXPvmunK6v3hErIbEwTzRij
	 YaOJ6/iMD0EbonjcIxOqqbuuVpVpQWa7O6ka0O9B7g7FO2JiNiTAwvgbAN/F3Ck7ci
	 JjNE+AxoJFDeYdXMuHCR1+0OlCBvh2xRQh5kBEmxqf9fxlVlSeNwzl4BO1PnlxhNQC
	 7AUsmdAVBE4EYgDHXyIOZ8TB0POq1yaJICtauOk6eOorPS6EEfdYbEwGnR9GP0l8Yr
	 exFYh78CmR5Dw==
Date: Fri, 11 Jul 2025 03:57:12 +0200
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
Subject: [RFC v6 6/8] array_size.h: Add ENDOF()
Message-ID: <37b1088dbd01a21d2f9d460aa510726119b3bcb0.1752193588.git.alx@kernel.org>
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

This macro is useful to calculate the second argument to sprintf_end(),
avoiding off-by-one bugs.

Cc: Kees Cook <kees@kernel.org>
Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Marco Elver <elver@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/array_size.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/array_size.h b/include/linux/array_size.h
index 06d7d83196ca..781bdb70d939 100644
--- a/include/linux/array_size.h
+++ b/include/linux/array_size.h
@@ -10,4 +10,10 @@
  */
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
 
+/**
+ * ENDOF - get a pointer to one past the last element in array @a
+ * @a: array
+ */
+#define ENDOF(a)  (a + ARRAY_SIZE(a))
+
 #endif  /* _LINUX_ARRAY_SIZE_H */
-- 
2.50.0

