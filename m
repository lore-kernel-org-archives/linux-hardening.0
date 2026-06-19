Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917203655CE
	for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 22:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781909981; cv=none; b=nnkxhTqC/l/ut8I9eZGcFGRLyKb+xlFWMYyHJ9Zjxv0GaIxfckWunQcKyjpqXRDMVj/HPl0SpCTh4Djot+Ti6pH9PI3xGn0egJuYz1jTOFKYLOu8kbtB5b2I4EIJ/3Qhizgqf41KpOn8vDtwiGwdww/9HHYlUMAZMFdg9UVhg7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781909981; c=relaxed/simple;
	bh=e/2Mln5D8xK8owW5EsqOW6UQeKNFdUiXUtf1I2RtIXM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BY/PUP//diKFN61DMG9F0+wWcErRPNAwzjB8vlsukRL2uQts3tDuOVDBPDo3l6PXWYBWL0omNTng6u5KD+Pjz2aZk6+AHn2dX4IQyq76gvzzve8xwy1YIAyRD5lhlWCok+vv9oTGQVxmAF6sb0WDbU3L+vpjSnKWe+E8fyyXt/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4905529b933so24248055e9.0
        for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 15:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781909979; x=1782514779;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yddd8uAv1z7sx4dK+pzC6v0s9Mw+xioH8fNF+U4EgkE=;
        b=lHvGOWhR7DT+zhFsza2pg6RedpID+JypAjvWL8mcD70H1pVjXVvOk0aPqR5rbBeokq
         vTSzLxKRMAJUkfF5ymOvb/lXcZ5v8gp3X0Y7dN9+n743l2oYkpMAUFC03qZPatKhUn7n
         wI370dDmjXLO/tgpOzUuVP/4H36Iex1fL0n3b/VwHV3MWw9yJw2itbFxinfhQ5H2plCM
         EpfnTs7ac5YbUu/djf5+Tl5ZKyZE/CDgf6vk1bFinIms+26aK5mmTQUfZova0h7REyxz
         N+KGlTN/59b8llRKcJKSZfpNFx11mY7aOjk4X2dy6kwjp9sbDy8NCPeqhFuDMAAbRDeK
         CStw==
X-Forwarded-Encrypted: i=1; AFNElJ/lLZ8LfAQch4Lp++fNrzmOXEV7nI/qyByn0QmdGLFwtVAd4nIsF/2SvUc/8ble6ARLfdUWTNPvQ3dYi6MQWnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx03Ogs1T4eOgKTty01NxT2f+K6PZ07t2CXG5WZ04y8dXgVE3f/
	NlSoH9pOgR2U90BZuaZLtYMjq626v1pPpqbYpUDDQuN6asdL4s73PglJQUm65Al9
X-Gm-Gg: AfdE7cnSvUkN3+bcPGc8iYI6ZgC5BGB+fHS1LQgaile0mlt2fj7xP8gjy7DkaXklV8R
	+XTFWJshVIRMbVhPKfEb28VbS401ClnTY1IBdiq3pCEuHEMwXocPxxqmWau18jvnlOCmsFx7DMP
	U6Pu5b/o6PO8sD0h13rhbzJoyxe6iKd+MGMjuNQcyKWlf2Fsy9muGhWGz59tNuJTy7PXoloBPJU
	TUHejwuISTH/hMAbaZvKJrjY6+iMdfPfrFpsxxyT9tZSIERpUx34rT1mOz6qPM78gCvk23uiGeA
	/ozK/HTZE4arBpmNypvH4c3VC370tAsXIpu41q7Rp/7XYqsHWYz8Swl5dC1vgWMqRuPaadTf7nt
	vumUVDOakh8IfPCt2lgk+bR758PM9/tt061uxSuEJIwMk95vWVRpI8j9xT+TWkU03y/1lpwoJNM
	2u5jaGJOuaUSl5LT9QXYp9dWfsaXtCXIiXYFt5EiyyYbBL
X-Received: by 2002:a05:600c:63c7:b0:492:3fcb:22fe with SMTP id 5b1f17b1804b1-49240e23d55mr63479655e9.1.1781909978827;
        Fri, 19 Jun 2026 15:59:38 -0700 (PDT)
Received: from [192.168.88.241] (89-24-48-145.nat.epc.tmcz.cz. [89.24.48.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924923914fsm16164585e9.6.2026.06.19.15.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 15:59:38 -0700 (PDT)
Message-ID: <f6c22c4c-68fe-4bf8-96ab-97d191cbbd16@ovn.org>
Date: Sat, 20 Jun 2026 00:59:36 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH net] net: dst_metadata: fix false-positive memcpy overflow
 in tun_dst_unclone
To: Johan Thomsen <write@ownrisk.dk>
References: <20260616100332.1308294-1-i.maximets@ovn.org>
 <CAKv6aAMTqSo0qSng2Kv4=i6BSvJuUy9KSfeFRYx5JsYuo9=kqQ@mail.gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <CAKv6aAMTqSo0qSng2Kv4=i6BSvJuUy9KSfeFRYx5JsYuo9=kqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/26 1:43 PM, Johan Thomsen wrote:
>> Johan, if you can test this one in your setup as well, that would
>> be great.  Thanks.
>>
>>  include/net/dst_metadata.h | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
>> index 1fc2fb03ce3f..f45d1e3163f0 100644
>> --- a/include/net/dst_metadata.h
>> +++ b/include/net/dst_metadata.h
>> @@ -164,8 +164,11 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
>>         if (!new_md)
>>                 return ERR_PTR(-ENOMEM);
>>
>> -       memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
>> -              sizeof(struct ip_tunnel_info) + md_size);
>> +       /* Copy in two stages to keep the __counted_by happy. */
>> +       new_md->u.tun_info = md_dst->u.tun_info;
>> +       memcpy(ip_tunnel_info_opts(&new_md->u.tun_info),
>> +              ip_tunnel_info_opts(&md_dst->u.tun_info), md_size);
>> +
>>  #ifdef CONFIG_DST_CACHE
>>         /* Unclone the dst cache if there is one */
>>         if (new_md->u.tun_info.dst_cache.cache) {
> 
> Hi Ilya,
> 
> Sure. Just stressed it for 24 hours and - I cannot trigger the bug
> with this patch applied.

Thanks, Johan!

Best regards, Ilya Maximets.
