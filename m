Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2B1C3DA7A
	for <linux-hardening@archiver.kernel.org>; Fri,  6 Jan 2023 16:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjAFQZq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 6 Jan 2023 11:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbjAFQZo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 6 Jan 2023 11:25:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5717BDDB;
        Fri,  6 Jan 2023 08:25:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B6C8B81DDE;
        Fri,  6 Jan 2023 16:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EC2C4339E;
        Fri,  6 Jan 2023 16:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673022335;
        bh=lVDpUjnFc4FP1Bc2ZATeWjj7jUbr00O4vLVnvBsZp4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qqkUuSacfFJLFtwu8WN/u3Mm7bMbg3DVIHB8KT+0cOHYldjs+DMzXL69oj1VhptiV
         sVJonKjYbS1YFm5bhxmkTKByZwo6ovSzvaJ10VQ2P4sKo4XtYWONrhPNMXGiBks02U
         kd3dUcbz9wactIKl224wLqQ/E8nidCoEEncgAnXMx1I3DX/EVGPXbL/439sLeetRcA
         sXHhYWvVzEVKOnRCllJJNpOy8vpfZ9BPN7c0nVyh4bfYvwJpj6DTpiwBVPgrnpFCd8
         j/XkLMQZoZpqgTkFdLHiW1JNYVmHGrzOTLhTGq+QL28ZTXadNln9YpZKcXJIvPI3hr
         gxat35coZk8GQ==
Date:   Fri, 6 Jan 2023 10:25:40 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        kernel test robot <lkp@intel.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Sean Anderson <sean.anderson@seco.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Amit Cohen <amcohen@nvidia.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] ethtool: Replace 0-length array with flexible array
Message-ID: <Y7hLhG6xf6KowsDo@work>
References: <20230106042844.give.885-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106042844.give.885-kees@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 05, 2023 at 08:28:48PM -0800, Kees Cook wrote:
> Zero-length arrays are deprecated[1]. Replace struct ethtool_rxnfc's
> "rule_locs" 0-length array with a flexible array. Detected with GCC 13,
> using -fstrict-flex-arrays=3:
> 
> net/ethtool/common.c: In function 'ethtool_get_max_rxnfc_channel':
> net/ethtool/common.c:558:55: warning: array subscript i is outside array bounds of '__u32[0]' {aka 'unsigned int[]'} [-Warray-bounds=]
>   558 |                         .fs.location = info->rule_locs[i],
>       |                                        ~~~~~~~~~~~~~~~^~~
> In file included from include/linux/ethtool.h:19,
>                  from include/uapi/linux/ethtool_netlink.h:12,
>                  from include/linux/ethtool_netlink.h:6,
>                  from net/ethtool/common.c:3:
> include/uapi/linux/ethtool.h:1186:41: note: while referencing
> 'rule_locs'
>  1186 |         __u32                           rule_locs[0];
>       |                                         ^~~~~~~~~
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: kernel test robot <lkp@intel.com>
> Cc: Oleksij Rempel <linux@rempel-privat.de>
> Cc: Sean Anderson <sean.anderson@seco.com>
> Cc: Alexandru Tachici <alexandru.tachici@analog.com>
> Cc: Amit Cohen <amcohen@nvidia.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
> v3: don't use helper (vincent)
> v2: https://lore.kernel.org/lkml/20230105233420.gonna.036-kees@kernel.org
> ---
>  include/uapi/linux/ethtool.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index 58e587ba0450..3135fa0ba9a4 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -1183,7 +1183,7 @@ struct ethtool_rxnfc {
>  		__u32			rule_cnt;
>  		__u32			rss_context;
>  	};
> -	__u32				rule_locs[0];
> +	__u32				rule_locs[];
>  };
>  
>  
> -- 
> 2.34.1
> 
