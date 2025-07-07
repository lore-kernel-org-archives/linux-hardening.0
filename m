Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5949E265CA7;
	Mon,  7 Jul 2025 05:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751864780; cv=none; b=FsSd+CsjEgBzdDxSpduK7ne02bNl1V0U9h4dLduPnuiC5yp8SvNRr3GtnEyF1sSuzn6bMVBfxD4lU7pgE8B7KMWEC8U35QWKhETer6LzoNgYnkS43Wd44htphEQaNY0P8Fytzqd2tCIpdnTpt9imJh/6Gdy6otY/eq1AJY8UcuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751864780; c=relaxed/simple;
	bh=tcpGh4dHgjGALEI/7Qt9HZzvd2bDQOcYewOF2ERkXuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXlJcDLX6TtYVYihJZmj5j/nrKiTzF7/ry/s8ziHV4jhvaM0PUoquIExv9Nop46YqCtrHFnca5JAZXIA3YUpYhwk507PR8dhMo4H3XUIC+Y57rxY5wnBIPOY+CVZnewaXn6F7kTjV8oBkvMMtubRRlb6sUVRfJMm2RRz2X58z0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVDyUZ1Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVDyUZ1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BC6C4CEE3;
	Mon,  7 Jul 2025 05:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751864780;
	bh=tcpGh4dHgjGALEI/7Qt9HZzvd2bDQOcYewOF2ERkXuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VVDyUZ1ZiTo6UBehB938a6N3GMEKaKiHMvld72jrlj1TqZ3xCOzo3JKajIzRjPTvU
	 YcxQxX924fozYDgLqQfVrlKDrNL5Cu4+cOKGTsFIXwdpOa0focWXfCy2i6VaAPGgwK
	 MnmrnuWsHxG+jZOhrIxkfPYYMvOmeL1J5BZWkzk7vNg4j3DWn9FmfZ4a5aEmKK6nKl
	 GXdyl8dBz5++Jjn7PuZ1r4Pgr2GSp+jJwn6dqQTlr+IsAo1PQDLUFzDcJ3qbHq7ZqP
	 eQyN+arIdJ3Z/7/3VIFTRQ9/8Lju3Rh0pzz8rmIJ7UuMhp1WnN5u3sWZKApD/LjvPt
	 ZxuY4Iblzr+WA==
Date: Mon, 7 Jul 2025 07:06:18 +0200
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
Subject: [RFC v3 6/7] sprintf: Add [V]STPRINTF()
Message-ID: <44d05559398c523d119afecdb3e748d37433fe9e.1751862634.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.0
References: <cover.1751862634.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1751862634.git.alx@kernel.org>

These macros take the array size argument implicitly to avoid programmer
mistakes.  This guarantees that the input is an array, unlike the common
call

	snprintf(buf, sizeof(buf), ...);

which is dangerous if the programmer passes a pointer.

These macros are essentially the same as the 2-argument version of
strscpy(), but with a formatted string.

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/sprintf.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
index c3dbfd2efd2b..6080d3732055 100644
--- a/include/linux/sprintf.h
+++ b/include/linux/sprintf.h
@@ -4,6 +4,10 @@
 
 #include <linux/compiler_attributes.h>
 #include <linux/types.h>
+#include <linux/array_size.h>
+
+#define STPRINTF(a, fmt, ...)  stprintf(a, ARRAY_SIZE(a), fmt, ##__VA_ARGS__)
+#define VSTPRINTF(a, fmt, ap)  vstprintf(a, ARRAY_SIZE(a), fmt, ap)
 
 int num_to_str(char *buf, int size, unsigned long long num, unsigned int width);
 
-- 
2.50.0

