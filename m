Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D323C681
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhC6t7VJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C09C433C7;
	Mon,  9 Oct 2023 19:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696880481;
	bh=3m8vfJotEQ3gbSMgx24f32JgP5HmYW7wJZrzxltQSBs=;
	h=Date:From:To:Cc:Subject:From;
	b=uhC6t7VJO+HL06uaAHUWAJUdKbYI1U0I4lHAaKZd4bTG5TO0SzI4JO02sEqNYsuDE
	 ZT5ovm+BxxZ/PabeZEwHa5iWpZ7qTf0S7GezI4mDDGLsZ8KxhENtVfi7xXIMiXj9yu
	 NB5aARhXR239GMlhoDAunPLa/kPwWmrjOfGUiQ1xW1nHrAv1j445CAlIYuhhHMTwub
	 TmgB3wSrGsv/yyDQyCgjpfJ9+CNla5nIkaRna/JnEnLkt9+Ezyy2DK6wNr4KxU36fS
	 /3xkom5ZGapfi75jW1iWdXlGkjIkss4HPI92i5JKnWHM/Fstt0+Hv1y0qcIQV64cvV
	 qmnl8EpzozcQw==
Date: Mon, 9 Oct 2023 13:41:18 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] hostap: Add __counted_by for struct
 prism2_download_data and use struct_size()
Message-ID: <ZSRXXvWMMkm7qqRW@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

While there, use struct_size() helper, instead of the open-coded
version, to calculate the size for the allocation of the whole
flexible structure, including of course, the flexible-array member.

This code was found with the help of Coccinelle, and audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/intersil/hostap/hostap_download.c | 3 +--
 drivers/net/wireless/intersil/hostap/hostap_wlan.h     | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intersil/hostap/hostap_download.c b/drivers/net/wireless/intersil/hostap/hostap_download.c
index 3672291ced5c..5e5bada28b5b 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_download.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_download.c
@@ -732,8 +732,7 @@ static int prism2_download(local_info_t *local,
 		goto out;
 	}
 
-	dl = kzalloc(sizeof(*dl) + param->num_areas *
-		     sizeof(struct prism2_download_data_area), GFP_KERNEL);
+	dl = kzalloc(struct_size(dl, data, param->num_areas), GFP_KERNEL);
 	if (dl == NULL) {
 		ret = -ENOMEM;
 		goto out;
diff --git a/drivers/net/wireless/intersil/hostap/hostap_wlan.h b/drivers/net/wireless/intersil/hostap/hostap_wlan.h
index c25cd21d18bd..f71c0545c0be 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_wlan.h
+++ b/drivers/net/wireless/intersil/hostap/hostap_wlan.h
@@ -617,7 +617,7 @@ struct prism2_download_data {
 		u32 addr; /* wlan card address */
 		u32 len;
 		u8 *data; /* allocated data */
-	} data[];
+	} data[] __counted_by(num_areas);
 };
 
 
-- 
2.34.1

