Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15D729009C;
	Tue, 22 Apr 2025 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745342443; cv=none; b=kXIMLjnF5oYh9NVGU9N46Uig4IwC759dRM0eyCnm332uPv8zOwIZlvqOrWV1y6V+xRGfpbK9O74lmV8i9XVib/ekmm0W75SVIMvpLM6NmUZp9xyUcG8mR+mBBHOHLxYFKVVSML76zANyMcLBlYkW3/iEEleFPo/PUJXleKq2M2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745342443; c=relaxed/simple;
	bh=lpo/asLav3oAyh0MFxDEsC60SBgA1NgyFy7Ml2zYgQI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Wb/2DJZDLoqu69qPNDtci5NkuDc5UR7+ds682uLByFFF4ekLSCdDBIs8UodzAoKJ8CziIe0vC34K5V5y8Bn02zAOju/cIvTW+cFteS7WLL15g7s240GWdp5HyBscM3PbSS/dqvqtaZNjht0qJ98ptYnBIPwgmzzTAZd2DZQJ+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxV0JLUP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxV0JLUP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD22C4CEE9;
	Tue, 22 Apr 2025 17:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745342443;
	bh=lpo/asLav3oAyh0MFxDEsC60SBgA1NgyFy7Ml2zYgQI=;
	h=Date:From:To:Cc:Subject:From;
	b=JxV0JLUPmUG5K5B0+kzJav89sVbSrugBY4d0OAz3o7yzzIigFbCGVKkzlhkCRGh4i
	 9qSLbnHCankbeLQBNY49kOHN6Q5qBl3OKDzS5KI0qqzpHDUQ2td1X1+62mNIRp0bKO
	 kaBvx84obt/nYXhTQgPImAERcPIkFZc89ox4IyFfPuN5w8A3auEBxlovdzVICxy8Vr
	 kvbO00ZVB3HGj3OOGJ/QL5yjcx/5s4Xs9i8E8vKyB7ui4ip77C7mXuFSq/LE1Co9fB
	 pctI755bIx5i2zro54f+0ub+3XnrZ2+9bwQBE1H+9iixkCqpZnPkuustXYi5ouAc+A
	 KL3kc8VkbcCyA==
Date: Tue, 22 Apr 2025 11:20:40 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2][next] Add STACK_FLEX_ARRAY_SIZE() helper
Message-ID: <cover.1745342381.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add new STACK_FLEX_ARRAY_SIZE() helper to get the size of a
flexible-array member defined using DEFINE_FLEX()/DEFINE_RAW_FLEX()
at compile time.

This is essentially the same as ARRAY_SIZE() but for on-stack
flexible-array members.

Gustavo A. R. Silva (2):
  overflow: Add STACK_FLEX_ARRAY_SIZE() helper
  kunit/overflow: Add tests for STACK_FLEX_ARRAY_SIZE() helper

 include/linux/overflow.h   | 13 +++++++++++++
 lib/tests/overflow_kunit.c |  3 +++
 2 files changed, 16 insertions(+)

-- 
2.43.0

