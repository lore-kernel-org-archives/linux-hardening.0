Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B037A1BDF8
	for <linux-hardening@vger.kernel.org>; Wed, 11 Oct 2023 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcXMT7cd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5210BC433C8;
	Wed, 11 Oct 2023 21:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697059904;
	bh=lLHvRjO2hpj6pfzRBw60Ir1FexEK3IHfQeGlLMPq+4E=;
	h=Date:From:To:Cc:Subject:From;
	b=ZcXMT7cdPU4QNv5ttgsv97XAMjAfmVuVEAbVODHGFQjnWw+lb/9oJKAPsfVWxNoJ4
	 Dst9SlHBU/71FSEfMXNT1iSKRAreG9Q9pdk+Wb7210cW7RQiEmORknUqAaQ8iwEChA
	 SsS1Y+yXvqcs5MMdJYKTMOUhWKdNIpKWLpXWbNBoKHF3o8xAuTzHdjwMXZzc3vznVM
	 ocWqF5UR74AHCj2Oz2PcrG9GSSCqspGKTQKSHuM6BY39tV47XihKOZiE2Q06zOvKW2
	 ndCqI9Qr++/pkvXdvCyveNhjP9QyISXmhlGe32uysv2o1tmUINKAJbUnIVRSRWrGkm
	 OJ4WFterEyTuQ==
Date: Wed, 11 Oct 2023 15:31:40 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/2][next] Fix undefined behavior bug and add bounds-checking
 coverage
Message-ID: <cover.1697059539.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series aims to fix an undefined behavior bug in
`struct stratix10_clock_data` and add bounds-checking
coverage at run-time for flexible-array member `hws`
in `struct clk_hw_onecell_data` when accessed throught
`struct stratix10_clock_data`.

Gustavo A. R. Silva (2):
  clk: socfpga: Fix undefined behavior bug in struct
    stratix10_clock_data
  clk: socfpga: agilex: Add bounds-checking coverage for struct
    stratix10_clock_data

 drivers/clk/socfpga/clk-agilex.c    | 12 ++++++------
 drivers/clk/socfpga/clk-s10.c       |  6 +++---
 drivers/clk/socfpga/stratix10-clk.h |  4 +++-
 3 files changed, 12 insertions(+), 10 deletions(-)

-- 
2.34.1

