Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDFAC43334
	for <linux-hardening@archiver.kernel.org>; Wed, 22 Jun 2022 22:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242135AbiFVW0p (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 22 Jun 2022 18:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349832AbiFVW0l (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 22 Jun 2022 18:26:41 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238333C71C
        for <linux-hardening@vger.kernel.org>; Wed, 22 Jun 2022 15:26:40 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x4so11001061pfq.2
        for <linux-hardening@vger.kernel.org>; Wed, 22 Jun 2022 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RBPrgVSpf0FmmJ0JbMWvmojuCTHOIxEix+BIvVMi/ts=;
        b=JU+BECnclpD9/+n154tw+ZMyT8mYzDPWCwkuLWYfESgBlENLt+eLP1o4pEziGVV2ji
         4JDF+F0r2a1g3aRmx/Z/nskidGvtYGrotAWthhqkWuILfqaW+wNqZgkw8fDaDx87YZR6
         Dxkt/rwmOyMjd5qXFvieZLPxzBlGuLMm/OPzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RBPrgVSpf0FmmJ0JbMWvmojuCTHOIxEix+BIvVMi/ts=;
        b=eFX0Z33xYiTRTkdQBYlu9PGyFEUetGT74+Ju7C3Kk7M9KHK2NcVAO9pHY7yTnrO3/9
         BKScPUpl8EoksTh23H/cNvgpeoL8rNHtSHXE5tB/KGHsJj7jnvfhYtu3U6kD1SlalVqg
         iwR6tB+Jia3kGJOZh9gmCPFjzXrSiTLlhaWKcR8BbVbcmuZK19I7Yr2T9HXm7wl8i/mV
         NP4yPVmsKHu8JYU6B939+OwvbnSdnlhUYykCVjrUoNLugAJgKAIUFc72Tws7kApwS/1e
         WYkaDxW/xcfizm1FpQ1HNUwPUZt1AkMtXz3SEtXjlIGLrMqiRR+MYbyIBDmBVFnzvV6F
         /t6w==
X-Gm-Message-State: AJIora/qshm7z0omZxIUh0j0fCzhKpy1s+o/ackzc7jHb09QHRS20FbK
        UKr31ag6gnTQFjpU8+xSCEZlhA==
X-Google-Smtp-Source: AGRyM1tDRF5crgvifiewOK30IVVYeVihLHJT7NPnt566X+eWqnnXTwWUJyjkkiMmKgjMrAePpmzPJA==
X-Received: by 2002:a63:b94a:0:b0:40c:e843:a1dc with SMTP id v10-20020a63b94a000000b0040ce843a1dcmr4683574pgo.441.1655936799660;
        Wed, 22 Jun 2022 15:26:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j3-20020a170903024300b00161947ecc82sm13262042plh.199.2022.06.22.15.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 15:26:39 -0700 (PDT)
Date:   Wed, 22 Jun 2022 15:26:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 3/4][next] scsi: megaraid_sas: Replace one-element
 array with flexible-array member in MR_DRV_RAID_MAP
Message-ID: <202206221457.1A12D768EF@keescook>
References: <cover.1628136510.git.gustavoars@kernel.org>
 <b43d4083d9788bb746dc0b2205d6a67ebb609b0d.1628136510.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b43d4083d9788bb746dc0b2205d6a67ebb609b0d.1628136510.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 04, 2021 at 11:20:04PM -0500, Gustavo A. R. Silva wrote:
> Replace one-element array with a flexible-array member in struct
> MR_DRV_RAID_MAP and use the flex_array_size() helper.
> 
> This helps with the ongoing efforts to globally enable -Warray-bounds
> and get us closer to being able to tighten the FORTIFY_SOURCE routines
> on memcpy().
> 
> Link: https://en.wikipedia.org/wiki/Flexible_array_member
> Link: https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/109
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

I'd really like to see this fixed. :) I'm running into this 1-element
array problem now with UBSAN_BOUNDS:

[   10.011173] UBSAN: array-index-out-of-bounds in /build/linux-WLUive/linux-5.15.0/drivers/scsi/megaraid/megaraid_sas_fp.c:103:32
[   10.087824] index 1 is out of range for type 'MR_LD_SPAN_MAP [1]'

and I'm not the only one:

https://bugzilla.kernel.org/show_bug.cgi?id=215943

> ---
> Changes in v2:
>  - None.
> 
>  drivers/scsi/megaraid/megaraid_sas_fp.c     | 6 +++---
>  drivers/scsi/megaraid/megaraid_sas_fusion.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fp.c b/drivers/scsi/megaraid/megaraid_sas_fp.c
> index da1cad1ee123..9cb36ef96c2c 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fp.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fp.c
> @@ -229,8 +229,8 @@ static int MR_PopulateDrvRaidMap(struct megasas_instance *instance, u64 map_id)
>  					le32_to_cpu(desc_table->raid_map_desc_offset));
>  				memcpy(pDrvRaidMap->ldSpanMap,
>  				       fw_map_dyn->ld_span_map,
> -				       sizeof(struct MR_LD_SPAN_MAP) *
> -				       le32_to_cpu(desc_table->raid_map_desc_elements));
> +				       flex_array_size(pDrvRaidMap, ldSpanMap,
> +				       le32_to_cpu(desc_table->raid_map_desc_elements)));
>  			break;
>  			default:
>  				dev_dbg(&instance->pdev->dev, "wrong number of desctableElements %d\n",
> @@ -254,7 +254,7 @@ static int MR_PopulateDrvRaidMap(struct megasas_instance *instance, u64 map_id)
>  			pDrvRaidMap->ldTgtIdToLd[i] =
>  				(u16)fw_map_ext->ldTgtIdToLd[i];
>  		memcpy(pDrvRaidMap->ldSpanMap, fw_map_ext->ldSpanMap,
> -		       sizeof(struct MR_LD_SPAN_MAP) * ld_count);
> +		       flex_array_size(pDrvRaidMap, ldSpanMap, ld_count));
>  		memcpy(pDrvRaidMap->arMapInfo, fw_map_ext->arMapInfo,
>  		       sizeof(struct MR_ARRAY_INFO) * MAX_API_ARRAYS_EXT);
>  		memcpy(pDrvRaidMap->devHndlInfo, fw_map_ext->devHndlInfo,
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.h b/drivers/scsi/megaraid/megaraid_sas_fusion.h
> index 9adb8b30f422..5fe2f7a6eebe 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fusion.h
> +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.h
> @@ -1182,7 +1182,7 @@ struct MR_DRV_RAID_MAP {
>  		devHndlInfo[MAX_RAIDMAP_PHYSICAL_DEVICES_DYN];
>  	u16 ldTgtIdToLd[MAX_LOGICAL_DRIVES_DYN];
>  	struct MR_ARRAY_INFO arMapInfo[MAX_API_ARRAYS_DYN];
> -	struct MR_LD_SPAN_MAP      ldSpanMap[1];
> +	struct MR_LD_SPAN_MAP      ldSpanMap[];
>  
>  };
>  

I think this patch is incomplete, and the wrapping struct needs to be
adjusted too:

@@ -1193,7 +1193,7 @@ struct MR_DRV_RAID_MAP {
 struct MR_DRV_RAID_MAP_ALL {
 
        struct MR_DRV_RAID_MAP raidMap;
-       struct MR_LD_SPAN_MAP ldSpanMap[MAX_LOGICAL_DRIVES_DYN - 1];
+       struct MR_LD_SPAN_MAP ldSpanMap[MAX_LOGICAL_DRIVES_DYN];
 } __packed;
 
With that added, I get zero changes to the executable code.

I assume the others need adjustment too.

-- 
Kees Cook
