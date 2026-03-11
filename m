Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4031D3A4F37
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773271264; cv=none; b=cj9r/7JWSuHn3ieRLkaYHidMY52JKaB6nUyyoMn1UsHsNU7LoezJ8N4q/vVHk9SHCUnUlvRStZv2jbMYGu9jvsjvZ2x8w3k4hUiIUBXGci9lSciYAhuSJD16EsC/Ko63pMMYFwkFtPiOZ/UzJSMr7LZInjkGAda9Ar0gA3Ua4no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773271264; c=relaxed/simple;
	bh=Tw+2EyKUb9agQ6zKe0hRUqwC5xleuQDNBz4yJ156L+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DduQrIs+v7drWorQkDdAVCCY3LueD1boUnFYD1TrEbnOJnZa8QzXj+m3e8FEW+82Ups+9qGPMcTaArjynUYgwyrg0iJxirG2eJPT/BWVDurrYPXSBE8/0xza8NKJBNczmCzynwQMVdz30xlysjuWkXDqHceuKpPuql4UN9PYdRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HU46iou7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU46iou7"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae4e538abdso5230605ad.3
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 16:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773271261; x=1773876061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DkMgiVq7K2oqvd5LIg0pWuilh6oqSCCM4UC7aP9hpy0=;
        b=HU46iou7qqulew9Q1YNo/BcYfAGpODphqmgtC5t/K0mmMKgTjEJoGpWpt0v6t9Nxy4
         TtuBwT4Mkkp1MNoEL+JiKgMaOL/tL94B/G1NIAPxw1xeFfFul2XJCmki2RlCR9qYbxqn
         51kP1Qig+NqiJ17E2eqe7x9xarT1WF2FALLVepJN80zAi+vDA0NVkB42T8HdNX+gId0+
         enmI/LVl50M1T7wY/fozGxGq8a2/0NPBEFIcRAu9f9cmWRnUUvymtAloy6hPkUT9b3eV
         avYiw2b/Ezbpl0h2W9S32WbBKJDJWQ/qotJzFqn5QpH13pRrPFxUNQVchToGvCg9jEDU
         8oHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773271261; x=1773876061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkMgiVq7K2oqvd5LIg0pWuilh6oqSCCM4UC7aP9hpy0=;
        b=MoI29T7SjehImoQu70jtry4dj6zuwvAh6HXuJY4bQlUf7T0gCvnv2jRDG302mzbzon
         WRY7aKWj7DJRSfpz6HvmArO5DokxXU0GGFm+UbYT1l62zcw4juHFguMLUPpc0k9PSzBT
         cN77bAWBpWEM6Ec6SP1JQ9URiaegt61Oulv7zaJXk9OzoyLhHlPL3q5EzSy7wxKxqlUX
         UN+irKmX9ts45mRcuYeWoqpwHRizTFMMYM4rAZ9+vzLpWmBYHE73l5c+pCWQ3FmwPHB3
         efVof0OcQ03ydPa3J7TF3wRLAJTDTcg/dPAxa10/7pz+PQPMvHlN/45XdOf0CquLkQ1g
         HW6g==
X-Forwarded-Encrypted: i=1; AJvYcCVklMBnfh6QeyS+YJm6kFIBPmpOYrwDbgRzYs77KXxBxKyU5zH0ptdZFWclgtrXY+P/OVOJG2odlEhPCvZ4D0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLYDI5bKoDRLFNAyrIdWNvKh9nHTCDWM/yL5FL7qB2bHceQTlf
	LhGEF6lJuLqQ6AYwLmIdgE+o6yA6oJ1MADAiyeB6nTskuP8+olnuagj4
X-Gm-Gg: ATEYQzxUUGtAPCAJvDLgWRodE+yGgCKvw6cI04QZkGCBzkE/ueflJ5uJmyzRdBdZCpz
	NoVuodoHT3+ua4w3MkNe7pu/X7zLqn/ZESThT3WCfp52yw8QQWm6AHScnOVasQ+0IFnsX7zH8+k
	suukTThlbplYvpBeTIqxppcUsLXRZ2m7Zi9E/T4+SJONc6koW4GxuusmM/uuScpFugyQKsH2ZZQ
	LXEcO9AHiE+H4c5Tz4s81waEcwFRcRRhNdvQJmoDMzZeuFSD9q/1nQ1FYzlgQ0e3F5TczEtvOnL
	MkYVyeXanC2klw2EQiQq7Fa6+qTKCU1qSHzFY45JCy0OiXi33ID53nDyB7TH2RJpkMoSdVRnnl1
	yxTaP7qHeFrF/dGXwp64kbIh729+YWy63DpfesRDGmU5G6hEVqNbhc+/nunI7nrYUBc4UqXAgox
	ANufIMOyFqRrdnsXgUfKlAN7cwI18PADNNMP3P1uA1Eg3ufmtZKXuFTMA9/X3bdeHBGf3s6obkp
	AwQLAWeGZS4KufpHDS+f03wIjQUt9Tol6Op
X-Received: by 2002:a17:902:f651:b0:2aa:e6fa:2f6c with SMTP id d9443c01a7336-2aeae7d8961mr41552345ad.24.1773271261277;
        Wed, 11 Mar 2026 16:21:01 -0700 (PDT)
Received: from ryzen (c-76-21-102-177.hsd1.ca.comcast.net. [76.21.102.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae261082sm46883805ad.41.2026.03.11.16.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 16:21:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] usb: renesas_usbhs: use kzalloc_flex
Date: Wed, 11 Mar 2026 16:20:43 -0700
Message-ID: <20260311232043.18025-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes one allocation and one free by using a flexible array member.

Also added __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/usb/renesas_usbhs/mod_gadget.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index 1539e8e6901d..0c7fe109d5c7 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -40,7 +40,6 @@ struct usbhsg_gpriv {
 	struct usb_gadget	 gadget;
 	struct usbhs_mod	 mod;
 
-	struct usbhsg_uep	*uep;
 	int			 uep_size;
 
 	struct usb_gadget_driver	*driver;
@@ -53,6 +52,7 @@ struct usbhsg_gpriv {
 #define USBHSG_STATUS_WEDGE		(1 << 2)
 #define USBHSG_STATUS_SELF_POWERED	(1 << 3)
 #define USBHSG_STATUS_SOFT_CONNECT	(1 << 4)
+	struct usbhsg_uep	uep[] __counted_by(uep_size);
 };
 
 struct usbhsg_recip_handle {
@@ -1084,15 +1084,11 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 	int i;
 	int ret;
 
-	gpriv = kzalloc_obj(struct usbhsg_gpriv);
+	gpriv = kzalloc_flex(*gpriv, uep, pipe_size);
 	if (!gpriv)
 		return -ENOMEM;
 
-	uep = kzalloc_objs(struct usbhsg_uep, pipe_size);
-	if (!uep) {
-		ret = -ENOMEM;
-		goto usbhs_mod_gadget_probe_err_gpriv;
-	}
+	gpriv->uep_size	= pipe_size;
 
 	gpriv->transceiver = devm_usb_get_phy(dev, USB_PHY_TYPE_UNDEFINED);
 	dev_info(dev, "%stransceiver found\n",
@@ -1115,8 +1111,6 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 	gpriv->mod.name		= "gadget";
 	gpriv->mod.start	= usbhsg_start;
 	gpriv->mod.stop		= usbhsg_stop;
-	gpriv->uep		= uep;
-	gpriv->uep_size		= pipe_size;
 	usbhsg_status_init(gpriv);
 
 	/*
@@ -1175,9 +1169,6 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 	return 0;
 
 err_add_udc:
-	kfree(gpriv->uep);
-
-usbhs_mod_gadget_probe_err_gpriv:
 	kfree(gpriv);
 
 	return ret;
@@ -1189,6 +1180,5 @@ void usbhs_mod_gadget_remove(struct usbhs_priv *priv)
 
 	usb_del_gadget_udc(&gpriv->gadget);
 
-	kfree(gpriv->uep);
 	kfree(gpriv);
 }
-- 
2.53.0

