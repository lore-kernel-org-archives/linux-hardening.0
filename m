Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC51E520B;
	Thu, 10 Jul 2025 21:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183084; cv=none; b=n0tdeo3WsxeEJkTP4B/ZIvKKk1N1Z8ljnbWdj9OoS7gYgA+Gl8KABNsK6NGHrulAb2JBuwy6PhAfx5f2qnQJiLjSlzrwlmB0Uy5glhtvR/pauNhiZHlMdDWZ7U4qkhSZKiIUaGGnDNB/kcCyzoQTuGMR7eTcI0XSgVjoarfyZuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183084; c=relaxed/simple;
	bh=BviaG8x5UaMaZ2NZNq4PRkpH6oax0KpIs4xoQwuZthQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eA39cMw1Toyyge1/lVfyKAy2VF9Qc3u986b4ciZq59WldwlBzeaNQLOlamzCcmokplM845Auy+2xwHrTNCbo+Q5G1sI3a8ck6YPYbPfVJLrKDrGSDa+t/h9EW5FghLwYbkU+RYx2k3UJ/9voN9JalSfZXn8uwNzbkHDE+jIawu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Czr/vs+w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Czr/vs+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC03CC4CEED;
	Thu, 10 Jul 2025 21:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752183084;
	bh=BviaG8x5UaMaZ2NZNq4PRkpH6oax0KpIs4xoQwuZthQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Czr/vs+wEbaVSdBx4yIctL/u3HxGAZE/y+vim/e+sn09CaMvg5y47zTkS/tEx/dWZ
	 /5bMgPrsHpl/rJ4D040AqEYgVFJ/Bck6WuCkR+6rdeF+Ssazk9PLeLcR6qXSqPO9Zs
	 nFQ5wcNxIVXgWmoNEcM0VWZ4IiA1ovl0PNxCk01jARFm8wHV+S3BrdNPxNDL9VW2bg
	 WgQrf4d4jefyBADF/g5LDs2FSXi3xNaqHV/nfsV/F8zycPkRzF4JN3Y0P6flSPtLK3
	 aP1sBhHGoZLdhoBGvtgHJqyWNScaCGvORxWyQPho5YFfIKMmChAZODlEoGSIM77k9w
	 Sy0yUgGXZv1tw==
Date: Thu, 10 Jul 2025 23:31:18 +0200
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
Subject: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
Message-ID: <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.0
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752182685.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1752182685.git.alx@kernel.org>

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
index a0dc35574521..8576a543e62c 100644
--- a/include/linux/sprintf.h
+++ b/include/linux/sprintf.h
@@ -4,6 +4,10 @@
 
 #include <linux/compiler_attributes.h>
 #include <linux/types.h>
+#include <linux/array_size.h>
+
+#define sprintf_array(a, fmt, ...)  sprintf_end(a, ENDOF(a), fmt, ##__VA_ARGS__)
+#define vsprintf_array(a, fmt, ap)  vsprintf_end(a, ENDOF(a), fmt, ap)
 
 int num_to_str(char *buf, int size, unsigned long long num, unsigned int width);
 
-- 
2.50.0

