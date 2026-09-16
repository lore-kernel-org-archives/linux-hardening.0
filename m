Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C38949B465;
	Wed, 16 Sep 2026 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580322; cv=none; b=hst9gLNquwV7vyKYFCyNsFEHgTURkQxNWd8xoYXVEiWJtTb0Y0fZOXAvnfo/FzyO2x3E7kMbcESWpZZzeziXKoXkcb1jXU/OgYou+q8RC2ZiMRUELkklRWRgJs9Is/Xk1FtwX8MkXMcfREGRzDS4FvLdyFJ2COt6HcXtfQt2Trc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580322; c=relaxed/simple;
	bh=oOaOFMuRewgFEERst252OeHfIiFurUrlHBR44bK5Gqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jEGJ9OjtE724ZiEdnYsKTHjis8NUee3BZxLAXDmTYiJm82by7syswCCb6Fynb69qcVn2Q89coIC0Id9PWaStfWw+9isJX0yXtEfCgacLyq8WNMDLSyNAjA6OXy3SDC/i8D8umonjWs3i3QpScG3efR6TrXF9DD/xOUQVQjEbc1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
X-PTX-Original-Recipient: jre@pengutronix.de
X-PTX-Original-Recipient: kernel@pengutronix.de
X-PTX-Original-Recipient: akpm@linux-foundation.org
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-PTX-Original-Recipient: linux-hardening@vger.kernel.org
X-PTX-Original-Recipient: andy@kernel.org
X-PTX-Original-Recipient: kees@kernel.org
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4B6672059EC;
	Wed, 16 Sep 2026 19:38:15 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x6taJ-001Go9-0d;
	Wed, 16 Sep 2026 19:38:15 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 16 Sep 2026 19:38:09 +0200
Subject: [PATCH 4/5] lib/string_helpers: use full destination buffer in
 string_unescape()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-string_unescape-v1-4-7f8bd986fa33@pengutronix.de>
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
In-Reply-To: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
To: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2338; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=oOaOFMuRewgFEERst252OeHfIiFurUrlHBR44bK5Gqc=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshadYWtZWeQ18tDj61iKrObq58VvcgL7A26JNrm8/1F4
 6uAe/2LOkpZGMS4GGTFFFli1eQUhIz9r5tV2sXCzGFlAhnCwMUpABOJ3sDwz9Qws3DFwZUrNJlP
 NCkZtK7g3F4c+zoyPN7u0sl40+91dowMNwQW6TOG75icPNnR9G9Xftl2pYXL71nVOrjtVdwmseQ
 nIwA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

Although all of the available sequences expand to exactly one byte, the
current implementation decrements the remaining bytes in the destination
buffer twice, effectively shortening it by one byte per each unescaped
character.

The extra decrement is only needed in the one case where a single loop
iteration produces two output bytes: when the sequence turns out not to
be a valid escape sequence, the previously skipped backslash has to be
emitted before the character is copied verbatim.

Add a kunit regression-test that unescapes into a barely long enough 3
buffer.

Fixes: 16c7fa05829e ("lib/string_helpers: introduce generic string_unescape")
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 lib/string_helpers.c             | 2 +-
 lib/tests/string_helpers_kunit.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 98d6ed0eaab7..cb41ef9d8c5b 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -331,7 +331,6 @@ int string_unescape(char *src, char *dst, size_t size, unsigned int flags)
 	while (*src && --size) {
 		if (src[0] == '\\' && src[1] != '\0' && size > 1) {
 			src++;
-			size--;
 
 			if (flags & UNESCAPE_SPACE &&
 					unescape_space(&src, &out))
@@ -350,6 +349,7 @@ int string_unescape(char *src, char *dst, size_t size, unsigned int flags)
 				continue;
 
 			*out++ = '\\';
+			size--;
 		}
 		*out++ = *src++;
 	}
diff --git a/lib/tests/string_helpers_kunit.c b/lib/tests/string_helpers_kunit.c
index 3c6fa7324965..2e02c680cbb2 100644
--- a/lib/tests/string_helpers_kunit.c
+++ b/lib/tests/string_helpers_kunit.c
@@ -623,6 +623,9 @@ static void test_unescape(struct kunit *test)
 	test_string_unescape_one(test, "escape at end", UNESCAPE_HEX, "a\\qX", 3, "a\\", 2);
 	test_string_unescape_one(test, "backslash before escape", UNESCAPE_HEX, "\\\\x41B", 12, "\\\\x41B", 6);
 	test_string_unescape_one(test, "backslash escape", UNESCAPE_HEX | UNESCAPE_SPECIAL, "\\\\x41B", 16, "\\x41B", 5);
+
+	test_string_unescape_one(test, "short buffer", UNESCAPE_HEX, "\\x41\\x41B", 4, "AAB", 3);
+	test_string_unescape_one(test, "unrecognized escape at end", UNESCAPE_HEX, "B\\qX", 4, "B\\q", 3);
 }
 
 static void test_escape(struct kunit *test)

-- 
2.56.0.rc0.108.gf0ef1b96a0

