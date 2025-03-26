Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A24019D88B;
	Wed, 26 Mar 2025 22:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743027464; cv=none; b=WZ1Dj76SWraGtnlruLMOljB1qfHjfFPb5nhsh3c3o8sbQH0h1mHnos/eTVJe0ckLeaQ/a57PrVBv1iZLrcXMftl7Viajo33++vxDC2MnHAOOlDg2tRKoD2b+nGA1ePS1ubFkWh/2zNzkYsxyqWcOxiM4TP+k5HZLdxJobViQov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743027464; c=relaxed/simple;
	bh=ztcSyDM8688dY/x4+PbD/IkRXQaivYoZnohIQ5z1uOk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qg2y2bGmu1s4ioSDIlWGbMHj5Ele88soFGAIoMj+yEvYZsTbWGY53bbMecrEoERJngmzagRuO2Moq1mpIUVpJVqWQzjqP3U7I4Yu95cZQyvy0VOXYV0V0qMFU8Fr7pUDO+MRI8ITN92ZOGV/RUM2YrM0uh/H8q8AmS0duuDAY6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZjKyefw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZjKyefw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C32DC4CEE2;
	Wed, 26 Mar 2025 22:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743027463;
	bh=ztcSyDM8688dY/x4+PbD/IkRXQaivYoZnohIQ5z1uOk=;
	h=Date:From:To:Cc:Subject:From;
	b=aZjKyefwZKYW7LeGPlItgSyUrpIMQulGkTH7hGBOcy36+7XQoK4Una1scZ6ZVHlax
	 WaKJRvg4WEcH7nrTkKZCrZv5Lagw9FRHfG6zutH3FgYnIdrjgn/bc76FOlfgd38VgU
	 Yp9g5LKLFsH6vrWDjxJywPxkBeXiavmEH4zl0wcNKSHr5tlb4BIBOXRRQPdfODkIla
	 SJvWdMdjhjy6repYF27U25o5E6JpVyMr0HBpNOmsccm/fhEHc4FREkWs23WNG8dZp4
	 t4Q2rN4/UZVh1/palTutmswlnOOFiuQi7AlXTIM0aLpWkGdCQgkUCzRzUQzmL28ba9
	 BtMEoboYuKvsA==
Date: Wed, 26 Mar 2025 16:17:41 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] usb: ehci-fsl: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <Z-R9BcnSzrRv5FX_@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declaration to the end of the structure. Notice
that `struct ehci_hcd` is a flexible structure --a structure that
contains a flexible-array member.

Fix the following warning:

drivers/usb/host/ehci-fsl.c:414:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/usb/host/ehci-fsl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 26f13278d4d6..c720d55f4982 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -411,12 +411,13 @@ static int ehci_fsl_setup(struct usb_hcd *hcd)
 }
 
 struct ehci_fsl {
-	struct ehci_hcd	ehci;
-
 #ifdef CONFIG_PM
 	/* Saved USB PHY settings, need to restore after deep sleep. */
 	u32 usb_ctrl;
 #endif
+
+	/* Must be last --ends in a flexible-array member. */
+	struct ehci_hcd	ehci;
 };
 
 #ifdef CONFIG_PM
-- 
2.43.0

