Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585931;
	b=0lwZr7cEQDo2rb5994kezUwLFcv4ZjCjWTkSYqCHVqnemdTMNwoHSs3mWyvNYjG36F3+
	 HS5awzH0iBh781KKIXyMrNVA2Q5BuKKBmWyFGEuQY2xdyOKpMU44l8xIqGevU/U4VLqOJ
	 l0eGOFi9PEarDZ1Av3ANDRIZia3EQZwsewsjhWdg9VlbnT6u+uaGXpNg/RtKgdKFjziDf
	 hnRcq2FWRgK2MJ/OdiGABFd6z9Xv1QG8YK0LdJfwJxKtGuPO84OsUPo3bA8akxvcoDhvV
	 famQ9ENrijo80fXXf0pQUsK9K6z5ChjHab/ygCB4nzFnpqF79p2TarNraWDLMVy2NCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nnZ0MwCj80U+rG8upbc3A6/J8KNZsuBJGtpG/de36Io=;
	b=SzTGg+HJfF7SHEZo4FsBQ+YEi+9naWxD5aR8YbI+lju+KIdkYIlvCJWV05SzBkD0EVXe
	 TjfDMKkA3pd/FgGVJRMz9Lm+F78bc8wjq/aIJpMbP4YuBdFZadEWU6Ctt6dhmYx4nGQgQ
	 UbpPv4/TTJZsX35cdnygt2qOu3SVmRr+Vyo8BCyJ5sqn1wCxfxKUTzmU5oQoePeAX4xGP
	 7qfKC44kuxL4Or6pw7LgUsRYdbvCJ83eMNpunX9DRWj4YjlvcoFfD6p9jq2CJnauey8N3
	 3CrrGzYZA5ds+crDkQ/W7nh4y3UuLjpIbEyg+CxhXG3ure+qGdJQvYo6V/sCNY9Xfmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AVWGBqbZ;
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C4560A3816
	for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2026 12:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2C4560A3816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AVWGBqbZ
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3ad41dad3faso478883a91.1
        for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2026 05:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585930; x=1793190730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nnZ0MwCj80U+rG8upbc3A6/J8KNZsuBJGtpG/de36Io=;
        b=AVWGBqbZm8mWQ0SX6qcDJWcEz6XBHV1d9prbvQRJGTmm5yb+X2NvUUJ8goV7+XPFa0
         xmUN0WtDouocr/yQS0X5Z1DQ5CX0AmWrk+5VDSaels87fAdzTJxWuAnC7yjKC68XqVQo
         XKpfLfyfc8ZM3yJhNdIiwdryMn4+kU45oZFOxtrr/KT91sk4CHPMV2FZLbdcDopo1BLb
         7ZGtDTj/6e2cCYEC0avqz/JaV4eOZ6mYoK2yf4KhEi7cNgoRm5JqBzBZVZr9v9/zoyYz
         sDIzTzpbVEW8/oixX/q2mJ/YfB4hms0mFcik/SXYxuik35ud2Go1zvaz2Cj9dO9gs3O+
         ++7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585930; x=1793190730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nnZ0MwCj80U+rG8upbc3A6/J8KNZsuBJGtpG/de36Io=;
        b=JxfGhjfNRRoR/RoyPr1wC2MAnVUA5tuHvYHY6ey9ctQIfOZ2EmmHckjLozjLkcHn5m
         vYJ6OpGflc+V+XyKJtj6XViVgSbFEPO3vkdEmgLX1QvUEKmdjdo0fHGi5CPM4NFd+kF8
         Ogj1vZDvbqvBWiqjhWj2fTW9MLAHoca711bKSPLGWhpkNWbVIQte8lrXuu7mWtZICKPu
         rF8gUQc/JqSGK2tE1ZsdDJ7oVsgLY/sqJiRzV5qzeUVC02SmnHfuZf3h4rPP07LBjUJa
         7tSj+WwXo8chag7suLxVpkmQnxZw9xBeIKFSyK1VBOMe1amMO2NIakuXXtVJmZbOtgtt
         eDlw==
X-Forwarded-Encrypted: i=1; AKwUvBz1PrBDdSh/olYpeisqW+Ci3L92PgnTQR26+XLM+rZ+VTQEq/JMkJfhCRAK3P79VpxQg8zX7Ya5jX5jsVw82NU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNKqEjj/EeX6XjNxOey3XUJhz71jv3G+WeHRQwaEdmrhCz8Ka6
	46IqE9EROb9PtsZMf45CAac+C4tTf++kBxNAW/LYLJNJJgcySii16jdq
X-Gm-Gg: AYBFou1sDXa6PHGlsP87PxVFvpAy+YKNhLnVRl31GUqV9+dP87FSBMy36Cg7gEKflqp
	+FRLvIU6FeXHTB/S+oDLpfjcdmTLTYmmOK8aH0f+HmqQnyUinYOV08Bmj8ET0pq2k5yD2z3MBYt
	cGVMO7Pv+gmnXHk+tIwgLZYWb8rWHh/5vff6+iOfHLCD+fB2PN8sxQYe8+Dw1SqVk/+OlmV2yJO
	jDsF9tJJeZGZ5Ys9jYVIBFGIW5iaI2BTAKDAn6ERA1cLW1Heq6fHsm7X8cin6yVMJtNZwaAJvgm
	TDvfXvg0wrKFuNK/DS34Ehb5roNHGY5NPBChVyPlifIpjYAHTBp6LvSydmRe4TqQmt8yq7HDsXi
	D7YZO7Y6Bp0cXM9cesZJ3WDYn1EsX1i4bP6MjYMEh0g56X7I1DpEbcrO7x0ISdpIX6aPps20RxK
	uizLYa+CRLeVOREmi1UASXi7szLkRofbr8E0KU0y8gAcQ+bYPk4Cs+292z63x1C4ZRRbo2XHD4B
	TdEgtlp3PjnrWStrbVHG9/kdfvyblhQ+muY+aadpClHmNZglOTOJignAUjvLwS7vhT5NhPYWZQz
	cA3NVqNBXaqV+F5Ejec=
X-Received: by 2002:a17:90b:57e8:b0:3ac:dd28:4621 with SMTP id 98e67ed59e1d1-3ad86f57070mr1515425a91.51.1792585929882;
        Wed, 21 Oct 2026 05:32:09 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813eb9casm4229523a91.15.2026.10.21.05.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:32:09 -0700 (PDT)
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
Subject: [PATCH v2 4/6] Input: mouse - use usb_make_subpath()
Date: Wed, 21 Oct 2026 20:31:44 +0800
Message-ID: <20261021123146.17202-5-shlomojune6@gmail.com>
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

