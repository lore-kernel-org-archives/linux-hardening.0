Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14952561AC;
	Tue, 22 Apr 2025 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745356065; cv=none; b=bVFzR/N2cu/BwCfjexo909L1Tu/JoV+A8OmvFEAegvFBUegC/euOaHfCHVHhIGlyhfD9l5scEQetAMRe2ZGnbBVsGb+sX+MzWLTKWavxAfrLbLAsBplYZS2p7FGfKXG+AWlM4cTlELqJZJ7Q8eWXSXaMmWtQxoFNWhRZ+TK9BAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745356065; c=relaxed/simple;
	bh=9JSlKwjDOZWbObZH/GEonA6F4eOl4NiGxW9Zajz1h8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/bB+L062eWOPHiwiZ1k0hYs3pl7WxYSLsfxfc1rFLYHrxf5N1fbRBErs7MjgYyoecywjqe5wPTT6GHHAsiPqcNsFQvq23QQbhbHErDF0YOxK3wIngUt4YRJmM2MEldefZI/gq4GsYf3KdvAUndMBT1h73zjoC5BO5oNSriA/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/N8gWSM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/N8gWSM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3B7C4CEE9;
	Tue, 22 Apr 2025 21:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745356065;
	bh=9JSlKwjDOZWbObZH/GEonA6F4eOl4NiGxW9Zajz1h8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U/N8gWSM3DNP6z4j6+0fsmMKv8+7IxNVWZ7aiQXxC8UopH08GW1Ia/DGGjCQsD4We
	 8/OQYWd5fY6VYTRZ8GV6lCDx6fDdkOZ1RGtSS1N1zKsFiKF/iJ93MMDli8gWJSQh9L
	 g3ubutNwMzrddEmkhucvYhX48jvGIGpCDOzEL1KJM3ol252hSbiWmF9NUoOiNSC8Rd
	 3cR7qfMq65znnQfZ8QfHGiNW/ynuHi3oQYGw9KukXffbmO5wq6k02hXCAhqr6scaly
	 cSdc8m4izQ/yE024qiL9CNqSBaqVALgKa47PQdKeg+v2iIznL+Qf9jv3HiBh2Z5NHW
	 3L04gku7pwL3g==
Date: Tue, 22 Apr 2025 15:07:41 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2][next] kunit/overflow: Add tests for
 STACK_FLEX_ARRAY_SIZE() helper
Message-ID: <c127631a03cdd7f59bfa091b9666a93bf69d0322.1745355442.git.gustavoars@kernel.org>
References: <cover.1745355442.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1745355442.git.gustavoars@kernel.org>

Add a couple of tests for new STACK_FLEX_ARRAY_SIZE() helper.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes v2:
 - Add 0 test for `empty` instance.

v1:
 - Link: https://lore.kernel.org/linux-hardening/8cf48c3f9d8ef9b999d87cc0a822ffe539bf7a64.1745342381.git.gustavoars@kernel.org/

 lib/tests/overflow_kunit.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/tests/overflow_kunit.c b/lib/tests/overflow_kunit.c
index 894691b4411a..19cb03b25dc5 100644
--- a/lib/tests/overflow_kunit.c
+++ b/lib/tests/overflow_kunit.c
@@ -1210,6 +1210,10 @@ static void DEFINE_FLEX_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, __struct_size(empty->array), 0);
 	KUNIT_EXPECT_EQ(test, __member_size(empty->array), 0);
 
+	KUNIT_EXPECT_EQ(test, STACK_FLEX_ARRAY_SIZE(two, array), 2);
+	KUNIT_EXPECT_EQ(test, STACK_FLEX_ARRAY_SIZE(eight, array), 8);
+	KUNIT_EXPECT_EQ(test, STACK_FLEX_ARRAY_SIZE(empty, array), 0);
+
 	/* If __counted_by is not being used, array size will have the on-stack size. */
 	if (!IS_ENABLED(CONFIG_CC_HAS_COUNTED_BY))
 		array_size_override = 2 * sizeof(s16);
-- 
2.43.0

