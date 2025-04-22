Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA331DFE8;
	Tue, 22 Apr 2025 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745342532; cv=none; b=XvBKR4+Bfik2f4exNb8e/SmnsqT7kn06iHTIFgnKaaByhJPL/oYQVyG/ZORQnQjBAryAOG63LM3P1Pvg7eS9Otshf9ncqUy5Wd9JEvVgTSrJGRTr3iEhCluEuHTTkTONbtNnAIn88J2nmrXqFPZeQBJRjzUZug027DuM3XT7JtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745342532; c=relaxed/simple;
	bh=30kKqaFuduO7eyom6+vPpvHDzqI9dCn3YSgXoyuTZfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxttED9kBBHE1jHKx+yj+hEWUMuUVnLvxxMeOvBr3BYXHs6drp8qVclslckPXbqZSbK96QdPn3TsyxkhIfTh+Y+Euz1o5et98RriA8tXjftOJigZ5TQo5sz4SH9kGlNBnsboqkvu39a8B82Vd/RDHLDLfgTFw0CGaK6vfH1SuXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bO4ZZYBF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bO4ZZYBF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A9EC4CEED;
	Tue, 22 Apr 2025 17:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745342531;
	bh=30kKqaFuduO7eyom6+vPpvHDzqI9dCn3YSgXoyuTZfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bO4ZZYBF5GZnJpsjIKNq+Sde4VFlAfX2V19inzK4ES0Nxz3MSyNDjHWSy0k1SgtFa
	 uaOUiUM9lXljztitSjkmW6Ixrlt6+I92HWSjyJeFCKgeOswiD9afyezQJSlL/0CLwJ
	 OV5fCOhMury/6oOREu1X/+mdtQnV8eVKy0twSsSV+kWEzmbxrQtf31hHaxiGD6qOgi
	 yLefCWEI8eLZtv1V2RTdMigJNHRXSu4L4Ru3TTw36v3VIkubmj9CkL3T3bRqpYA4X1
	 jFoAQROprnsM8Jz5ajEwKdIXNpIgw7DDZhR+hbApdgTC9smF5oaeejtZnT7QY4mdB9
	 EDcCk/YiL6a8Q==
Date: Tue, 22 Apr 2025 11:22:08 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2][next] kunit/overflow: Add tests for
 STACK_FLEX_ARRAY_SIZE() helper
Message-ID: <8cf48c3f9d8ef9b999d87cc0a822ffe539bf7a64.1745342381.git.gustavoars@kernel.org>
References: <cover.1745342381.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1745342381.git.gustavoars@kernel.org>

Add a couple of tests for new STACK_FLEX_ARRAY_SIZE() helper.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 lib/tests/overflow_kunit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/tests/overflow_kunit.c b/lib/tests/overflow_kunit.c
index 894691b4411a..3beb497a44be 100644
--- a/lib/tests/overflow_kunit.c
+++ b/lib/tests/overflow_kunit.c
@@ -1210,6 +1210,9 @@ static void DEFINE_FLEX_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, __struct_size(empty->array), 0);
 	KUNIT_EXPECT_EQ(test, __member_size(empty->array), 0);
 
+	KUNIT_EXPECT_EQ(test, STACK_FLEX_ARRAY_SIZE(two, array), 2);
+	KUNIT_EXPECT_EQ(test, STACK_FLEX_ARRAY_SIZE(eight, array), 8);
+
 	/* If __counted_by is not being used, array size will have the on-stack size. */
 	if (!IS_ENABLED(CONFIG_CC_HAS_COUNTED_BY))
 		array_size_override = 2 * sizeof(s16);
-- 
2.43.0

