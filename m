Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EE21775B
	for <linux-hardening@vger.kernel.org>; Thu, 21 Sep 2023 17:31:40 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8521C5AE21
	for <linux-hardening@vger.kernel.org>; Thu, 21 Sep 2023 10:29:26 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7740c8509c8so48967985a.3
        for <linux-hardening@vger.kernel.org>; Thu, 21 Sep 2023 10:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1695317357; x=1695922157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yr/T9kX37mjruI2YODshHpmgcsopLzBXqNS+RBfjBUE=;
        b=AnyY+QF3B9Ak/9OgUojdN3dR3Shj6VmKNCyYTXVJogrtpag7Olv0yHtgYGdQDcQipn
         AAl3Hffwj8y6Vho1UKR48kHFrwLi2OsC3hoAjXyjhyHepIUsBEOrHq6G6kqnuTTGznd+
         3zQviNePge6K//46RQZM+CCWqVIleih9/vOGsTDwYOAxyi/MBxGGuE50Oouimbh95tkp
         2VlKsOPudALfMGPvW/edUa/IZyeDIuJjiBqvthgo1GIM3lugIdDT27yfjq9LdBVey7ao
         bZMA637CJvKfBBAh2Dleng0fx6ZFJTdIOu7fM4qUFImyyDIclWahAbUHFm34lceYRhrt
         7+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317357; x=1695922157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yr/T9kX37mjruI2YODshHpmgcsopLzBXqNS+RBfjBUE=;
        b=ZAeQy8JOH8dAb3bSBleqSFhdcoWlwrHHgRmWsrjiUsDdYa76Ds3HJ0AvBFJyzT0KCx
         CoBoCHNMtVY614xT6n8qq57WYyKvULKjoVZiwZ/SoxGaSl11lTWNVyX4rxsRIRDnR0tG
         dqFXV+Jqm5wlBywsBMSlFTYrC2G0lXl+AL3ECLoKWfo80G3pnfIO442a5juiD1+0zhMM
         8Sft1nOoEAprvcdzktS4ORZfpPvn2TEvbZCk95tP/1eX07KzrqyK9MlfWJMvaq9tjs7w
         5DCRwtyCqYGbHHF1KRbhYw41kMRRqq8P66El/p4Amb/7rUxOSHJ/sDcbuaiPGws4i2Ye
         ameQ==
X-Gm-Message-State: AOJu0YyuLOTt9/KNok2gO2av7AQRXmy2S6vAlsq/AuV8l6qfO1nuumOn
	ZCEI1e6hEtZN4gtUoqr7WAAIgfukJylbtgDb5LslvA==
X-Google-Smtp-Source: AGHT+IE3J0hPYG3mlCf0LBXPDD4F3dt6Xy+7aUsS0fZmwILVCrE54YYcSKTbvRwSwG6maa7zoRunYA==
X-Received: by 2002:a05:6a20:914e:b0:14b:e604:9f0a with SMTP id x14-20020a056a20914e00b0014be6049f0amr5003289pzc.20.1695267460994;
        Wed, 20 Sep 2023 20:37:40 -0700 (PDT)
Received: from hermes.local (204-195-112-131.wavecable.com. [204.195.112.131])
        by smtp.gmail.com with ESMTPSA id jc10-20020a17090325ca00b001b9be3b94d3sm251294plb.140.2023.09.20.20.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 20:37:40 -0700 (PDT)
Date: Wed, 20 Sep 2023 20:37:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kees Cook <keescook@chromium.org>
Cc: Mirko Lindner <mlindner@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sky2: Make sure there is at least one frag_addr
 available
Message-ID: <20230920203738.7e2c58c6@hermes.local>
In-Reply-To: <20230920202509.never.299-kees@kernel.org>
References: <20230920202509.never.299-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 20 Sep 2023 13:25:13 -0700
Kees Cook <keescook@chromium.org> wrote:

> In the likely pathological case of building sky2 with 16k PAGE_SIZE,
> make sure there is at least 1 frag_addr in struct rx_ring_info:
> 
>    In file included from include/linux/skbuff.h:28,
>                     from include/net/net_namespace.h:43,
>                     from include/linux/netdevice.h:38,
>                     from drivers/net/ethernet/marvell/sky2.c:18:
>    drivers/net/ethernet/marvell/sky2.c: In function 'sky2_rx_unmap_skb':
>    include/linux/dma-mapping.h:416:36: warning: array subscript i is outside array bounds of 'dma_addr_t[0]' {aka 'long long unsigned int[]'} [-Warray-bounds=]
>      416 | #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
>          |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/net/ethernet/marvell/sky2.c:1257:17: note: in expansion of macro 'dma_unmap_page'
>     1257 |                 dma_unmap_page(&pdev->dev, re->frag_addr[i],
>          |                 ^~~~~~~~~~~~~~
>    In file included from drivers/net/ethernet/marvell/sky2.c:41:
>    drivers/net/ethernet/marvell/sky2.h:2198:25: note: while referencing 'frag_addr'
>     2198 |         dma_addr_t      frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT];
>          |                         ^~~~~~~~~
> 
> With CONFIG_PAGE_SIZE_16KB=y, PAGE_SHIFT == 14, so:
> 
>   #define ETH_JUMBO_MTU   9000
> 
> causes "ETH_JUMBO_MTU >> PAGE_SHIFT" to be 0. Use "?: 1" to solve this build warning.
> 
> Cc: Mirko Lindner <mlindner@marvell.com>
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309191958.UBw1cjXk-lkp@intel.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

With page size of 16K the frag_addr[] array would never be used, so the original
code was correct that size should be 0. But the compiler now gets upset with 0
size arrays thinking this is some flex array leftover? Or can't figure out that
in this case an rx skb with fragments would never be created.

The workaround is fine, but could you add an explanatory comment?
