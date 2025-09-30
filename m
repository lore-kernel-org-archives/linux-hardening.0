Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7714D21A95D
	for <linux-hardening@vger.kernel.org>; Tue, 30 Sep 2025 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759224086; cv=none; b=qX+69tBHCd2r7bSk//3NhOJ0a2jKwKsq9OeYS5VWYyiiAwFVojdYYIJhZIP5OvJyxLs2YppMpgg9gismmKduIN5PTHrQDaze6ETdallsv0+cOtUx2CpBNBdmC8wvVXU98AVRtAGeiUiSCsP76wxrmW4aCT8hU3qs2WMMZphFax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759224086; c=relaxed/simple;
	bh=rfsb2QgV9gE8owTKtx+ktFw7AKzvTfRLqTJDGMGEdqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dt9a9xmdkTrmXFwMgNwRWABBF6ZuPuoP5vEL1qweVXtsXuEJ4R0O8kOZI0ahlMGi2uMR9kGGkiKK7EttVfvO5wARgc27ygIKtIKwjUzAR4BCF4QjzHZl3xE1srJGdt93IddUjeUgg5T8HrSJCeIo17MWw/kU5ESPIy33uf8KMxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROLP6+gn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROLP6+gn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24286C4CEF0;
	Tue, 30 Sep 2025 09:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759224086;
	bh=rfsb2QgV9gE8owTKtx+ktFw7AKzvTfRLqTJDGMGEdqM=;
	h=From:To:Cc:Subject:Date:From;
	b=ROLP6+gnnPRQ/c5UnkEEv+zr/7bCcfGn2vLOrnn5khcboEf63d3DMeFlbuNYw2/T6
	 4UgYMKG/ek3e9VxBKLhYWsLLbw4jjz41NRm1vCx2DvJj8IDFRt82CDhAu7WPf04GnS
	 P/Cz4VYxMjkmgqUq/uo5HATD71xQ3MnPirAK1cCFZ02mZzxZy03MVyzELWBVboCtCI
	 i0phCzEpv26itimWMleuY0sghspmAZQbEqqXeD8Kgkl2tRnsXXf98k3tTGv/m0UEpr
	 xFzOBk9791Oa8JEnN4hDq8dgCVWtjArUBQjBOr27MCxok+7s2pnUpHaXZlCgQPe+tf
	 5/mIuCmrjyJRw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH] pstore/ram: Update module parameters from platform data
Date: Tue, 30 Sep 2025 09:21:01 +0000
Message-ID: <20250930092101.698737-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.51.0.570.gb178f27e6d-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update module parameters `mem_type` and `ramoops_ecc` from platform data
so that they are available through /sys/module/ramoops/parameters/.

`ramoops_dump_oops` isn't included as it has been deprecated.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 fs/pstore/ram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index bc68b4de5287..39936d6da0dd 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -864,6 +864,8 @@ static int ramoops_probe(struct platform_device *pdev)
 	ramoops_console_size = pdata->console_size;
 	ramoops_pmsg_size = pdata->pmsg_size;
 	ramoops_ftrace_size = pdata->ftrace_size;
+	mem_type = pdata->mem_type;
+	ramoops_ecc = pdata->ecc_info.ecc_size;
 
 	pr_info("using 0x%lx@0x%llx, ecc: %d\n",
 		cxt->size, (unsigned long long)cxt->phys_addr,
-- 
2.51.0.570.gb178f27e6d-goog

