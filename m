Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E162F003A
	for <linux-hardening@vger.kernel.org>; Wed, 18 Jun 2025 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750261908; cv=none; b=VmBjBbQbla/t7hloKnX3a0Xb4Yv0Ginzw+260O27postShhKPims98wxRVyqjdOm+FYDmLn7e0xL8P/aKPMWMEf86iKRLGa1lkDaMMKxFk/S38bi468kYdVpCvzbaKPnJ+dW+ShyaW3pFfXtO5YziWMBGrzI+mq30AsdoJqWRyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750261908; c=relaxed/simple;
	bh=23FzxqtG6GgAE/fMAHJQU0Q8RmYqZeTXf4zDRHmSZjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4QhJlI+6/M7V8ENwMqk4fRmDZuAyl/fSQoVWhZ9/egwBsuZiANNtEOxTy0xdFcxv0OABebf+btangHlwqTaF+Kqbdk/A2ACO7q7SEgOnNhYZlUDC9DYf5gPqIosS07jB/97y1tj6WqBw81JRIrg2eVNOHOzth9Xvy3rqd/piSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c55xp1fm; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c55xp1fm"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-739dcdb012fso1813336a34.2
        for <linux-hardening@vger.kernel.org>; Wed, 18 Jun 2025 08:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750261906; x=1750866706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kYPQPWqeQ8cFIac7fW7Mg6b3Vri4HsDMay80nKR0axs=;
        b=c55xp1fmqzOZBOMkoe7L873bU+mSZ8BBkTBQpR/nx/b2HHDr3aSSw5F+Gp2XRsOdzH
         brJvGvmvTSizkgr1uWhWw5btrWfDuApfSSu6igvBho7Q3F9XUew+hNdAaGpd1MI8D3hz
         uM3Xsw6lNE42p/x1P4YH5gZ7gViPjndUKVDKq8OfufLzEKfUs2duMzJwO+LtL6nNAe/8
         zC8VlxsIi/8JLQRz24utqI/+xLScMmZd5ij7Xy8NKx6VvfCNZCEF0IsuC74CMCuTugRi
         CyGsdp8BwwDSatoGPB7nzQS71Uzj3hk6pnUrOHdYBmdJIxk4mUYYYpiPyxcjq2Rm5QCG
         YYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750261906; x=1750866706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYPQPWqeQ8cFIac7fW7Mg6b3Vri4HsDMay80nKR0axs=;
        b=VUXSsmi1RvsVte1sFHkiIncJdlSO4dA9ZkzfPzUrdyrNwFvV701eJDQA3HDm5NLHxL
         Ktq77VvFcFmO1yXmG3A+Xkeftshle2e1yp9JYXkpvwlacQbfF7+AdqRKaU7xego2J5q0
         dv34ThFXr3Gw/oO4AKZYLZkoWVwNDT2E0l81GK4V4zIl2VbRKtFCOfRa4WKLDASzgg61
         CAOCf1T4o1IYnjKjQpHFjVTqIRDO55Lz+FixU9v8eaG94/i0Zi46adv+Bl+LiqLBr1a0
         +ndfiD1woF5C06jYEGA14kadZQD5mQUreZ0h91jzijAzxzmZFLLWH4XJnjSqB+MVR41e
         fwtw==
X-Forwarded-Encrypted: i=1; AJvYcCURjcOX3kJG1UMntWP73FBU9Ty2drHIHUOd7Id7Lkp4h1TQhZThCGyN1/ytVEJgKhiwMDdna4E+HrKTPJKyo/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqZCSzvcwYyTy2b7S8kXvvWY6wq9kp4CI3T3MIMs59d4yBVgKm
	GphmsMTnZ+S9ew5+3qHwvaPxaXVwPe6wcFeZ7ezaENXpcXUBIUhGfXGnzNny4UDvk1U=
X-Gm-Gg: ASbGncvMNksY8P7FKMNt63oFx2tAYCOr1m4MX5ZcvbbkxALU9i6EgX0RBLXkivZ4XJB
	IAyIn1yjPkDF7oPEp9x/kJtUNhSq+cO6xp4Dk7OHSc1N7ySX/rn2barLRvqEXepIQ2BcC1+xAZ4
	xrxrsUj2pL+8q/0RmkH9t6XpYziVVQqHg4kRdDUyrpjfeW4iCr0kBiZ1nxqkGe8qiits2KYXFMx
	/Zm3oTn0jxRvQ7NTqotVv7of63ATIftV11tuUw2y1eAiiUilC7r2YRoCr/4AFOAMXnQ2Y5KTW1P
	+cu/+Cn4lfDsbfZMjaC9eFGCEuEI6WqH4FGfCm9egmrVSP5bDm38IZycM3hN50M/ARtGqA==
X-Google-Smtp-Source: AGHT+IF4tQv5VuEQMCpbEPVkO8mXIAv9i/Gb5HQeEcizVo5ZWGkRY/icNXe2XOorHfOXGX7eq/SdMA==
X-Received: by 2002:a05:6808:2124:b0:408:fbb6:f4cb with SMTP id 5614622812f47-40a7c0fbb45mr11582833b6e.6.1750261905772;
        Wed, 18 Jun 2025 08:51:45 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1b3b:c162:aefa:da1b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a741b882csm2367776b6e.48.2025.06.18.08.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 08:51:44 -0700 (PDT)
Date: Wed, 18 Jun 2025 18:51:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Zaid Alali <zaidal@os.amperecomputing.com>, rafael@kernel.org,
	lenb@kernel.org, james.morse@arm.com, bp@alien8.de, kees@kernel.org,
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
Message-ID: <2859fb82-1579-4d45-a8ee-2e3de184fa0d@suswa.mountain>
References: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
 <20250612231327.84360-6-zaidal@os.amperecomputing.com>
 <3a143d53-8731-4afc-9117-bac49ea96db1@suswa.mountain>
 <aFLbgkhB5Q4ZbAZl@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFLbgkhB5Q4ZbAZl@agluck-desk3>

On Wed, Jun 18, 2025 at 08:30:10AM -0700, Luck, Tony wrote:
> On Wed, Jun 18, 2025 at 06:21:39PM +0300, Dan Carpenter wrote:
> > On Thu, Jun 12, 2025 at 04:13:25PM -0700, Zaid Alali wrote:
> > > +static ssize_t u128_read(struct file *f, char __user *buf, size_t count, loff_t *off)
> > > +{
> > > +	char output[2 * COMPONENT_LEN + 1];
> > > +	u8 *data = f->f_inode->i_private;
> > > +	int i;
> > > +
> > > +	if (*off >= sizeof(output))
> > > +		return 0;
> > 
> > No need for this check.  simple_read_from_buffer() will do the
> > right thing.
> 
> True. But why waste cycles populating the output buffer
> when it will be ignored? The normal flow here is that
> a user will likely try to read a <stdio.h> sized buffer
> and get back 33 bytes. Then read again to find EOF. That
> second read doesn't need to do all the "sprintf()"s.
> 

Ah.  Okay, I didn't realize that.

regards,
dan carpenter

