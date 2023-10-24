Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A845F6FA8
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 03:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHQ7sKHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93ECBC433C7;
	Tue, 24 Oct 2023 03:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698118206;
	bh=m6aDnL/Wqs3CWj+B9Tf1lfn61pxuZpDr4pD8/+/qlYU=;
	h=Date:From:To:Cc:Subject:From;
	b=KHQ7sKHWH31O7ePKffnaxCnVkIz59sZ3XmACN8pX5LJL4JtG/MNhKzN+yVNF3EgW6
	 AmJ+IFocfqLTCC6Fh/ts9yYtDVaQZw74pQbwCiEKE9zrh34V1qZ/CzFsgfoZxdBU6t
	 wTpubIFUGFIDzWGG3+tP3RAhVw96PBGPhXeLCVb9203pOWTzz1kIcZG1hELthejFk/
	 as0abOc2kbA9ZGw1Zr0EB5K+Qp5sLhXxdKy8UVEHQ4iFYng2TEpgNoaetKACHqGUgF
	 sxS6W4+McVWZ3McNqhlnRvKV+F7vHrwuSs1Lhd2ffHhRRoMD0+Ctq6g5L8EqMZQ4Zw
	 ZrM3wq4/kJ0FA==
Date: Mon, 23 Oct 2023 21:30:03 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 0/2][next] clk: socfpga: Fix undefined behavior bug and
 add bounds-checking coverage
Message-ID: <cover.1698117815.git.gustavoars@kernel.org>
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

Changes in v3:
 - None, really. Just Cc linux-clk@vger.kernel.org this time.

Changes in v2:
 - Mention -Wflex-array-member-not-at-end in the changelog text.
 - Link: https://lore.kernel.org/linux-hardening/cover.1697493574.git.gustavoars@kernel.org/

v1:
 - Link: https://lore.kernel.org/linux-hardening/cover.1697059539.git.gustavoars@kernel.org/

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

