Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE884D7D35;
	Wed, 16 Sep 2026 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580320; cv=none; b=SDmT2f4JSFhJa6NC4n1tMuCvcNn99crZlOfr+ylXgS1n2P8v8RUeqVu8KYPLSreyKmISqcfpKKA0+Q9yEPusKr0jZp7lJa7Z3KlnnR1kXEqHqu1nT4/FEuEHveRAA9gE/Qd6QOp/xGLi5Y3nUQBucP77dKZ3lHLjEFnTf/fUoeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580320; c=relaxed/simple;
	bh=rVt8YGwnDLRp84WV00lbEvbeEVulHf6uFDxTB/Nn2/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gshCjq9xvUotqlERhK51JAoIoi+a+gsVvLNqjo17MqUmYlFOaxuNRdA/DFg217xyKeDGnu77n9Ms8XRl6OzE2dUxt8OBQPoV4bG45SJF6LFMdbNfb7LDogqhj/DUEGZCKWWlalSVH0OI6MhAIm03hDuQ7gjD8uQn1IpoLmuNB9o=
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
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 406AD202B14;
	Wed, 16 Sep 2026 19:38:15 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x6taJ-001Go9-0T;
	Wed, 16 Sep 2026 19:38:15 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 16 Sep 2026 19:38:08 +0200
Subject: [PATCH 3/5] lib/tests: string_helpers: introduce
 test_string_unescape_one
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-string_unescape-v1-3-7f8bd986fa33@pengutronix.de>
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
In-Reply-To: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
To: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2968; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=rVt8YGwnDLRp84WV00lbEvbeEVulHf6uFDxTB/Nn2/w=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshadYX1Zc2KMLvXSZ5XnPQPvF2wbe4BJtNy62cGnzheh
 BZfWHsiq6OUhUGMi0FWTJElVk1OQcjY/7pZpV0szBxWJpAhDFycAjCRqp+MDN+exURdn2PzJnih
 2Mprt3xWRfvJyDlZyU/dPlvRI239MiWGf6aPT5wS96pVTWhs+fvH9D7z3ZwD9784TPVey6GwQ+2
 JKg8A
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

The existing test_string_unescape() function follows a complex procedure
where it, given a set of UNESCAPE flags, appends multiple test fragments
and predicts their unescape result for the chosen set of flags. Rename
test_string_unescape() to a more descriptive
test_string_unescape_combined

In preparation to add simple regression tests, introduce
test_string_unescape_one() which asserts on exactly one call to
string_unescape.

Add some tests for corner cases which already pass.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 lib/tests/string_helpers_kunit.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/lib/tests/string_helpers_kunit.c b/lib/tests/string_helpers_kunit.c
index 1ed652f762d1..3c6fa7324965 100644
--- a/lib/tests/string_helpers_kunit.c
+++ b/lib/tests/string_helpers_kunit.c
@@ -55,9 +55,9 @@ static const struct test_string strings[] = {
 	},
 };
 
-static void test_string_unescape(struct kunit *test,
-				 const char *name, unsigned int flags,
-				 bool inplace)
+static void test_string_unescape_combined(struct kunit *test,
+					  const char *name, unsigned int flags,
+					  bool inplace)
 {
 	int q_real = 256;
 	char *in = kunit_kzalloc(test, q_real, GFP_KERNEL);
@@ -596,14 +596,33 @@ static void test_upper_lower(struct kunit *test)
 	}
 }
 
+static void test_string_unescape_one(struct kunit *test,
+				     const char *name, unsigned int flags,
+				     char *src, size_t len,
+				     char *out_test, size_t q_test)
+{
+	char *out_real = kunit_kzalloc(test, len, GFP_KERNEL);
+	int q_real;
+
+	q_real = string_unescape(src, out_real, len, flags);
+	test_string_check_buf(test, name, flags, out_real, q_real, out_test, q_test);
+}
+
 static void test_unescape(struct kunit *test)
 {
 	unsigned int i;
 
 	for (i = 0; i < UNESCAPE_ALL_MASK + 1; i++)
-		test_string_unescape(test, "unescape", i, false);
-	test_string_unescape(test, "unescape inplace",
-			     get_random_u32_below(UNESCAPE_ALL_MASK + 1), true);
+		test_string_unescape_combined(test, "unescape", i, false);
+	test_string_unescape_combined(test, "unescape inplace",
+				      get_random_u32_below(UNESCAPE_ALL_MASK + 1), true);
+
+	test_string_unescape_one(test, "simple case", UNESCAPE_HEX | UNESCAPE_SPECIAL, "ABC", 6, "ABC", 3);
+	test_string_unescape_one(test, "single escape", UNESCAPE_HEX | UNESCAPE_SPECIAL, "A\\x42C", 6, "ABC", 3);
+	test_string_unescape_one(test, "escape before end", UNESCAPE_HEX, "B\\qX", 4, "B\\q", 3);
+	test_string_unescape_one(test, "escape at end", UNESCAPE_HEX, "a\\qX", 3, "a\\", 2);
+	test_string_unescape_one(test, "backslash before escape", UNESCAPE_HEX, "\\\\x41B", 12, "\\\\x41B", 6);
+	test_string_unescape_one(test, "backslash escape", UNESCAPE_HEX | UNESCAPE_SPECIAL, "\\\\x41B", 16, "\\x41B", 5);
 }
 
 static void test_escape(struct kunit *test)

-- 
2.56.0.rc0.108.gf0ef1b96a0

