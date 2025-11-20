Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8695C2F49E3
	for <linux-hardening@vger.kernel.org>; Thu, 20 Nov 2025 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667334; cv=none; b=OzbmGpcXWxxQ8Bc2DDcqsYulIl4HyghXakanIVXXPX3We/UNlZqYy2UWUTjlZlRrtPLp7qtmqCZu/g+LdohIDxVxHKkjrcbK5XpC0EAcwZpFyiaRXepEipqNDkW0/fDVbtT2bIVDIdhA36OyCgaf3Xbe02WL4d4gMjS7MeSHgXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667334; c=relaxed/simple;
	bh=V/rD4t8NOQsfOC3HfIsU2xfXT7WTaTdhvmjP0SpAch8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AK/N2oxwP41JMwFwPJJkxnO2fu/DFfwE8H2ibmMIozMTQxFhMckOFN7LE3DGzplLrTgzRmVJGXOrPM/jer902fuq+GpOc5VdYPVzuhDdkYt4BzY3ZfQbo6+cOnxTcWGm2StQEgZ/duhORLUtNtmOcorg0xtTRcYVsUfHgFTA3Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnqBwQ9Q; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnqBwQ9Q"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so14160585e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 20 Nov 2025 11:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763667331; x=1764272131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mfCNwo/JH9zJ9K5wPIMMZT4NAocS/4bQyKanpHhyxWk=;
        b=XnqBwQ9Qkrm4xDOWhXZz4IwNSntrsujjMreW6sNAEMedQ0h+4eRnS+x+e+WevJkt3B
         eKDcCO348tJl+426DsQJ/FmPG/ATTTls7wteHle4bWI3/OqZkeL95qP2aHzanX2/SZwn
         TyItkX2nh0z9nHaStBf1Sfnd3ge0TjMvsUh+fzBowO5xRi+wPV0wAjk145HQzU2Ro0x7
         YE/cyUKdVn3NVFjcwhbkzFWwhtk8aiKEOAW2GFfF8qRzYz3Ihc7gc6rVUODAYmw/5KzK
         lD5w34vLqrCMCLywE8hQ3BWQ9ihlEkH0yT0/KyElEs4Vw0DU++qMcFlZCF+lMW6Bat+0
         LTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763667331; x=1764272131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfCNwo/JH9zJ9K5wPIMMZT4NAocS/4bQyKanpHhyxWk=;
        b=DYfoGVUOxPGSXQAsF2LwiRTG8CFEucp+W64mW0jntSPDsTU6O8i4ACQ4aTVse0KAQH
         BxWYzmsSWPx27fVcLRJFuGeOagBTkOQv2bCZymXv7zY+aRQDhWVVnEgVZMplZJuv3Gw3
         YU3qoK82sCo+dpYLdwAOH+am+i45H5h8/dp+RYWukrcjPlJsl57IZ3WzufSZlWNqVxnQ
         OEQT41x+VTthi6hJ8GHReeBYMRUsUmJRiRQN+1AQEJfnFmaOwSvkfSfg/OZL0tGS477I
         9x0xSbFwLoI+zGN6WoU7+jU+IzRRt9/ZFD4X8s7XVql0H7suyLDjX1WNOMZ/Z8rSLD7I
         KPXw==
X-Forwarded-Encrypted: i=1; AJvYcCXK97vN13HeEyveRA9u3ViFCAIvl9p1jVGiCKgUPOiNV3Snz/6B1xH4l1OctYvP+HMIsQOHSgtOj43uS8T2lBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4hQCeiF1fnn+pmAJtay3kfK3S0P4YKZ1xDdkV/7xnwifH4DAc
	0OmUFLLjhCU0qDB/oC+vhXYQCTV0WmTsxbEgqIB0rCc4bb1IlKYgHFGq
X-Gm-Gg: ASbGncuDLh66rQcMnyrm2Z30e2nYtI2V6A1aMSmqKn/lbFMLhlc5RYrlnA/sMv1Yh/X
	3c3vFRf3PDq68gF4jm2Lsr3yKuM8L2DAErA3yobqx8kC2MEhOkPNWIoZ+aZildNjytfQk9O9+hZ
	6Im2ur84VqFgxqglj4EQY3HcONxJnkB33qlALhY+VXGimcukePbisa0Dvnfop2W1+96Vd62+kH6
	To/TEtYqLdGlfVoSbm4qi2cTQ5Qnl9qQ+HSramzuvmPuq1QtrRPPDaV9j6BQ3/A4pSBL5ACfmBj
	jGphaEuLogS9xVjKj8xPcuDE2MYgpaor3UlQlIOkwh2U484OQ/rPHSchaaKA3gAk5N0Gmt60MC8
	XvnHh/OB1zodIY43aPfDicj36BtRDxDinlO3VtNF9nS2smTJLUQJzQRq6GV8ciSZxYBF86sWva8
	6yChUoCjJKg1wCsV+Idnfe8b4n6WgSBVJDmdsxzOH0mbmWBLkcABzNhGCtOJQU5J20JjlOKI8Po
	UeIKDRbjnZzrpd14xI=
X-Google-Smtp-Source: AGHT+IE/+BXkFRkJPsMKrx/dpAlaCljzFnGLNYQP4GX74+JEmuPteT2PVEtj9OOLKjWaKQRmqWqRkw==
X-Received: by 2002:a05:600c:46d0:b0:477:aed0:f403 with SMTP id 5b1f17b1804b1-477b8a64734mr42030485e9.8.1763667330720;
        Thu, 20 Nov 2025 11:35:30 -0800 (PST)
Received: from shift.daheim (p200300d5ff242c0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff24:2c00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3607b3sm5027005e9.6.2025.11.20.11.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 11:35:30 -0800 (PST)
Received: from localhost.daheim ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99)
	(envelope-from <chunkeey@gmail.com>)
	id 1vMARF-00000001iZv-2iWI;
	Thu, 20 Nov 2025 20:35:29 +0100
Message-ID: <20c2a143-3841-4839-b377-b90dfd8a031c@gmail.com>
Date: Thu, 20 Nov 2025 20:35:29 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] carl9170: Avoid -Wflex-array-member-not-at-end
 warning
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aR1yxjmzb2DM2-Uq@kspp>
Content-Language: de-DE, en-US
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <aR1yxjmzb2DM2-Uq@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/25 8:33 AM, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration (which happens to be in a union, so
> we're moving the entire union) to the end of the corresponding
> structure. Notice that `struct carl9170_rsp` is a flexible structure,
> this is a structure that contains a flexible-array member.
> 
> With these changes fix the following warning:
> 
> drivers/net/wireless/ath/carl9170/carl9170.h:382:9: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Sure, if this truly fixes the warning.

Acked-by: Christian Lamparter <chunkeey@gmail.com>

> ---
>   drivers/net/wireless/ath/carl9170/carl9170.h | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/carl9170.h b/drivers/net/wireless/ath/carl9170/carl9170.h
> index ba29b4aebe9f..b13685e22a0d 100644
> --- a/drivers/net/wireless/ath/carl9170/carl9170.h
> +++ b/drivers/net/wireless/ath/carl9170/carl9170.h
> @@ -375,11 +375,6 @@ struct ar9170 {
>   	u8 *readbuf;
>   	spinlock_t cmd_lock;
>   	struct completion cmd_wait;
> -	union {
> -		__le32 cmd_buf[PAYLOAD_MAX + 1];
> -		struct carl9170_cmd cmd;
> -		struct carl9170_rsp rsp;
> -	};
>   
>   	/* statistics */
>   	unsigned int tx_dropped;
> @@ -463,6 +458,13 @@ struct ar9170 {
>   		unsigned int cache_idx;
>   	} rng;
>   #endif /* CONFIG_CARL9170_HWRNG */
> +
> +	/* Must be last as it ends in a flexible-array member. */
> +	union {
> +		__le32 cmd_buf[PAYLOAD_MAX + 1];
> +		struct carl9170_cmd cmd;
> +		struct carl9170_rsp rsp;
> +	};
>   };
>   
>   enum carl9170_ps_off_override_reasons {

