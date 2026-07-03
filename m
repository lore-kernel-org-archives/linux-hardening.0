Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8638A3B27C5;
	Fri,  3 Jul 2026 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783071896; cv=none; b=WsGmD8pItPXijGosgSrSPuWYAIcGfheGQzUG6DCWeZ5YF+RqqCxBcNztI56aCQAUWuz5iQ3Xrxnu/dtFs5DupDXXuE/qnPumUQxWHLW7QTjV2zVnxKzDytxijxaut2LvbmDTxOxPsxa3IyuQQ0ZXUcH4zqJnNywEMYEs50PfF+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783071896; c=relaxed/simple;
	bh=0YQCMORrAL0CY4BlPlYIh4rccY3+aiWKkECAfv0KqwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rf64TluD1xuwcmoxVGMmneHZFwQ/CTauLL9T5+pi0M6vP/ly9sKQDTVHR5vMhNxgn8r3FINKVIVhs+hL/0zwK5xxpshmY5m2OyZGhsMvw/yVc7FCKCafQoaGQHQ1ZqhmiQKcYgLvYg86UML77wEtYh0a2GutWOTXAhCsAfHow3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XTTJPkNU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XTTJPkNU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6711F000E9;
	Fri,  3 Jul 2026 09:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783071895;
	bh=TlhEmV9b3yQuDivDKOLQMuW+utydjEwNxJ3dp+PpmXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XTTJPkNUPp4wAbmiW3ylIpmJ5anOfLqudJkPW9QCFvMG5RndqmV+GBvkavNv10FfJ
	 iGfHuQncpHp11s38qXMelHtH3pGadPYzmJa9wwwbLMyRy8oxxxc8ovxXWJUz9gpX3E
	 6yRFjS0vdBDxfqooTw7pQQ766nzHelOCrj1av5n4=
Date: Fri, 3 Jul 2026 11:45:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-usb@vger.kernel.org, Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"moderated list:MEDIATEK USB3 DRD IP DRIVER" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:MEDIATEK USB3 DRD IP DRIVER" <linux-mediatek@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] usb: mtu3: allocate phys with ssusb
Message-ID: <2026070330-darkroom-taking-3687@gregkh>
References: <20260411035731.163580-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411035731.163580-1-rosenp@gmail.com>

On Fri, Apr 10, 2026 at 08:57:31PM -0700, Rosen Penev wrote:
> Use a flexible array member to combine allocations. Allows removal of a
> pointless branch. A size of 0 means phys are not allocated.
> 
> Add __counted_by for extra runtime analysis.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/usb/mtu3/mtu3.h      |  2 +-
>  drivers/usb/mtu3/mtu3_plat.c | 18 ++++++------------
>  2 files changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
> index ba5a63669e5f..d71849388602 100644
> --- a/drivers/usb/mtu3/mtu3.h
> +++ b/drivers/usb/mtu3/mtu3.h
> @@ -252,7 +252,6 @@ struct ssusb_mtk {
>  	struct mtu3 *u3d;
>  	void __iomem *mac_base;
>  	void __iomem *ippc_base;
> -	struct phy **phys;
>  	int num_phys;
>  	int wakeup_irq;
>  	/* common power & clock */
> @@ -272,6 +271,7 @@ struct ssusb_mtk {
>  	struct regmap *uwk;
>  	u32 uwk_reg_base;
>  	u32 uwk_vers;
> +	struct phy *phys[] __counted_by(num_phys);
>  };
>  
>  /**
> diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
> index cc8a864dbd63..11a919fc3d47 100644
> --- a/drivers/usb/mtu3/mtu3_plat.c
> +++ b/drivers/usb/mtu3/mtu3_plat.c
> @@ -240,17 +240,6 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
>  	if (ret)
>  		return ret;
>  
> -	ssusb->num_phys = of_count_phandle_with_args(node,
> -			"phys", "#phy-cells");
> -	if (ssusb->num_phys > 0) {
> -		ssusb->phys = devm_kcalloc(dev, ssusb->num_phys,
> -					sizeof(*ssusb->phys), GFP_KERNEL);
> -		if (!ssusb->phys)
> -			return -ENOMEM;
> -	} else {
> -		ssusb->num_phys = 0;
> -	}
> -
>  	for (i = 0; i < ssusb->num_phys; i++) {
>  		ssusb->phys[i] = devm_of_phy_get_by_index(dev, node, i);
>  		if (IS_ERR(ssusb->phys[i])) {
> @@ -330,12 +319,17 @@ static int mtu3_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct ssusb_mtk *ssusb;
>  	int ret = -ENOMEM;
> +	int num_phys;
>  
> +	num_phys = of_count_phandle_with_args(dev->of_node,
> +			"phys", "#phy-cells");

You just caused a bug here if this returns a negative value.

How was this tested?

And why is it even needed?

thanks,

greg k-h
