Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE234C652F;
	Wed, 16 Sep 2026 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580318; cv=none; b=KzzJUONWyxRzacBW7BWKq5tNlpSgPBFieX1wSA7QJDkVnbnNUWQAFip9RdGZ/rOGoQL508KnP5wFQH4v7lSt+0cl/ezEU2hxKGWGyeicaGUT72e6/oanMeskzS4QpUhp8Pd/Y8oRebvEJcBH8084t5lUvIHy7CN163LDz2AOTME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580318; c=relaxed/simple;
	bh=ECun2AALw4gQB+9hdl9j+YzzMYCXapHOZtRm+GpHsDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nMDcnKsc3Y8EHepIHj6cJpEUdueonmuZBPS39NOSBmZEG40AbrNYMYMg1a/m/w8onjThiklh3rR6h2YhNBCGm2W3hIUkh/j5xyHvjpxKzaRGGEXn046664SdlxbRpsgoHPrP9/B8sMshUuwZIgkJByJpSVYYtwF1QJX1Nv3SE2I=
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
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 317D32028FE;
	Wed, 16 Sep 2026 19:38:15 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x6taJ-001Go9-0J;
	Wed, 16 Sep 2026 19:38:15 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 16 Sep 2026 19:38:07 +0200
Subject: [PATCH 2/5] lib/tests: string_helpers: drop unused parameters
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-string_unescape-v1-2-7f8bd986fa33@pengutronix.de>
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
In-Reply-To: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
To: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=ECun2AALw4gQB+9hdl9j+YzzMYCXapHOZtRm+GpHsDA=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshadYWV57nK1ZIPb5Xi5f8teun3PfO55wl1RfEVEy6X3
 567Kv0ve0cpC4MYF4OsmCJLrJqcgpCx/3WzSrtYmDmsTCBDGLg4BWAiaTWMDNOX9UzUD5qRdpb1
 eGNR62xtJfnWuX6qTdqLy3bMvFT1k5HhNzvrXabcozkdrlP8zGO2fzH8HmbbfXmRbYL0kdJjERY
 WnAA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

Drop the unused parameters from test_string_check_buf() to improve
readability.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 lib/tests/string_helpers_kunit.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/tests/string_helpers_kunit.c b/lib/tests/string_helpers_kunit.c
index 9bc3acffaf2f..1ed652f762d1 100644
--- a/lib/tests/string_helpers_kunit.c
+++ b/lib/tests/string_helpers_kunit.c
@@ -18,7 +18,6 @@
 
 static void test_string_check_buf(struct kunit *test,
 				  const char *name, unsigned int flags,
-				  char *in, size_t p,
 				  char *out_real, size_t q_real,
 				  char *out_test, size_t q_test)
 {
@@ -101,8 +100,7 @@ static void test_string_unescape(struct kunit *test,
 		q_real = string_unescape(in, out_real, q_real, flags);
 	}
 
-	test_string_check_buf(test, name, flags, in, p - 1, out_real, q_real,
-			      out_test, q_test);
+	test_string_check_buf(test, name, flags, out_real, q_real, out_test, q_test);
 	KUNIT_EXPECT_EQ_MSG(test, out_real[q_real], '\0', "name:%s", name);
 }
 
@@ -457,8 +455,7 @@ static void test_string_escape(struct kunit *test, const char *name,
 
 	q_real = string_escape_mem(in, p, out_real, out_size, flags, esc);
 
-	test_string_check_buf(test, name, flags, in, p, out_real, q_real, out_test,
-			      q_test);
+	test_string_check_buf(test, name, flags, out_real, q_real, out_test, q_test);
 
 	test_string_escape_overflow(test, in, p, flags, esc, q_test, name);
 }

-- 
2.56.0.rc0.108.gf0ef1b96a0

