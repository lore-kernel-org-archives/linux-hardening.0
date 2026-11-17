Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932923;
	b=bwvp9nCxbnrSjkZ+keXbSdPCMt6wkl1b14X//dZcbUcZQYnfwYSFKRuNRa+/TmcrLNBt
	 GbwKm8sHVa8penC4K39xMyHIwWSB1JHwGC5oNp1dtMR9l+ZcrESQpev6ErcftC+8Jly4S
	 3uR0K4Mjoe0eLaz9GN3jTfNXNFj60jZOzEfX88yeXJdfiU62xwjRyNbqKaI1UYqoE55uc
	 Ju74B5OdOsumc30aNc76t22QakSP/rOHVQA8QPBCgNo6S9Je/Ss0MIQ5V/afG+jVmw89K
	 f8ONn9yfS9k1SQ05up1zhzaVT3WbntvJsRxq9D4wm6vaylKKzl72WzqRV04cJqhA1CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=z9knRtCcMgIWWsx+jn+Ep/GYomBKonoGDT8JCXsB+Dc=;
	b=OPvV4d6JmWh/NX6Ok0eUtE0z0WFMLDN/yWmEXQBycI0irhAIqPsYwO3D0TZnHUat18HU
	 KVUTUbIMyIsbGPnCReTpVL0kLFP8acGkiBUQFd9vbo0yurL0bRiHQmLu1XfH/E1aIC1gB
	 UuZhz8V9FUwANouxtR/b3zdA4JyIkkM88Rjca8UCIhKQdHUYHozsm4qtnTaRUCiQucfIL
	 GuutsSkq8/HI/v1XzvOTiKmLAgOgWYUDp/G70dinM3OArhlU0TaoF3W0UGSq+JdJqKUu9
	 hToJ2xbYVO0xW5TFnBMeg139L73ekw9bv52BdCy5ZuzWhQ8GDeEq0T3bFBBUVtkHlKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gYkOXE36;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A64606A32C
	for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 16:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5A64606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gYkOXE36
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cddac941ed1so13071a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 08:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794932922; x=1795537722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z9knRtCcMgIWWsx+jn+Ep/GYomBKonoGDT8JCXsB+Dc=;
        b=gYkOXE36LvPXoQfL6aSBJHmNbbme+s9cnk9acjuy56Vmj3PoJvFZb/K63ZS/539zUL
         bYhAI8uvQKlMiiOMytgcSOF+1zOLMqcfCFnXfJt+aSPPfd/r7xj+DoKoE2MbXqVPtEKp
         38p92sJIeYys8Alu8V1nOqPLNUzrhrz5szblsSwNzd7FPJLb5tyR9Xx7C+XYZegIpdPp
         j0c5BTv//RIvjz2XOgjvip+T4NI93mfkTee/6T8Q80TxYvdnXOiDS+4QTmixV0fFubuB
         vq1M8vt74x0WX3IPF5TVRKnJoKNtjA9db134IkMe5J0IjuRH2IpMxrj/CHXLh8oz/rJZ
         gXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794932922; x=1795537722;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z9knRtCcMgIWWsx+jn+Ep/GYomBKonoGDT8JCXsB+Dc=;
        b=dhqBavWnSWH2pV/FIuY6I6hS6uV/GqDkH04ahHjvuaxaUGuIRuGQhqJ3ALRpItUAs9
         x9fM6G9Z/YR2yxZnWW3BbZsHiSJt/o9PD4oROdCzVrNLadarAbA/mwqQ6oeGyRaUG74R
         Nxc64kfMjHCBP5qYOA22pTMFGJzzckg5gAHgmaPNFceqC9Zf7fILCKEgjfwlrhBD9doJ
         KUFDkyjAzHKLut5vKVRoj9OG1nVF/M3tBIvpX68L42yb1J1WbwreLey3T3s4cy09ZYOF
         jk1aMDg1yMjCkJ9NhGdiXpywrJspKC8+5kssDaxOI+t6hrVy2rdrjnjZRwVvatdnu0Je
         GZdg==
X-Forwarded-Encrypted: i=1; AL+hErH+qNir934d7QL0AvBAM/vYmeFRM39nd/qj00C1exw9t1C512UAAnTexg1r17Hkfoo8vvjNy3HmfqGaEyJ60fE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gTQxocq/9G5CPBr7sshAMbK7USfP3qpZ+WDtdGhPwQG5WGpkF
	Gr0gpUdorplJgwCedGCX79MvAtBNAOTuU3A6yG03TcjAJ276Ni+YabEafKYiLhI30YY=
X-Gm-Gg: AZFdTZcIKf6yzDO08hsPqG3+JXetfVZhxvpUrEn2Gru1pUUUZmBsAkK6WWnA3H5Sh/9
	gCfCNJkoIwJwxGhYnuGnmz7FYBVUicnqVeJlQFKAhrDiCHEtlz43HIuTgfS5tkjBP8d7Mksb47f
	lYB2GIf4cwyWID3WHZLfRzvlX2a3E3JrUwzSPDhA9ofSXwtGKbH+/EUiCvU9NZnvHZcgU4bqWXH
	BmolMTRx+mcbdV1UiuAD3aB+LvUVde8T0pUOMNOHk/3Qhn4apMvnVcJ1wz3XMQfZuFhtbsfawqZ
	XNre2KqwIi3E5yfBW/qwnIA23bYCCg3G+5XmL9ywBfnCFeg4GJ4S72lGoc/9TphpvxEEClL6geN
	0flZY2HQHkRLDFrAAqejxhFMVmsNZf0tjqA1WUCxVPjtnSVITHHE2ANgVRHcScpYl6EPzX8lHEZ
	VbPOdcHZbcnpMEY5d3350jTKN/Ue4dPtJ2YNB/8WLfvRWpuZvukJKJLmK3Wvu5NIgiEMBigkcB3
	0OoZFxEL6+3iVSAdXCoeZAv1QRax6/FbjNzRBfiUEiZL2cMP41tM90PQyp0rUNqxarw2vwbR7K4
	klvExLlzWvQfJf1UtDedAVKErxSWwwaC
X-Received: by 2002:a17:90b:6c7:b0:3b0:9183:23ef with SMTP id 98e67ed59e1d1-3b1b07e41b9mr15684802a91.3.1794932922021;
        Tue, 17 Nov 2026 08:28:42 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:61f7:13ac:b599:b52c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3abe8b263sm5082310a91.13.2026.11.17.08.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 08:28:41 -0800 (PST)
Date: Tue, 17 Nov 2026 10:28:38 -0600
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
Message-ID: <avyAtmxdbfEBbZ87@p14s>
References: <20261102-remoteproc_virtio_map-v2-0-26b300e01c62@valla.it>
 <20261102-remoteproc_virtio_map-v2-7-26b300e01c62@valla.it>
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
In-Reply-To: <20261102-remoteproc_virtio_map-v2-7-26b300e01c62@valla.it>

On Mon, Nov 02, 2026 at 12:26:44AM +0100, Francesco Valla wrote:
> The virtio subsystem already supports a fwnode describing a vdev; search
> for a specific node during vdev registration and supply it to the
> rproc-virtio platform device that is being registered.
> 
> A memory-region specified inside that node is also used for the virtio
> device if a carveout was not supplied for it through the parent device's
> node.
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
>  drivers/remoteproc/remoteproc_core.c   | 48 +++++++++++++++++++++++++++++++---
>  drivers/remoteproc/remoteproc_virtio.c | 41 +++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index c946ecd980a5..e833853ae7f6 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -440,6 +440,33 @@ void rproc_remove_rvdev(struct rproc_vdev *rvdev)
>  	if (rvdev)
>  		list_del(&rvdev->node);
>  }
> +
> +static struct fwnode_handle *rproc_get_vdev_fwnode(struct device *dev, u32 idx)
> +{
> +	struct fwnode_handle *group, *child;
> +	u32 reg;
> +	int ret;
> +
> +	group = device_get_named_child_node(dev, "virtio");
> +	if (!fwnode_device_is_available(group)) {
> +		fwnode_handle_put(group);
> +		return NULL;
> +	}
> +
> +	fwnode_for_each_available_child_node(group, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			continue;
> +
> +		if (idx == reg)
> +			break;
> +	}
> +
> +	fwnode_handle_put(group);
> +
> +	return child;
> +}
> +
>  /**
>   * rproc_handle_vdev() - handle a vdev fw resource
>   * @rproc: the remote processor
> @@ -475,7 +502,16 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
>  	struct device *dev = &rproc->dev;
>  	size_t rsc_size;
>  	struct rproc_vdev_data rvdev_data;
> +	struct platform_device_info pdev_info = {
> +		.parent = dev,
> +		.name = "rproc-virtio",
> +		.id = PLATFORM_DEVID_AUTO,
> +		.data = &rvdev_data,
> +		.size_data = sizeof(rvdev_data),
> +	};
>  	struct platform_device *pdev;
> +	struct fwnode_handle *fwnode;
> +	int ret = 0;
>  
>  	/* make sure resource isn't truncated */
>  	rsc_size = struct_size(rsc, vring, rsc->num_of_vrings);
> @@ -498,20 +534,24 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
>  	rvdev_data.rsc_offset = offset;
>  	rvdev_data.rsc = rsc;
>  
> +	fwnode = rproc_get_vdev_fwnode(dev->parent, rvdev_data.index);
> +	pdev_info.fwnode = fwnode;
> +
>  	/*
>  	 * When there is more than one remote processor, rproc->nb_vdev number is
>  	 * same for each separate instances of "rproc". If rvdev_data.index is used
>  	 * as device id, then we get duplication in sysfs, so need to use
>  	 * PLATFORM_DEVID_AUTO to auto select device id.
>  	 */
> -	pdev = platform_device_register_data(dev, "rproc-virtio", PLATFORM_DEVID_AUTO, &rvdev_data,
> -					     sizeof(rvdev_data));
> +	pdev = platform_device_register_full(&pdev_info);
>  	if (IS_ERR(pdev)) {
>  		dev_err(dev, "failed to create rproc-virtio device\n");
> -		return PTR_ERR(pdev);
> +		ret = PTR_ERR(pdev);
>  	}
>  
> -	return 0;
> +	fwnode_handle_put(fwnode);
> +
> +	return ret;
>  }
>
>  /**
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index 1496659ddff9..950d65480be5 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -13,10 +13,12 @@
>  #include <linux/dma-map-ops.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/export.h>
> +#include <linux/of.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/remoteproc.h>
>  #include <linux/rsc_table.h>
> +#include <linux/swiotlb.h>
>  #include <linux/virtio.h>
>  #include <linux/virtio_config.h>
>  #include <linux/virtio_ids.h>
> @@ -394,6 +396,23 @@ static void rproc_virtio_dev_release(struct device *dev)
>  	put_device(&rvdev->pdev->dev);
>  }
>  
> +/*
> + * Attach the memory region declared inside the vdev's own devicetree node.
> + *
> + * A restricted-dma-pool region is attached by of_dma_configure() when the
> + * platform device is probed, but it is released together with the virtio
> + * device (see rproc_virtio_dev_release()); attach it again if needed, e.g.
> + * when the remote processor is restarted during a crash recovery.
> + * Any other kind of region (e.g., shared-dma-pool) is attached only here.
> + */
> +static int rproc_virtio_init_vdev_mem(struct device *dev)
> +{
> +	if (is_swiotlb_for_alloc(dev))
> +		return 0;
> +
> +	return of_reserved_mem_device_init_by_idx(dev, dev->of_node, 0);
> +}
> +
>  /**
>   * rproc_add_virtio_dev() - register an rproc-induced virtio device
>   * @rvdev: the remote vdev
> @@ -410,6 +429,7 @@ static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>  	struct device *dev = &rvdev->pdev->dev;
>  	struct virtio_device *vdev;
>  	struct rproc_mem_entry *mem;
> +	bool has_mem_region;
>  	int ret;
>  
>  	if (rproc->ops->kick == NULL) {
> @@ -417,11 +437,24 @@ static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>  		return -EINVAL;
>  	}
>  
> +	has_mem_region = of_property_present(dev->of_node, "memory-region");
> +
>  	/* Try to find dedicated vdev buffer carveout */
>  	mem = rproc_find_carveout_by_name(rproc, "vdev%dbuffer", rvdev->index);
>  	if (mem) {
>  		phys_addr_t pa;
>  
> +		if (has_mem_region) {
> +			/*
> +			 * The carveout takes precedence: drop the region that
> +			 * of_dma_configure() might have attached at probe time.

I don't understand this part - why would someone configure vdevXbuffer with the
same name at the rproc and rproc-virtio level?  This should be an error.

> +			 */
> +			dev_warn(dev,
> +				 "vdev%dbuffer carveout found, ignoring memory-region\n",
> +				 rvdev->index);
> +			of_reserved_mem_device_release(dev);

Who would have called of_reserved_mem_device_init_by_XYZ()?  The remoteproc core
or virtio core?  

> +		}
> +
>  		if (mem->of_resm_idx != -1) {
>  			struct device_node *np = rproc->dev.parent->of_node;
>  
> @@ -451,6 +484,14 @@ static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>  				return ret;
>  			}
>  		}
> +	} else if (has_mem_region) {
> +		/* Use the memory region declared in the vdev's own node */
> +		ret = rproc_virtio_init_vdev_mem(dev);
> +		if (ret) {
> +			dev_err(dev, "Can't associate vdev memory-region: %d\n",
> +				ret);
> +			return ret;
> +		}

Mixing the initialisation of the legacy rproc-virtio and authentic rproc-virtio
devices is very confusing.  I think there is value in splitting them, even if it
entails some code duplication.

Thanks,
Mathieu

>  	} else {
>  		struct device_node *np = rproc->dev.parent->of_node;
>  
> 
> -- 
> 2.56.0
> 
