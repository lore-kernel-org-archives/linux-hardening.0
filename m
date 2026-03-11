Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167DE3CF03D;
	Wed, 11 Mar 2026 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773240430; cv=none; b=pcwXmGeW05rj9UTMQm5ZywqpPioHp/9qqJ4TJA+u3Ya9h80rfremsUVC/wBChbLcuxDP/Tz1l+SBqMPSEPpxHzyGmc3Khyt3WEpXgE+RuZNAi8MCT3dPj0+dgL+qJ9zo/3QFox2OxVCT2TPD3cw8aoMrbYLxj3xOHQblNrlQnvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773240430; c=relaxed/simple;
	bh=57nVp/q/Z2G8xFagzdFKofKKzNWEujXevPq8V/3HkkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQcTzTae+qrePXkLDOMnNc+w+voaeuEJSVtzRF79vNnmi9HaWl1ndfQpkFzEovr5O9R8++eujfBxxLD4v91lzjtMErA4n6iG/dpi4QHrmjIH71y8nhmJWs8hTWXgmIMuBV4OZ6tlqepH3OW6P9mGA0tQObMNeItBco/Un29jL8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M3u7Tnc/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M3u7Tnc/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FCDC2BCB1;
	Wed, 11 Mar 2026 14:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773240429;
	bh=57nVp/q/Z2G8xFagzdFKofKKzNWEujXevPq8V/3HkkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3u7Tnc/4197+T5TRkHdm8ISq9KEdW1pRKIblLQLKTur5YA3+f+TQQsoFFQYormVP
	 wpSLObqNyovZIUugLR3Mpf6x1DsxQBY/YxM6Ir4j/L0PsnNM45WwAnxw0/1v7sLrxV
	 HtyeAOcY7aAOjQm6CH7j+nIJDPDgFsAiUn88oG9I=
Date: Wed, 11 Mar 2026 15:47:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-usb@vger.kernel.org,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"open list:QUALCOMM TYPEC PORT MANAGER DRIVER" <linux-arm-msm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: qcom-pmic-typec: simplify allocation
Message-ID: <2026031127-siding-caress-7ed9@gregkh>
References: <20260306222148.8200-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306222148.8200-1-rosenp@gmail.com>

On Fri, Mar 06, 2026 at 02:21:48PM -0800, Rosen Penev wrote:
> Change kzalloc + kcalloc to just kzalloc with a flexible array member.
> 
> Add __counted_by for extra runtime analysis when requested.
> 
> Shuffle some code in probe to provide a clearer picture.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../typec/tcpm/qcom/qcom_pmic_typec_pdphy.c   | 27 ++++++++-----------
>  .../typec/tcpm/qcom/qcom_pmic_typec_port.c    | 26 ++++++++----------
>  2 files changed, 22 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> index c8b1463e6e8b..4b3915c6894a 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> @@ -95,13 +95,13 @@ struct pmic_typec_pdphy {
>  	struct regmap			*regmap;
>  	u32				base;
>  
> -	unsigned int			nr_irqs;
> -	struct pmic_typec_pdphy_irq_data	*irq_data;
> -
>  	struct work_struct		reset_work;
>  	struct work_struct		receive_work;
>  	struct regulator		*vdd_pdphy;
>  	spinlock_t			lock;		/* Register atomicity */
> +
> +	unsigned int			nr_irqs;
> +	struct pmic_typec_pdphy_irq_data	irq_data[] __counted_by(nr_irqs);
>  };
>  
>  static void qcom_pmic_typec_pdphy_reset_on(struct pmic_typec_pdphy *pmic_typec_pdphy)
> @@ -560,31 +560,26 @@ int qcom_pmic_typec_pdphy_probe(struct platform_device *pdev,
>  	struct pmic_typec_pdphy_irq_data *irq_data;
>  	int i, ret, irq;
>  
> -	pmic_typec_pdphy = devm_kzalloc(dev, sizeof(*pmic_typec_pdphy), GFP_KERNEL);
> -	if (!pmic_typec_pdphy)
> -		return -ENOMEM;
> -
>  	if (!res->nr_irqs || res->nr_irqs > PMIC_PDPHY_MAX_IRQS)
>  		return -EINVAL;
>  
> -	irq_data = devm_kcalloc(dev, res->nr_irqs, sizeof(*irq_data),
> -				GFP_KERNEL);
> -	if (!irq_data)
> +	pmic_typec_pdphy = devm_kzalloc(dev, struct_size(pmic_typec_pdphy, irq_data, res->nr_irqs), GFP_KERNEL);

extra long line, checkpatch.pl didn't complain about this?

> +	if (!pmic_typec_pdphy)
>  		return -ENOMEM;
>  
> +	pmic_typec_pdphy->nr_irqs = res->nr_irqs;
> +	pmic_typec_pdphy->dev = dev;
> +	pmic_typec_pdphy->base = base;
> +	pmic_typec_pdphy->regmap = regmap;
>  	pmic_typec_pdphy->vdd_pdphy = devm_regulator_get(dev, "vdd-pdphy");
>  	if (IS_ERR(pmic_typec_pdphy->vdd_pdphy))
>  		return PTR_ERR(pmic_typec_pdphy->vdd_pdphy);
>  
> -	pmic_typec_pdphy->dev = dev;
> -	pmic_typec_pdphy->base = base;
> -	pmic_typec_pdphy->regmap = regmap;
> -	pmic_typec_pdphy->nr_irqs = res->nr_irqs;
> -	pmic_typec_pdphy->irq_data = irq_data;
>  	spin_lock_init(&pmic_typec_pdphy->lock);
>  	INIT_WORK(&pmic_typec_pdphy->reset_work, qcom_pmic_typec_pdphy_sig_reset_work);
>  
> -	for (i = 0; i < res->nr_irqs; i++, irq_data++) {
> +	for (i = 0; i < res->nr_irqs; i++) {
> +		irq_data = &pmic_typec_pdphy->irq_data[i];
>  		irq = platform_get_irq_byname(pdev, res->irq_params[i].irq_name);
>  		if (irq < 0)
>  			return irq;
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
> index 8051eaa46991..7c5cf8061f04 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c

Can you just convert one driver at a time please?  This should be a
patch series.

thanks,

greg k-h
