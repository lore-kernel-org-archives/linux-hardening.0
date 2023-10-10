Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E531594
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5VghDhb"
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B7A99
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 15:35:30 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-79f909071c3so257924439f.0
        for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 15:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696977329; x=1697582129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LbnEdKq2z/F673J0PyLo1dcLzZBfT0ZL+5O9D0Q9H3k=;
        b=b5VghDhb2Ysz4Ub07PijViWG/KRXCZFORn0pshqvZqNxUZKfNK6QAx8789LgeNPJMZ
         OAON8/chzN7eWxghmbPNC6uyoD4C5YYX3wzgtqBzqUXkfqvdBg7GPHi+fljDRkWMx5w/
         x4S32AT4ySLuYKHGy0d7/fC5g/iWCsIO0N5CYYfcNUU2MbIYBik7m+cJIl8uh8T9SWe9
         CfQJIjTOIYII4mVu7db8q0goVVb+S9wlC1LfUEk5q7b7T+lbYXo96MfQcM/jmx8sC2+q
         CQagDUc7k05icWWrGt6wDWsneYg1O6MyGGAOiuS1aUmWtjSt8RqsdzNVFP/6NrBMdCte
         IJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696977329; x=1697582129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbnEdKq2z/F673J0PyLo1dcLzZBfT0ZL+5O9D0Q9H3k=;
        b=Bv87XHYBOpDu6ifdNRWUhu/auYsNg1UX7Iot4jHdvL1zvO87Wx9Ozf439xMc8Fn8ho
         5JUAuu9ZCw+jomGqz7bOJeXT3O+Lq3SDAnMMA12pelevb+vVShNjYpbdpuf8qwfEH/EA
         BfPiTlw/CjOU7x5LTSJMZBeg0mcMJuQNNlpmcsb7dvPZ1S4TL0aNSqMjjLV9+DH8FYGU
         NlrCULG6sROjUutMpIPAkJbOz1befUSXzZswnZ++7jqTr/pw1PLylinqSL/G3/9PCj3m
         VGGcU4OgUYb5ZLz2LxkdjKIY9YLE4wy+Yvn3noqYUW75u9w9pMLhUhdb9IMR/8OIAEaB
         YXCg==
X-Gm-Message-State: AOJu0YyvVcH/VhEP9AkoMhzhp1JWyhQkRTThii/n0jnJ8CeJtbaH6ndZ
	iX2zOjB/ybD06fg0+pXw7dsxYQ==
X-Google-Smtp-Source: AGHT+IE79Ek/gb463rp8bLbwMC/z4YopcNOtHcxvez3Rikw2zfNOxy/a5n3J8for9IZJ2q5BpTQahQ==
X-Received: by 2002:a6b:6f09:0:b0:790:a073:f122 with SMTP id k9-20020a6b6f09000000b00790a073f122mr19043765ioc.2.1696977329595;
        Tue, 10 Oct 2023 15:35:29 -0700 (PDT)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id q21-20020a02a315000000b0042b2df337ccsm2907113jai.76.2023.10.10.15.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:35:28 -0700 (PDT)
Date: Tue, 10 Oct 2023 22:35:26 +0000
From: Justin Stitt <justinstitt@google.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] e100: replace deprecated strncpy with strscpy
Message-ID: <20231010223526.2qc4q64txfoi64lq@google.com>
References: <20231009-strncpy-drivers-net-ethernet-intel-e100-c-v1-1-ca0ff96868a3@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-strncpy-drivers-net-ethernet-intel-e100-c-v1-1-ca0ff96868a3@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 11:41:01PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> The "...-1" pattern makes it evident that netdev->name is expected to be
> NUL-terminated.
>
> Meanwhile, it seems NUL-padding is not required due to alloc_etherdev
> zero-allocating the buffer.
>
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
>
> This is in line with other uses of strscpy on netdev->name:
> $ rg "strscpy\(netdev\->name.*pci.*"
>
> drivers/net/ethernet/intel/e1000e/netdev.c
> 7455:   strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
>
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> 10839:  strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/net/ethernet/intel/e100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
> index d3fdc290937f..01f0f12035ca 100644
> --- a/drivers/net/ethernet/intel/e100.c
> +++ b/drivers/net/ethernet/intel/e100.c
> @@ -2841,7 +2841,7 @@ static int e100_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	netdev->netdev_ops = &e100_netdev_ops;
>  	netdev->ethtool_ops = &e100_ethtool_ops;
>  	netdev->watchdog_timeo = E100_WATCHDOG_PERIOD;
> -	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
> +	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
>
>  	nic = netdev_priv(netdev);
>  	netif_napi_add_weight(netdev, &nic->napi, e100_poll, E100_NAPI_WEIGHT);
>
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231009-strncpy-drivers-net-ethernet-intel-e100-c-4547179d9f2c
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>

Hi, this patch was bundled up with some others. It has a new home:

https://lore.kernel.org/all/20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com/
