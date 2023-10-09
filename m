Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382AB156E1;
	Mon,  9 Oct 2023 21:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyYdAZ9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBB9C433C7;
	Mon,  9 Oct 2023 21:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696888383;
	bh=W+VZfakyDjRAObO1dDQmRahEdfhe6IqKNZRo1tRwkuk=;
	h=Date:From:To:Cc:Subject:From;
	b=IyYdAZ9EdWVH9jfcqTIBghy4+Muh2EwEWNScrz4b6/aGOUsd4mtqMfoBGTvK0lO6c
	 onA3n0Ti125FvNmSQK8G0nHnkQuQfLHPIw94GdKqymW9RjYlnO5rr8K59gXix6rYDv
	 K+smp/Ptnv2nHzZokKGH0fagbuF1UXumVrzSuy0S+2dpj6k0oYedewNK8JDJCA4UBh
	 2kaFeZIXRSskXp46DKazFRFkJSWh0LQUEl4WA4ZKmoYOfpOlfrz6Q1kGaCyWSDkKHV
	 R+pJO6bQVK5kh2aPVWX0fFUVo6ErAoyTDyV3dCkv9qD4GYbDHRsqsj4TsHtEtYQEZn
	 AaCet59ZGYm5w==
Date: Mon, 9 Oct 2023 15:52:59 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] staging: greybus: Add __counted_by for struct
 apr_rx_buf and use struct_size()
Message-ID: <ZSR2O6zGyT/VX6ve@work>
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
 drivers/staging/greybus/raw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/raw.c b/drivers/staging/greybus/raw.c
index a00978c8e1d2..b9c6eff7cdc1 100644
--- a/drivers/staging/greybus/raw.c
+++ b/drivers/staging/greybus/raw.c
@@ -29,7 +29,7 @@ struct gb_raw {
 struct raw_data {
 	struct list_head entry;
 	u32 len;
-	u8 data[];
+	u8 data[] __counted_by(len);
 };
 
 static const struct class raw_class = {
@@ -73,7 +73,7 @@ static int receive_data(struct gb_raw *raw, u32 len, u8 *data)
 		goto exit;
 	}
 
-	raw_data = kmalloc(sizeof(*raw_data) + len, GFP_KERNEL);
+	raw_data = kmalloc(struct_size(raw_data, data, len), GFP_KERNEL);
 	if (!raw_data) {
 		retval = -ENOMEM;
 		goto exit;
-- 
2.34.1

