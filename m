Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652987;
	b=sq5+PL5Q/vMw/VzDYtGJnFPuR9n0+wl+uQxMxTHOJ2VWykXmN1IetjZkfx7DDgL/45VO
	 AmKihEx0L31FRGqNH/YusXOp3ITC7MjVv0PfHogamxL3bA4PKhBz1NVq1ViJvdcXqmG/5
	 AFQClrjYExn8Mpv0NAPF8/5LZCBMACeXlM0/j+c4ACJHs7DBlwKi618Y4nckPa/YR7L+s
	 0andr8a1jve+2xzmj+3iKkTuzGT6g/w0F6ps0rbN/DvAm5VN0rY/fcb7xxCTcgDTATis6
	 kfV1nTlPw6ybx/p/ASUizmqKKFYEhkB3aEkuQQAiP0YkJAAq0Z9HqWGCo0PQQEbopjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MnlYdPOPJlOuiqma0L/KGA43PVF31d9BgFd4VINQMpI=;
	b=NZ+ruXUzQbN4Nd0stbyBitmCmxU6/rPGc1fetPUDTuawPqwlTqKXAIlCgaBnREixUgtj
	 4u0G0EvN9r97ewiVC+DqZKRymr7y6wP0H41IC8fKE24lvbK66Y8ktVQvQlmw1CP/tbOrX
	 NHDCzp/NGXf6vzl6ItE/7IeJM4eATVCWSxZoR5QtwwH+6UEa+QzJo2S7/RAS7zruWVOOj
	 8GkMaObyZnTD+sX/Crsce2zbd0SXiKeCHJSud5V4JZp40+HWLEc1TLCAUrmeBKc9Sts1W
	 PInYPaI4NP6w5jdZ3SP5thiLg5IeI9eto0OjBDHtlu8p6antUHFyQ8o4p5CKmA67fdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FBF1Lipi;
	arc=none smtp.remote-ip=74.125.228.1
Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915D2606A319
	for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 07:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 915D2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FBF1Lipi
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-cd63952c9f2so154305a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 00:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792652986; x=1793257786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MnlYdPOPJlOuiqma0L/KGA43PVF31d9BgFd4VINQMpI=;
        b=FBF1LipimvlOXg4hcf0YrlXHky4zAxyQTFinP8CkurFD/jn6M+yJwf6tRtFBg6yqXw
         GK+bdxY6WZg5zL7A063h1/5kly2IfPqDaL2wa92lxQjXdB0hI2TkmLmjwHlzMim2oVGw
         s/VIKcLAXnYeR6Cr1sEXqZaDgow1ed6sRGg8c5pMr4D5joTBodOPesrPvhW2PzWYmrcR
         FJnfNSYGzRY5DNosRdZBwXilRX6mMukUcyW0IvZVdzt68lcmxTCLHwhJhz0aE5NcMViE
         vRH943rWPi4qlUkRqEeLU2OwKnQ07L1exEd0iDtK12SGnoHDkQu1HayJO3iAeMZW1Qc8
         BPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792652986; x=1793257786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MnlYdPOPJlOuiqma0L/KGA43PVF31d9BgFd4VINQMpI=;
        b=h+fe7s2fPVLKj6dNWFktszB/XkkjDqWTZDlnkWcagjXe4bdIbMc9caP9I6pOzEOCkC
         lOyVo0xVYzfzL/wOhEN0JNNlevsp2rCAPMiA5BGBSIEFKlCWnelJJh801MXBkASpg0+f
         2fsVNbuDdbnKoWwUYSSeUelgn2+L5BNjoQkwkCg+y8yUdJdu4YyIlGR8MD+779AqL/NS
         IP36s9pNjKyZ4LwFbRM+Rrk48nDwAWjpzGOAtcCKqgStaTxBf9kAVzuizIlbkzQno0n/
         9qdXwhKWZE4HGDXg1biwTS6lhLlwTYvXfFdnKplQ++pvvOo2FXClXLKfUJjZonNVThf+
         DDMg==
X-Forwarded-Encrypted: i=1; AKwUvBzE96H3zkSMyO3oru7sHwcQ1xLtBmi7t8mEj3hJ7D/Da3bPEqH57jKQyIcuIk6Z/ndIOf9mgTPF2T+JZRICiZM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKv0E3ZOuPW7qYZpS7eEL3lOEK10QeaKcM7BqPX4lCn+OtBgIYX
	6LMCpXMuNgRlm42zeu2OnWnD48QpPKA2yQg3fk6zZck+fvbY6C32jlPH
X-Gm-Gg: AYBFou1uclj6IoEHMayLZ0EwA5op9sB5OjtxeN4rix1eXRR3u7ZNG924khoX6t/cvVt
	zyFfZX6KOvNZ0d+K/54J6qTfKaAjvNF8cVW/Y5Nu0UCQlevuQtIia72y1wEUMCvxIFLO0FkdMco
	tNc0frD0uiACTgWTfLdC7A4VbIVpnanG8Z6X2i7LN02uT+WxwwL6TQgV28AOn44LoS1Prem54uS
	fbDTikZ77H5iDV2PBi5wRsmXAPFU8Y5wWRXzddi2yFuf7NnbPuHcmf64jTfl8uHFmHwG3pyKNSA
	2Eo5N/StrLRW1qTbr8gqh4pqyDcpi89aWc5RXU/YgXy62CdhhIK4h1fUpMmLnybI3f2bJjGOCBQ
	jB77ydbY8agm8LKFI3MkdlFKxhbIBwtq3vvZ7wfCABPVS6Pm4EoVqUpHxMWD9mtdg1i/4X48HQS
	3zbmLzzdyvywBuwv/4V9jWZLt1f43NxUVd7ikkhc4w2C3sWMkAQnNP8yyv57e3kHILlGy32+r2z
	uSyBj2IWh/iv+0FS5BeOrDtVXMgll7G5IaqngRbo9s0ggq6mXRi7vGUQqyXiV6vPD9oUFTN6DE=
X-Received: by 2002:a05:6a00:a387:b0:882:94ab:20f6 with SMTP id d2e1a72fcca58-8a089c3eec3mr3115617b3a.1.1792652985830;
        Thu, 22 Oct 2026 00:09:45 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b49d1sm1706039b3a.12.2026.10.22.00.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:09:45 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Alejandro Colomar <alx+linux-hardening@kernel.org>,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH v2 RESEND 1/6] USB: add usb_make_subpath() for formatted device subpaths
Date: Thu, 22 Oct 2026 15:09:24 +0800
Message-ID: <20261022070929.20820-2-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022070929.20820-1-shlomojune6@gmail.com>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261022070929.20820-1-shlomojune6@gmail.com>
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
