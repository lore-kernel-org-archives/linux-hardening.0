Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F5627FB3C;
	Thu, 10 Jul 2025 02:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752115729; cv=none; b=bjCdUSPhx4kNN56nnCW2uA7rTR+JmzXrY5GdfGYLr+aHL3Ve70p/oKdHjOHAGc2iYcAU7yzUC05egFV4H/I3VkTbj1HAbpvh59IuuguNsKsp5Y90z055qX5iHluI278RjUMV+YaDMk853GoQsg0fcisd6AcuYIY1V/HoPpGJPKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752115729; c=relaxed/simple;
	bh=rA+UPFYPuwoFgyGzULq9cIi8t0p+DMJsALzl86HNlek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhsNpY7JHUqozlpX/tZIwRKZDBt8QCcCQUfAwFShfolSGxfr6257DFiT9CRjZBczu0ahAhXmom0wI38WD7yHCkudyrRVhQ1YZ6tKNwK5pPwCoL4ScKWwzkPLmBwkLTLf0nesV8/59FCAYpUd/0vjOdZiRKsCY3AdMeNQaJuPolI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Os+GBNrj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Os+GBNrj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11458C4CEF5;
	Thu, 10 Jul 2025 02:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752115728;
	bh=rA+UPFYPuwoFgyGzULq9cIi8t0p+DMJsALzl86HNlek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Os+GBNrjZeEhyYlj8yYdJoW9irRUw6vHagC99ydRypwCqbglrGNYPzSsxonCJSpDN
	 pMIP8RHBXVO7MhvqA2muaq248nqu1XUn6DB0mAFBqEZcAOtGGT7bt5TdxGJYcNgloq
	 rzXAXBG3p/NEloymUlkDHSHUL4sCpY+evRm2jUBHjFx6hvTUEFiA0fy8SDJtNCVKRP
	 Q/fOumV2i9EYwJbRQjIHwFqLuuaPmmrbJ9q1nE0d7CTDzvZQtFAMf2zRLVYZ3kZ6R1
	 UCVcpxVprPL6nd9Ej+dlgnxU6OFJAZy4obv+83rUw1AvLTVOskpDIGduzLC4rF5gbo
	 zIdu+kuI+IwHQ==
Date: Thu, 10 Jul 2025 04:48:41 +0200
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
Subject: [RFC v4 4/7] array_size.h: Add ENDOF()
Message-ID: <e05c5afabb3c2b7d1f67e44ed8a5b49fc8aed342.1752113247.git.alx@kernel.org>
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

