Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D6FEB64D9
	for <linux-hardening@archiver.kernel.org>; Thu, 29 Jun 2023 19:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjF2TWX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 29 Jun 2023 15:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjF2TWF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 29 Jun 2023 15:22:05 -0400
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73B93C24
        for <linux-hardening@vger.kernel.org>; Thu, 29 Jun 2023 12:21:15 -0700 (PDT)
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
        by cmsmtp with ESMTP
        id Ef4sqhBb1QFHRExCdqL6u9; Thu, 29 Jun 2023 19:21:15 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id ExCbqUffWW9zGExCcqQR9Y; Thu, 29 Jun 2023 19:21:14 +0000
X-Authority-Analysis: v=2.4 cv=To31ORbh c=1 sm=1 tr=0 ts=649dd9aa
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=of4jigFt-DYA:10
 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=cm27Pg_UAAAA:8
 a=JVAyioYkJOEp9aBO_QMA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=17j2CnZnjoSsNdoDaHKN3iihC0WboI8ajeA2vNVcd4M=; b=hJaeMGrC+8sigC8TiZ7oj3XS+N
        4kdxJiMOusjxgC+xwENu8CwtjLQewCX+YS1bSr8tad2X9Yp79lSS8tdwdwaK9DSMDPuYfK5BZTJFw
        LGghGhnmlQyo3eCo3gGqdKzKYDYbKzIfwV7kX91Ty8dmR2FoCG53bRfu1WOxqanbzocaiXpquDa1a
        15d6qJzauKUf44WZ9w+IOorilIkYcE4KGHx/qqS2tBAxXQDn3KvmMqcg9mjFvY1LpvCF5X+ep1sXJ
        NYP/tX8HVeq7/f+N2sliNkw81jP9JBUA1c7iGsjwotWtQ5lCFGfhMbzsuJ4MA5cAfolYeg6JtGYlA
        mNR+BC1A==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:52578 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qExCb-001ANQ-13;
        Thu, 29 Jun 2023 14:21:13 -0500
Message-ID: <3068b31e-9a18-68e3-0a15-05a026435ddc@embeddedor.com>
Date:   Thu, 29 Jun 2023 13:22:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] usb: ch9: Replace bmSublinkSpeedAttr 1-element array with
 flexible array
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        =?UTF-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230629190900.never.787-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230629190900.never.787-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qExCb-001ANQ-13
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:52578
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfH6MQavtrhb3Lc43TSKUvTuGshcknGChmcRP2Ivteh9svA3mvzHXd1C0UMCamZC5OaLex0aUfgRkbPvY0ImICZqBNyv05nXOprAVh3qihCg5eNHxlkXD
 sfio+yPXGN6RirvdTjq4nUhTtmgtBOEmfPrB/13hRzl2WGeJg0GMuU2TAtMOhQMAwkEnkFGc0TVnd4WxD7JckC2rn2eHdo0QKWmP/F4sRnbsIJM6xs8oIOWX
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 6/29/23 13:09, Kees Cook wrote:
> Since commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3"),
> UBSAN_BOUNDS no longer pretends 1-element arrays are unbounded. Walking
> bmSublinkSpeedAttr will trigger a warning, so make it a proper flexible
> array. Add a union to keep the struct size identical for userspace in
> case anything was depending on the old size.
> 
> False positive warning was:
> 
> UBSAN: array-index-out-of-bounds in drivers/usb/host/xhci-hub.c:231:31 index 1 is out of range for type '__le32 [1]'
> 
> for this line of code:
> 
> 	ssp_cap->bmSublinkSpeedAttr[offset++] = cpu_to_le32(attr);
> 
> Reported-by: Borislav Petkov <bp@alien8.de>
> Closes: https://lore.kernel.org/lkml/2023062945-fencing-pebble-0411@gregkh/
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>   include/uapi/linux/usb/ch9.h | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
> index b17e3a21b15f..3ff98c7ba7e3 100644
> --- a/include/uapi/linux/usb/ch9.h
> +++ b/include/uapi/linux/usb/ch9.h
> @@ -981,7 +981,11 @@ struct usb_ssp_cap_descriptor {
>   #define USB_SSP_MIN_RX_LANE_COUNT		(0xf << 8)
>   #define USB_SSP_MIN_TX_LANE_COUNT		(0xf << 12)
>   	__le16 wReserved;
> -	__le32 bmSublinkSpeedAttr[1]; /* list of sublink speed attrib entries */
> +	union {
> +		__le32 legacy_padding;
> +		/* list of sublink speed attrib entries */
> +		__DECLARE_FLEX_ARRAY(__le32, bmSublinkSpeedAttr);
> +	};
>   #define USB_SSP_SUBLINK_SPEED_SSID	(0xf)		/* sublink speed ID */
>   #define USB_SSP_SUBLINK_SPEED_LSE	(0x3 << 4)	/* Lanespeed exponent */
>   #define USB_SSP_SUBLINK_SPEED_LSE_BPS		0
