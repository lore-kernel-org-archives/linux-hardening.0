Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017301;
	b=BBBvYy+KjpA+phmQea9E+fUo9zHgT5tq6ahyl0D8e+0jPZ6kwvpxTKR27A7lqNvdEH26
	 mI4noYgpdHYYJj6Y+M2FewLn57yrJL+reZC8nQHh+ynceD9TbnQVETBCr9Ng4Q8ReEVna
	 Gws26BeKPktVnSC67Jel1tunZE940td7A64xAYbFP7g2928qe3syLAh/FTyh2r6TSQuZj
	 zH+iAHUlQ+LfVtbw4TMT0y9YcuQb+18Prh8XIMyvdWU5i8FaoZlkRWI/Jw3tkr9e+B6xy
	 GX19R1Zykx4WqAFj8k3r4tuIaOw78uCvcMBoDyC0wZs2+dLJj77RwHCDDeRF9jLp3Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=qYegP4uULHLbb4rYN9EEt/ZV0VWypeovKGqy+rkk7so=;
	b=Lim8dcbtYwTKg3ZqbY2e9zHTQAIx1Jekt/ApvwsdZMniv2wRU0PhHkbDAFr1lcf0SLai
	 xhQw8Dnyeh5XfKnjkOLuza8OlJMkp1YzPpX7UVLwIQN9LHOJz7lgMm1VUtrl/Ng+BhsgD
	 +rjQ2SyxDtMAWjoxa4sDb5h4FjFn1n2VCS/aGIP+sjnb1xuB05PorFOz4wuNScBM2Zs1M
	 Qe0I35h+Gn5GqaDOaaWEbJYEpPc9yAQwmlmN8FYdB9UE1rCyIiG0IvBMExNZT6YS0Zthk
	 hFQfl4paW1m04nXqk0eUoy2wYImmMRequulOavdY/rCXSkmElkkgSovmt/z8cM/Oabw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XXowsTec;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E1606A330
	for <linux-hardening@vger.kernel.org>; Wed, 18 Nov 2026 15:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B90E1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XXowsTec
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b86bbce3d1so1635268a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 18 Nov 2026 07:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795017299; x=1795622099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qYegP4uULHLbb4rYN9EEt/ZV0VWypeovKGqy+rkk7so=;
        b=XXowsTecBEc1yVTP/SGAQPtMfrRnZ1p1ga3D1SZP2gtvhzZZUKZxMlkyBdRkw4YcEP
         NnWS/4tdnNQuSW7Kv9FpHMtgm2C1B+P8BakhwvKBeweq5SI0rlHgCkajgnCvmFOi35nL
         0ybtCKWg9PKlkuLqYj4Lrr5Wj7I+AJQrpXaZFSNJggUQfOQWaQaysysTRNlL9M508/0I
         KrReBVEVq4lpl7+zC9uvFLb8+X1sLILOg9GngO1R5MIQh8xnt59yBvbLQTotFlL8M5Cn
         gbQC1FDxYIZ81/nC+0N+bqfP4MXLJzxI+rkvVDFRYeSWT/zmRY9t9EfqjDSvnASIV95t
         5avA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017299; x=1795622099;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qYegP4uULHLbb4rYN9EEt/ZV0VWypeovKGqy+rkk7so=;
        b=dhj6GeWGJWqfrc75YwvysM4j/ATHXp9QCpwDFcyp3DppWPUXBqL/4TupvdDYTuJwp1
         pUuuWeCxFSJWOrid3kg2xyTx88lVKEkdGMROpvTZIvodKQhGPMC3iF/3lTyufWgKqQko
         HRsY/wM5KkG+CHP3IycdYK6UYr5kWS/QWWrSHkWTUruTuBshoZNVSJiVKkV2sx9d7LTd
         V3qN7pJ3gqwlK1hldNPSjbA7Qzfu+yKlMas2DKtJA02hKdjOXj4VDA8TlgAXcwzC7HHf
         i5YIXw5tpb+3oatDRShF9n+ZJMrYoiVr0UU0pp4XClyZagBj2meqA51xcCIQJ38XcnbF
         NwKw==
X-Forwarded-Encrypted: i=1; AL+hErGcvFpBZnRtEMsf5CKyAWkdIIXoeDeOZ9NhIJZZl6n1xMDA9WeLXUSBVH8nrBS5TkqHkVQ/kwafNV5JLiCE2QM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jRMjao52qg/wvMK2TrBP283voCaFtAYGxv0WZAP5ZdXaVgMJB
	NShgthHeEZtbMIIAY1El9i+/POnODb5zWPtSSu/Hv9kxZ6kTTytWPPCyEbrBhNzO+dQ=
X-Gm-Gg: AYBFou2DurB519OvBsv2V7Ti+3yCA26NFcXp18Tnv6GtIb8GeattA1pyLBAM2EQAQzY
	LwCLh1SJ47lF/vjyPy9T0nvUN1F46WYF/5yowFrU7/JHSt/Ta01Y7wmVheZoazN7Qcp91i8DzZA
	nvSwfXz/llDCJ7oI6ZT1Pj4k6OVbbHAMN+HhtuQL6pwvYVijRVH3vEuGk5Zre7xeUFQ1QKPT5ik
	HQrZvV7jI0vjUrX+pL0HvnjFq3I71Fd9InDv0XEQsqV2fkcFl5BFiOmqScfkDASN6PL20FBRNCP
	jk8FN3X0uXFdqRjul58Dvo0ZHnjzcq2PqedVhQZQEa9Dgbmrjo7FuCxBg4esysm2ch73P9tjFaA
	dM0LDJkgmGyb8PO9h3t9mehq5/bCW3C8JPrOwdErG0hLO6n8W/d6jBe7JnKW41eTC1yYZIbzuBM
	Euk42lYhKlpnWcuk7cJLhCAY0FnzjLOJGoeKtmZfDhbfnbsw8ryp0IglGX9/iAUH9jiYOeCxItv
	l8cThrlH8S2yWR8MpilNtJSBkBRxJ8PZvbwnzXw7tPe5+4sgR9keCMsfhrcHgKm4X3QA+CsTcWW
	oo2SKHJHT17sN/M8tKNYTeem5yUuQWBO
X-Received: by 2002:a17:906:c14e:b0:c50:a7ff:f880 with SMTP id a640c23a62f3a-c510e28dfcamr310805266b.34.1795017299066;
        Wed, 18 Nov 2026 07:54:59 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:9f37:bd39:7f19:3b3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51231bc1a2sm20902066b.5.2026.11.18.07.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:54:58 -0800 (PST)
Date: Wed, 18 Nov 2026 09:54:49 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Francesco Valla <francesco@valla.it>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC v2 07/11] remoteproc: assign fwnode during vdev
 registration
Message-ID: <av3KSXqeGyazaMR9@p14s>
References: <20261102-remoteproc_virtio_map-v2-0-26b300e01c62@valla.it>
 <20261102-remoteproc_virtio_map-v2-7-26b300e01c62@valla.it>
 <avyAtmxdbfEBbZ87@p14s>
 <avzS1DiNGmL1Pqmn@bywater>
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
In-Reply-To: <avzS1DiNGmL1Pqmn@bywater>

On Tue, Nov 17, 2026 at 11:29:01PM +0100, Francesco Valla wrote:
> On Tue, Nov 17, 2026 at 10:28:38AM -0600, Mathieu Poirier wrote:
> > On Mon, Nov 02, 2026 at 12:26:44AM +0100, Francesco Valla wrote:
> > > The virtio subsystem already supports a fwnode describing a vdev; search
> > > for a specific node during vdev registration and supply it to the
> > > rproc-virtio platform device that is being registered.
> > > 
> > > A memory-region specified inside that node is also used for the virtio
> > > device if a carveout was not supplied for it through the parent device's
> > > node.
> > > 
> > > Signed-off-by: Francesco Valla <francesco@valla.it>
> > > ---
> > >  drivers/remoteproc/remoteproc_core.c   | 48 +++++++++++++++++++++++++++++++---
> > >  drivers/remoteproc/remoteproc_virtio.c | 41 +++++++++++++++++++++++++++++
> > >  2 files changed, 85 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > index c946ecd980a5..e833853ae7f6 100644
> > > --- a/drivers/remoteproc/remoteproc_core.c
> > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > @@ -440,6 +440,33 @@ void rproc_remove_rvdev(struct rproc_vdev *rvdev)
> > >  	if (rvdev)
> > >  		list_del(&rvdev->node);
> > >  }
> > > +
> > > +static struct fwnode_handle *rproc_get_vdev_fwnode(struct device *dev, u32 idx)
> > > +{
> > > +	struct fwnode_handle *group, *child;
> > > +	u32 reg;
> > > +	int ret;
> > > +
> > > +	group = device_get_named_child_node(dev, "virtio");
> > > +	if (!fwnode_device_is_available(group)) {
> > > +		fwnode_handle_put(group);
> > > +		return NULL;
> > > +	}
> > > +
> > > +	fwnode_for_each_available_child_node(group, child) {
> > > +		ret = fwnode_property_read_u32(child, "reg", &reg);
> > > +		if (ret)
> > > +			continue;
> > > +
> > > +		if (idx == reg)
> > > +			break;
> > > +	}
> > > +
> > > +	fwnode_handle_put(group);
> > > +
> > > +	return child;
> > > +}
> > > +
> > >  /**
> > >   * rproc_handle_vdev() - handle a vdev fw resource
> > >   * @rproc: the remote processor
> > > @@ -475,7 +502,16 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
> > >  	struct device *dev = &rproc->dev;
> > >  	size_t rsc_size;
> > >  	struct rproc_vdev_data rvdev_data;
> > > +	struct platform_device_info pdev_info = {
> > > +		.parent = dev,
> > > +		.name = "rproc-virtio",
> > > +		.id = PLATFORM_DEVID_AUTO,
> > > +		.data = &rvdev_data,
> > > +		.size_data = sizeof(rvdev_data),
> > > +	};
> > >  	struct platform_device *pdev;
> > > +	struct fwnode_handle *fwnode;
> > > +	int ret = 0;
> > >  
> > >  	/* make sure resource isn't truncated */
> > >  	rsc_size = struct_size(rsc, vring, rsc->num_of_vrings);
> > > @@ -498,20 +534,24 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
> > >  	rvdev_data.rsc_offset = offset;
> > >  	rvdev_data.rsc = rsc;
> > >  
> > > +	fwnode = rproc_get_vdev_fwnode(dev->parent, rvdev_data.index);
> > > +	pdev_info.fwnode = fwnode;
> > > +
> > >  	/*
> > >  	 * When there is more than one remote processor, rproc->nb_vdev number is
> > >  	 * same for each separate instances of "rproc". If rvdev_data.index is used
> > >  	 * as device id, then we get duplication in sysfs, so need to use
> > >  	 * PLATFORM_DEVID_AUTO to auto select device id.
> > >  	 */
> > > -	pdev = platform_device_register_data(dev, "rproc-virtio", PLATFORM_DEVID_AUTO, &rvdev_data,
> > > -					     sizeof(rvdev_data));
> > > +	pdev = platform_device_register_full(&pdev_info);
> > >  	if (IS_ERR(pdev)) {
> > >  		dev_err(dev, "failed to create rproc-virtio device\n");
> > > -		return PTR_ERR(pdev);
> > > +		ret = PTR_ERR(pdev);
> > >  	}
> > >  
> > > -	return 0;
> > > +	fwnode_handle_put(fwnode);
> > > +
> > > +	return ret;
> > >  }
> > >
> > >  /**
> > > diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> > > index 1496659ddff9..950d65480be5 100644
> > > --- a/drivers/remoteproc/remoteproc_virtio.c
> > > +++ b/drivers/remoteproc/remoteproc_virtio.c
> > > @@ -13,10 +13,12 @@
> > >  #include <linux/dma-map-ops.h>
> > >  #include <linux/dma-mapping.h>
> > >  #include <linux/export.h>
> > > +#include <linux/of.h>
> > >  #include <linux/of_reserved_mem.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/remoteproc.h>
> > >  #include <linux/rsc_table.h>
> > > +#include <linux/swiotlb.h>
> > >  #include <linux/virtio.h>
> > >  #include <linux/virtio_config.h>
> > >  #include <linux/virtio_ids.h>
> > > @@ -394,6 +396,23 @@ static void rproc_virtio_dev_release(struct device *dev)
> > >  	put_device(&rvdev->pdev->dev);
> > >  }
> > >  
> > > +/*
> > > + * Attach the memory region declared inside the vdev's own devicetree node.
> > > + *
> > > + * A restricted-dma-pool region is attached by of_dma_configure() when the
> > > + * platform device is probed, but it is released together with the virtio
> > > + * device (see rproc_virtio_dev_release()); attach it again if needed, e.g.
> > > + * when the remote processor is restarted during a crash recovery.
> > > + * Any other kind of region (e.g., shared-dma-pool) is attached only here.
> > > + */
> > > +static int rproc_virtio_init_vdev_mem(struct device *dev)
> > > +{
> > > +	if (is_swiotlb_for_alloc(dev))
> > > +		return 0;
> > > +
> > > +	return of_reserved_mem_device_init_by_idx(dev, dev->of_node, 0);
> > > +}
> > > +
> > >  /**
> > >   * rproc_add_virtio_dev() - register an rproc-induced virtio device
> > >   * @rvdev: the remote vdev
> > > @@ -410,6 +429,7 @@ static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
> > >  	struct device *dev = &rvdev->pdev->dev;
> > >  	struct virtio_device *vdev;
> > >  	struct rproc_mem_entry *mem;
> > > +	bool has_mem_region;
> > >  	int ret;
> > >  
> > >  	if (rproc->ops->kick == NULL) {
> > > @@ -417,11 +437,24 @@ static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > +	has_mem_region = of_property_present(dev->of_node, "memory-region");
> > > +
> > >  	/* Try to find dedicated vdev buffer carveout */
> > >  	mem = rproc_find_carveout_by_name(rproc, "vdev%dbuffer", rvdev->index);
> > >  	if (mem) {
> > >  		phys_addr_t pa;
> > >  
> > > +		if (has_mem_region) {
> > > +			/*
> > > +			 * The carveout takes precedence: drop the region that
> > > +			 * of_dma_configure() might have attached at probe time.
> > 
> > I don't understand this part - why would someone configure vdevXbuffer with the
> > same name at the rproc and rproc-virtio level?  This should be an error.
> >
> 
> The carveout might come from the remote processor's resource table. I
> was unsure on how to treat it (warning or error) - if you advise for
> the second I'll go that route.
> 

Ok, so this is also related to my for patch [5/11], i.e handling of authentic
rproc-virtio device should follow modern practices.   

> > > +			 */
> > > +			dev_warn(dev,
> > > +				 "vdev%dbuffer carveout found, ignoring memory-region\n",
> > > +				 rvdev->index);
> > > +			of_reserved_mem_device_release(dev);
> > 
> > Who would have called of_reserved_mem_device_init_by_XYZ()?  The remoteproc core
> > or virtio core?  
> > 
> The of_dma_configure() call that is part of the platform DMA
> configuration automatically associates to the device the first
> restricted-dma-pool node referenced by memory-region; see [1].
> 
> This is actually beneficial to the proposed solution, but current
> implementation requires this step to avoid leaking the association (this
> will be required also in case of error, because of_dma_configure() is
> called during the probe).
> 

Ok

> > > +		}
> > > +
> > >  		if (mem->of_resm_idx != -1) {
> > >  			struct device_node *np = rproc->dev.parent->of_node;
> > >  
> > > @@ -451,6 +484,14 @@ static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
> > >  				return ret;
> > >  			}
> > >  		}
> > > +	} else if (has_mem_region) {
> > > +		/* Use the memory region declared in the vdev's own node */
> > > +		ret = rproc_virtio_init_vdev_mem(dev);
> > > +		if (ret) {
> > > +			dev_err(dev, "Can't associate vdev memory-region: %d\n",
> > > +				ret);
> > > +			return ret;
> > > +		}
> > 
> > Mixing the initialisation of the legacy rproc-virtio and authentic rproc-virtio
> > devices is very confusing.  I think there is value in splitting them, even if it
> > entails some code duplication.
> > 
> 
> Ok, I'll split them for V3.
> 

Please move forward on that.  Since it will introduce a fair amount of churn, I
will simply stop reviewing the current set and wait for V3.  You can remove the
"RFC" tag, we are well past that now.


> > Thanks,
> > Mathieu
> > 
> > >  	} else {
> > >  		struct device_node *np = rproc->dev.parent->of_node;
> > >  
> > > 
> > > -- 
> > > 2.56.0
> > > 
> >
> 
> Thank you!
> 
> Regards,
> Francesco
> 
> 
> [1] https://elixir.bootlin.com/linux/v7.4-rc1/source/drivers/of/device.c#L35
> 
