Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AD73655CE
	for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781909938; cv=none; b=D4ypGvwxUm3dPL4/N/5REDOpjG5sHkY5T/225nIqGAfdGMcjDydJPuYuDeO0JQlKx4JOvwdfgXBqkF7ZPPjZZygA6R3rNwHCDvWwbQD4bJDf1kLRU25uL3rqHEBDx8QcHS4sUJAHFS80aEU7IfzMt2bgIBREwJfmahB4SMzpBEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781909938; c=relaxed/simple;
	bh=P44btkX/5G9W5QhX0wBooqqGpL5H58AxXskj6RX48zk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i0IQwlgkrOdrzuH8wAttCKNNpQyH+PkO8vMtncjB9viz8xKPy/X6B7D5gbPcuwPM50S/HpoknyUsr+UAMzyrMpgSXJOpD1e8X6pCJplmdNokzaxAP4Y+rQC4Fau6GFMpx085An8solsn2A9oRknp6rlRzfSL3rmSPLQXd4kVDGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so20524635e9.0
        for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 15:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781909934; x=1782514734;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07lVSutuBZtSqSTP2+DZuX+nW0UInURGUViWnvtWS0g=;
        b=pO38EbwbegR1fOh7ZmnPlYLNvrIuc83yGQbqU6mFGXBS8rQAy4ZVPF3R7AwZ1NeP2J
         BHqWlVSROATjQZPzJpdGbTYLJ7Ic98MFYd2IXfAy1OE1U2f0nOhpD2bO965/6t96HlVN
         36F62gdkErWyO65dat/ecfNdttAQbs6Zbg5QQne4/wDU27rtZANYA3rbcAVuxGG51zSG
         I3CzBmx4atu+rUaCmpo8ifqxuG5RMrgd1cDm/iAAtnwyvV66fnuf51LtAes8IZQEOZ0z
         a8S0kiDVOYsC6jLfcjvm2qJilqSTiPo6LzUm+7LhNYCGGLe1iSAVtRzuBcq3+DVDLOqC
         Ppgw==
X-Forwarded-Encrypted: i=1; AFNElJ8z3GhhfpDTRyfw9o6dfiULw3hGzY4P942RWVlMMl6KAp4eRMESc7n8cZOXrTrfMdLLZ3yStK9LYy50ycQ1mLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxrw0xSZimKvfrMyJhDUuRlYmQDEY0X+mi+459pzLURkyOg+A0
	1I7E9D1lPQOCxgr4sbvPWrIEgG0FbwA4w79ChHP7i+c64t6X9Nn1nhXw
X-Gm-Gg: AfdE7ckcf7bE/Fu/r5xkN0JdeN2p2a6KnNl10Tmrqqo37YuXTDor/CMsZoMvoRPwmaU
	vnyq+6s9McgVPgLr0ItEFfezz5R62Zmbj2PnoTR+TLHDvQWMVwBG5rN0ZEnqiHMG+IjVNx1Ebtk
	CP4CB9/lXHEExBtA3/wPZAer9bimu61fioN3C0LsyYmD2uRhJkq824cf6Zoj9fyirA5peCRhK7r
	P0x3fVlWohRnxgn4oEQZgWFV53mJJYYV7XwMOhlcyCVc24pTL9taIeaXEbs8unoNrhBDAiGhphs
	pcEe+A4RYmOxlcTkXu9NuuZWiCt76aLRBZ3dY9OeO5j09tv+NwmJvC00yPingbOU/K1N+rnuTi4
	6vNKbV45xewNHV9KGZ1KZK0TeBvlPGAvmiVNrIJvP/OY1uQT+BHgHe0L2xw9XdrFT9SxFp6HJWJ
	J81Gm/uoHj6QU3DmZwhRGWl5hKaax3MmwTqa5aMOfgjN3AL0+7OO93TeE=
X-Received: by 2002:a05:600c:3e83:b0:492:3fb5:4697 with SMTP id 5b1f17b1804b1-492423140e0mr91571045e9.5.1781909934193;
        Fri, 19 Jun 2026 15:58:54 -0700 (PDT)
Received: from [192.168.88.241] (89-24-48-145.nat.epc.tmcz.cz. [89.24.48.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240eef2basm98973675e9.2.2026.06.19.15.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 15:58:53 -0700 (PDT)
Message-ID: <d967e161-f0a8-434f-9f71-a8838b8576ac@ovn.org>
Date: Sat, 20 Jun 2026 00:58:51 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev, Johan Thomsen <write@ownrisk.dk>
Subject: Re: [PATCH net] net: dst_metadata: fix false-positive memcpy overflow
 in tun_dst_unclone
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, netdev@vger.kernel.org
References: <20260616100332.1308294-1-i.maximets@ovn.org>
 <9e941b82-23d4-44e6-a240-b7949ace76ab@embeddedor.com>
 <b16e8bac-e149-4052-b1cb-8fd3e1137f9c@ovn.org>
 <a95aabe9-6294-42ed-8327-b7d74bb4a8c8@embeddedor.com>
 <13b922ce-8450-48fd-adf7-5377989fb6e4@embeddedor.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <13b922ce-8450-48fd-adf7-5377989fb6e4@embeddedor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/18/26 6:02 AM, Gustavo A. R. Silva wrote:
> 
> 
> On 6/17/26 16:59, Gustavo A. R. Silva wrote:
>>
>>
>> On 6/17/26 16:01, Ilya Maximets wrote:
>>> On 6/17/26 10:08 PM, Gustavo A. R. Silva wrote:
>>>> Hi,
>>>>
>>>> On 6/16/26 04:03, Ilya Maximets wrote:
>>>>> kmalloc_flex() in metadata_dst_alloc() sets __counted_by for the
>>>>> structure to the options_len, which is then initialized to zero.
>>>>> Later, we're initializing the structure by copying the tunnel info
>>>>> together with the options, and this triggers a warning for a potential
>>>>> memcpy overflow, since the compiler estimates that the options can't
>>>>> fit into the structure, even though the memory for them is actually
>>>>> allocated.
>>>>>
>>>>>    memcpy: detected buffer overflow: 104 byte write of buffer size 96
>>>>>    WARNING: CPU: X PID: Y at lib/string_helpers.c:1036 __fortify_report
>>>>>     skb_tunnel_info_unclone+0x179/0x190
>>>>>     geneve_xmit+0x7fe/0xe00
>>>>
>>>> This warning has nothing to do with counted_by. See below for more
>>>> comments.
>>>>
>>>>>
>>>>> The issue is triggered when built with clang and source fortification.
>>>>>
>>>>> Fix that by doing the copy in two stages: first - the main data with
>>>>> the options_len, then the options.  This way the correct length should
>>>>> be known at the time of the copy.
>>>>>
>>>>> It would be better if the options_len never changed after allocation,
>>>>> but the allocation code is a little separate from the initialization
>>>>> and it would be awkward and potentially dangerous to return a struct
>>>>> with options_len set to a non-zero value from the metadata_dst_alloc().
>>>>>
>>>>> Another option would be to use ip_tunnel_info_opts_set(), but it is
>>>>> doing too many unnecessary operations for the use case here.
>>>>>
>>>>> Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
>>>>> Reported-by: Johan Thomsen <write@ownrisk.dk>
>>>>> Closes: https://lore.kernel.org/netdev/CAKv6aAM8_EWgXScnKmKYm_4SwGDVBK++dzfP+Y6msUXbp99QUw@mail.gmail.com/
>>>>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
>>>>> ---
>>>>>
>>>>> Johan, if you can test this one in your setup as well, that would
>>>>> be great.  Thanks.
>>>>>
>>>>>    include/net/dst_metadata.h | 7 +++++--
>>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
>>>>> index 1fc2fb03ce3f..f45d1e3163f0 100644
>>>>> --- a/include/net/dst_metadata.h
>>>>> +++ b/include/net/dst_metadata.h
>>>>> @@ -164,8 +164,11 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
>>>>>        if (!new_md)
>>>>>            return ERR_PTR(-ENOMEM);
>>>>> -    memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
>>>>> -           sizeof(struct ip_tunnel_info) + md_size);
>>>>
>>>> What's going on here is that, internally, fortified memcpy() retrieves
>>>> the destination size via __builtin_dynamic_object_size() in mode 1.
>>>>
>>>> That is:
>>>>
>>>> __builtin_dynamic_object_size(&new_md->u.tun_info, 1)
>>>>
>>>> For the above case, Clang returns sizeof(new_md->u.tun_info) == 96.
>>>>
>>>> So the warning is reporting that 104 bytes don't fit in an object of
>>>> size 96 bytes, regardless of any counted_by annotation or allocation.
>>>
>>> Hmm.  Does __builtin_dynamic_object_size(&new_md->u.tun_info, 1) return
>>> 104 when the options_len is 8?  If so, isn't that because it is counted
>>> by that field?  Asking because the fortification doesn't complain if we
>>> keep the full 104-byte copy as-is, but set the options_len beforehand,
>>> as tested by Johan.
>>
>> I see. If that is the case, then, internally, fortified memcpy() ends up
>> using mode 0 instead of mode 1. Something like this:
>>
>> __builtin_dynamic_object_size(&new_md->u.tun_info, 0)
>>
>> The above will effectively consider the allocation and counted_by because
>> it will interpret new_md->u.tun_info as an open-ended object due to the
>> flexible-array member (in struct ip_tunnel_info) whose size is determined
>> by counted_by.
> 
> Indeed. The execution stops here:
> 
> fortify_memcpy_chk():
> 588         /*
> 589          * Always stop accesses beyond the struct that contains the
> 590          * field, when the buffer's remaining size is known.
> 591          * (The SIZE_MAX test is to optimize away checks where the buffer
> 592          * lengths are unknown.)
> 593          */
> 594         if (p_size != SIZE_MAX && p_size < size)
> 595                 fortify_panic(func, FORTIFY_WRITE, p_size, size, true);
> 
> with p_size = __builtin_dynamic_object_size(&new_md->u.tun_info, 0)
> 
> The code never reaches the part where p_size_field (__bdos(&new_md->u.tun_info, 1))
> is checked at runtime because there is no need for that.
> 
> So yep, this patch is okay as-is.

Ack.  Thanks for looking into this!

Best regards, Ilya Maximets.
