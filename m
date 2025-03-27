Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E29145B24
	for <linux-hardening@vger.kernel.org>; Thu, 27 Mar 2025 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743103882; cv=none; b=JGOngeqd7TJ225z8i+Vw8Y3S2TajZRNlrl2gauEgpa1YYbVWPTGaO1slU1baZuRy6NydNKjscoGZfbSf7iSQN0stF0FwcnUtsMlb27dST/O/TjXhIvzbPjSRIteJmHKWGcu0tPKpe8CS0VAXG1nDF5kW/MbAbD5UF3qp38saKDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743103882; c=relaxed/simple;
	bh=Uo3Y4wwMyV3y+DSOMke8R1D7DBAWK/vp0DGAudzMYeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9Xf0UHAj0ogpi0uCoHBSIwNLfd4H2zp5pnpkI/2NhVyiUC4h0eOzxF7EQmhT5yd437kykFNDGvQIfId8ltZMz5CUnlJ7CBV408NAEbd4g6nkj6uNcSpXOeI92fMBzRwh5TPLyEGvwBl/8oQlMUspYVREQwkHcTWNlE2u3znD/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=jwTKEtkW; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="jwTKEtkW"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4774193fdffso22322751cf.1
        for <linux-hardening@vger.kernel.org>; Thu, 27 Mar 2025 12:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1743103879; x=1743708679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fOWvcEa0sbfZjABPw9Te+y/65mWJI8Lsb95Ek+V1dlo=;
        b=jwTKEtkWQuP40eSVJnCqMGKUXDv7LRvL4ATsKdf26B6bkeYXlFq8KKuqmzIyt4knjZ
         MVQoW1+bDJCD25GGSq9yonzk7H99jWi/UHjDSapc0O31BGxwDmJxW0sbvY5oh+k5aAlb
         K/k2TDm3plK4XIzx9VetIdQc3jU/p8MHtFAfCz3DkSYuhpsZcwlA2Tzd2XVLBuwJrbPA
         3JQMAHQ1KVQ2qsR+fwzxNMMxG8r+cmdliX3ofJZb8ijDXjehqMzT1E5bYv7bw8sx8tz6
         x9hW4yp8f3PXcJkcSHCiUYbEdcNu22T07KtczXKlaS60xWmapq6OyM4hsTXpYoebOUEV
         H3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743103879; x=1743708679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOWvcEa0sbfZjABPw9Te+y/65mWJI8Lsb95Ek+V1dlo=;
        b=fEkF+CnPsb9hzxYK9qfXiYyUiCHbAekb51OGuHrpIrSzSKhAIWQlpBsqVKyp8G/ZiI
         c40ZHp6ANefqDGqWdM0qL6/LQ7hAB9c42JsiD6tMKJNaBBxOX+E60I38sbXpEYNr7Cn4
         UCS7+iKKGnv8M4FnjkfPqrTvfA7duPvcL7y+OWDyGHgxxQq5bf1GU2oX5YLLxltW9RMC
         kgjn/4PqrYO/E8KP6wrfngsTRsZeI0LN1doTvPrD7VuWXcPe2rm8O+m7CBf7kgMm5SVK
         AN6n5Fo2U9yW3UmlNHQA7cz+ikhTOJ1tchqOYQAnQRm5mvofLgtVr9VqUoWqjJibK2dW
         hBeg==
X-Forwarded-Encrypted: i=1; AJvYcCX7qAwhR72X81g4VMvrcOrgJZEt+aPuliNUXmhaHl3k0Fc7TZn8YJdswIAJ7v8OQe3DW6DB7Rz5di1YWMpWuoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzffIE4LMo/TKpR6GOFw0X1p9ris23T72i8R8gW+lzasKXaSpZn
	XsFI5sy0rJNaQxY3m3doLi0kaxDcGRTXhMwYXTv26Nv1y6llvgmDa4tAjSpE0xjWaxHFSdphgv4
	=
X-Gm-Gg: ASbGnctR5Wzfp/sH5H66ETH2qCN0x+BdXwglV+Lr6lQXEL0Qo6u513yZAZvnnAUkYlO
	yoiNHmsP+NYtPQ08SbwwWSlR8Rw/OSIB0x9tf67WkF35IQTd/BN91znIbQKsB57yMdDUN00i8Dk
	CnRIpXNdVIA90FoMBsqUtnvt7rVxCU2+JHoUiA5KVZkwnfTyDF3+2DRU5Cx3f13wF4yyJqkbyCF
	7DR/DswfsqlHZNGV4tavY1bNAZ/4tV7v3+F8h/giDmVk9wAjb0bR0tpH+NpTaV+4HRpdqvelJF9
	2I54hiogUcRHrgI3SXzMAeE2pctJlhMEjohkTbY9aYB+bIGUdKeTc7D57EYUgQlT4460qMjpW5w
	e32MVdohq1nQoPyc5Xj3SZqhXU6/0uXiWr0Bb+g==
X-Google-Smtp-Source: AGHT+IHhYGeHC6Cc7v+fL0j0iHE1UuzcR8DR3uKdtY7qHAlgm3C/YNf4p1yl1SUxogG0H29UbqzJ+g==
X-Received: by 2002:a05:622a:58c6:b0:477:4df:9a58 with SMTP id d75a77b69052e-4776e0d1714mr88924621cf.18.1743103878520;
        Thu, 27 Mar 2025 12:31:18 -0700 (PDT)
Received: from rowland.harvard.edu (nat-65-112-8-24.harvard-secure.wrls.harvard.edu. [65.112.8.24])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47782a1070csm1526041cf.9.2025.03.27.12.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 12:31:17 -0700 (PDT)
Date: Thu, 27 Mar 2025 15:31:15 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] usb: ehci-fsl: Fix use of private data to avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <8139e4cc-4e5c-40e2-9c4b-717ad3215868@rowland.harvard.edu>
References: <Z-R9BcnSzrRv5FX_@kspp>
 <1e82761e-8554-4168-8feb-561abbe49f7e@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e82761e-8554-4168-8feb-561abbe49f7e@rowland.harvard.edu>

In the course of fixing up the usages of flexible arrays, Gustavo
submitted a patch updating the ehci-fsl driver.  However, the patch
was wrong because the driver was using the .priv member of the
ehci_hcd structure incorrectly.  The private data is not supposed to
be a wrapper containing the ehci_hcd structure; it is supposed to be a
sub-structure stored in the .priv member.

Fix the problem by replacing the ehci_fsl structure with
ehci_fsl_priv, containing only the private data, along with a suitable
conversion macro for accessing it.  This removes the problem of having
data follow a flexible array member.

Reported-by: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/linux-usb/Z-R9BcnSzrRv5FX_@kspp/

---

 drivers/usb/host/ehci-fsl.c |   25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

Index: usb-devel/drivers/usb/host/ehci-fsl.c
===================================================================
--- usb-devel.orig/drivers/usb/host/ehci-fsl.c
+++ usb-devel/drivers/usb/host/ehci-fsl.c
@@ -410,15 +410,13 @@ static int ehci_fsl_setup(struct usb_hcd
 	return retval;
 }
 
-struct ehci_fsl {
-	struct ehci_hcd	ehci;
-
-#ifdef CONFIG_PM
+struct ehci_fsl_priv {
 	/* Saved USB PHY settings, need to restore after deep sleep. */
 	u32 usb_ctrl;
-#endif
 };
 
+#define hcd_to_ehci_fsl_priv(h) ((struct ehci_fsl_priv *) hcd_to_ehci(h)->priv)
+
 #ifdef CONFIG_PM
 
 #ifdef CONFIG_PPC_MPC512x
@@ -566,17 +564,10 @@ static inline int ehci_fsl_mpc512x_drv_r
 }
 #endif /* CONFIG_PPC_MPC512x */
 
-static struct ehci_fsl *hcd_to_ehci_fsl(struct usb_hcd *hcd)
-{
-	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
-
-	return container_of(ehci, struct ehci_fsl, ehci);
-}
-
 static int ehci_fsl_drv_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
-	struct ehci_fsl *ehci_fsl = hcd_to_ehci_fsl(hcd);
+	struct ehci_fsl_priv *priv = hcd_to_ehci_fsl_priv(hcd);
 	void __iomem *non_ehci = hcd->regs;
 
 	if (of_device_is_compatible(dev->parent->of_node,
@@ -589,14 +580,14 @@ static int ehci_fsl_drv_suspend(struct d
 	if (!fsl_deep_sleep())
 		return 0;
 
-	ehci_fsl->usb_ctrl = ioread32be(non_ehci + FSL_SOC_USB_CTRL);
+	priv->usb_ctrl = ioread32be(non_ehci + FSL_SOC_USB_CTRL);
 	return 0;
 }
 
 static int ehci_fsl_drv_resume(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
-	struct ehci_fsl *ehci_fsl = hcd_to_ehci_fsl(hcd);
+	struct ehci_fsl_priv *priv = hcd_to_ehci_fsl_priv(hcd);
 	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
 	void __iomem *non_ehci = hcd->regs;
 
@@ -612,7 +603,7 @@ static int ehci_fsl_drv_resume(struct de
 	usb_root_hub_lost_power(hcd->self.root_hub);
 
 	/* Restore USB PHY settings and enable the controller. */
-	iowrite32be(ehci_fsl->usb_ctrl, non_ehci + FSL_SOC_USB_CTRL);
+	iowrite32be(priv->usb_ctrl, non_ehci + FSL_SOC_USB_CTRL);
 
 	ehci_reset(ehci);
 	ehci_fsl_reinit(ehci);
@@ -671,7 +662,7 @@ static int ehci_start_port_reset(struct
 #endif /* CONFIG_USB_OTG */
 
 static const struct ehci_driver_overrides ehci_fsl_overrides __initconst = {
-	.extra_priv_size = sizeof(struct ehci_fsl),
+	.extra_priv_size = sizeof(struct ehci_fsl_priv),
 	.reset = ehci_fsl_setup,
 };
 
