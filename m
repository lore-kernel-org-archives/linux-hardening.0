Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FA67E4
	for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 02:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjwYMpdr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75749C433C8;
	Thu, 12 Oct 2023 02:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697076888;
	bh=c3G3HVGvGIs8FEY0jb1ba95NJxbK+CEvkZgGlWn3Ck8=;
	h=Date:From:To:Cc:Subject:From;
	b=WjwYMpdrkWZm3vLulM3RsDQKQum6qGR9K0uqFhKd8F01NZVWAXktIY/Ko1CBeT8x8
	 WRGwXIXVZTewXpB417CEpj+b0DiWl/L3YO9qkTKxPqNc+7WSO2RbwneUFB0xADWeVS
	 Sd2Lb2J6A+YeGMh7EWLkGT8gQL3wYsLIn7K56oUXa5CVDow7lWGriOTyJ7hZmicXec
	 gkEiDUJ3QwyH1VXFLYl5jHxtGwgwml6rTE+zvqyZ7HoR3GyuPYdUuycvPrvbWnjuCj
	 iXgydgtZP/O7gLo0q6vFbFZIQFHpQfziccSsoFGUsrXAlCKvMnVH++uCGSbnbyItyd
	 N8lANoTEHuT2A==
Date: Wed, 11 Oct 2023 20:14:44 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: Kees Cook <keescook@chromium.org>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/2][next] clk: visconti: Fix undefined behavior bug and add
 bounds-checking coverage
Message-ID: <cover.1697076650.git.gustavoars@kernel.org>
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

