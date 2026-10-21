Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585940;
	b=x+T31l+rEy0mp5PJKu5M66fnk8g5sPgeAcpZ+CJ0hy8dubDY7h/6WHyKsXrsojtGob4c
	 K4a6LO9w0hnJLZ3JaPm8GeiGJ3lD5l6fWHk4deTPJmSBi3pdLme2AOosMpC/y6AQb6iyX
	 BNmM6IN0Jl/wlf+8qTe0JOmM2P8Gz9CFB97sEkKYmYMnPxt+zobmfleSbihpqGVznHZ5V
	 mT30u/s5Twd+DXQRJ46jX8OLa43ZHiRk8M/bS5qB9xfMMRjigJ5IZRBqwTamemN91NHqu
	 EJBSL497id7Bea9LjMbGYVRfU5WVhtVmubtsL/q+3zQXZQJ4ZYNYD5j7FvLUNGF1s5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UlfXExQXyhG92dzdrPUvVvWcK6W0MmRTGKrmc+yyUUM=;
	b=0yVVNbj8MrduudnXmWbY4D76JWM9TYrxUWOEeK7nDdncsT1GnLcuuhO4EZv1GkcEiZpa
	 iilHlAAc/2g0dw6dGc/qODUEc0J7Xfs7D+8UlKexBVp5xTcCuc+Q2M35TccMdUZ1S46Gu
	 0aMdU7aX8hYhuz4+8HKXZu3tHr4hsnxf9ctT/I33h1dc+E3rdj29ZPgQO4guCktZ1PEXX
	 IdlQ6a5K6tK16FdrFKKKNHciJEPWIuNhQVeP5Wp1BWVO9NcPeMAVJSTKb9IPYihm921ou
	 y8HsUFEGm+4WIE06aIlaWZTyWXY35cH8QTUskCcaE+JClyAZcsrCc//yWyfWA0lDw8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aulBXKiD;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE8260A261D
	for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2026 12:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BE8260A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aulBXKiD
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-3ad6011ecebso177853a91.1
        for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2026 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585939; x=1793190739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UlfXExQXyhG92dzdrPUvVvWcK6W0MmRTGKrmc+yyUUM=;
        b=aulBXKiD6yr4+Lpo4Q4fQnuP3c62bSp5gu1WaPr9X8F9pBH63WOXP/HmOkj4tA/DwI
         f7c+9Qq6K4JfLf2CYYTlYdL46udovCZHsZWK/oNBh6GLjiX3+rEsqpwMci1cmV5c7Obl
         sImwte7h80qCmdOB7fys3U8uxsuPplW46JMjCp4eu+qEo8+jawjt2Hw9FeABGniYE8jb
         D5+ftqdXwL+dUVqZTyIVXoHUT1S4qYwTtZQN0x23TbxP5hxJ9RgWJXXt540R12rQIK8h
         ZX8ZXNl1Tdw6+kc4Dal9QyGsURqGESjBd2mFgmcBYQE8keRxvJOT6FnKKDAcKZsRsSjv
         4CUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585939; x=1793190739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UlfXExQXyhG92dzdrPUvVvWcK6W0MmRTGKrmc+yyUUM=;
        b=pQMA9uitLAIcGvZ3EsKHuEe+5Z7QYRFa+9/HBOevsMXyLpRWyqO+E8ebdZ4TnbaHin
         +lkLbOhBuENhjxJemqq6vOmMvMc2u+Xk6zmWm6VtSw/YFmZBd/L7iNwvuP1nhfUzkJVP
         TRYpiKTz+GFctkynCyEe4tFVynkQkHak9ycbRzXpEuFcXLuuvwjTGoiT7lPpzQGWOO2M
         bBbK18LO/aIQhqOpIjVVDvmWGW6CVOrKYPdxPAHKcS/7tfJKAu4ZPnghY5P+mT1iuP1y
         LelyAFsVE7C17SWMsaItg17mpm8rzPKCZk9n43M1x3629S4eAm8puIaTLmztGTgJJP+B
         XVww==
X-Forwarded-Encrypted: i=1; AKwUvByM9gDCaQs0DkmOUoqWEryfzu57l8O396sjMhG2U6OBiJSMYMjAgxvvb2eNGbSdxuujPOwVHPWnBXitqA+A07s=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0Hjq2LcjbMUJbRj13dBLBH21pJcHq5bXLgJ4nPNfi0HsmMozj
	cUYQIinNmJN+4ZCXMDNFExzXKT0znDr7TyS7TxFdbEDqsB/Ll1jdUY9+PGHb5qDVMpa/kg==
X-Gm-Gg: AYBFou29bXjq7/rjcg+ImKuCx/7DY8ZO8yDYlFZpaVxhor+X6yK8ZpZE33QQPY3S5BR
	sEjmenrbIYsfHX8uy8GvyFr6zvtYGMVIsWT8cfNCPjP4JuWhSgrV5JLkYNu9ZvWxJzSF0XX8A1a
	zT7IPcPlj8oqrI9PifaXjnW9fl0DLkIWopfUeJUAOCuIvnFEftdfv/+HT6mWEqVbBrZUom84UNh
	VeM8LM82/DcWoP2lQkwi7yONZf4wNzNLFTctWSGtqLtFNjRhpb11Wdl2ttHQX2WuKr+d61AvPZJ
	QhHNIRYeqB6cFmJ7IfDcTyYfzO6c6LpNbLhsuzaUMkVJRWIw4DB+A1B0WJjJlmAe0wFQuBVwvCb
	9Pb/7QsA6tbymeFcWlWW0fWF5uH30YqOqwPaZZrnQnt6JUvMKTkErAxsjODDdnU/hzQ8k80VXkh
	QhzrOWvzxRbFxQUMRpQ+dfTs+wIbZZDGLuNAvSc9uQrnpNnYGVzi0OMrbCqapHh/i8m1HzFiBVr
	qPtDJOmLVh4J8vV2weIOTTrJ8CET3xnaZoskaqbNB2vu0Ybnyeh5dLuK8FDXGAwt1oLx/0yMA==
X-Received: by 2002:a17:90b:4b03:b0:3ac:80dc:f40c with SMTP id 98e67ed59e1d1-3ad86e9eb76mr1566540a91.14.1792585938937;
        Wed, 21 Oct 2026 05:32:18 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813eb9casm4229523a91.15.2026.10.21.05.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:32:18 -0700 (PDT)
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
Subject: [PATCH v2 6/6] Input: touchscreen - use usb_make_subpath()
Date: Wed, 21 Oct 2026 20:31:46 +0800
Message-ID: <20261021123146.17202-7-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021123146.17202-1-shlomojune6@gmail.com>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sur40 and usbtouchscreen drivers build their input device physical
paths by appending "/input0" with strlcat() after usb_make_path().

In preparation for removing the deprecated strlcat() API [1], replace
each pair of calls with usb_make_subpath(). The helper formats the
USB path and the "input0" subpath in one call, avoiding a separate
buffer scan and append operation.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 drivers/input/touchscreen/sur40.c          | 3 +--
 drivers/input/touchscreen/usbtouchscreen.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 77ec2c94b91fd..7702eead123e2 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -690,8 +690,7 @@ static int sur40_probe(struct usb_interface *interface,
 	/* Set up regular input device structure */
 	input->name = DRIVER_LONG;
 	usb_to_input_id(usbdev, &input->id);
-	usb_make_path(usbdev, sur40->phys, sizeof(sur40->phys));
-	strlcat(sur40->phys, "/input0", sizeof(sur40->phys));
+	usb_make_subpath(usbdev, sur40->phys, sizeof(sur40->phys), "input0");
 	input->phys = sur40->phys;
 	input->dev.parent = &interface->dev;
 
diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 0bbacb517c286..fd2b896675dee 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1512,8 +1512,7 @@ static int usbtouch_probe(struct usb_interface *intf,
 			 le16_to_cpu(udev->descriptor.idVendor),
 			 le16_to_cpu(udev->descriptor.idProduct));
 
-	usb_make_path(udev, usbtouch->phys, sizeof(usbtouch->phys));
-	strlcat(usbtouch->phys, "/input0", sizeof(usbtouch->phys));
+	usb_make_subpath(udev, usbtouch->phys, sizeof(usbtouch->phys), "input0");
 
 	input_dev->name = usbtouch->name;
 	input_dev->phys = usbtouch->phys;
-- 
2.43.0

