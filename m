Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792653015;
	b=pq9CN3DFHF8Lu+DjomWZASR7S53OT5+00tC3/agmSOfbj3ulXLoT+afAp4pn03ap5icK
	 p7FQgZ/GY+aIajckkG4V9vO35lruFzV1EiwBoIvLpjmABlN9ph88YOZumAk86a+jMbLmh
	 l4Ys3KVbw+kJyCinoxv3IhrRKS+OgPct1M2RrDCPrPdg6Ot5H1RoZSRD9/O5wzeZ7zPOT
	 FxromUq7AoOYUJQBwMSlAynSRmboI3+OFBavhq23qKh3l6AH6cy3mqbdSINYzSGCwLiTo
	 0WYjrIQVhi8ek2xBn9Ud1nb7y7kz3D25mYrwFag4pQnj93nU5gqF6ilQvFuPr5vpA8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nnZ0MwCj80U+rG8upbc3A6/J8KNZsuBJGtpG/de36Io=;
	b=WO1fiy23vp+xkGTQXiY+GT3xxkutBYi75LHTgwGFCKVHX8JUENLE9bP2JT3J3GIeRz2y
	 ZbRyWKVH9T+1K5dcmRb62UhnPMpYN5/v4OWySiUmWa9gTqVPan+qEMUA5p4pO5KYRsrht
	 WurVL8y/B8Qay9mTNp3t6ogpaUQHqelcyS2Ctvp5MEVk+EYyiL1XQvaRiJdm7QWPTq9Sb
	 bwCT4nLnvYzW3ryk6Mi8WSCDf64ZWAJt4BqKvibw+wg+UVBIQbxIbkHD8WFy9g69pV2BU
	 m4FkpGevsfZNBAWhtD6lxL27NqvieJfZ4qrshTTkP0cDcCoOsbpEAD78yxGBX2P3/FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=elYBUVHv;
	arc=none smtp.remote-ip=74.125.228.5
Received: from mail-pz2-f5.google.com (mail-pz2-f5.google.com [74.125.228.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EC9606A31D
	for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 07:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60EC9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=elYBUVHv
Received: by mail-pz2-f5.google.com with SMTP id 41be03b00d2f7-cc7c286026aso544814a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 00:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792653014; x=1793257814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nnZ0MwCj80U+rG8upbc3A6/J8KNZsuBJGtpG/de36Io=;
        b=elYBUVHv1G/+HQcaNkxI5vFRLDZdl4qCwIUkcU/qNwNUpTSV4qXGzPUkwBnSmr4nxd
         wwVezuvR6Ife3TvQzjo+6K7A6wFvxXJCNcmsuuvTJNcBisvkxV+yDcLbpa572clLuVCI
         9fKil/njdza/R6iwWl11nH61WeT5Epgq0Zykr/jDqP5yuVO47whXgjdQwt6gp8OmSs0N
         idqR9tjE6FPUjivxfYkN5TBNgTz/JAp3q7tdvuFrtnQjJEmwxm3md7ag84qYIaP0tcvU
         NZsQ8W481LlK7Rdco81h88o/EYxdK/htfSER/FoyHgzzdJITP+DHQbednvYEQYj1EVzy
         tMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792653014; x=1793257814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nnZ0MwCj80U+rG8upbc3A6/J8KNZsuBJGtpG/de36Io=;
        b=fpz9pUitjKvLeaEYzMHWRQCoo68AEgXoqHn74TqdMYgj8k24MWa1QaFKWW8XY68rWT
         nJwJ9Wf8XkHQP8GN9Z4pvko7zivc/HyMh7l3fqYYcHDyPNJsgYbqIkezUN4vw5Qc4ElZ
         lHfo5MjDGBgx0Hm6pyvjBQaUlMKIlkDsa6IX5G1Kxun73poqAM9ibCGww63AG9pLrhmt
         u0T3sv4eD1hIWeo2SGai1v4UtIyAq9fDvoGFqHIpQ7NFyyj8E06qtj6H5dshPO1P7tA2
         I6iN5fP4lpBdxv9adLUlYYsReu4u+0fd9EGLMo3p/K/nbCMz1SjKF0Jv3idxNvcdalDK
         84GA==
X-Forwarded-Encrypted: i=1; AKwUvBwWQt4yFC3+RhUj8xhm9TfmbABm7Vt0UsURR8Di1L8yfuP88ilUCQJg0QwT00gY84048Q6mW6rjcpd80VJEgSA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIv8Cc6DLyp0MBomxuEbv4wM1+X7qMLsWWpcAht8Ut+9QfodbAQ
	nfVMMMOHhw1o5nC48hIC2bWAKQC8xZ6GWEsTFIgDhW2k5lq3ZShSeT+X
X-Gm-Gg: AYBFou3/CF8cBWGQXPuH49651EOIm+Wjgts4L9Xs3V1R2Lp2u5XlAjrMdHX2+/Hd7Zj
	HjTwCR0laQnz8+d9nty9FWCQAfbe2+MKr/kuYhVSMSM6+DM47A3zJLmVypg1TQ0YgyrkbiJUrnf
	dz05L6THgOQD0CZvNoQMpntyqZs7VrvC7GoXvzcpet1ch16N1VLYtafe+CY11wJMgY0Y0I3403a
	DtJi/gaSnhdEqsd5dBMD0DhD9JxUnGshzkmpgKJFNxD9aaLXAOcL+z1l4rLoJ3LlI0awwsYpQ6E
	yjl+VcoVXejr22YnaD5k8zCJ5zGqI5jQlOGg19m6qlpzpQt+oIaBl1VE9G3SIe0pgnVPG/2UpdV
	yoAuoFH/7qLJdepTdBoGIs+K20f2joPexQ02a9u9h2gfHhZu8Ht9vbZccQ3AIjcxYqscVnfDy1D
	6MhqP8ksfbmRZOot93Qi0WlswRBX4wJagjRQyNHbpn1yHdqaKM247m7JX0nsc3+Ca7HmMgm5tJE
	g3FYS909XavMH/9W9jJbVRU7X9CrvV919dzTiRkZb+VajbMRStlMiTtNAer8abvGKpq0+l2PA==
X-Received: by 2002:a05:6a00:3020:b0:882:e3a6:27c9 with SMTP id d2e1a72fcca58-8a089d0f2f8mr3839994b3a.30.1792653013784;
        Thu, 22 Oct 2026 00:10:13 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b49d1sm1706039b3a.12.2026.10.22.00.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:10:11 -0700 (PDT)
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
Subject: [PATCH v2 RESEND 4/6] Input: mouse - use usb_make_subpath()
Date: Thu, 22 Oct 2026 15:09:27 +0800
Message-ID: <20261022070929.20820-5-shlomojune6@gmail.com>
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

The appletouch, bcm5974 and synaptics_usb drivers build their input
device physical paths by appending "/input0" with strlcat() after
usb_make_path().

In preparation for removing the deprecated strlcat() API [1],
replace each pair of calls with usb_make_subpath(). The
helper formats the USB path and the "input0" subpath in
one call, avoiding a separate buffer scan and append operation.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 drivers/input/mouse/appletouch.c    | 3 +--
 drivers/input/mouse/bcm5974.c       | 3 +--
 drivers/input/mouse/synaptics_usb.c | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index eebeb57515e1c..b536dfae427de 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -874,8 +874,7 @@ static int atp_probe(struct usb_interface *iface,
 	if (error)
 		goto err_free_buffer;
 
-	usb_make_path(udev, dev->phys, sizeof(dev->phys));
-	strlcat(dev->phys, "/input0", sizeof(dev->phys));
+	usb_make_subpath(udev, dev->phys, sizeof(dev->phys), "input0");
 
 	input_dev->name = "appletouch";
 	input_dev->phys = dev->phys;
diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index e772bac3b64c0..0732bf3a97adc 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -989,8 +989,7 @@ static int bcm5974_probe(struct usb_interface *iface,
 	dev->tp_urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
 	/* create bcm5974 device */
-	usb_make_path(udev, dev->phys, sizeof(dev->phys));
-	strlcat(dev->phys, "/input0", sizeof(dev->phys));
+	usb_make_subpath(udev, dev->phys, sizeof(dev->phys), "input0");
 
 	input_dev->name = "bcm5974";
 	input_dev->phys = dev->phys;
diff --git a/drivers/input/mouse/synaptics_usb.c b/drivers/input/mouse/synaptics_usb.c
index 880a0c79148cd..7da22118ce576 100644
--- a/drivers/input/mouse/synaptics_usb.c
+++ b/drivers/input/mouse/synaptics_usb.c
@@ -353,8 +353,7 @@ static int synusb_probe(struct usb_interface *intf,
 	if (synusb->flags & SYNUSB_STICK)
 		strlcat(synusb->name, " (Stick)", sizeof(synusb->name));
 
-	usb_make_path(udev, synusb->phys, sizeof(synusb->phys));
-	strlcat(synusb->phys, "/input0", sizeof(synusb->phys));
+	usb_make_subpath(udev, synusb->phys, sizeof(synusb->phys), "input0");
 
 	input_dev->name = synusb->name;
 	input_dev->phys = synusb->phys;
-- 
2.43.0

