Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993992D9ECA
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316775; cv=none; b=f62a4chE4NnM3rKzgxnSAH1HuuogtC4N82L4g0hu3HPXJhT04322u5Q2x98bZ3zlhk0497EWnj9F6gIe9hXOWLpArq6011yxzfuGK0cmAIOrZ/7vYAogR5whH2ZkLa2HBpWP/lpW5tdzzJAtLxRf+p2u1+8ZWr5zvn5OqN03uSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316775; c=relaxed/simple;
	bh=s+CuNh8nN+c3duGNNJwpTmjqk55xK0VXgzFyC6AyLv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AzQ4kCsX5cuLizGaSbluvpEF3YN1WsTtqVBpI7CXY4VoVCZBuNMXZlRaGtQo6e19RyAVqXOorJXAckQihW5VfgTVmD7e3Z9OY7jxyvekGwIsqQ9I8mjF/xZZ0qFiYGiowvVTacJGvjRkN/QuTg4MjcC1Gau5oZyrSQw3wXlM22A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HoSf46pG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoSf46pG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768316772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDwCw69rb94qC+LZlvI4uRVvjhNJWGT4TLlWN2hOUDk=;
	b=HoSf46pGj8V6vkSSS6EBxUMIPDwLss1VqKrc9+2g4X80PcTNzykBSH0NxriMB33ZN5qpPC
	bYCY46wwn5/JvMVOw1n2EBwD39g91HQw+Bjg3JM/xNFvCB3G5fo76rPLd6UC1xO1FgrS6m
	h7TlG4xqVsjdsdMNfIsuHVRndVcMTJE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-BuTY3C09PNWa4BtLOeNhUA-1; Tue, 13 Jan 2026 10:06:09 -0500
X-MC-Unique: BuTY3C09PNWa4BtLOeNhUA-1
X-Mimecast-MFC-AGG-ID: BuTY3C09PNWa4BtLOeNhUA_1768316768
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d28e7960fso78343875e9.0
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 07:06:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768316768; x=1768921568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDwCw69rb94qC+LZlvI4uRVvjhNJWGT4TLlWN2hOUDk=;
        b=uDinjZRglNbVKVSfXU9VBNkfWp2cc7lyq8g0VKSm7L9XfSCffsLrbX9w+vVsBj3YIn
         Cpw11DBU452CM+SOEGwIzqAA7SjNxDl7WusczdDXiql+uiKhP5QQ4k0aWuMKlG52Lsxg
         xBLxWrwscQQ+8nzlrSW4WA4nmYvhWbtbSFAbWprmRyya6U1omt6DkgAMmKsCYVbadQRO
         wuw0RwnzRYJPls+qP4IsagLcKAH+xWK3oAJlADG97WSmQIr1KvpHUAL9Dtlp95fwwHsD
         +lcdz63fyS+aalaZkkJPadS9uUApUUANuhsD26bmwSO7H8GMfX5QxIC5a8qbPfhf6ELU
         lcBA==
X-Forwarded-Encrypted: i=1; AJvYcCUlVebXccJy/nwjQ5c5XEOlzo8NmjS//gDRq92pRijfiXyxibj8Z0AeLj8rMt7fQRVM4WDFK1yufxkG2JIEvdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz6m5C+SrjWy5HRn3x++DjBud29rXjhFYLqvf3oED91jN6WUtS
	kxc+mfu1UfeEDeMZCH+u+1QSe2zQYfE/4bLJ2zzWVr8zy8NUo07oaCV/bm10mc47iwB8+f3X8T4
	OSMCCu8FwKoDTi4oldAJS0hFaM/dNRpfXbHyOCSrGo7BRUa1JARLp5BrwTbTnQovUD7zBZQ==
X-Gm-Gg: AY/fxX65jdjYgmST7G3LpeQtKuyVJcJCQRCnCjk6x+E7aGnc1NVOE6zFCSrO6R8yBYH
	ysxpiL/SjLdmkeDZ8SGyccLlB5CQsA5ewxjOCUzzey2UbUhW9QRsRzARoNDOiDO/d44/5y9xTEj
	z6/NRmlx14+yEj9bYLRYsuttSztIpuMRWV5ba/+bi4qKmmb1iinjAmPJ/96w8OzwnFooKcClw4F
	yhZX7HZVTw011MyXaZNTxNn5zJh894ebkPzS7YDxccFmJJ168cThxYP9M4wlLuc1ifGs0yYG2vR
	VTueWCCK9OMuQu02uwtZPhlwRRXSVeO+g/7PLq0hsObeALeonibqPHbn7PYH2uGu2fgjcFcifdC
	ya0kyQoHze1B2
X-Received: by 2002:a05:600c:3556:b0:479:33be:b23e with SMTP id 5b1f17b1804b1-47d84b3b4eamr286985245e9.17.1768316767888;
        Tue, 13 Jan 2026 07:06:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSrRyHk6thUAyQczy6/cI8N/GQqeafVlq48pG73G8dfSC1NPPmKMlwELspqzYKhAl9nUej4w==
X-Received: by 2002:a05:600c:3556:b0:479:33be:b23e with SMTP id 5b1f17b1804b1-47d84b3b4eamr286984645e9.17.1768316767454;
        Tue, 13 Jan 2026 07:06:07 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee1189f5fsm2255445e9.2.2026.01.13.07.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 07:06:06 -0800 (PST)
Message-ID: <916a6c1a-681e-4e5e-8d49-75d0de5c46a1@redhat.com>
Date: Tue, 13 Jan 2026 16:06:05 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] virtio_net: Fix misalignment bug in struct
 virtnet_info
To: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>
References: <aWIItWq5dV9XTTCJ@kspp>
 <e9607915-892c-4724-b97f-7c90918f86fe@redhat.com>
 <20260113093839-mutt-send-email-mst@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260113093839-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AaEK7BqOXgxyFvl4jx8Bu5CWjE9auVfI0dslbDUrgxM_1768316768
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/26 3:39 PM, Michael S. Tsirkin wrote:
> On Tue, Jan 13, 2026 at 03:30:00PM +0100, Paolo Abeni wrote:
>> On 1/10/26 9:07 AM, Gustavo A. R. Silva wrote:
>>> Use the new TRAILING_OVERLAP() helper to fix a misalignment bug
>>> along with the following warning:
>>>
>>> drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>>
>>> This helper creates a union between a flexible-array member (FAM)
>>> and a set of members that would otherwise follow it (in this case
>>> `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
>>> overlays the trailing members (rss_hash_key_data) onto the FAM
>>> (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
>>> The static_assert() ensures this alignment remains.
>>>
>>> Notice that due to tail padding in flexible `struct
>>> virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
>>> (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
>>> offset 84 in struct virtnet_info) are misaligned by one byte. See
>>> below:
>>>
>>> struct virtio_net_rss_config_trailer {
>>>         __le16                     max_tx_vq;            /*     0     2 */
>>>         __u8                       hash_key_length;      /*     2     1 */
>>>         __u8                       hash_key_data[];      /*     3     0 */
>>>
>>>         /* size: 4, cachelines: 1, members: 3 */
>>>         /* padding: 1 */
>>>         /* last cacheline: 4 bytes */
>>> };
>>>
>>> struct virtnet_info {
>>> ...
>>>         struct virtio_net_rss_config_trailer rss_trailer; /*    80     4 */
>>>
>>>         /* XXX last struct has 1 byte of padding */
>>>
>>>         u8                         rss_hash_key_data[40]; /*    84    40 */
>>> ...
>>>         /* size: 832, cachelines: 13, members: 48 */
>>>         /* sum members: 801, holes: 8, sum holes: 31 */
>>>         /* paddings: 2, sum paddings: 5 */
>>> };
>>>
>>> After changes, those members are correctly aligned at offset 795:
>>>
>>> struct virtnet_info {
>>> ...
>>>         union {
>>>                 struct virtio_net_rss_config_trailer rss_trailer; /*   792     4 */
>>>                 struct {
>>>                         unsigned char __offset_to_hash_key_data[3]; /*   792     3 */
>>>                         u8         rss_hash_key_data[40]; /*   795    40 */
>>>                 };                                       /*   792    43 */
>>>         };                                               /*   792    44 */
>>> ...
>>>         /* size: 840, cachelines: 14, members: 47 */
>>>         /* sum members: 801, holes: 8, sum holes: 35 */
>>>         /* padding: 4 */
>>>         /* paddings: 1, sum paddings: 4 */
>>>         /* last cacheline: 8 bytes */
>>> };
>>>
>>> As a result, the RSS key passed to the device is shifted by 1
>>> byte: the last byte is cut off, and instead a (possibly
>>> uninitialized) byte is added at the beginning.
>>>
>>> As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
>>> moved to the end, since it seems those three members should stick
>>> around together. :)
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>> Changes in v2:
>>>  - Update subject and changelog text (include feedback from Simon and
>>>    Michael --thanks folks)
>>>  - Add Fixes tag and CC -stable.
>>
>> @Michael, @Jason: This is still apparently targeting 'net-next', but I
>> think it should land in the 'net' tree, right?
>>
>> /P
> 
> Probably but I'm yet to properly review it. The thing that puzzles me at
> a first glance is how are things working right now then?

Apparently they aren't ?!?

rss self-tests for virtio_net are failing:

https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/471521/15-rss-api-py/stdout

but the result is into the CI reported as success (no idea why?!?)

/P

