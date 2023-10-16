Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559E8347AA
	for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 22:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDJ3m32h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E17C433C7;
	Mon, 16 Oct 2023 22:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697493888;
	bh=Zu8r+UFNm3vd5emenr5/jPt+Q2RIuOTafj17uJohU+Y=;
	h=Date:From:To:Cc:Subject:From;
	b=SDJ3m32h5Fq72f4xV1Mgs/ZVsIsG4MjIHRKKj/QV8CAZ77CUIzbBiFEqi2QnZz0yR
	 NspIuMLPXzPeHhLFILOZ/UehXr7pIloHyDcr42gnrgPlmqSJDZkDIjy2Q7yeU23lDM
	 vqH8+YmU4V0GTZPZKHMl5Ti64omHBT0tydfkyFNp5vjbevwRvEhPT1agkRuiY55d7l
	 y0UoOCnk0XhVXZJy82x+htxUg081xzhEJPlEAGCzgYRlnXfyQm9BoOrCR45U9lcOAI
	 75huKhqZ9nLcNvR4a1FUSkcT7U1IPqlSbU5087htRSiXfsgTVEPPljFoEJQYuUWq7d
	 6RI2mMc7nuG9w==
Date: Mon, 16 Oct 2023 16:04:44 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: Kees Cook <keescook@chromium.org>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/2][next] clk: visconti: Fix undefined behavior bug and
 add bounds-checking coverage
Message-ID: <cover.1697492890.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This small series aims to fix an undefined behavior bug in
`struct visconti_pll_provider` and add bounds-checking
coverage at run-time for flexible-array member `hws`
in `struct clk_hw_onecell_data` when accessed throught
`struct visconti_pll_provider`.

Changes in v2:
 - Mention -Wflex-array-member-not-at-end in the changelog text.

v1:
 - Link: https://lore.kernel.org/linux-hardening/cover.1697076650.git.gustavoars@kernel.org/

Gustavo A. R. Silva (2):
  clk: visconti: Fix undefined behavior bug in struct
    visconti_pll_provider
  clk: visconti: Add bounds-checking coverage for struct
    visconti_pll_provider

 drivers/clk/visconti/pll.c | 6 +++---
 drivers/clk/visconti/pll.h | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.34.1

