Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398311A71F
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 15:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69593C433C7;
	Fri, 29 Sep 2023 15:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696002136;
	bh=Zl9IzDfJ74tSHG7Bo3AkrSgoNzTjNILJUvTaD+C2hpM=;
	h=Date:From:To:Cc:Subject:From;
	b=qyDMdW5b+k9YsTcDHVa6jtbOihi/nlM/xncg5bZPJCRQEuUEtK6jXE+OoW58OSQKD
	 ZgwbxqXxdZAEhgaBpWo1c6XxZXkhcZxQDzvkVFpR2DU9DUyFLlUaKG82/Y8YTNd8xi
	 O0d0hVUy/uqd4PbDUTXeIbpEcm8etsmdMnXgFmi3YG/Rq2A8LhFPDcVj5uCKaLcWOc
	 ohsuJ5/hPAQT39aQW/NCjmO153g/RPL8acTQLExpvutAuJQEAvtDUH8TEmcY4LJcTv
	 rMg8SZZn5zoIF+WcA/LUJT8UlLl173AXx+XZ1ysj4XwrpKtIvsUSoTcTAcC9B13QIb
	 /KAO3+pqJztOQ==
Date: Fri, 29 Sep 2023 17:42:11 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] media: usb: siano: Fix undefined behavior bug in
 struct smsusb_urb_t
Message-ID: <ZRbwU8Qnx28gpbuO@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

`struct urb` is a flexible structure, which means that it contains a
flexible-array member at the bottom. This could potentially lead to an
overwrite of the object `wq` at run-time with the contents of `urb`.

Fix this by placing object `urb` at the end of `struct smsusb_urb_t`.

Fixes: dd47fbd40e6e ("[media] smsusb: don't sleep while atomic")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/media/usb/siano/smsusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
index 9d9e14c858e6..2c048f8e8371 100644
--- a/drivers/media/usb/siano/smsusb.c
+++ b/drivers/media/usb/siano/smsusb.c
@@ -40,10 +40,10 @@ struct smsusb_urb_t {
 	struct smscore_buffer_t *cb;
 	struct smsusb_device_t *dev;
 
-	struct urb urb;
-
 	/* For the bottom half */
 	struct work_struct wq;
+
+	struct urb urb;
 };
 
 struct smsusb_device_t {
-- 
2.34.1

