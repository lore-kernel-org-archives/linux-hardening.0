Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472338;
	b=PsSCrNOdC/DcI3a5tTwfV7KaK2209mMfGGkEfxd/dwzIIhGZAHRfvZDqtgUCthq+CCcp
	 xunM9PbWCySQnUUiLXYAr0+KDDviayW9s088fZHMIcck58+HapvFrJXWO315CN+ggDarF
	 IZHUVduyP9y6GmrJQ5SXy+CffrdkgfitFlHYPMlpC9PgRx5dvpkJwuC1DHkbVUJH/8xCq
	 n0TwfKyvEbZwKllsUnjIgSdCPaipJKPBwoyYX3+39BZ8E4lRxXVfkmbChGUHxpeKVTbnu
	 4OKLNJLjBQRzwMB+F39+cyp/O10NEuXnOwcH9hlnMaXEEoVFEENnwepivGMz5vO8MkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472338;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YNpY5R5+Z9kOj9iFoPNkKtuTlJgBDahWNmiFIL4yAAg=;
	b=cUtzrOAde4849Lm1jZUqpnQ5N02KjQMGl9M7XrxHqW9EzuebM8Q10gfqjcGyfDsLzmzI
	 BWtrmAkYE7pxf9EpigXI3AdhwbyWiNt6uleA0e2tZn5uEM0PCqaJnbU3acCoNZb38r1RA
	 m1D3tnWuEyliSWVvfmRcsUaoNSRjRwMn4q2Qy05vcRbWd+LsdYki+dMzwtq24EaCskddD
	 jQwltpoNlM8afUi31tMdfLyxB5dSrkivZClfXZ9KhPyYDdAfWOmvleUbanT8Tj+eGkMik
	 owRRuHYda/qsrPUPVJ9ojRSomh1Mq/oWtQm9SQVjI1HHq4d1lrZc8hl6loWbqbEKqjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=isDwKzIs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFA4606A31E;
	Mon, 23 Nov 2026 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=isDwKzIs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF4B1F000CA;
	Mon, 23 Nov 2026 22:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795472337;
	bh=YNpY5R5+Z9kOj9iFoPNkKtuTlJgBDahWNmiFIL4yAAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=isDwKzIsdk/vyOxgxLodfDlw2VRkT+LfkwevOXmwG/pe8ENUlkfKCeDU3BLeMcsNh
	 0SuTSXVCFVefMhj+57tNTiYh85lTqaWQLZXwEi8SeFKTswko544Q0f5C8d2foLTVzT
	 wPwr2pTkOoHLH7uqArmv7M269bPyjg/cTF7ymQIuMdfI9Ga+M3Cr+4DZhYNijWvsHQ
	 ISsjrqAU4VeeKeqNp9ps/PW65ndv+zxiD0XPIFw/5KzmQQAdaKDKUEvyyAft/jj4vE
	 2FJY3OdYDvQTQ9wy8GANDHg/1WSaoJh6CfwGvYrMAEI+kgasdDry6FC4O3OE3FNRpv
	 M73dOUDblBqYA==
Date: Mon, 23 Nov 2026 16:18:48 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-acpi@vger.kernel.org, Saravana Kannan <saravanak@kernel.org>,
	driver-core@lists.linux.dev, Andy Shevchenko <andy@kernel.org>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, devicetree@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-hardening@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johan Hovold <johan@kernel.org>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v3 05/10] of: property: implement the
 .property_get_names() fwnode operation
Message-ID: <179547232789.2860658.13356602121797700590.robh@kernel.org>
References: <20261120-fwnode-for-each-prop-v3-0-808e304dc73e@oss.qualcomm.com>
 <20261120-fwnode-for-each-prop-v3-5-808e304dc73e@oss.qualcomm.com>
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
In-Reply-To: <20261120-fwnode-for-each-prop-v3-5-808e304dc73e@oss.qualcomm.com>


On Fri, 20 Nov 2026 13:46:42 +0100, Bartosz Golaszewski wrote:
> Implement the property_get_names() callback from the fwnode interface
> for OF nodes.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/of/property.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

