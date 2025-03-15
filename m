Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F7DAD51
	for <linux-hardening@vger.kernel.org>; Sat, 15 Mar 2025 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742048861; cv=none; b=Mvr3GUJRG/Hauk+ZcX9DWxEz5zNcB/smXKYqF2iONX38diq7ypVdUXPQ27dNwBrpjRrTpceWAQOC/8FoxNLcnmsASvAK0dWMCuvI/2dUXP5wpqHt/h3+UdJCTmQ/xoTmAtmkJZqZA0o087VLQ3b3Mu93UHu5ZJsPmhUFhRr/wPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742048861; c=relaxed/simple;
	bh=hXzuzhU31dBnJ3J+QSMHwZIJhmbHXosL4ufMNjsocBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZER4miZBSMIU9PO//ndkTcXj6v3eMf6dIBu5ei8kXXVVew9BxK7uaObTfrriKLPCojC4WDm5XCDbWn0wy5dt3AcYBs929iQ30BDfxTs1PGiYgHumF+bUyMAO+6nlF+neei2NSdwb0nqrc/kynR8kmKNz3STL4ZxMsnDpdKmahU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=oM28RtlH; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="oM28RtlH"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85b3f92c8dfso92868339f.2
        for <linux-hardening@vger.kernel.org>; Sat, 15 Mar 2025 07:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742048859; x=1742653659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85qKjHMygbhbh5ay23QR06Q47KNXbs3nAMboqHenrk8=;
        b=oM28RtlHlTgvLgkVpxTieAJKjtq/GkvI3MJVmMOb5/w4gK18BLpIAb00cmwrb2GUzX
         7ifRRgNIbYl71cdWf7DYezSITpzybrXXRBm4+8aVhCRMjU6qrrHiNctducao4md1XCmf
         O6G5K7Wc8i/N9sXeuEsCfHKn4YzK9WXH9DlIww9rGjZlavBYl+0AEaSZbJqgEujh338m
         ofENIP/YEczXOptQqyfsWKO9CTRjhxeUKq1YSBh4iYk3jLG46CKJ1SMihp7QEd+dpG1o
         YTv1CGyrMNGxeY/5V+umSI8fuY1pHu4irU7o8XJ2jHJ82NMR2eZxSux0ArppdnYsQcWP
         GY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742048859; x=1742653659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85qKjHMygbhbh5ay23QR06Q47KNXbs3nAMboqHenrk8=;
        b=P38rRUoDbL0P7w7fj/A9znVZf64F2vJq/wsdWRDUCGVxF+zWZPXO+hUyBXaPtZcQgY
         LexYf/GqwRDza0V7mwIpl+nEq6Uu2OcLGf8nJZgJOGmfW3X8mrQV1l6AAVIhlllgcf+8
         3BAhZedPTnZgbSGImbi7GiHQjgqJtEWhL8BP51gZvJrYFe6dt5TgaFfvbE9afQsKpE0F
         zSTRvEdPyjGKriMUgyhnjfDOjElfJyCaM6j2RM8Tld3m7sM0dT90xdDtQYAmCVirY9SH
         fJvmomV52ouotkfg7ul8EbLZt0vqvvJ2jngvluOOV+CoHn0tNDkCDvpGKdnI6gxVwNqB
         qqrw==
X-Forwarded-Encrypted: i=1; AJvYcCV4EplPfSpnNyeiV4dG+/UEcmqkuYgDBrFxwA6DwpIfaf78/lDdymU231SYFNDLT6eIX1JfvRDPxhqo7weAF20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmfailv+twWDpIVnvQGL1nK6fPk3Ri+j6kWe6F7TqtGDkOYcU6
	1dKzIRVe79VdqqqerpG8+LQx4msICaHbEJyolSSxprpCGkbcdJhYEslcllXAoso=
X-Gm-Gg: ASbGncv5vcImAjqaEpCKrsYOfsCa1899IsbGue9qKAf4xwfS7zGCVTp44ep44F2fqWF
	c6a0bQwdP5oZ83cgu8vVPRgM/nq+odv3GBVxZvy2yGb+LodcpSsqBfKZeAVOhtApLO7pm2zySqV
	bRIj+t5asdplHzKXHDRig8isTpsk/e+C9j0GWuRIC8TPELgrHq/ADL19YVm3ah1tivbAUGj068e
	JWwV8GvZtN+JP7XJrdrY93YHpvOeaaGQCi8VNqGE6m1whn/anR/0BXrGrooFKSMkHCvOhNh6730
	iBQgoIDvIwMmXX9D+pVcMSN74IixGJbeR6mB3fetiheGdwRut2UPMZmUtTCzBiEjejueeQAxoWa
	AIv7Xi8DFp0H/olDy5w==
X-Google-Smtp-Source: AGHT+IG2r58Fk3NA3qR81ukfbE2s31irRsv2remuPcZFqo6brrKgODOh88/Pox0h2KHzwYsKGQ8ccA==
X-Received: by 2002:a05:6e02:1c23:b0:3d3:fbf9:194b with SMTP id e9e14a558f8ab-3d48397e87amr53988045ab.0.1742048858723;
        Sat, 15 Mar 2025 07:27:38 -0700 (PDT)
Received: from [10.211.55.5] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a6475cfsm15623435ab.13.2025.03.15.07.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 07:27:38 -0700 (PDT)
Message-ID: <3c6bc732-bd90-4a29-bcbc-f545b0ed79ad@riscstar.com>
Date: Sat, 15 Mar 2025 09:27:36 -0500
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EISA: Increase length of device names
To: Kees Cook <kees@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>, Alex Elder <elder@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, alx@kernel.org
References: <20250310222424.work.107-kees@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250310222424.work.107-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/25 5:24 PM, Kees Cook wrote:
> GCC 15's -Wunterminated-string-initialization warned about truncated
> name strings. Instead of marking them with the "nonstring" attribute[1],
> increase their length to correctly include enough space for the
> terminating NUL character, as they are used with %s format specifiers.
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
> Cc: Alex Elder <elder@kernel.org>

This was interesting, but based on the bug text I suspect you
meant to address this to Alejandro Colomar, <alx@kernel.org>.

For what it's worth, it looks fine to me.

					-Alex

> Cc: Sumit Garg <sumit.garg@kernel.org>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>   drivers/eisa/eisa-bus.c | 2 +-
>   include/linux/eisa.h    | 4 +++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/eisa/eisa-bus.c b/drivers/eisa/eisa-bus.c
> index cb586a362944..edceea083b98 100644
> --- a/drivers/eisa/eisa-bus.c
> +++ b/drivers/eisa/eisa-bus.c
> @@ -21,7 +21,7 @@
>   
>   struct eisa_device_info {
>   	struct eisa_device_id id;
> -	char name[50];
> +	char name[EISA_DEVICE_INFO_NAME_SIZE];
>   };
>   
>   #ifdef CONFIG_EISA_NAMES
> diff --git a/include/linux/eisa.h b/include/linux/eisa.h
> index f98200cae637..c73a410bf88f 100644
> --- a/include/linux/eisa.h
> +++ b/include/linux/eisa.h
> @@ -28,6 +28,8 @@
>   #define EISA_CONFIG_ENABLED         1
>   #define EISA_CONFIG_FORCED          2
>   
> +#define EISA_DEVICE_INFO_NAME_SIZE	51
> +
>   /* There is not much we can say about an EISA device, apart from
>    * signature, slot number, and base address. dma_mask is set by
>    * default to parent device mask..*/
> @@ -41,7 +43,7 @@ struct eisa_device {
>   	u64                   dma_mask;
>   	struct device         dev; /* generic device */
>   #ifdef CONFIG_EISA_NAMES
> -	char		      pretty_name[50];
> +	char		      pretty_name[EISA_DEVICE_INFO_NAME_SIZE];
>   #endif
>   };
>   

