Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08F82420F
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4497A2;
	Tue, 24 Oct 2023 13:01:54 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-27d11401516so3349969a91.2;
        Tue, 24 Oct 2023 13:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698177714; x=1698782514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3q89EnJ4jUP8Y3YaLMAS6E9w1gTCD+SiGGP7gCXLM2c=;
        b=W1ztffIHzAXrwPAVPxT/Hp1gpZELftOrADiAsaVolOAx9K5DG3ADLkF6iMKrVoRukp
         aMS8d0U1KaQqrVDL0mATNGkBGo35zCJq2i2DKbqmGWGf3QaaKPn5LMmL3szbIyKRgNx3
         8PXy4BcD6BL/6Or3H0lIO1Gsx9Yey4fSzinXi4Fy9SuYlJHZXOyPL6m3kD5DWlIizs+j
         omdcjYf6qbb8xnIF3hDLavww5S7UM0X+QJkuJo8zwL1gu7kDe2FpvZo4CQOYY28C93tK
         JDR1c8ewso1scBhE3/a2tpulddDE44o2tuFrZyJpaZgbTeR9MqGZjacLPqLfaMq4baz9
         aC8Q==
X-Gm-Message-State: AOJu0YyvAFPIeB6dbpJXGxV+f6bgcA+9yhfytGBOmldGgC8zbck5MLkf
	7ds2lI+5AUYX6i7MBjNwdlk=
X-Google-Smtp-Source: AGHT+IHbDFImznTQkMF0msiilCf1sjhqSC1U4BOtN17QPIniAZ01YJbmuU3MPTqsfHhbKeft3ZxtMQ==
X-Received: by 2002:a17:90a:194e:b0:27d:b488:92ee with SMTP id 14-20020a17090a194e00b0027db48892eemr10229357pjh.2.1698177714177;
        Tue, 24 Oct 2023 13:01:54 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:30e1:c9d3:6b41:493d? ([2620:15c:211:201:30e1:c9d3:6b41:493d])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b0027476c68cc3sm7264364pjb.22.2023.10.24.13.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 13:01:53 -0700 (PDT)
Message-ID: <9f38f4aa-c6b5-4786-a641-d02d8bd92f7f@acm.org>
Date: Tue, 24 Oct 2023 13:01:51 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: fcoe: replace deprecated strncpy with strscpy
Content-Language: en-US
To: Justin Stitt <justinstitt@google.com>, Hannes Reinecke <hare@suse.de>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20231024-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-v1-1-1e0026ee032d@google.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231024-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-v1-1-1e0026ee032d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/23 12:52, Justin Stitt wrote:
> diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
> index e17957f8085c..7a3ca6cd3030 100644
> --- a/drivers/scsi/fcoe/fcoe_sysfs.c
> +++ b/drivers/scsi/fcoe/fcoe_sysfs.c
> @@ -279,12 +279,10 @@ static ssize_t store_ctlr_mode(struct device *dev,
>   	if (count > FCOE_MAX_MODENAME_LEN)
>   		return -EINVAL;
>   
> -	strncpy(mode, buf, count);
> +	strscpy(mode, buf, count);
>   
>   	if (mode[count - 1] == '\n')
>   		mode[count - 1] = '\0';
> -	else
> -		mode[count] = '\0';
>   
>   	switch (ctlr->enabled) {
>   	case FCOE_CTLR_ENABLED:

Please consider to remove the code for copying the sysfs string and to
use sysfs_match_string() instead.

Thanks,

Bart.

