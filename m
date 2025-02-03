Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [195.130.137.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CFE209684
	for <linux-hardening@vger.kernel.org>; Mon,  3 Feb 2025 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593263; cv=none; b=lZF3oRJYrBaPvDt5FVtZ83+ZWiBlUXfewy9xRe7PAp5jiVtauXUjnBDJRikh2lqVL5rFZ2DBJF4j9GU6xvjwivBYD3NEuESb1AjHNoklVsiSKr6CVdU1VVGbi8HmDFEDPRzsi4a1IFdD3Axx34D0TGzIFd/zE3pPQ1rQpSgPlh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593263; c=relaxed/simple;
	bh=625RtJRCTtNa1lSKe81zsXGX4BP5nv6d1/mkV8i9Jn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cZeHHH6XXbn8JEbK49es7UN6GDg/9I5X72+dhmkbeZwKYm8rIgQi2bd5Gk+SFeygu6Lei/XmmM2ZvU3E1f7BvKvZRQ313ZTy49S0yks/dX+mdCZY7QGjPOyciNWX21KoLtJuBcGQDeVagDaAZMSuS3iPhKfnFmerl5VZZFijyXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by riemann.telenet-ops.be (Postfix) with ESMTPS id 4Ympsl4RC2z4x1yw
	for <linux-hardening@vger.kernel.org>; Mon, 03 Feb 2025 15:34:19 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:d465:743d:7f2:30d8])
	by andre.telenet-ops.be with cmsmtp
	id 92aB2E00Z4UDnen012aBTz; Mon, 03 Feb 2025 15:34:12 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1texWS-0000000FcxH-0KVJ;
	Mon, 03 Feb 2025 15:34:11 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1texWd-00000003Ril-2DTh;
	Mon, 03 Feb 2025 15:34:11 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] stackinit: Fix comment for test_small_end
Date: Mon,  3 Feb 2025 15:34:07 +0100
Message-ID: <3f8faa2d7d0d6b36571093ab0fb1fd5157abd7bb.1738593178.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In union test_small_end, the small members are three and four.

Fixes: e71a29db79da1946 ("stackinit: Add union initialization to selftests")
Closes: https://lore.kernel.org/CAMuHMdWvcKOc6v5o3-9-SqP_4oh5-GZQjZZb=-krhY=mVRED_Q@mail.gmail.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 lib/stackinit_kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/stackinit_kunit.c b/lib/stackinit_kunit.c
index fbe910c9c8253480..12ffbcc8d4753107 100644
--- a/lib/stackinit_kunit.c
+++ b/lib/stackinit_kunit.c
@@ -349,7 +349,7 @@ union test_small_start {
 	} big;
 };
 
-/* Mismatched sizes, with one and two being small */
+/* Mismatched sizes, with three and four being small */
 union test_small_end {
 	short one;
 	unsigned long two;
-- 
2.43.0

