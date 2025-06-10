Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D122376E1;
	Tue, 10 Jun 2025 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568251; cv=none; b=u531RLvczbeEos4iAp2yAzbOCS9I3MDdE5+R8B2VJmb8pRWAeixdE49gUtURYS29Mhscl277QkZSHVpNCMUycThj89WOZ8FcKqttMSMHd+gaP2dfmQOMjx7jbduBTtzP3ypHQxkZAyyVf8sMVNqBwrAsvv7/P1qFpKAGqFNL15g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568251; c=relaxed/simple;
	bh=spvctm3ZTIwSylv/GDwnK6tu7BZA1j5E0lauFoZ/CKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eji6cHCkQey5GiITYLjvEJ/i/jgsG1xUcBnXdfneejc9h5C9qEjLjKH1yBc86ismSOjZm16PE4N1YxlHB5XJas1ejt3DuyQXVhQdbfmLJSL4tA9bEDW0SuZui5v7KOZ5iZqUsTrhrir9vuOnPATcG9fhWZPIz5K3dKzB9zqVR4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYYK0Q29; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYYK0Q29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6545AC4CEED;
	Tue, 10 Jun 2025 15:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749568251;
	bh=spvctm3ZTIwSylv/GDwnK6tu7BZA1j5E0lauFoZ/CKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GYYK0Q29SIbGCH2/EVWyzHZ3XixY4edz+YUHrlDy13SnnkcyklmjmOQVkvkO2XXgj
	 90Y0lieVudBL+XIaWlkE19U/hU0A7C+nGRVLuWKUiMsXmUkJL8vcj4RWlFOaz4wyl/
	 paR1/M4wLOb2mNvp4WktOnNMltUkOEQnuRzvC2i2yr7vVdVvzYuM4o/YdND3urAxvs
	 2DStYnw9oRI1OQhSLbp48V4FyOu2eNbudeeeMrf4PqDD+GV8rxahHRwd6AbzDDXBkk
	 MsHcn7WCwEhl/O9mgeZTqj0sp2wX1wzefd1tBZOXD2lwWII3QRYSfBvYgWpQJfS3jY
	 F5ZMwlw/+ZXcA==
Date: Tue, 10 Jun 2025 23:10:46 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Naoya Tezuka <naoyatezuka@chromium.org>
Cc: Benson Leung <bleung@chromium.org>, Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] platform/chrome: chromeos_pstore: Add ecc_size module
 parameter
Message-ID: <aEhK9knE1Fu_e_Sv@tzungbi-laptop>
References: <20250610050458.4014083-1-naoyatezuka@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610050458.4014083-1-naoyatezuka@chromium.org>

On Tue, Jun 10, 2025 at 02:04:58PM +0900, Naoya Tezuka wrote:
> On ChromiumOS devices, the ecc_size is set to 0 (check dmesg | grep ecc 
> to see `ecc: 0`): this disables ECC for ramoops region, even when 
> ramoops.ecc=1 is given to kernel command line parameter.
> 
> This patch introduces ecc_size module parameter to provide an method to 
> turn on ECC for ramoops and set different values of ecc_size per devices.

The doc [1] suggests to describe changes in imperative mood. If you have
chance to send next version, please fix it.  Otherwise, it doesn't really
bother me.

[1]: https://docs.kernel.org/process/submitting-patches.html

> @@ -9,6 +9,10 @@
>  #include <linux/platform_device.h>
>  #include <linux/pstore_ram.h>
>  
> +static int ecc_size;
> +module_param(ecc_size, int, 0444);

Does it need to be world-readable? How about 0400?

> @@ -117,6 +121,9 @@ static int __init chromeos_pstore_init(void)
>  {
>  	bool acpi_dev_found;
>  
> +	if (ecc_size > 0)
> +		chromeos_ramoops_data.ecc_info.ecc_size = ecc_size;

It seems `ecc_size` doesn't have an upper bound.  Wondering what would
be happened if it is a somehow large value.
