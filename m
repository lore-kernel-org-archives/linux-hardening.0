Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1714C2472BB
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684630; cv=none; b=swSvDekmfRo3cxKEB6hV3pROksoJdQwOvh/ydlX3J1MkbXOCBqRMsY6KR26vKx52ckIdiFZQhWfEA2rcdo6cZIppX86b4ds84Z8UQjr7mHFBLZxVXf061/rsHz56/Uep8SQ2h/qh5Qw3HY7c8XmSlQYQi5JA74XvzYiiEdPZU3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684630; c=relaxed/simple;
	bh=rSFCVYBQGHYIVw4AaRKYw6Ay38HyAtjHDSJOWPLks+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrqNAMWxzlgNpJFITNNSXhXD1j7GymbosHAo7qSZCbqkSm+xgjK6MlK85lvsWF0IbcYQzVYTPHF0sq4kEYdffrH4fl4xXviigmntkfZKFSTQ9O/SoCTEGYwyPsA907qoAKkf7iLK9znN1+XWdn1KvBxHp4wiQK81m2dRJlkY7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=X0nsss1q; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="X0nsss1q"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8804650ca32so13105566d6.0
        for <linux-hardening@vger.kernel.org>; Thu, 20 Nov 2025 16:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763684626; x=1764289426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HeoQ6A9zQA47pPVQ4WN0R1Mr0WB5BGBDvzJz+/SIjn4=;
        b=X0nsss1q1dQAqvVQCjfcM7UUewWlBvLurLKTQOkoLVBJ11Zbv8ClxmGVsU1Bo6EF5b
         qB1Gi2Yhtkul9cgel4Ab+PKL3kmhaxR19s/esS9Nary6n06TyegRG022N0a1RmQ8sFQJ
         Ar/lOjV0WQuho9a2OOlwX2VRTf+i183+ahDzvYQdBGOKzztulAsjTqiXgnQP438u63kz
         84HsJu/Oi7pdM7HSBpBL0ajrrzV4LFaclFsAjGqTlANxGvWpGEGC8h7B/dZ7yx5ZuK5v
         9BQIRbH7CWDiUe1Y5XDQZyyKT8tkkQWxTuthpFeNHPLVryv7gw6vE+thgY7MLcr+xgTz
         DZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684626; x=1764289426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeoQ6A9zQA47pPVQ4WN0R1Mr0WB5BGBDvzJz+/SIjn4=;
        b=mmdG1Lmze2Fa+e2AjJLCbUdZLdXdvPkHTy49JtvNWF8Z1S7DCVC4F+lZDTRX+9IuVK
         DIPjA48dQ9+jtS4y5FV91cWsKFtX+P89KWsN5oRyHb/d6+VBWBc3n/51Q1fw/SJo5y29
         xM2ucZ2PqfhRuMAEJy/4gdYPHova3jvLa8nEgCQzK1QXa49DJBXc8k1dqa5dJOegj7kQ
         sIz7cJAA/O0m209EQ772P5rKBH4pVA5QdO9YjwNACmvxjPcQIL3eTtmNJOEM7pUUfqeL
         Z1CcwoQGyIAyqmk9KZ2j6v6Tz0rlPYbar00Bb7g6vJFSDlvep97r5Ao5qxPKIPshS79f
         lZTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVN4D5yoGrpsppHntX2LJlzYQ2dDhg4v1Wty7jglhmGRPy2IjJgtZUs3iA20CGe8pSjDBzPa76a6xj4KdlcSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL3I7KV0r7aHQuzAddB4vbr27y8lxmHcwcamih5lly0z3mYQiG
	1pOVbV9NJ0Nke6qOKlbKUVUP7BjeTVBFbHq2OSR7A/vW63FgMy7rArhSKQU182cyw0E=
X-Gm-Gg: ASbGnctHTE00PW/mO21wMB1TonBqJwquGZvAAKaVDwWHykMi1NKESmzlRFjXTCrS5+5
	GiekTgaMsOGUu9cO97Jkc/iInUDOenBwDT/htCS+PoaXQk+5kLP9pUbQ2Q07B0TG+bic1KmFTr4
	hhbh+1UnCdogeXrccp5CrG1R6dxFW3Vb2rlhAkKTzUuyhz0LN+Djuts/AoALERETFn6nCg9A5cV
	eaH9r8ypeQzRJsqC8ID6arJyp2rJYqvIn2Egoq+O4cuX058Sa6UfPYGJ6vLSOzsV35qSjxXhcTI
	5/l41ODJFYKOwY4lhg93RXxZcWAhUjXDwHCOBYPF498oirbJvSiidI2OlxpoR2LqxS6drdRZzGq
	ezw2nmL8B8oYa7E5Bf17QqMCZ5GyIZR23dY01KOIG0ybezc5FlFE99IT415yTxqBexoegE1IYFc
	O9sR3WuVJithiQvtlNqG3zbCVV8W1rrYo79yioiBbN84YQe0rERuECnw8P
X-Google-Smtp-Source: AGHT+IF9fpUZC0KSEi60qYSTXqU5TN/0kv3Br6v+7st2smYcT5XQOEwOWy/F2amvDq4QuChbOli5Vg==
X-Received: by 2002:ad4:5d42:0:b0:880:2c08:88e with SMTP id 6a1803df08f44-8847c5206f8mr8425876d6.45.1763684625945;
        Thu, 20 Nov 2025 16:23:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e472ae1sm27645766d6.22.2025.11.20.16.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:23:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vMEwC-000000016i7-2ZE0;
	Thu, 20 Nov 2025 20:23:44 -0400
Date: Thu, 20 Nov 2025 20:23:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH v9 10/11] vfio/pci: Add dma-buf export support for MMIO
 regions
Message-ID: <20251121002344.GC233636@ziepe.ca>
References: <20251120-dmabuf-vfio-v9-0-d7f71607f371@nvidia.com>
 <20251120-dmabuf-vfio-v9-10-d7f71607f371@nvidia.com>
 <20251120170413.050ccbb5.alex@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120170413.050ccbb5.alex@shazbot.org>

On Thu, Nov 20, 2025 at 05:04:13PM -0700, Alex Williamson wrote:

> @@ -2501,7 +2501,7 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
>  err_undo:
>         list_for_each_entry_from_reverse(vdev, &dev_set->device_list,
>                                          vdev.dev_set_list) {
> -               if (__vfio_pci_memory_enabled(vdev))
> +               if (vdev->vdev.open_count && __vfio_pci_memory_enabled(vdev))
>                         vfio_pci_dma_buf_move(vdev, false);
>                 up_write(&vdev->memory_lock);
>         }
> 
> Any other suggestions?  This should be the only reset path with this
> nuance of affecting non-opened devices.  Thanks,

Seems reasonable, but should it be in __vfio_pci_memory_enabled() just
to be robust?

Jason
