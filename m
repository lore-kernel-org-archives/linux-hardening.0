Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806385;
	b=JNrnti+9SSRmO3wEXGhqBdWwlNAlHCzFp3jV2l+cKgbZvNTRZP4sD44WtpuHBZMVti3F
	 hQsC+ZWcMoMBfiywiqSyKz1O6wtrY42tDuAdhufN30Tdz3xNekPI0urstvfAZEEbK1Ce4
	 gwIUl6IvtvZZ9bWDIZHdTaZa8clBTQA5b5pr2n3p3f0z6TqvzpXGrxRuvBnSiuFLJHeVi
	 kmR3zhpZ/ZQVFNJKe2P6GxoS25HdyoaFWBNHZGCdPmLDOPeXYeOkJKH0ulnRRUaC/N1Vq
	 wv8apKilYMcPy9U5dU0E/XuBASpH7jkDaRx6ZY7wrkSi9uKjMImEg06nf8N8gekhAeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806385;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=b/x6zpD9OBHa7oB2g2wm+0IAQx4iGRhspWzCqvvaFww=;
	b=gDv/W+TH4n2vTw0/2U4xfMfz1gy0yX3CIxzFIQu4csMDt2QH7STauaTRfcgMd6FgrwKF
	 zUgEf6ABwciF/Ytvxr6rDT1BScfZnolAKb/+AXcge4gK9KijQ1S/pfGcHHq1f5srZgSwT
	 2pnJctfhfrBrCRbWEh1maE8t8AVeB3b8RUiOumE5BucgmPXjavSuMDi5YGafHSVbW7BKl
	 Yx3dis54BbvP+VyhfpJUQ9iOWdD+s40qeoIR30OGAz23BaUN0hsvzSfYPamQt8zuD7z4M
	 MgAtLbrTzVKrP2CcgdA2I/r5j54GVm3pCanzPSFmLPAD0AMhViQU0O7HTCIdiNmwLdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R+bri8M/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6F2606A32D;
	Wed,  4 Nov 2026 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+bri8M/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018791F000C1;
	Wed,  4 Nov 2026 15:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793806385;
	bh=b/x6zpD9OBHa7oB2g2wm+0IAQx4iGRhspWzCqvvaFww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R+bri8M//bIxpp/85z/gG/q9NtoELwrxjLtJK0FqUgNTr0KgUDF7WBeQxi0rzs80U
	 hvcpjFPDVy0IK+REsAD9RH8621T3uNvROTsO3dERub2j1A4zCMG37xcHSToep/Vcdo
	 Wo9FkSkY11ZyuXKTzVzqLRSV/Et2Mw6aUdUqebLzaVqFrzjb4tDaA9e8xMoDHb13Ms
	 ziQF7+6d/8XpI8kIYGg1B2xUr120I/EAEQszkccnDUgKm4nDcjzF3x2TOs20JOsJfo
	 7wVDFturzzuEjSeyEr7M1C2g4UWtSSIh8aj7EBJT76lV9EzMXGFO+x0UcSybQIyE0A
	 sv0xtIiZCYwlQ==
Date: Wed, 4 Nov 2026 09:33:03 -0600
From: Rob Herring <robh@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
	Linus Walleij <linusw@kernel.org>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 8/9] of: property: implement the count_references()
 fwnode operation
Message-ID: <20261104153303.GC3951195-robh@kernel.org>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-8-6e28fe1c72c4@oss.qualcomm.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-fwnode-for-each-prop-v1-8-6e28fe1c72c4@oss.qualcomm.com>

On Wed, Nov 04, 2026 at 03:03:50PM +0100, Bartosz Golaszewski wrote:
> Implement the property_count_references() fwnode operation for OF nodes
> by wrapping the existing of_count_phandle_with_args().
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/of/property.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Acked-by: Rob Herring (Arm) <robh@kernel.org>
