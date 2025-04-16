Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9C533991;
	Wed, 16 Apr 2025 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824747; cv=none; b=YaytRBBanerMaiqfnC6thbl7seUrrhVeCMZl4zfyVnGgRrhRlgVuWbxo7RmbOFnG125UUY9peXlmqUW7CpPvzFcyu3mhXbkEM9nUXc+jpATfOlf3+LQqrRQWuTED547+oOK6xZp9eidvkOVrLMmleEswSuud1TJ6GvxDGNJ5UIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824747; c=relaxed/simple;
	bh=HK/ACkCSXH9iBavYefiL3UQ3gNZHnIc01A/zo5ZfKmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=li0tPulUuVoajLzweXoG15BzS+1SwUk+Y9uRx9gdHP7ZI6yvT+WHR7qVz6Wq+4JaPrkrxWAEMGtLtUNIIH5vu2OQM73X5Jhq/7DUSSC5GJsldLIRni1gkUw/oSS0+/OMO/eqcIVRFnFWtj7PmvioD0MWrWQIzOZdjyWWo6OSS+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WVUzN54G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WVUzN54G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5+DmEreLd4tGBrT4AUVKbL/9BUAR7PVq/ro9PvBSOX0=; b=WVUzN54GFucJKC3jngxZF9vCFH
	PNcDcPqQ7vHirWGZqnYLr6t2ovXiKtRt+J9rSoOm/uCi0TifPVNos7K0ue9oYrjuQEjgTrCcXlQdB
	8J40V7YNUe7qBnEb7pJ6KSGvtQaqdUnBj+7LhJnfcf+CY3d6W925GtRciteLKgDxl1OI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u56cO-009gHX-JP; Wed, 16 Apr 2025 19:32:12 +0200
Date: Wed, 16 Apr 2025 19:32:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 net-next 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
Message-ID: <d286dec9-a544-409d-bf62-d2b84ef6ecd4@lunn.ch>
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-6-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416162144.670760-6-ivecera@redhat.com>

> +/**
> + * zl3073x_mb_dpll_read - read given DPLL configuration to mailbox
> + * @zldev: pointer to device structure
> + * @index: DPLL index
> + *
> + * Reads configuration of given DPLL into DPLL mailbox.
> + *
> + * Context: Process context. Expects zldev->regmap_lock to be held by caller.
> + * Return: 0 on success, <0 on error
> + */
> +int zl3073x_mb_dpll_read(struct zl3073x_dev *zldev, u8 index)
> +{
> +	int rc;

lockdep_assert_held(zldev->regmap_lock) is stronger than having a
comment. When talking about i2c and spi devices, it costs nothing, and
catches bugs early.

> +/*
> + * Mailbox operations
> + */
> +int zl3073x_mb_dpll_read(struct zl3073x_dev *zldev, u8 index);
> +int zl3073x_mb_dpll_write(struct zl3073x_dev *zldev, u8 index);
> +int zl3073x_mb_output_read(struct zl3073x_dev *zldev, u8 index);
> +int zl3073x_mb_output_write(struct zl3073x_dev *zldev, u8 index);
> +int zl3073x_mb_ref_read(struct zl3073x_dev *zldev, u8 index);
> +int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index);
> +int zl3073x_mb_synth_read(struct zl3073x_dev *zldev, u8 index);
> +int zl3073x_mb_synth_write(struct zl3073x_dev *zldev, u8 index);

I assume these are the only valid ways to access a mailbox?

If so:

> +static inline __maybe_unused int
> +zl3073x_mb_read_ref_mb_mask(struct zl3073x_dev *zldev, u16 *value)
> +{
> +	__be16 temp;
> +	int rc;
> +
> +	lockdep_assert_held(&zldev->mailbox_lock);
> +	rc = regmap_bulk_read(zldev->regmap, ZL_REG_REF_MB_MASK, &temp,
> +			      sizeof(temp));
> +	if (rc)
> +		return rc;
> +
> +	*value = be16_to_cpu(temp);
> +	return rc;
> +}

These helpers can be made local to the core. You can then drop the
lockdep_assert_held() from here, since the only way to access them is
via the API you defined above, and add the checks in those API
functions.

	Andrew
