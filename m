Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739F1C05027
	for <linux-hardening@archiver.kernel.org>; Thu,  2 Feb 2023 20:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjBBU3Q (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 2 Feb 2023 15:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjBBU3P (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 2 Feb 2023 15:29:15 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09641CA03
        for <linux-hardening@vger.kernel.org>; Thu,  2 Feb 2023 12:29:14 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id v23so3119720plo.1
        for <linux-hardening@vger.kernel.org>; Thu, 02 Feb 2023 12:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n98EttFHW/ICYNI7MY6lJvEvw1N9VKBoPOxpFnAc55Y=;
        b=S2Ov+6rM54xrDH7orxvNW4eqx9iStel27qTGmwTu/8Ps04aOqwnbMk5NoTSUzdjdDq
         OhcVz5WVT+6piNm4iQGPpJdxnbq8ctyZ7N6ngCrQfPKzRXPupiupzIx4XD7aVj1iCDwV
         Sv/eHNWV5sSBVsS7EkWgF6JM+Zohy2P6NrbAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n98EttFHW/ICYNI7MY6lJvEvw1N9VKBoPOxpFnAc55Y=;
        b=i+w0y8aEP21U4XtZpqCYAsFhA/6H/jYFndBoF3Ciz3rnrpK3Qn2eqMMmzLQAbE8Xx7
         tGF7dEyLNEKlgs+1Z0LYEby7eqX9HvLSNKTEKAsOgxt6EyDfkXT3ZD94tTvHXWsksmbQ
         D8rqJdynOJZG4WaRvbG7ZdS02hlMglB7pqP0EoSuVyJOPs0BOvcSqICKgEjCAo7jNy/q
         br8XRotTV129DCXTE419zGcJJIIUCUvoNHYva0Mz0ibrOjzmc4+qvmqnv7C18HOR88b0
         ydvxQBXfYj3fbdMhHe27+8/swTL+bEH3aUUfY9jhAuPPbffwXwrd2lVwyb+s1ivvV389
         Ba5g==
X-Gm-Message-State: AO0yUKU6Almab0OocY2hMDipjyo9k9fFmVyOgmBJm6e0sICZVlmxxGPV
        O0mVa6BB9MzP2on5ydhRCCtYYQ==
X-Google-Smtp-Source: AK7set9OU2OrVIrEXTtjm0QF80aNH2/8ujJBnSQ6knT7NhUSN/89E1xG5mDlL25ZefUwjnnHgG1YwQ==
X-Received: by 2002:a17:90a:1997:b0:230:3af9:177 with SMTP id 23-20020a17090a199700b002303af90177mr2619933pji.8.1675369753525;
        Thu, 02 Feb 2023 12:29:13 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m19-20020a17090a7f9300b00212e5068e17sm261011pjl.40.2023.02.02.12.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 12:29:13 -0800 (PST)
Message-ID: <63dc1d19.170a0220.51d25.0de4@mx.google.com>
X-Google-Original-Message-ID: <202302022029.@keescook>
Date:   Thu, 2 Feb 2023 20:29:12 +0000
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kevin Barnett <kevin.barnett@microsemi.com>,
        Don Brace <don.brace@microchip.com>, storagedev@microchip.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/3][next] scsi: smartpqi: Use struct_size() helper in
 pqi_report_phys_luns()
References: <cover.1663816572.git.gustavoars@kernel.org>
 <b6a23dbc136710e98580ac01daa39ad971eecb5d.1663816572.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a23dbc136710e98580ac01daa39ad971eecb5d.1663816572.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 21, 2022 at 11:30:47PM -0500, Gustavo A. R. Silva wrote:
> Prefer struct_size() over open-coded versions of idiom:
> 
> sizeof(struct-with-flex-array) + sizeof(typeof-flex-array-elements) * count
> 
> where count is the max number of items the flexible array is supposed to
> contain.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
>  drivers/scsi/smartpqi/smartpqi_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
> index 544cd18a90d7..17bdc8b3f161 100644
> --- a/drivers/scsi/smartpqi/smartpqi_init.c
> +++ b/drivers/scsi/smartpqi/smartpqi_init.c
> @@ -1192,7 +1192,7 @@ static inline int pqi_report_phys_luns(struct pqi_ctrl_info *ctrl_info, void **b
>  
>  	rpl_8byte_wwid_list = rpl_list;
>  	num_physicals = get_unaligned_be32(&rpl_8byte_wwid_list->header.list_length) / sizeof(rpl_8byte_wwid_list->lun_entries[0]);
> -	rpl_16byte_wwid_list_length = sizeof(struct report_lun_header) + (num_physicals * sizeof(struct report_phys_lun_16byte_wwid));
> +	rpl_16byte_wwid_list_length = struct_size(rpl_16byte_wwid_list, lun_entries, num_physicals);
>  
>  	rpl_16byte_wwid_list = kmalloc(rpl_16byte_wwid_list_length, GFP_KERNEL);
>  	if (!rpl_16byte_wwid_list)
> -- 
> 2.34.1
> 

-- 
Kees Cook
