Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFD125A642;
	Mon,  1 Sep 2025 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756757582; cv=none; b=plCDKwSzWwyVn+jlxAxfYOmXBI58u8WXrqsuzr0XPgNDjUOTh3n1fL/B0Of4LVm2EGsxwpk32PuzD7CSzKGFBHRtKwzM6QRb68G7pSDn8hbk0XEhgya810ZMdVb3w5+e3eQ9Yf1IuuCVXkqiaY0Yl4cVYpxv7hpJOpeWt0in7l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756757582; c=relaxed/simple;
	bh=zvdD5eNoOKxgj1d84KO3wFQ/w8Pf4L1cCEZiTrLfefc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNhE80VxAj9AtFAPvgAKFFC04eO3SB/TGu6c7rd0JEDP26VT3/5qg2LcQgFgMHr/fuGU06/x6n0ff2YY1/3Y1hVvoV/t50+RIph9s/fj5myo22TzIkVB7NNjc9pb1gsz9mGYdASjaNDvbcd3xhfiKwfQIKn6K/ZqGDiUJ410PbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WHzpMIZj; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WHzpMIZj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E014F4E40C5E;
	Mon,  1 Sep 2025 20:12:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9A141605FC;
	Mon,  1 Sep 2025 20:12:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 453091C22D4DC;
	Mon,  1 Sep 2025 22:12:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756757576; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=yx7mHEOoHsc87Dtv9nuxZTICDeAvK7jqOFwE7WdiL7s=;
	b=WHzpMIZjyezAVqM5LP+PwrF5dQX10LbmN7LXHNVX4E0d1Pahp/10z5ZXuiGO8kwnDRCZJD
	/BQgMEk7hT09KLlTALWS02GhIsryTQ61olMvL+CSiKbmN+Ljr8RKEAP5UTSSVK+vdSObN1
	+zu16/Ur87JB5qOan4XoVM3+7Pdu1SK5Ve3xxgRp3BmZeVwoki+kI/h3d2VAl0wdCoZIDO
	NHE1IudywD+OynU8gbdUH7HUEsdBYElVX/eYdXYAr6RD48tfuLca64OgvC/4lRXidigdE0
	+Wmi2tFS0yYtGB62hKH+PJntWWby9pTr03E0Fx8KEVLh3lc37DnRR/6kK0+sHQ==
Date: Mon, 1 Sep 2025 22:12:48 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: git@amd.com, michal.simek@amd.com, Frank.Li@nxp.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, kees@kernel.org,
	gustavoars@kernel.org, jarkko.nikula@linux.intel.com,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	radhey.shyam.pandey@amd.com, srinivas.goud@amd.com,
	shubhrajyoti.datta@amd.com, manion05gk@gmail.com
Subject: Re: [PATCH V2 2/2] i3c: master: Add AMD I3C bus controller driver
Message-ID: <202509012012480348cc7a@mail.local>
References: <20250829171327.2590730-1-manikanta.guntupalli@amd.com>
 <20250829171327.2590730-3-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829171327.2590730-3-manikanta.guntupalli@amd.com>
X-Last-TLS-Session-Version: TLSv1.3

On 29/08/2025 22:43:27+0530, Manikanta Guntupalli wrote:
> +static void xi3c_master_reset_fifos(struct xi3c_master *master)
> +{
> +	u32 data;
> +
> +	/* Reset fifos */
> +	data = readl(master->membase + XI3C_RESET_OFFSET);
> +	data |= XI3C_FIFOS_RST_MASK;
> +	writel(data, master->membase + XI3C_RESET_OFFSET);
> +	udelay(10);

As pointed out by checkpatch:
usleep_range is preferred over udelay, I guess it would be fine in this
function.

> +	data &= ~XI3C_FIFOS_RST_MASK;
> +	writel(data, master->membase + XI3C_RESET_OFFSET);
> +	udelay(10);
> +}
> +

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
