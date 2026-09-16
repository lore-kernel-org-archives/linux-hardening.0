Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDF14D6C23;
	Wed, 16 Sep 2026 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580334; cv=none; b=bJDr7HOc+jZ9ngMzyVwd9Hz3nQ9nY5mxRIqIK4giSIyEYX9juNKTVeDlcQP9JOhF+ddjxyRT2n+r3mG7sXBil67GPiBiC8uJTrSLa4h5Y/oAhL2kpGV+2C10suMAf1QVBgOT07Zh/0EJJEAH7c/crNj1gDdP/a4U+1HK1oxq16c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580334; c=relaxed/simple;
	bh=1xBOa/arXWhUJUP6g5m17JkL1URolc5p+IQdAXLKJ/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JgGSmamELerhU6BDrK7Is5YWg6mCS+zACDjk2s8PdTN6HUlvzfQdWPwxvdxn0cPNm3uB3EOVnd1baocy7Ir8xQNM2qpDFa8nKeny7qDtFikbbvTYzKS/50JALkqEHZgWSl3hADSK+h8Xj8kYcRzLdeykBq/FY/y2xFXTvPCsWdY=
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
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 53C512059ED;
	Wed, 16 Sep 2026 19:38:15 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x6taJ-001Go9-0m;
	Wed, 16 Sep 2026 19:38:15 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 16 Sep 2026 19:38:10 +0200
Subject: [PATCH 5/5] lib/string_helpers: fix counting of remaining bytes in
 string_unescape()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-string_unescape-v1-5-7f8bd986fa33@pengutronix.de>
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
In-Reply-To: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
To: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2281; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=1xBOa/arXWhUJUP6g5m17JkL1URolc5p+IQdAXLKJ/M=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshadYVNz/jirVZhl00dzbwfT7Od9J7l/T9PqrTwCl/Fr
 RSZBTN/d5SyMIhxMciKKbLEqskpCBn7XzertIuFmcPKBDKEgYtTACYSsJzhN3tu7aefdxZesDQ5
 W/vO96/aQpP2Y47KR5Pdkqxsu143LWP4HxkmeYtZy1LffsJ9xbL9+c/KJi8sLjyR7fFGYoJQRfV
 aFgA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

All of the available sequences expand to exactly one byte, the size
check in the loop condition is sufficient for the case of an escaped
character too.

Otherwise, an escape sequence that should be unescaped to the last
character before terminating with null in the destination buffer will be
output as backslash instead of the escaped character.

The only exception is when encountering a backslash that turns out to
not start a valid escape sequence and both the backslash and the
character following are handled in one iteration. Move the check there.

Add a kunit regression-test that unescapes a character to right in front
of the null terminator of the destination buffer.

Fixes: 16c7fa05829e ("lib/string_helpers: introduce generic string_unescape")
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 lib/string_helpers.c             | 5 +++--
 lib/tests/string_helpers_kunit.c | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index cb41ef9d8c5b..4a621f884bde 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -329,7 +329,7 @@ int string_unescape(char *src, char *dst, size_t size, unsigned int flags)
 		size = SIZE_MAX;
 
 	while (*src && --size) {
-		if (src[0] == '\\' && src[1] != '\0' && size > 1) {
+		if (src[0] == '\\' && src[1] != '\0') {
 			src++;
 
 			if (flags & UNESCAPE_SPACE &&
@@ -349,7 +349,8 @@ int string_unescape(char *src, char *dst, size_t size, unsigned int flags)
 				continue;
 
 			*out++ = '\\';
-			size--;
+			if (!--size)
+				break;
 		}
 		*out++ = *src++;
 	}
diff --git a/lib/tests/string_helpers_kunit.c b/lib/tests/string_helpers_kunit.c
index 2e02c680cbb2..10763a01be83 100644
--- a/lib/tests/string_helpers_kunit.c
+++ b/lib/tests/string_helpers_kunit.c
@@ -626,6 +626,8 @@ static void test_unescape(struct kunit *test)
 
 	test_string_unescape_one(test, "short buffer", UNESCAPE_HEX, "\\x41\\x41B", 4, "AAB", 3);
 	test_string_unescape_one(test, "unrecognized escape at end", UNESCAPE_HEX, "B\\qX", 4, "B\\q", 3);
+
+	test_string_unescape_one(test, "end of buffer", UNESCAPE_HEX, "B\\x41", 3, "BA", 2);
 }
 
 static void test_escape(struct kunit *test)

-- 
2.56.0.rc0.108.gf0ef1b96a0

