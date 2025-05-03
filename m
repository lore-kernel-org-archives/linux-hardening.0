Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD211A23B0;
	Sat,  3 May 2025 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746305011; cv=none; b=XDUVid30vlghu2U4IArDPqwNc2sVGgj7rM73DOjL06PDPuhHdQoNMbu1B609Axztw9Ec8yFWjNWo9MiawQHdCZIBKtYNIhVGcgK/G8Sxh7NMTY5aCIBhRKAPkLSEcLnwczFBoOmGBjEkxfxbFlkYCmTW1ZeqathzHCBv47O5VaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746305011; c=relaxed/simple;
	bh=2kYIDxUSNIhuk6XAdC4IwpYi/8qYhnjXYhU2lSsqvVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p2YeXj7XHCyQx7xHQLGiev9uWuLgwt8QgSuPhO2oK0RR/wls+SCP+f33rerQUOHJrX9nSZf4bSvQ89FPlOpMhY3u5wdZDoX9YPDJOVwIKwQok1bGTkgQwFiuUUVCrK9J21GSrMRTSzqSLy5MwOncnQqx8Gk7qgnnubgNyXUaAzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=pN5ooFea; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="pN5ooFea"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZqfrX6vc0z9sJ2;
	Sat,  3 May 2025 22:43:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1746305005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+f8DYjNt9PFVqfIo6Y2nTQ6Nf76jZWR3hZhg9UXSZtI=;
	b=pN5ooFea8VqSwKhSdv3X8cXmhNOp0oDEsa+k08S18kr31iY7q8poHgZ/XGRPuxVE8y0erV
	Rbjx5BubcXqZB1wgNmepp2mFYwF7zJ8stfB69/9WodhC74mpEi7oG4SaIliXfNepDXfWb9
	hDFALnt/PhhEmNUR1H9HQfXuRP0EBhItwxqblzmmZSI6MviRaiexjsPxKFYGtwH4nTAyhJ
	2i/ccjlUItPrTIbhLWOJgPEHnxd5HpoXLKjfS9jKrDKs3xyX0ABKir3oKO3Ps4Yl00kuzs
	+IKWVz58xt6BE5FwudyKifKc7bQeRu04q9cSo6EVuI1SzCdgnJQrDXROFZvtcw==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Sat, 03 May 2025 16:43:21 -0400
Subject: [PATCH] usb: misc: adutux: replace kmalloc() with kmalloc_array()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-adutux_kmalloc_array-v1-1-80c74c4bd3e7@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAOh/FmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUwNj3cSU0pLSivjs3MScnPzk+MSiosRK3WQLwyTTFPNk4yRjcyWg1oK
 i1LTMCrCx0bG1tQDjbD3oZgAAAA==
X-Change-ID: 20250503-adutux_kmalloc_array-c81b5d7c3b37
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=2kYIDxUSNIhuk6XAdC4IwpYi/8qYhnjXYhU2lSsqvVg=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeFpJalZ2elM5N1NQd3lFbEwxK0dwL1k5YWlhSXJmOFE4Cnc2Tm5ud3l2bngxb3V1K2Fj
 MlpIS1F1REdCZURySmdpeS84YzViU0htak1VZHY1MWFZS1p3OG9FTW9TQmkxTUEKSnBKMG5KRmh
 CL3ZWaHFCVlhiY2QrMDdNbmhuQTFUMDUybmJKUnNsTmQvbE1kWG0zSkd5N3hjaHc0WGo3dHB1Zg
 pESzNNZ3dTZjg2UnZpRGdadTc3dnpiL0hrK2JLejRsMjl2M09CUURFZTB4dAo9RmVGVwotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

Replace kmalloc with internal multiplication with kmalloc_array to
improve code readability and prevent potential overflows.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/usb/misc/adutux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/adutux.c b/drivers/usb/misc/adutux.c
index ed6a19254d2ff9fead898adad0b3996822e10167..000a3ade743258f381d85397395a43c28a8481cc 100644
--- a/drivers/usb/misc/adutux.c
+++ b/drivers/usb/misc/adutux.c
@@ -680,7 +680,7 @@ static int adu_probe(struct usb_interface *interface,
 	in_end_size = usb_endpoint_maxp(dev->interrupt_in_endpoint);
 	out_end_size = usb_endpoint_maxp(dev->interrupt_out_endpoint);
 
-	dev->read_buffer_primary = kmalloc((4 * in_end_size), GFP_KERNEL);
+	dev->read_buffer_primary = kmalloc_array(4, in_end_size, GFP_KERNEL);
 	if (!dev->read_buffer_primary)
 		goto error;
 
@@ -690,7 +690,7 @@ static int adu_probe(struct usb_interface *interface,
 	memset(dev->read_buffer_primary + (2 * in_end_size), 'c', in_end_size);
 	memset(dev->read_buffer_primary + (3 * in_end_size), 'd', in_end_size);
 
-	dev->read_buffer_secondary = kmalloc((4 * in_end_size), GFP_KERNEL);
+	dev->read_buffer_secondary = kmalloc_array(4, in_end_size, GFP_KERNEL);
 	if (!dev->read_buffer_secondary)
 		goto error;
 

---
base-commit: 37ff6e9a2ce321b7932d3987701757fb4d87b0e6
change-id: 20250503-adutux_kmalloc_array-c81b5d7c3b37

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>

