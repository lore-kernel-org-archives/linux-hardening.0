Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03E031F990
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012381; cv=none; b=EBIVnKY+t2T2DiMyOkM+z4tE9QH0yBbcxhlWaxTy7Hr87y8B/cGJcVyR6ewk+dtbnqh1Ijk5BhqvBrskMiAbDcsV22l3IeH/8oQm8GybBwQB+5zeQuyumLWgWsX0ZwUFK7i32t5xU+iRWTmADzVeH4uWaWKVSOdvgcrNGXXaoZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012381; c=relaxed/simple;
	bh=wtjPJAnglYI9Dj7GB9EESnje7qeI4+zON/gDJ4GXSSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WEOmhDOs2ckut7zbOeNEVT94rxVXcAlOmNdAw/ckj0tjpQpWCGfh2eMJRAUT9mMbuAUjNPXHEYUTHrJJ9x0IZOPsl11ulR/HtU35Xz8XM9wZBrX/sphHdJetWAVVsKfZ0UKn+TAc6mRDUT+vZUmMwLzRmgjC6qJRZvO7pYei6xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eN1SA366; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eN1SA366"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781012379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=midNIA+cjqOgSDgw/FW1wAANg34nkC9zllETKh3Fse0=;
	b=eN1SA366aFYm+84xKYEh+ClxPJWFDmXHDVY1gCk+/aY2YiYjlYsHlAq/l/HkhyvME/153N
	Ae5K+Ys07dMVEx439LVSwOEVtfPZbbCde+l6iPpLBm9/OOuQBXtAA2yjJRQ0UVPRj0L52i
	pLDKZ10Scx7kcbNCMSFTw5RHxpL3ipg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-18RPdNaTPEuCPZHsw3Emgw-1; Tue, 09 Jun 2026 09:39:38 -0400
X-MC-Unique: 18RPdNaTPEuCPZHsw3Emgw-1
X-Mimecast-MFC-AGG-ID: 18RPdNaTPEuCPZHsw3Emgw_1781012377
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef5e38a18so2594367f8f.1
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 06:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781012377; x=1781617177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=midNIA+cjqOgSDgw/FW1wAANg34nkC9zllETKh3Fse0=;
        b=pNRkWiQtYZG9nMmK3jno7hDOU3fklK50JEoi51HNO9SpWs9JzrsZkAVoQSAXR+9Gji
         eGq75hOWxd8f/jrF/VC3+I4vzn7KHaCoU2TnAF1tyEfFWe0IhuTcdPdzFQORSER+XIZ/
         H5OwJKW+1Sv+DQqaYn4RlrDzFHVr/pervplek0CjZDRj0Unf+XyDQHeqn0dqHlbItuW1
         x0solcsUYLn5TXkk+YjZauB4j/LYmy0aZjivvpXI9rYMu3rpyfGmD+BpuxQDdSRw8RqK
         gYh/lUtkKpqcobK33BT/Ye2BlfDZyU9IDCPnyoKsYSTCTB8ArGQ3pTN3+09Dysl+j7TV
         mo9A==
X-Forwarded-Encrypted: i=1; AFNElJ/xM+qmhv/ZHamSB6cqIyJfDGEeh3BcKFhLbDJt5D+w0r31B5mXiYoepRA1CGCiC3FJgOoFE9Z0a302Wzo+fks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOb0tAq/3DWn3dZP2T8YbCDD6HawidM4eyKDHgL1qpyDDKbqNE
	5FAckMjdSFB0PtJ/0N4Zh7fYdSF5Txf6BIMr+sokJ6mE76Xe4Zztik3Tj59f0dCz8mZCO7xUeVP
	yovT7wrEiIYN2QUrzdYGYHqhn6UipM5YOmoBRxAngX/AcuEhsgD/+P9LRfgp/vNSWu31t0g==
X-Gm-Gg: Acq92OHeBv3Emv2mHygOYTtUjVRCx6TZrKlaEd7foSOgklFMzJgrX7XZG1rM6TtODiX
	z3kOcWYzo4V5+LlMhTgh28/l+RyNpUHSPxV5Rq/meZ4LxYCBzFfLrKEfd4xTB0vf/FhDKGw+Ux4
	oHKOlRUbqAeFZLSToKiXuzg42fMrd6EDm5mfMRXWSSGclj2Lkp8j52FJkaRA7GuOkKZS1At2tQv
	4CTFXwn3xcOYwPUxYdjhBHRtOuOryPDOkVT8f57mvKIRYtJkLuoGivlGNIpQv8aq53nuXO0Fhed
	iohRp49g7UdZJwL3EEEgt57aquMzWyOBsqXiyAeGoFyo8DhAZ5n9vmJPQVjHxtzg4w7Zp01g1HP
	MSKlEK0zaL0uCD57Un6secKGc+dDhN0gvQvmdHsUK4rnaUYOU6FF7TvjtRSlSR98jXQ==
X-Received: by 2002:a5d:5270:0:b0:460:edd:ca89 with SMTP id ffacd0b85a97d-460306091e6mr24183888f8f.26.1781012377352;
        Tue, 09 Jun 2026 06:39:37 -0700 (PDT)
X-Received: by 2002:a5d:5270:0:b0:460:edd:ca89 with SMTP id ffacd0b85a97d-460306091e6mr24183842f8f.26.1781012376909;
        Tue, 09 Jun 2026 06:39:36 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344762sm67110899f8f.23.2026.06.09.06.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 06:39:36 -0700 (PDT)
Message-ID: <c6eb816c-3f2d-4705-82ea-8c2c0ad70ded@redhat.com>
Date: Tue, 9 Jun 2026 15:39:35 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/devlink: Use strscpy() to copy strings into
 arrays
To: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>
References: <20260608095523.2606-13-david.laight.linux@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260608095523.2606-13-david.laight.linux@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6X5gtV6mXrFFITS7eRnNTIBw686GxCj3wE6g8urxCvY_1781012377
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/8/26 11:54 AM, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Replacing strcpy() with strscpy() ensures that overflow of the target
> buffer cannot happen.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
> 
> They are mostly replaced by strscpy() or, when strlen() has just been
> called, with memcpy() (usually including the '\0').
> 
> Calls with copy string literals into arrays are left unchanged.
> They are safe and easily detected as such.
> 
> The changes were made by getting the compiler to detect the calls and
> then fixing the code by hand.
> 
> Note that all the changes are only compile tested.
> 
> Some Makefiles were changed to allow files to contain strcpy().
> As well as 'difficult to fix' files, this included 'show' functions
> as they really need to use sysfs_emit() or seq_printf().
> 
> All the patches are being sent individually to avoid very long cc lists.
> Apologies for the terse commit messages and likely unexpected tags.
> (There are about 100 patches in total.)
> 
>  net/devlink/port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/devlink/port.c b/net/devlink/port.c
> index 485029d43428..108926d3f899 100644
> --- a/net/devlink/port.c
> +++ b/net/devlink/port.c
> @@ -1222,7 +1222,7 @@ static void __devlink_port_type_set(struct devlink_port *devlink_port,
>  			devlink_port->type_eth.ifindex = netdev->ifindex;
>  			BUILD_BUG_ON(sizeof(devlink_port->type_eth.ifname) !=
>  				     sizeof(netdev->name));
> -			strcpy(devlink_port->type_eth.ifname, netdev->name);
> +			strscpy(devlink_port->type_eth.ifname, netdev->name);

Given the above BUILD_BUG, I don't see how this change can help?!?

Generally speaking, I suggest restricting this kind of tool-assisted
changes to real problems (if any).

Thanks,

Paolo

