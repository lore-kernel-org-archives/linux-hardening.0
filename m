Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585919;
	b=WZ+ZnSPYO8BLqlRB+KrIPFa4zN19Y546p1UXX2/mNsvogvWharjlJU1WibbywC39ZM/O
	 RUqYqsyPwHZWiufGJN9gZNzaBZRXrABhylW+GA19NEmrTEmmFfW3+ZkkGUSLqmWgMAlW3
	 +HjgFzJDGmmZ0bcFZo8eR64+Dd0zEy38wY2pTA7RP3lH4LZNBpYHj2iPbzd0tJfEBPSnf
	 bfA086LDAXFwXZ5Bj3mEkXFBkQ2Lnz74uFn3wTsxR8vTqzdW+xkkzg0NZqRfzAfp875Q7
	 ik2yjbxA71yUyfVoNMpHAx8kiwEdbvbLwZEx+waGlmNSU2VH/Mudpw8w+O4GAaQ9rqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MnlYdPOPJlOuiqma0L/KGA43PVF31d9BgFd4VINQMpI=;
	b=al31YYN1evYxWgfau8/fvC5H1sRlvh4BYwchR6Qu0jovSotNBG9q8y/VcbdJijIdn0GG
	 DBmpp8HJiUqnCzY/acWJlfvukH/LEUfH5G75xWyrLoF9pZgmibDSqTR2W+AtYDrdVlIwc
	 NIPrYdeX+MFaVPtlB3/2qfoD4tkxhfMiaHR7ZNML3GFK9gW67MuPSbKQ4bpk/2rgOQKqA
	 rKT4qCOerrLltQXHxy2IwBmvhfZnsPSxbfWuZadv8bnAtOyeSQOY4KzVJn5XDAyWHwVd2
	 0US+kfUruSHUAYagzQ0y7kqgznOuBOfpkJgy3QD5R2accKnVQ0StTMpNbrM9xbLT2SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nGb3wX49;
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4C2606A327
	for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2026 12:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B4C2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nGb3wX49
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3964e7720afso456376a91.1
        for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2026 05:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585918; x=1793190718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MnlYdPOPJlOuiqma0L/KGA43PVF31d9BgFd4VINQMpI=;
        b=nGb3wX493/8Cy5xh9Atv9Axf7FdB26I4tXoOvows+NmU+dGzu9kENcWlBHxs15w1GP
         mdcvYp8AEG55IbTZ5Su3d8WP8ZNv82n/4ckpyvmOsVLHo1K5XWHuSPH5NlMRCCZHLTC1
         AwhAhGqyJe4T9JdWlEB0XGiuEcl1WM9Fmqo8PdAXOj+iRrGF8Ti52eDst6wiCw1JuTmZ
         1b4WTVdujyqoMQTdQYM80J7ooVmOkE/gOq0bckjO00L4tHmA6mOPglYdczt3NREXSWbY
         WYyacpcewNI4/xJGRDOUhavr2nBe4qPA/rhpY74WpXAbssUGEqpfKn0GAOmq4nILfOHW
         Sd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585918; x=1793190718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MnlYdPOPJlOuiqma0L/KGA43PVF31d9BgFd4VINQMpI=;
        b=vXOZYqqOTqxP7t/s2FE/Gg4fwAFaxGVg/9P6itQGgUC7gG+EcUaOSqgM7hQA7myfGH
         XrTpZz52HFnp5EONKy/NxP94uIIY8ERvqMqC4TE+mJIGdiXalHA57JNPrYIr8d9lVAp+
         Aq4Rwmj/MTVMw2WV0sx+eDawaRFAomtSwWIK8qsVOW6uIppyvEj0zMVHsmKYRRPnJYKF
         R5EWHX6cU/+4lAC+DySq0RrwLjkZ8CEWyEdQr7Tt0WRjAtEHY42KLrNLj2rVm0hW8/dU
         CB2yvhsXbhT4eguy6qvAzVz553pUIeVAZxHIi5jbDVWhDaYZcn70CUBnIIUlR1s4TOgC
         fYMA==
X-Forwarded-Encrypted: i=1; AKwUvByvlaVF/E9qG/+I3k1msCJX8s9GmHdswx1Ez/JliHM515ALqAyCygxx1Na97RCyXFECyqVMqro2e97YKRU2udI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVRXaOueC+PxnDzxNgveJl2oXpKxwELugQZWu5Z+4CRbMXRp59
	9qHGk4EFJuXIHCL1NebVJC72YG2frA7irycop7CX//Xl0dfLcC6Htyl+
X-Gm-Gg: AYBFou0ZhWs4TJOWHWk3iy6cHyjHhcv0A+EWDX3SQTvpjmy0rEg99F4zDNTgjYq6zgo
	HlUw8eLqtIuil4zMsscL+zK+zHUgvh+NIJAUDNNhQ3jWJp0V5E5VXAlqcdo8qDfWKELlld2s9E1
	ANdo/xz9TKCJ4o9ciBP78VhKP/VhfTKqbCZP5GNqY1UVuv5zxQ862DZF3bkBofm6TLBiWkAHtd/
	BR3z+neXCzufRHGjZe+GGQ+NjbwkeQvgq1Kq3AiMO790BMDuOlff9MTb9hygwuJ3rB2iwJZu+O3
	4VGiKL9LE4HpWivq+vAUzSYcokTvok4XRCjCTXjrqyKPQ6p8bfT/DC8vprTWZDPAhvfxVDC0EFq
	TSPlN5vpM5SMotT0ynHj4wB/4P3SOOMJOUlb9LfpInlEoOz6Xxz4/S1s6N18EgY+6ZUgH8JduzY
	zj3Y8BfQq5VfqEkscnaMSLC9qp/xIaFkdZoktqp1cnRnW2pypxUWdZrC4DRjBEEtOY6QodKvNed
	BwtBgg9jTqmyF74e7F+JSmnilzC+3k6RZRp+FltIjUbtmwMd5lUwv0SFB1z3mNCV6w0/LDfWA==
X-Received: by 2002:a17:90b:2646:b0:3a4:ca46:8d44 with SMTP id 98e67ed59e1d1-3ad86f1c073mr1747613a91.18.1792585918204;
        Wed, 21 Oct 2026 05:31:58 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813eb9casm4229523a91.15.2026.10.21.05.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:31:57 -0700 (PDT)
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
Subject: [PATCH v2 1/6] USB: add usb_make_subpath() for formatted device subpaths
Date: Wed, 21 Oct 2026 20:31:41 +0800
Message-ID: <20261021123146.17202-2-shlomojune6@gmail.com>
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

USB drivers often build device paths by calling usb_make_path() :and
then appending a subpath. Several callers use the deprecated strlcat()
API for this.

In preparation for removing the deprecated strlcat() API[1], add
usb_make_subpath() to format the USB device path.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 include/linux/usb.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/usb.h b/include/linux/usb.h
index 1da4ad1610bca..c90ccea0cdbf6 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -14,6 +14,7 @@
 #include <linux/errno.h>        /* for -ENODEV */
 #include <linux/delay.h>	/* for mdelay() */
 #include <linux/interrupt.h>	/* for in_interrupt() */
+#include <linux/stdarg.h>	/* for va_list */
 #include <linux/list.h>		/* for struct list_head */
 #include <linux/kref.h>		/* for struct kref */
 #include <linux/device.h>	/* for struct device */
@@ -987,6 +988,34 @@ static inline int usb_make_path(struct usb_device *dev, char *buf, size_t size)
 	return (actual >= (int)size) ? -1 : actual;
 }
 
+/**
+ * usb_make_subpath - returns a stable device path and formatted subpath
+ * @dev: the device whose path is being constructed
+ * @buf: where to put the string
+ * @size: how big is "buf"?
+ * @fmt: format string for the subpath, without the leading slash
+ * @...: arguments for @fmt
+ *
+ * Return: Length of the string (> 0) or negative if size was too small.
+ */
+static inline __printf(4, 5)
+int usb_make_subpath(struct usb_device *dev, char *buf, size_t size,
+		     const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+	int actual;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+	actual = snprintf(buf, size, "usb-%s-%s/%pV", dev->bus->bus_name,
+			  dev->devpath, &vaf);
+	va_end(args);
+
+	return (actual >= (int)size) ? -1 : actual;
+}
+
 /*-------------------------------------------------------------------------*/
 
 #define USB_DEVICE_ID_MATCH_DEVICE \
-- 
2.43.0

