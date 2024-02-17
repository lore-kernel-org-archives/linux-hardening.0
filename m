Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56A11E880
	for <linux-hardening@vger.kernel.org>; Sat, 17 Feb 2024 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708204745; cv=none; b=O5ePKbcdOWZfFjvSW+CKZ8pDw9Pcn0HiBSzKLariHydt1buFA+JE2gnD+DApJk266ISgwLo7F+oEhd4BEU8pAwuhgs6rKzQym9cxsxB5MzAPnyzuMw3Fk1OKJbO97RRj0f0O2VimpJlWw1Qpa8miWPS61tC25sfdZNLFALu9OLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708204745; c=relaxed/simple;
	bh=jqmSZE/6hIL7tHTUq7XBmsqEMOHIxcazTD9D7B73dnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rG5VdI2jTCWRndHJwNeXc1vK2uX6M2PEmX7dvkuff3mAWOiZqExrPMXVNdT5WqhbuAEUSdMWwORtikhpDsezH6xzx9spV9yZfcrPfq71BXg3gUgGOtFPbiu/MgPm5a77ZD4ENhIRRzzVyyroA7rbQvUUcfVRrvcGh+HPCh+oo+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=fRjUtNWb; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="fRjUtNWb"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7874a96a0a8so85306285a.1
        for <linux-hardening@vger.kernel.org>; Sat, 17 Feb 2024 13:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1708204742; x=1708809542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jsUAb6vb40+XemerMiSmb6ZuxYzXcwGlQ49c+yrXOkw=;
        b=fRjUtNWbyUcxuRIkCB0gXWYH6TIvfHCtO29QgX3+Ws+ceUgFRqNzEYiutvsEmoBBYM
         ypJp25oScrs8hIJBClbEkerQf+Um4HRE0GUZ+JrpN8Pzx8C4G5JwFfJKXVuZvVFP+MIG
         f+tCQxLCGwwjS0d5d8xqHaIMgDw958TM+cDl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708204742; x=1708809542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsUAb6vb40+XemerMiSmb6ZuxYzXcwGlQ49c+yrXOkw=;
        b=RXBtQYo7sDt3InVymjUh/FbXaw++tgDw7XcnAS4USV1FvA5Byf9zplPvm4fhMqXjco
         Icu03UK++aM54BQs5osEd+LHg/2m02WUwM+PuK4SerXFdlCdKEEULbd66Jlt3quGJdiU
         iQX79wlODfUhKDL4UOkfRf+sTAZYpxPEHhxc7O4tp8u59x5YgD0dJ8299wvgUZx+Do+k
         PfK/F0YxufHopwv5jzoqpDn/fh+swfIZxRqF2agLtZ5gh44Xr4faLXbFYx/e2pD6OkPM
         4gGodjaPGZqOldTKkv2YF0d5vjJv0slzXhahI3Tw2+/6Cf5DJOlUlQg5XM6PKP4stqt1
         i/IA==
X-Forwarded-Encrypted: i=1; AJvYcCVGK/zrjj5ycHf23idTf0CPzmDNJ2lpe9ZHzx9fIxs9NDj7eefhJwAMWIO2N2faYD5vP+GEQmPRJxDG4uRcdJ25CoK2quCXVtSNbAKwnZ38
X-Gm-Message-State: AOJu0YwDCMA8taz96bdwEdOA1NhTucLfalUbd9KnYqWYRViqKdkbit9M
	TK47yDkGsW6BWSkXQgXMicLxowI85fpqu8b/b9QqPAB2KECRZ1TryuaUfKAimg==
X-Google-Smtp-Source: AGHT+IGP14v6oCCtMP0+vugRbMd2i51vK0hqWp5NBXjAY0xKJajqQMGwjum2Jn2GI6G56nWQ9lc40Q==
X-Received: by 2002:a05:620a:46ab:b0:787:538c:58cb with SMTP id bq43-20020a05620a46ab00b00787538c58cbmr4663545qkb.28.1708204741830;
        Sat, 17 Feb 2024 13:19:01 -0800 (PST)
Received: from [10.211.55.3] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id c3-20020a05620a11a300b00785d7f634bcsm1116200qkk.8.2024.02.17.13.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 13:19:01 -0800 (PST)
Message-ID: <02cf87a3-4e92-4f6d-98f6-dfc0e198d462@ieee.org>
Date: Sat, 17 Feb 2024 15:18:59 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] greybus: audio: apbridgea: Remove flexible array from
 struct audio_apbridgea_hdr
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>,
 Vaibhav Agarwal <vaibhav.sr@gmail.com>, Mark Greer <mgreer@animalcreek.com>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <keescook@chromium.org>
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240217154758.7965-1-erick.archer@gmx.com>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20240217154758.7965-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/17/24 9:47 AM, Erick Archer wrote:
> When a struct containing a flexible array is included in another struct,
> and there is a member after the struct-with-flex-array, there is a
> possibility of memory overlap. These cases must be audited [1]. See:
> 
> struct inner {
> 	...
> 	int flex[];
> };
> 
> struct outer {
> 	...
> 	struct inner header;
> 	int overlap;
> 	...
> };
> 
> This is the scenario for the "struct audio_apbridgea_hdr" structure
> that is included in the following "struct audio_apbridgea_*_request"
> structures:

Yeah this was not a very good way to define these header
structures, but I'm glad to hear the flexible array at the
end was never used.  I don't know why it was there; maybe
it's an artifact from some other information that got removed.

If the code compiles with your change, it ought to be fine.
(It compiles for me.)

It would be good for Vaibhav or Mark to comment though, maybe
they can provide some context.


> 
> struct audio_apbridgea_set_config_request
> struct audio_apbridgea_register_cport_request
> struct audio_apbridgea_unregister_cport_request
> struct audio_apbridgea_set_tx_data_size_request
> struct audio_apbridgea_prepare_tx_request
> struct audio_apbridgea_start_tx_request
> struct audio_apbridgea_stop_tx_request
> struct audio_apbridgea_shutdown_tx_request
> struct audio_apbridgea_set_rx_data_size_request
> struct audio_apbridgea_prepare_rx_request
> struct audio_apbridgea_start_rx_request
> struct audio_apbridgea_stop_rx_request
> struct audio_apbridgea_shutdown_rx_request
> 
> The pattern is like the one shown below:
> 
> struct audio_apbridgea_hdr {
> 	...
> 	__u8 data[];
> } __packed;
> 
> struct audio_apbridgea_*_request {
> 	struct audio_apbridgea_hdr hdr;
> 	...
> } __packed;
> 
> In this case, the trailing flexible array can be removed because it is
> never used.
> 
> Link: https://github.com/KSPP/linux/issues/202 [1]
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
> Hi everyone,
> 
> I'm not sure this patch is correct. My concerns are:
> 
> The "struct audio_apbridgea_hdr" structure is used as a first member in
> all the "struct audio_apbridgea_*_request" structures. And these last
> structures are used in the "gb_audio_apbridgea_*(...)" functions. These
> functions fill the "request" structure and always use:
> 
> 	gb_hd_output(connection->hd, &req, sizeof(req),
> 		     GB_APB_REQUEST_AUDIO_CONTROL, true);
> 
> Then, the "gb_hd_output(struct gb_host_device *hd, ...)" function calls:
> 
> 	hd->driver->output(hd, req, size, cmd, async);
> 
> The first parameter to this function is of type:
> 
> 	struct gb_host_device {
> 		...
> 		const struct gb_hd_driver *driver;
> 		...
> 	};
> 
> And the "gb_hd_driver" structure is defined as:
> 
> 	struct gb_hd_driver {
> 		...
> 		int (*output)(struct gb_host_device *hd, void *req, u16 size, u8 cmd,
> 			      bool async);
> 	};
> 
> Therefore, my question is:
> Where is the "output" function pointer set? I think I'm missing something.

I think it will be drivers/greybus/es2.c:output().

But in any case, the output function will know nothing about
the structure of the request, so I think it's unrelated to
the change you're proposing.

Johan can confirm this.

I'd like to hear from these others, but otherwise this change
looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> I have search for another greybus drivers and I have found that, for
> example, the "es2_ap_driver" (drivers/greybus/es2.c) sets the "output"
> member in:
> 
> 	static struct gb_hd_driver es2_driver = {
> 		...
> 		.output	= output,
> 	};
> 
> I think that the flexible array that I have removed should be used in
> the function assigned to the "output" function pointer. But I am not
> able to find this function.
> 
> A bit of light on this would be greatly appreciated.
> 
> Thanks,
> Erick
> ---
>   drivers/staging/greybus/audio_apbridgea.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/audio_apbridgea.h b/drivers/staging/greybus/audio_apbridgea.h
> index efec0f815efd..ab707d310129 100644
> --- a/drivers/staging/greybus/audio_apbridgea.h
> +++ b/drivers/staging/greybus/audio_apbridgea.h
> @@ -65,7 +65,6 @@
>   struct audio_apbridgea_hdr {
>   	__u8	type;
>   	__le16	i2s_port;
> -	__u8	data[];
>   } __packed;
> 
>   struct audio_apbridgea_set_config_request {
> --
> 2.25.1
> 

