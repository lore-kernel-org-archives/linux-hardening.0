Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D68029E107;
	Sun,  6 Jul 2025 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751823463; cv=none; b=uWOhtdhhPxNRnWO6vVKiEHhVrIoh7dwqdIXxfWI1ORzOEO4ixBSFOETzcV7KD1/GGmotJgHWWD9u58aobG5uLsdqNDLpKFHsuxTwO6GPcaoBuYUCZZ4UpK+FJqAT5YtgY/eLXLZ7+4v1GWJLtzrrhCVL0qWfax8exwtNBxvSVew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751823463; c=relaxed/simple;
	bh=qe0OTWsYjimAaCK25tMmk1gW7skbsmCkZX6Pukik9B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iP0dyZzCRe4vrpB/6LyfwNXKEoTBycHZ+lB3MLK5ToRKeyt7qGf/Y0XGNrI5X6d/gLwccwWLS6ecZAacrczNUGPgd0NIPu4SL1xKc0BtvPVvVCgF86D+DVibY0nyHNBE91Cmu51eMr+6hbUiQAB7ivx5K2YYHoFziT2vON70qRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlbC7Oy6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlbC7Oy6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D26BC4CEED;
	Sun,  6 Jul 2025 17:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751823462;
	bh=qe0OTWsYjimAaCK25tMmk1gW7skbsmCkZX6Pukik9B8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XlbC7Oy64OfgfN20MltOgEUEHqTitA9SuofjL4lDG65XV+5PVcmB9Zw5FVIt8dL07
	 Cc8du/YegNQQeQbak5aEtboc5EzuTi4pTg+dDK20UeJW03Th3PpbGVThPgoyZmKkAM
	 TctPUlTtRWV8W4KHz/hGLXuJCusFkwYf7gylZep6L6MNnP8BDQV3byTmz8yLhSWgj7
	 yjOqJ6BH1n8xa8j7sYfMLCAjfvYXr9OpJVFqQZ+7Tj5cC2tSGTFGADC81eG01tVLNv
	 Ok1wlq7MeL+90JMGdMX4ndUeEkyEOPskd+wOAg8wDKdblO0emOLXX8L0dNnNiPwS1M
	 pO88YarNbIyVQ==
Date: Sun, 6 Jul 2025 19:37:40 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-mm@kvack.org, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>
Subject: [RFC v2 4/5] array_size.h: Add ENDOF()
Message-ID: <5331d286ceca807bab76587127a9491c807c9a2a.1751823326.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.0
References: <cover.1751823326.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1751823326.git.alx@kernel.org>

This macro is useful to calculate the second argument to seprintf(),
avoiding off-by-one bugs.

Cc: Kees Cook <kees@kernel.org>
Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/array_size.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/array_size.h b/include/linux/array_size.h
index 06d7d83196ca..a743d4ad5911 100644
--- a/include/linux/array_size.h
+++ b/include/linux/array_size.h
@@ -10,4 +10,10 @@
  */
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
 
+/**
+ * ENDOF - get a pointer to one past the last element in array @arr
+ * @arr: array
+ */
+#define ENDOF(a)  (a + ARRAY_SIZE(a))
+
 #endif  /* _LINUX_ARRAY_SIZE_H */
-- 
2.50.0

