Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAEBC433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Nov 2021 23:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F29B61A86
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Nov 2021 23:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbhKRXUT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 18 Nov 2021 18:20:19 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22440 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhKRXUT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 18 Nov 2021 18:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637277438; x=1668813438;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3FRxLZFQ1ant8RvQeCMXpMeGccsTGL1wsogxaW4rxA0=;
  b=AW+LiVzlWu9KE9IWoMklP21Nfw1wYxzhoSaXAPPn2ORllslm+RtT2l1/
   Tz2nB2Yo/4AyeJGmfMJ3jUGiVDvUEpIskfK1je9kpA+pED9g4Wvt7giHN
   i5hug+FecYvpD2ss8mN5y1xLTUKJ75pe3Kp1V+5CmCNGYTqUT106sdyzP
   oCycZbpriwqJvJIZ9gCwP1cGKxT6exsq5vzSO3fgwtJpuRT88B3W1a1yc
   sqj9Yz8IlDQelIJMX8DWahxvB2VDJF+rh/TTxfLg8tqvJUhtVs3sAby0S
   V/55zUf7WO1S7IcBBN2hSQ2kVPB7js1AiuuovBjMOmbOE/KN71ItfCMPg
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,246,1631548800"; 
   d="scan'208";a="289953271"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2021 07:17:18 +0800
IronPort-SDR: KYrrNeE0plZSO3Q3ezcltJdoIAQWIYrb8k087/PPSksbVbhxNgPLR2QI9Ox7wGgXrCqMAil2y+
 LyyYJJDPT96J2zNXmdA+CQYnu0MxjVAXSevh5Ep//VvuD/Cn5DvEjK4/hXYBk/L8yRq92o6zlx
 IDoM+bvWTpM/R/mAwt1rmSy4vTkOpCisk4IsUrQ2jm33OXmn0wC3bBWlNX73vlJuDSOWDnu15z
 v7MZN8oY5dK+g1C8aaR4dKutNCY0d3FsMitt9qD83Lu4gYjQ4yDybAIwRJ9Lpi0HH0jKu54yYh
 Mb5j6qtCDkuAyLsqqwVD4e7l
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 14:50:45 -0800
IronPort-SDR: 1lZAII99+Ja7+7waijRhmgu7dbUZ00xsZzrzvNlGp5HBYzUJBAcj/M9hB6WQOd9cTvjqEQMb8e
 P+QMEPb//zsPbF1ghOUILxW7Tn7Z0hcNf8qPCw+9OxV/DDXspo5ZzdUkuiVajeZtVpkSP7EsfV
 r/dE+dGgNY7Mog2gGhl5LlK34KcVZfpW31Ez0Pr7TR+PH4AN6EsEB3tnAW5OlSR+Xv3TNNlQCO
 SG8BeuRxGttnLZ2VL9+FenhQdVsFCUgiNN2eiCSJY7SLWbfHC9Q+4ACuuu5vXd/zIzg6wIVtdJ
 kS4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 15:17:19 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HwG0Y4Lxbz1RtVv
        for <linux-hardening@vger.kernel.org>; Thu, 18 Nov 2021 15:17:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1637277437; x=1639869438; bh=3FRxLZFQ1ant8RvQeCMXpMeGccsTGL1wsog
        xaW4rxA0=; b=RcO4PLrxhZ9Wtq3TCyoGYca+66VQkzklFDz3HvLl6yp7oPdVqgG
        B1RGsUrh9UpZ3xY3+f4U4FiqxGnHa6KqbMIvLanqGZmf0J65/OAHzDtd9U4w5A40
        93I0hDHugPyNGSK/zI9jHuB9xdiXFFHGRaMGvBagm143cuC24TKkt4zO5mk6bP90
        Q23lWKC1ssZtWj8x+nfF5uO2aI/URl/up3v/6vb6MkwfkScsZDV041fdaWyk5xsf
        X58ICeGA0hYYXBkFlyHsYCjp0O2ZWbJs+5FYtO1M2xv2V2KC9oxeh1t0SGVxH2+q
        t1/UI7VWp6b91KEA59xCwVb9MCCZrjEtHww==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id p_7VKKkPqDPy for <linux-hardening@vger.kernel.org>;
        Thu, 18 Nov 2021 15:17:17 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HwG0X20ylz1RtVl;
        Thu, 18 Nov 2021 15:17:16 -0800 (PST)
Message-ID: <0dd24142-a5e6-b146-9315-d2680ef4ed35@opensource.wdc.com>
Date:   Fri, 19 Nov 2021 08:17:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
Subject: Re: [PATCH] sata_fsl: Use struct_group() for memcpy() region
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20211118183807.1283332-1-keescook@chromium.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211118183807.1283332-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 2021/11/19 3:38, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally writing across neighboring fields.
> 
> Use struct_group() in struct command_desc around members acmd and fill,
> so they can be referenced together. This will allow memset(), memcpy(),
> and sizeof() to more easily reason about sizes, improve readability,
> and avoid future warnings about writing beyond the end of acmd:
> 
> In function 'fortify_memset_chk',
>     inlined from 'sata_fsl_qc_prep' at drivers/ata/sata_fsl.c:534:3:
> ./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
>   199 |    __write_overflow_field();
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

This lacks some context with regard to FORTIFY_SOURCE and struct_group(). Is
that already in 5.16 ? It sounds like it is not. Do you want a ack ? Or do you
want me to queue this up for 5.17 ?

Cheers.

> ---
>  drivers/ata/sata_fsl.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index e5838b23c9e0..fec3c9032606 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -246,8 +246,10 @@ enum {
>  struct command_desc {
>  	u8 cfis[8 * 4];
>  	u8 sfis[8 * 4];
> -	u8 acmd[4 * 4];
> -	u8 fill[4 * 4];
> +	struct_group(cdb,
> +		u8 acmd[4 * 4];
> +		u8 fill[4 * 4];
> +	);
>  	u32 prdt[SATA_FSL_MAX_PRD_DIRECT * 4];
>  	u32 prdt_indirect[(SATA_FSL_MAX_PRD - SATA_FSL_MAX_PRD_DIRECT) * 4];
>  };
> @@ -531,8 +533,8 @@ static enum ata_completion_errors sata_fsl_qc_prep(struct ata_queued_cmd *qc)
>  	/* setup "ACMD - atapi command" in cmd. desc. if this is ATAPI cmd */
>  	if (ata_is_atapi(qc->tf.protocol)) {
>  		desc_info |= ATAPI_CMD;
> -		memset((void *)&cd->acmd, 0, 32);
> -		memcpy((void *)&cd->acmd, qc->cdb, qc->dev->cdb_len);
> +		memset(&cd->cdb, 0, sizeof(cd->cdb));
> +		memcpy(&cd->cdb, qc->cdb, qc->dev->cdb_len);
>  	}
>  
>  	if (qc->flags & ATA_QCFLAG_DMAMAP)
> 


-- 
Damien Le Moal
Western Digital Research
