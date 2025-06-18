Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A002EFDAE
	for <linux-hardening@vger.kernel.org>; Wed, 18 Jun 2025 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260105; cv=none; b=ouVHuvW8/VmzazDZhUw6rtELehpDuFqLKoUx1QAPGQpSQTkzq7+z6WtjX+JEKsLPlzfzEhYTi525jRyMiyqFqoPzBXNIoZomZO354U4v3eocjxKfthNlOkkU7SAqzNF4O1gIEthoi04bVtYNSr7+EBuG6J8EElgAceuEHYP9pH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260105; c=relaxed/simple;
	bh=g07THXNWgAdEHWIqoiEHlcfwthoxZVyVXkEAgRexV0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ii0O0fxNsK4jM/lEdAT6u9sdfKi61jO3xtjqbOY8YR5MO6EFYBt+MhV/B7zf2sISdXAy7jkfhxow/X+y/woL/MffGppmoW7O+Bk18aZEln9Kf/8yPegIJyoDHfiYnqeKtgz1LqUrh+BV275iHsf6frReVHRtTTap5BdHO+iQfl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r3rKuG+x; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r3rKuG+x"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4091180d3e5so3378205b6e.0
        for <linux-hardening@vger.kernel.org>; Wed, 18 Jun 2025 08:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750260102; x=1750864902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9AxwiK4VYo3D71UIHkicDqC7/83I7Lbnvvk8W3WY5b4=;
        b=r3rKuG+xt/6fjUipvT17u93EVUlVMjQfpT7D05ucLAMebOFy9CQU5VMPaRb0oi7TqG
         ObTwduvkwcmOdPoXYIZ7v00uhzdYrqBkS7gPWCG7HUEgSePqKFIyPD6bfYossU3Uiy8h
         Ym/CawwMPi5XR2Fes6RHUXQGdzg7znAYpWbsEvvxibHpwhVgmD6+irjzgWqp45gVRzko
         +ATEuaEd231fsiA5Taog/NIImPA9KgXcl0O7UhCVqPTjjW1IvyGS88dp8pd4S2gQBMLK
         Pnl7CbNM3RSZ2EHZsVoSM8/wbuWl+tmm414+raqdpIV3s4CsLhJzvlrNRfzSLyNj6bJa
         DUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750260102; x=1750864902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AxwiK4VYo3D71UIHkicDqC7/83I7Lbnvvk8W3WY5b4=;
        b=tll1xHHgDnwBaaTtgEsMePxAKQKQheLCDRjMC6PS5pFTofE72LhiKOzrmbKJg8dmqM
         oVKrSFoIn+N7JD/uoS3Ju0Prw5MTW4SDfjtpM0gWI2kb0TozYDMafIoHHBBsybQT4H4e
         u1Si0191H1f+/emCC8bav1TIpwwqjwM+4MaG303mVEbL6LPlvNiZnmOnyYBAty8Gilv/
         jdHLAkcG2NTHQSxj2ZTrXW8qmQumoFrd9xyAZc8AAmBW/UCIAK6OaZsWEdPnyhV1G3wH
         EoYuvZXhnYDhl1Ws0apv5nbly+ZyxfO8uDPmnFrhlzdu7DeRoePdZMf2FFAWe1MAbvd7
         xarg==
X-Forwarded-Encrypted: i=1; AJvYcCVJATtPlxPTcWtKxwICqWYqISH4tW80wUkzaHQF1vw0YNmOkIkCuDUv//9J9Pz32Oq+Tq99NgBSPwo8cdVQxs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4UguJqQI3XNZgLkMsLEpRVY0SjfOoQJnSRfCXJx4CLRWLQhk3
	+0tBfwpHN9LL3WQmxkMPn8UtADhcaw60IHtFeLaU5Hf3fn3ExvIZnWpL0S711cHlSs8=
X-Gm-Gg: ASbGncuFzzGN+Prq+QByqKWZ1KmBc5SzYXn6i9XP+qHE7xX2vylJ/aJoSO7+sA6+yTl
	RJoMGBlV28nTPoh70MJpsLVZJnoAdEcP00o1OJJwnoKW2FgTtlpSvlHUBSJ4sz9mj089YU1Ck/0
	L3AT5eH7m4nV0hlAnl0vQzk3JWWDEJbEh4gzvr16GuhNe0b3UzU9wUgoz/SQG8MKvf/bsizvr/A
	JnTI3j1bdU3PwrzuaumqvZYT6Ry8ToNEs889/cbLj3HWX6E6y1dGP8Rx0f+fgCg5bRsheF79Oam
	ZOtr62+dsXxEPlGdc3cvc93kllydlYTzRGrYekwJrx/n95oE+aMXl8ZJiGWATw6EqQx1+A==
X-Google-Smtp-Source: AGHT+IGrf/owYOZYoHFe51D4S6Sh3ECbMUim7WjOpYzkcX3/wGxlPvEhosTHB9TtV8xPJwEvEZoZLA==
X-Received: by 2002:a05:6808:238a:b0:3f6:a1f8:ce3 with SMTP id 5614622812f47-40a7c1160b3mr10691931b6e.14.1750260102438;
        Wed, 18 Jun 2025 08:21:42 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1b3b:c162:aefa:da1b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a741b8588sm2371576b6e.49.2025.06.18.08.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 08:21:40 -0700 (PDT)
Date: Wed, 18 Jun 2025 18:21:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de, kees@kernel.org,
	gustavoars@kernel.org, Jonathan.Cameron@huawei.com,
	sudeep.holla@arm.com, jonathanh@nvidia.com,
	u.kleine-koenig@baylibre.com, viro@zeniv.linux.org.uk,
	ira.weiny@intel.com, alison.schofield@intel.com,
	dan.j.williams@intel.com, gregkh@linuxfoundation.org,
	peterz@infradead.org, dave.jiang@intel.com,
	Benjamin.Cheatham@amd.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v9 5/7] ACPI: APEI: EINJ: Create debugfs files to enter
 device id and syndrome
Message-ID: <3a143d53-8731-4afc-9117-bac49ea96db1@suswa.mountain>
References: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
 <20250612231327.84360-6-zaidal@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612231327.84360-6-zaidal@os.amperecomputing.com>

On Thu, Jun 12, 2025 at 04:13:25PM -0700, Zaid Alali wrote:
> +static ssize_t u128_read(struct file *f, char __user *buf, size_t count, loff_t *off)
> +{
> +	char output[2 * COMPONENT_LEN + 1];
> +	u8 *data = f->f_inode->i_private;
> +	int i;
> +
> +	if (*off >= sizeof(output))
> +		return 0;

No need for this check.  simple_read_from_buffer() will do the
right thing.

regards,
dan carpenter

> +
> +	for (i = 0; i < COMPONENT_LEN; i++)
> +		sprintf(output + 2 * i, "%.02x", data[COMPONENT_LEN - i - 1]);
> +	output[2 * COMPONENT_LEN] = '\n';
> +
> +	return simple_read_from_buffer(buf, count, off, output, sizeof(output));
> +}

