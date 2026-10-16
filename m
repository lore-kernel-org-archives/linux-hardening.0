Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A77853D0CB
	for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2026 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170272; cv=none; b=npkQ5Grm12A8y8BQQWM8+1pFx/qpYq+/csTaXWuYXfSG62xI37se/8r72Xxj+X1VpechkB9+cye5AaN6houiqGNFIhHIyHb4Na3M/7sLUxPU2WQnInJkjVZ974ZpuzjhMBwe12vXRmwkrKqKDKWT7JTDfL2hRZ6X5zMom6Qjeqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170272; c=relaxed/simple;
	bh=RfoITBHU/34UblaJczsB41NK5NQZH3g/VaxCKH1Y1A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7jo9MmLWoLPZb5x7v0Vjpj7kCLCC1DzaPQtOlkv7CU2TDjRE05QMU9eml6BUmyHx+3K00wDS6rlOTBTDWkqIctrxzAUrVYf7uF6iMYiutP1OrUDN6VPHafXBF5wZBAaPkh7HQd/UcdMzqdM7q7EHv0+2CiF8Z6SeDwkuaQMFBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIKFB+8l; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIKFB+8l"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-3ab37ea4798so70768a91.0
        for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2026 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792170271; x=1792775071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WLJ8r+Qkw352j8qkFr8FpLRJS070PYdeAw/tFXJw0Kc=;
        b=jIKFB+8l3+DwwqfX3kzjjhpslR2BFg7T4zPTw+L74gl9IP4iXIiqXXrFJzjhVKGusm
         ogf3CdbvLiQLGH+lepLqlWYN4YAAJSucvQnIXQ2BNYfGYXcTrjPp6jjFQSlCQ1a6OIkQ
         +MWv7WpfJwPi/T4LHmgtRhj2+gNvC4zvjSyxEgxH29dKTP/k6vux+cjkVw91qnM/VTBn
         AN8LvFgNJg7HKLGvR8kGMoRBKrJ+VUHsAyVQSWb8QSWkzM+nW88HL9bWFT7bLx8uhVCg
         zVZ9umEJ6b75ldMNEmFzvahf1BnTKgCec/hvcT2kmfW0neJb8qXdyCX5jd4O0RnFGdgD
         2dGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792170271; x=1792775071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WLJ8r+Qkw352j8qkFr8FpLRJS070PYdeAw/tFXJw0Kc=;
        b=wvKSheZPjt/TLhcEaCVIdrGOYlQU4rN98vTGPgf+AgMM0Gacsoevgn4s0RK4G5G37Y
         2Q/05EbqO3tqnoPvdZ53YiKGHlVMNNgDbL+sderkmYzxbGZEwwNztI7SdRDSW9NxVcqD
         GH7W1a9S6poAYecuTIYZCB6an1WcHd9wtrmwsNGjiqSKRvC58Gjl/SqlpVdG5QrRf/fS
         c2xID7prznnfkGfY4qLPNtFM1bYEpmClc2idTKmZTwTvuR8db7O1boBYhUfozVzvKwIQ
         0eAAAc0yd3udIWiaQ+M7TZ/gKpiyheNPAmEmW4rkVlBUs4MhQQOlx5GIMfypAR3VTeSd
         nxhQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmXcCs3SVFh2F/yR+iDQiDf4bPhc3k0LEAtKk8vacV/LUfjL8JGs7VO07jjLD/D85P7zMQ44Wkl9TZGoCKykA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRcKopCNsThTLQxzBHd8Iql7JoYCeyLKpD8IHHE+BoS05gjqtr
	Spu1VlifKUUVDfF8VgE5l+9oxZPOPDl49bt2stAZ+31HTesqyhZ9AN3t
X-Gm-Gg: AYBFou34a2mXdmy+EkzovTn/BCRkChLDAsGnF0qu5NCNCSdNCCCGFGpNJ+mZoxJN6vR
	pHL18SERRiCw4oUX/QIVO9E50ho7NGK17KMfA7LfJdBbgPaQwjSUsLby5FQtpNagqY8m9rs6XDB
	bTd6qT5sQQQHaXARSYKvR7JFVQh8R8hsEb51zMtiegBn5HatBB2EQzGfURUQhzQBrqhZnXCxT3S
	E2slPhGHJ40CEJ7eYT2rnwywgbzvcRdzc7KSMj5FwQPi/uYsDFa8xsOqwD4kGOJ/I/ON5pnB8IA
	l2CaBdhCuNNHcatgqroXDHqhnLKCW+01KVrksrVjfsY0Ac9Kc+1zSYQsm/HCqzE22WIu8o9rdU+
	8ESE5x0Qta/9YDnpXA8lbGGqMEe1Zybkn96PcHoDJNq2fPxOlvq/4xnmiVUnkdaBbXuEizoMsuA
	9E21pmmPASgP+zW7o9CwPl0NB8Pqx2kHCmNqYvhN5WekBkVwU1BW7hbqnI53Xotkf8BpaXgLrOD
	Y+GZWY1NWWpFzc=
X-Received: by 2002:a17:90b:2cce:b0:3ab:b39f:41da with SMTP id 98e67ed59e1d1-3aceefbf76emr320123a91.11.1792170270459;
        Fri, 16 Oct 2026 10:04:30 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([223.104.67.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac940055f5sm9928587a91.0.2026.10.16.10.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:04:29 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: linux-input@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-kernel@vger.kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH 1/5] Input: joystick - replace strlcat() with strscpy()
Date: Sat, 17 Oct 2026 01:04:07 +0800
Message-ID: <20261016170411.51025-2-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016170411.51025-1-shlomojune6@gmail.com>
References: <20261016170411.51025-1-shlomojune6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pxrc and xpad drivers build the physical path by appending a
constant "/input0" suffix with strlcat() after usb_make_path().

In preparation for removing the deprecated strlcat() API[1],
replace it with strnlen() followed by strscpy() into the remainder
of the buffer, as commit 34b228b739f5 ("HID: usbhid: replace
strlcat with better alternatives") did for the usbhid drivers.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 drivers/input/joystick/pxrc.c | 4 +++-
 drivers/input/joystick/xpad.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index 52d9eab667b7a..9abda2394fffb 100644
--- a/drivers/input/joystick/pxrc.c
+++ b/drivers/input/joystick/pxrc.c
@@ -121,6 +121,7 @@ static int pxrc_probe(struct usb_interface *intf,
 	struct pxrc *pxrc;
 	struct usb_endpoint_descriptor *epirq;
 	size_t xfer_size;
+	size_t len;
 	void *xfer_buf;
 	int error;
 
@@ -170,7 +171,8 @@ static int pxrc_probe(struct usb_interface *intf,
 	pxrc->input->name = "PXRC Flight Controller Adapter";
 
 	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
-	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
+	len = strnlen(pxrc->phys, sizeof(pxrc->phys));
+	strscpy(pxrc->phys + len, "/input0", sizeof(pxrc->phys) - len);
 	pxrc->input->phys = pxrc->phys;
 
 	usb_to_input_id(udev, &pxrc->input->id);
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f834e..4f2bb9ca74936 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -2045,6 +2045,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	struct usb_xpad *xpad;
 	struct usb_endpoint_descriptor *ep_irq_in, *ep_irq_out;
 	int i, error;
+	size_t len;
 
 	if (intf->cur_altsetting->desc.bNumEndpoints != 2)
 		return -ENODEV;
@@ -2060,7 +2061,8 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		return -ENOMEM;
 
 	usb_make_path(udev, xpad->phys, sizeof(xpad->phys));
-	strlcat(xpad->phys, "/input0", sizeof(xpad->phys));
+	len = strnlen(xpad->phys, sizeof(xpad->phys));
+	strscpy(xpad->phys + len, "/input0", sizeof(xpad->phys) - len);
 
 	xpad->idata = usb_alloc_coherent(udev, XPAD_PKT_LEN,
 					 GFP_KERNEL, &xpad->idata_dma);
-- 
2.43.0

