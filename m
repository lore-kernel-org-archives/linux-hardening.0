Received: from mail-qv2-f20.google.com (mail-qv2-f20.google.com [74.125.230.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA214AE11E
	for <linux-hardening@vger.kernel.org>; Wed, 16 Sep 2026 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584595; cv=none; b=e1j+ilgEtPDHuX58shZ5NwSlVg+nCA10zo2qyOj/G+lcRQ+jdGsT7fZbhZZ5DY+7MoEAVFS21ilIaVwR2ieOJUfRFa1QaR7X/qLvQUUga5Pyqn9yWWz6JIF0l+IyxT0od+7sIoMGPvu8zbHy/KEnPyz38bjMQq2N6V6rIcqvpRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584595; c=relaxed/simple;
	bh=qjO05h8NCgW9DdH4l85dlmT24Ysl3YzDoaGNJA1xrmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRMPb3wd5CqguPF8I3l5y4tnup3fjgnEv7D3Zi3Q9MN7lI8AnyEtYlud7jpuJv3LIjxLuBJuOAeOm6YduP0Cpmz5ATNB/pMUQlxhJiPcXm2dp0C6zfE7KxeaAaZTaHyEkxoWE8S8/rmN4R2yZN29wKrFe6/xg6XOlovOrppyQZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ur49RFow; arc=none smtp.client-ip=74.125.230.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ur49RFow"
Received: by mail-qv2-f20.google.com with SMTP id 6a1803df08f44-90cdfc9b6e4so11317166d6.3
        for <linux-hardening@vger.kernel.org>; Wed, 16 Sep 2026 11:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789584579; x=1790189379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c0iIgJwWQvCfxDYTtHwJ9R8OwiKsFPaAaYmGvWCYHto=;
        b=ur49RFowrugsitDaOgTStbQHm+W6D/02S+/MOvhvMB009kC6tZjAi82Ko/N58VLPxD
         pyXFXamCYOw+3E+3qoL6beXSB2Y+gpDfO5z9awOvcWz7nw9t2V0Xr537zaWfHFk++/Rq
         0GuINYEzdF0e+POW4Y/Do/mCRSlGCD3kXhWFx7qIwwwqIV7ufFvS0J+Er7wZz3IiM4tn
         TJMnvlbZZ94JK4CDfNX+/YXNcrPPNLKYtV8st/9DMgMPbLzXWFPaxS5GLdZSU4TG1PXV
         q8FDrb8A3DsRRBqB+9r2Z6tpBjpAyMpR/lJ3LDNi14KfyPnY2vUxIrxPEgEqezIy/u6a
         SLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789584579; x=1790189379;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c0iIgJwWQvCfxDYTtHwJ9R8OwiKsFPaAaYmGvWCYHto=;
        b=tIQ8ceAPxMtXnVaBvLjKV8OoPB2fU1glAP3cnGGNK30tcZ+sVxZchHOjk9h3IlTcic
         OkZm4VJLPDtbzuMkLBpLqtTLwCCXArSevOtUq/jd1iE1LNs6c1fPQtHKj0m6gdizBJb1
         1ggCdJ0KJMY5sTk4vMES/lXgGsj3Jrfd9V6h1ZToLc2KZpgGrEZAqbgbAHGi5Tgr/5iQ
         lg1vVWRUuGaq4Sxu4MgbOgqpCEzOMCq5TyUUeYE5ybgwPxmcfjLJLaCelZ4gL9eRBYv8
         IGytQiKCD0VnAc74l+JiX2Tt07vriimciyddYjgxTHOODat0yt4jcex3r31uAmujlpcA
         itBg==
X-Forwarded-Encrypted: i=1; AKwUvBz1E0tbyeoNEAHq2uxXoGwqK3EAqMwS/2WfTE13jD7wecOn5WzmswnuHSem9bZyZAydJGJ80SjRvJa1rzOV8Cg=@vger.kernel.org
X-Gm-Message-State: AFuF++nVrw0YrVTp0fl/ZZ2h2LdAhuWCELIh2JK7L+iBAV6e1CY6U3RK
	2AB63hWfltqEdR3/gqsEdHvOX64Lem0eVCLrBy0nGXe+17YZRBfVb6B2uLC3cUNAnmM=
X-Gm-Gg: AYBFou1sJGtbm6b27Bxrr0XdoGJzos4m+UNI9/BOgnXjT08sVhECZXf/tlKToABtKCE
	Ke59qOj8fdtftpxazGiM3jw9WWl9LCIZ0Zl8LcE9llp07mQPaSDT4g/hI2shopahDbHiIfcqDgl
	xj7z5WO6R66erk3vQBZQz5SRVP5K8TyVjH1QCIybIbOpgFih5AJtktQaalMjs2awPIoehNADyt0
	dzn5pP5nUgeS/vFtG1CpuuuzD0ItZGXJZ+DIygK1wEGN6K2FgWFBdianPgS8eAbHRoWJ9doolxw
	76mo9QWMvwJQf0y0pSLr3bcExYqP67foHCWvVy0uk3pWghb8b0mwhbAHE+yN3zR5oAs0oj1jlk5
	Pw6Al0A4C685ObhoPM+2zCLu+8NFk2Xk1KKE20EqqOOW4qQ/F79Jm8p9JA53FuPk6+0wE5ySaAd
	VpPHedGoSwwemDa8irdGiQmxLNoEhg28xb4WpUp91XNc/q8igUeKAq971yJfKR0K11COuQqQFKV
	2ROxSQzxctjgQV4Vfw7wIQtUMHQEfwN9ZBqVwU3kAPAHAb0djaHess=
X-Received: by 2002:a05:620a:17a3:b0:939:8905:ce9b with SMTP id af79cd13be357-93bb77461a9mr631916885a.17.1789584579016;
        Wed, 16 Sep 2026 11:49:39 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b81d147ffsm281088485a.43.2026.09.16.11.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 11:49:38 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:49:36 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: mhonap@nvidia.com, alex@shazbot.org, jgg@ziepe.ca, ankita@nvidia.com, 
	dave.jiang@intel.com, alejandro.lucero-palau@amd.com, smadhavan@nvidia.com, 
	corbet@lwn.net, skhan@linuxfoundation.org, dave@stgolabs.net, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, iweiny@kernel.org, 
	ming.li@zohomail.com, yishaih@nvidia.com, skolothumtho@nvidia.com, 
	kevin.tian@intel.com, bhelgaas@google.com, dmatlack@google.com, kees@kernel.org, 
	gustavoars@kernel.org, cjia@nvidia.com, kjaju@nvidia.com, vsethi@nvidia.com, 
	zhiw@nvidia.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 07/27] vfio/pci: Detect CXL devices and load vfio-cxl
 on demand
Message-ID: <aqrg9AJBh0GUsP0l@gourry-fedora-PF4VCD3F>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
 <20260813093631.2288172-8-mhonap@nvidia.com>
 <20260916191659.1d3cb36b@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916191659.1d3cb36b@jic23-hlaptop>

On Wed, Sep 16, 2026 at 07:16:59PM +0100, Jonathan Cameron wrote:
> > +/*
> > + * A CXL Type-2 device advertises both CXL.cache and CXL.mem in its CXL DVSEC.
> > + * pcie_is_cxl() is also true for Type-1 (cache only) and Type-3 (mem only)
> > + * devices, which the vfio-cxl provider does not handle, so confirm the Type-2
> > + * identity before engaging it.
> 
> We don't expect to handle type 3 class code compliant devices, but what about
> the things referred to sometimes as CXL Type 3+?

Dan has previously (and I think would continue) to just call that
an accelerator - because it is.

I think the Type 1/2/3 nomenclature is stale and needs to go away,
it's outlived its usefulness.

To your point below, a compressed ram device is really an accelerator
with CXL.io and CXL.mem.  All the spec says (used to say?) about
"Type 2" is that it *may* support CXL.cache - it doesn't require it.

> It is also plausible we'd pass a full compressed RAM device through to the
> guest without paravirtualizing like we currently plan to do for class
> code Type 3 devices (for DCD, sharing etc). +CC Gregory to point out where
> I am wrong on this ;)
> 

Plausible, possible, feasible - yes.

Sane?  More sane than using it as a normal memory device on the host
assuming RAS signals from the device can't overwhelm the host (unknown).

> More generally, why are we controlling usecases?  A class code compliant type 3
> device 'could' be passed through I think if someone wanted to do that.
> I'd not encourage it but why is it a linux policy to not support it?
> 

The only scenario I can think of that you'd want to pass a simple
expander all the way through to the guest would be RAS signals - which
I think still require host plumbing anyway to avoid passing said signals
to the wrong guest depending on how you've chopped up the region.

Basically if you need DPA/HPA data from the device to be interpreted by
the kernel, the guest needs a translation mechanism.

In practice I can see passing a virtualized, locked auto-decoder through
to the guest with the same HPA/DPA values as the real device so the
signals can be delivered quickly with limited host interposition.

You would probably need on-device vitualization support to do "proper"
passthrough so the device can route signals to the guest directly.

Anyway, you could pass it through, sure, why not.

We shouldn't limit it, if only because we're not clairvoyant about
what will be useful tomorrow.

~Gregory
