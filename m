Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115F4CA6B
	for <linux-hardening@vger.kernel.org>; Fri, 13 Mar 2026 00:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362115; cv=none; b=JlIFf6kQOSunW4B69YWpKZYAIyTgmHdZN0t29PXSTS1zHD/SeoRyP4J4s5B0x3eygJqvKC0HVWjcPo6Q7BnFU3hm6VWtYGvZw9hdunb6e/N/JnO0OLfajDfYlkQMDyKCgpqR4KGXSjMKgGYuGMS7ljfDxi614RM+oCkXR6AM0kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362115; c=relaxed/simple;
	bh=w+4eBmfvEhip5bCDa4fv8QpZ35nYLDz1KYW1f0RZbes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GCvcQBAwD0gaSHKWSTMLLDWQ7+m/fGMwIXywZNnnG1ufbElMNV7+t46cmI0zx7+OfCN0dJrWGVq4+aLRQ9BztxjxFLFy9KWh/f/snRTzxJTtq3gLYgy1FdO9cNH25jOOO8U/U+ZLD7dtnCgNz8VOn/0yMaOf/lphqphJGo94igU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9gW4T/8; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9gW4T/8"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-829b2019b39so936030b3a.3
        for <linux-hardening@vger.kernel.org>; Thu, 12 Mar 2026 17:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773362113; x=1773966913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5g1oxOZuD0TjRJopzLlGiiDsTi7txtKncHU5UC9/URc=;
        b=G9gW4T/8oz0UAiw+37C6LcNiL8J9cEKvHyQUdWaG+ZzMoz9UozGsRI76SPcmhQwDuO
         ahxiJcsMQsieo2UoD8lyRMZxLpl1nuYEDEKDwdUWK0kTp/1nypP/qQ1D+aRQReLii60x
         skc663FGHYdDnpff/VMUDN6oSEePAhkg0yMFe78g2rNCGlIKb9X82hok3WXS1j0tVAom
         P8VDPbW+t6fGk0wbaEHvTo0CCq8FA9FhLei5I/bRpGS1qKqAB53wr7+Xo90rh9MaKKvt
         OCngVtBmhP7u5l5K7FOa5nOhIv11ipPZrUtMBInXfTc0Sb/qGN9CRr9crbQxc7uu4+EP
         5YZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773362113; x=1773966913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5g1oxOZuD0TjRJopzLlGiiDsTi7txtKncHU5UC9/URc=;
        b=ooZ9C6aqSrS1Bom0GBuzfUhOa2Zt2HaJMHT0uU8UXWKg/MNJQ6jxKePFsxPswKtjdY
         XqHmbEwK8KaaQUQ0Am8PtPCgoHiUVpy7E7oVxlcAl8+xzG3KJg7i1fu/BgU6ZpAZ4IiC
         lH0DIYG6MnO+oAjeV438f7PNgEsglVcThLUxlZCO0IGsslrj9CfYx3OvWkATqdqU4qoq
         9s/eX8artVPKX9JcOdugraeIEE3EfOhXe8EidDVLKQ98P6oIZ7qacJA1R8BhKsb4/fKG
         NhuftatFGvDMhbXzvvehnZd4K+ypuQ/GuLU2A2lCfiTRaXUSHkR7fOc3exEn5RIY6pP2
         68xw==
X-Forwarded-Encrypted: i=1; AJvYcCWnKuZz4hMXzZEfTm2IhNN+6w7ZTm4oH4vCgZLKkUggSLEtH4OXZ3d1EeWbtwYa2Q27IeNog3h7rf88hfqg3ok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4cpmIYQg8GWmQIMCd9rBV7N+HzNP6o5PkDg/5sndaiICsdnum
	jW2LYsDRa6W0P0uHRcy14xRZJ958GAEKRfE5kgLH13XpVBmQ83+Agzkx
X-Gm-Gg: ATEYQzxSEADo9Ti8eUirgMnz+InoCoxcU7F4YEMybn5ghKAVM0qsEOjgOgi3kTKkWec
	SL1piiXdgQ0DrmkUJIBade7Y8lyqrKxUd2/JAt/3TNJYWWnWpjqtWdH+BmqV6PPG+7AOrtA+Pvt
	hZYVCh+vxxKkrxukCc/QAcXhtDSNp/BdGzDB0vJ2PGsHUqUPM2Frk2DnCQNG+T2Kvc1W0u3oJgJ
	SHnNKXwp73ow+z7wj25EI1hZpDjAgPDJaYAH2zIPY2G7jERFYRru1Vt4KVFLiOKM/FJfp808Dhc
	/hZ+kfJsVdYw4mVcpAeeeRVUSLii/2NevSSyFRJD3lqIza6QM+p0lmkgoxoIhYnaDPpfYmuz1RH
	tXQw6ARJaSss6l8KX9QjvzvwKWeVYHc1vJxXychAeYKaG00Lg3H5EFo0moxoQxEu7dnq+MJFTt2
	50QD7XDFnzipaXLhSvArV7aCXlj4GPxsHhH70VONHnkb6O/23+uqCnO6iFT+LNWeKy
X-Received: by 2002:a05:6a00:2e90:b0:82a:1380:417d with SMTP id d2e1a72fcca58-82a198fcf29mr1117576b3a.52.1773362113369;
        Thu, 12 Mar 2026 17:35:13 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0727f2fcsm4032305b3a.28.2026.03.12.17.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:35:12 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] usb: fhci: use kzalloc_flex for priv struct
Date: Thu, 12 Mar 2026 17:34:55 -0700
Message-ID: <20260313003456.124270-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert kzalloc_obj(s) to kzalloc_flex to save an allocation.

Add __counted_by to get extra runtime analysis. Move counting variable
assignment immediately after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/usb/host/fhci-hcd.c | 15 +++------------
 drivers/usb/host/fhci.h     |  3 ++-
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
index 271bcbe9b326..71e785f445a3 100644
--- a/drivers/usb/host/fhci-hcd.c
+++ b/drivers/usb/host/fhci-hcd.c
@@ -426,16 +426,11 @@ static int fhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 	}
 
 	/* allocate the private part of the URB */
-	urb_priv = kzalloc_obj(*urb_priv, mem_flags);
+	urb_priv = kzalloc_flex(*urb_priv, tds, size, mem_flags);
 	if (!urb_priv)
 		return -ENOMEM;
 
-	/* allocate the private part of the URB */
-	urb_priv->tds = kzalloc_objs(*urb_priv->tds, size, mem_flags);
-	if (!urb_priv->tds) {
-		kfree(urb_priv);
-		return -ENOMEM;
-	}
+	urb_priv->num_of_tds = size;
 
 	spin_lock_irqsave(&fhci->lock, flags);
 
@@ -444,8 +439,6 @@ static int fhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 		goto err;
 
 	/* fill the private part of the URB */
-	urb_priv->num_of_tds = size;
-
 	urb->status = -EINPROGRESS;
 	urb->actual_length = 0;
 	urb->error_count = 0;
@@ -453,10 +446,8 @@ static int fhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 
 	fhci_queue_urb(fhci, urb);
 err:
-	if (ret) {
-		kfree(urb_priv->tds);
+	if (ret)
 		kfree(urb_priv);
-	}
 	spin_unlock_irqrestore(&fhci->lock, flags);
 	return ret;
 }
diff --git a/drivers/usb/host/fhci.h b/drivers/usb/host/fhci.h
index 1f57b0989485..e221b28e8608 100644
--- a/drivers/usb/host/fhci.h
+++ b/drivers/usb/host/fhci.h
@@ -387,9 +387,10 @@ struct urb_priv {
 	int tds_cnt;
 	int state;
 
-	struct td **tds;
 	struct ed *ed;
 	struct timer_list time_out;
+
+	struct td *tds[] __counted_by(num_of_tds);
 };
 
 struct endpoint {
-- 
2.53.0

