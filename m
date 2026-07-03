Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18713C4171;
	Fri,  3 Jul 2026 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080771; cv=none; b=HwFKwsnnXu6M/hIcQ0Gq0XKjgPuS6qHsiWoF8YIt1gEMJppIG21GAoXi1CF8Of2NL/QUjQ1U+GbMvXRIlcrFNAG0idxqq2NMYNqOfpcBi+STKs8ZzvGppsRiPWiUQjuJML3M/VdjCpeSwm47ThnN5dzkxuXmnBppB59nxXIQBdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080771; c=relaxed/simple;
	bh=svuMCr40km+pZ9uy6Wrvq5DI4pzkEmdcVGA4/pmIkcE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JKw5zpPCZ2s0Ugfb96AwAFKTq5njJ+xqTjSYolBx2CGsRM08L0hHsGeie8mAWbjxuglebWv9ajS5CFsKx0z1kVi6Xi5iW0cDXAOvSUiS5Ls7IS0i040vL8L57JFGWMQOHZkQ4DBsUTnRnOh9fple+y/YXFhdgCxEYrfldLRvIoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=RujNGzWy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LbR5w1H9; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="RujNGzWy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LbR5w1H9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id A921B1380284;
	Fri,  3 Jul 2026 08:12:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 03 Jul 2026 08:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1783080768; x=1783084368; bh=m4XJPc232WXgHvfWbkxdWEyKS6DaeVGg
	FYWDDMuo6k8=; b=RujNGzWyVEXpSE0n+Jr4mRWFddDz+dvHDNydDzanbLya2m3H
	mqXI5+OTGrF4ShApJAfeED1M5tGtksscmnDMIEFkVUwzvaa4oXv1ZeFvvRYnmqSn
	Q+H8IcV1GsTEQVxI8JkWoecTTDbV5LZk2m4S0cvOZLDtIhoqk1Hn22WNbjvx9QAW
	DhuqEnsiPEzLIfB8RPnd3pq1QEVGVwofQ9jSghjQ5lgNOUp6AJ36Ethu8zyIGCDv
	I09ESHDLeHw/hpor/N2PSKY62JuZf57uIrZQUL5cC6y7+Nh6JRyOQOZ/tOe0Lc1A
	uqjtJJ2DXDRlkdrL0mRZK/UUk/arsP9WVu5utA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783080768; x=
	1783084368; bh=m4XJPc232WXgHvfWbkxdWEyKS6DaeVGgFYWDDMuo6k8=; b=L
	bR5w1H9m8OLeANhy9ft+aOFCycMBm/TLTuQJImrXyc77gzRjj3WpZQZYtorUHiR5
	tYhMIX33Wej5D/zK+Dflv8JNew2h86dt47+u8qxKGPPhX+0Gl8+xCG3GAk5CP7tN
	Mxb3Sq2iXHzd4r1MlcJGKuXvDeAaTq6EO4wHjum1qpOFJDoFE9bc99LL7mAUu0co
	kmtBvhiz++vrU47vyBR7vzZG0rzfqS01LtFaYpqUqZigplqFOKWmk66VW8pem8zP
	0oo1ZP2sNUXLAUY/tPw31RpzzCAPgkhTYoJD9BXf5/ye05pZs+QYzJyUpL3iSoqm
	PK3XzKCjOBKGYziuQXoFw==
X-ME-Sender: <xms:QKdHamIhHfb9yrkBj5RAVBCi9CdD0hl-cWSsGjAVcYL6ntWl6mibqQ>
    <xme:QKdHaoOiCgtSbGkJ90x5XWWVD4h9zVzSOt3HudidDs5MOUbOqQG7zMCzeSjUXOnnH
    w-MB-UDNPFOw-5tqsviyRxg-6c72s19867m0VdueCuEzST0DNXNWA>
X-ME-Received: <xmr:QKdHamk_JyApDLQpHtzcip37k--OJsc3pXGSOBZOpUZEeBSmxJTnNesgi70>
X-ME-Proxy-Cause: dmFkZTEAwyBZPl0V2RBfwhsNfZDOaVSL/bZNHBc1GnWElBBEjOg7d9WhUZaS1YAT/Kq5I0
    r/NWyOA4/OIyQxgX09eMu00qaVbBQptcgEhWPxRpH2/WnLWCjyF3lkjoFRoO7e3FU7cULa
    ADNQweOt4aRX0xWLfj4+aLYguU47OyrCDlKKpF4RoOiPQjaBVmXisM90kAJAuAtJ5erMkz
    4Q8rhsCLs8V5JDcSawJWo1cwsuZec4qS9PUAvJw15Tt/tDL9tEYLC8L10yNQ7PWghBVQa1
    GUxJsIXpq6w4NUUrMUavux11wXMKBYtI6WQ2fK5RA6YAEYOZIUi+6xOJNozdHX+rl+QeQe
    TJFBcWDadlGyoHzMobdMZeYvpnHvKdNlz1UfpbHIQ0phwcqB7M/3ED6POq+b6Sg8CNuJSv
    qxPpHXh5G3wNP/ez0WZassEsVmjOoW/65NGQUQy8agq8XKyN2HlMuoiRoDmPznhP0PQAIW
    cepYcy1KnCh4f2nB7wYxj/jDKghnzJhtv4TTEAkeACg1vVLRbAV+4lTpd+cFn2m1fTgPyO
    YsIsV5xfroCmyFMkwBMFrFcu+ZNGvJe+lBYly43RxJs5FUxw+mIEG8uKqKWLmhd28UjBov
    GeRTjWgBNmi8QN+x1k84GX5lZQwHu0TIn5htwGZxbQQseROK9X8c4z5JYlaA
X-ME-Proxy: <xmx:QKdHas5Q4wTQYwVxDx0y1izlhekHdWc_ImV9Ez2MxF4ncj0toyC0hg>
    <xmx:QKdHaq051wSuDud02Wx8FdgOkifz9naiXnLb4nl6LSKCl_meB3tQXA>
    <xmx:QKdHanEa2hMewyaiMH2Dn-lyJMnuPazrTThB-0Pf0ETQQ3lTEPQAxA>
    <xmx:QKdHaphWCe49d4ZEgiM0IUS1cowHCBWPdWioR8-z3V0u0h06Lav6pA>
    <xmx:QKdHaowSHACkgHDpw4LoYI7Ld3ZDuALVmJA5o68lzQS-JKU6ZR1iWooP>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 08:12:48 -0400 (EDT)
Date: Fri, 3 Jul 2026 07:12:46 -0500
From: Ian Bridges <icb@fastmail.org>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] kunit: string-stream: Replace strlcat() with strscpy() and
 seq_buf
Message-ID: <akenPvVk1xr_-480@dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In preparation for removing the strlcat() API[1], replace its uses in
string-stream.

string_stream_vadd() appends at most a single newline into space that
was explicitly reserved when the fragment was sized, so a bounded copy
at the end of the string is enough. The return value of strscpy()
keeps the length accounting unchanged. string_stream_get_string()
concatenates a variable number of fragments into a buffer sized to
hold them all, which is what seq_buf is for.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Ian Bridges <icb@fastmail.org>
---
Truncation semantics differ between the two APIs. On overflow,
strlcat() keeps whatever prefix of the fragment fits, while
seq_buf_puts() drops any fragment that does not fit whole. Neither
path is reachable here. string_stream_get_string() sizes the buffer
to hold all fragments exactly. The newline lands in a byte that
string_stream_vadd() reserved when it sized the fragment.

The patch was tested as follows:
 - The string-stream KUnit suite passes all 12 tests before and after
   the change. The full lib/kunit KUnit config (95 tests) also shows
   identical results before and after.
 - An x86_64 build of lib/kunit/string-stream.o at W=1 produces no
   warnings.
 - A userspace comparison of the old and new construction ran
   with different fragment lengths for the newline append and with
   randomized fragment lists for the concatenation loop. All outputs
   were identical.

 lib/kunit/string-stream.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index 0d8f1b30559b..51ba40ebf19f 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -9,6 +9,7 @@
 #include <kunit/static_stub.h>
 #include <kunit/test.h>
 #include <linux/list.h>
+#include <linux/seq_buf.h>
 #include <linux/slab.h>
 
 #include "string-stream.h"
@@ -74,7 +75,8 @@ int string_stream_vadd(struct string_stream *stream,
 
 		/* Append newline if necessary. */
 		if (frag_container->fragment[result_len - 1] != '\n')
-			result_len = strlcat(frag_container->fragment, "\n", buf_len);
+			result_len += strscpy(frag_container->fragment + result_len,
+					      "\n", buf_len - result_len);
 	} else {
 		result_len = vsnprintf(frag_container->fragment, buf_len, fmt, args);
 	}
@@ -118,15 +120,18 @@ char *string_stream_get_string(struct string_stream *stream)
 {
 	struct string_stream_fragment *frag_container;
 	size_t buf_len = stream->length + 1; /* +1 for null byte. */
+	struct seq_buf sb;
 	char *buf;
 
 	buf = kzalloc(buf_len, stream->gfp);
 	if (!buf)
 		return NULL;
 
+	seq_buf_init(&sb, buf, buf_len);
+
 	spin_lock(&stream->lock);
 	list_for_each_entry(frag_container, &stream->fragments, node)
-		strlcat(buf, frag_container->fragment, buf_len);
+		seq_buf_puts(&sb, frag_container->fragment);
 	spin_unlock(&stream->lock);
 
 	return buf;
-- 
2.47.3

