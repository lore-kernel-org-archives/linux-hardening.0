Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C235F2512C8
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314608; cv=none; b=X4BTwCeChwnrtQEudkLVFW9S3kevTeFPW5JVpPsnmHB7zvtjASVqmnzKltn6atijajkqFzQkLoKfGUeVGbSpdTPHf1Gd85tPn8ueBljtauFzfZlKtQoDn9mf6GTMHJS2bQ9RGte2JaeXJcodbn1i39y5iMagu/0P4nQSJjypcuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314608; c=relaxed/simple;
	bh=lHu6MXmC881GNys4A4x9dwsGJnuct71yJhITMvkSNBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHVbKQRxk3J/5uJgwy6Hcowz4SGkZ9RlyPYGTpdJNVUJVvZiMbNLmpJ8qJ5Scb7WIqArAi9uwvO2QIo1qyNzcVALxB1Rdgiih1sQkT/4WLtkuaXoSi74X1HTrMvVfuaJhOFU6RoUBqOHlVjNj8DTZiFGWHVysoWatCKwgpvQZJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFU/dZ1a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFU/dZ1a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768314605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BsGMLadexo/nCzuVTGjgLCJkB33PukmvAkeDyomNP3Y=;
	b=QFU/dZ1a8NlbMjuSzMe/cxMmRXci8UZAX8ttovMPSYp9vY9/AXgRhlZJGA3qI300cCHH68
	/32haXfWVOzWFrh0hJZZ6dNUjEFzvTcGXd2SjURrBqGD2/bPqsgNKARgpgmPiHm/S6IC3X
	5NO1RM6Z36Kp9nrqImlob0JiggukSGk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-IwzXFJpuN5CIZ1giJrJL4A-1; Tue, 13 Jan 2026 09:30:04 -0500
X-MC-Unique: IwzXFJpuN5CIZ1giJrJL4A-1
X-Mimecast-MFC-AGG-ID: IwzXFJpuN5CIZ1giJrJL4A_1768314603
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43101a351c7so6234475f8f.2
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 06:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768314603; x=1768919403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsGMLadexo/nCzuVTGjgLCJkB33PukmvAkeDyomNP3Y=;
        b=gqJ+0iZoqvZgnrXzufaTVU4IBTYzRJzfgCqs36gaeXyFiW5htN4VxUYZyffchxzSPV
         cBAGsv11TPQQpbOF9csMiRxIT29uzQddN2J/1NArz37MwCfzVu/O/0Jk0kPDDW2IWMwc
         PlDn2+eRCf4K4afGdlcsC8uE2w5lJ7CChzfuLU9jiLPz9EMXiu5Xi0Sru2hwmV9rvhNa
         impDdcA9vFRXtWyz0dQ07phzoyAgosJJPJCn6PJUI5JoovvRCiANHNYkRIq3Iag6L6ic
         4Cw5jbsBnWCT4aD3TDTLRn0pmrlg6EM2KXfCCcwFSZJXGRWDOd2kwY/0lMLICHPPgGNs
         TLsw==
X-Forwarded-Encrypted: i=1; AJvYcCXWpOtKg8uW689unNYY+7crQDoKBmED55IdRczrGGFBCF26UbgZzj8OH3oFUjLvydVNaSR7iaztaX01iXoFvzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9n6YnESi18zYH3EmOryHQYBmeO+vN+5S7wMNhWATJgLx+y2ik
	dqF46/u2zFr27fQx1CYqWYxjMDGS9T2bXxpEvm+MC0JPRqtfpvUM1PEYr0atwU+fMQ3sHIpkaf1
	uQ6QLAOSP4B4XyjW8P5e+gQNkASRPD3G/IQ+VP02Ljwy166kSkpTOnrPSE+MHoOEkkIPVFA==
X-Gm-Gg: AY/fxX49kAU99uOOvt04n1LZ+UcwTAGC41hj/MEfwiWGPV7vhvYZcl5JaSoQ1JgkLnJ
	xfw2Ramz7RQwi4y9IQnVJGpviStFvvtYqKLyZcuoRETrXXyGNavCVALfDyrqQYJTjK09nsErbCd
	8GAHHnJZwA6MSBmqy5wHFj/SSFR8ueonzylrPU7r99NlZo63c45ctq4+uqs7TYYT8KedHoQxXFF
	3NyW1DwnOl9DbTVOZympEsucReCf4yW371+uEpFEtoiQS3Yn7660dZKxzF3JsQFa7fVF2rpBWOK
	hjXqfGfp66hPdpMhzGKfq8Ry5lVFMX9Wqq8wCWXM/u0IK4pFPKC3xKKu9AWSmqnwWdQzD0TbTd7
	uOAbw4hF5YGwe
X-Received: by 2002:a05:6000:2411:b0:431:c2:c632 with SMTP id ffacd0b85a97d-432c38d22f0mr26992650f8f.57.1768314603280;
        Tue, 13 Jan 2026 06:30:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/QAVAjAHGrbVqsroQVjucumpuberxPHjIK5D6+36lcnv98Jxe8Pu+ntURZqANmPNOZ6UFhw==
X-Received: by 2002:a05:6000:2411:b0:431:c2:c632 with SMTP id ffacd0b85a97d-432c38d22f0mr26992605f8f.57.1768314602838;
        Tue, 13 Jan 2026 06:30:02 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df9afsm47097191f8f.24.2026.01.13.06.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 06:30:02 -0800 (PST)
Message-ID: <e9607915-892c-4724-b97f-7c90918f86fe@redhat.com>
Date: Tue, 13 Jan 2026 15:30:00 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] virtio_net: Fix misalignment bug in struct
 virtnet_info
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>
References: <aWIItWq5dV9XTTCJ@kspp>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aWIItWq5dV9XTTCJ@kspp>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p3PbSLMktvFrAZX5eIVduLLH9M0HZEJDNdTp2aZ9Nas_1768314603
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/26 9:07 AM, Gustavo A. R. Silva wrote:
> Use the new TRAILING_OVERLAP() helper to fix a misalignment bug
> along with the following warning:
> 
> drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> This helper creates a union between a flexible-array member (FAM)
> and a set of members that would otherwise follow it (in this case
> `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
> overlays the trailing members (rss_hash_key_data) onto the FAM
> (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
> The static_assert() ensures this alignment remains.
> 
> Notice that due to tail padding in flexible `struct
> virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
> (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
> offset 84 in struct virtnet_info) are misaligned by one byte. See
> below:
> 
> struct virtio_net_rss_config_trailer {
>         __le16                     max_tx_vq;            /*     0     2 */
>         __u8                       hash_key_length;      /*     2     1 */
>         __u8                       hash_key_data[];      /*     3     0 */
> 
>         /* size: 4, cachelines: 1, members: 3 */
>         /* padding: 1 */
>         /* last cacheline: 4 bytes */
> };
> 
> struct virtnet_info {
> ...
>         struct virtio_net_rss_config_trailer rss_trailer; /*    80     4 */
> 
>         /* XXX last struct has 1 byte of padding */
> 
>         u8                         rss_hash_key_data[40]; /*    84    40 */
> ...
>         /* size: 832, cachelines: 13, members: 48 */
>         /* sum members: 801, holes: 8, sum holes: 31 */
>         /* paddings: 2, sum paddings: 5 */
> };
> 
> After changes, those members are correctly aligned at offset 795:
> 
> struct virtnet_info {
> ...
>         union {
>                 struct virtio_net_rss_config_trailer rss_trailer; /*   792     4 */
>                 struct {
>                         unsigned char __offset_to_hash_key_data[3]; /*   792     3 */
>                         u8         rss_hash_key_data[40]; /*   795    40 */
>                 };                                       /*   792    43 */
>         };                                               /*   792    44 */
> ...
>         /* size: 840, cachelines: 14, members: 47 */
>         /* sum members: 801, holes: 8, sum holes: 35 */
>         /* padding: 4 */
>         /* paddings: 1, sum paddings: 4 */
>         /* last cacheline: 8 bytes */
> };
> 
> As a result, the RSS key passed to the device is shifted by 1
> byte: the last byte is cut off, and instead a (possibly
> uninitialized) byte is added at the beginning.
> 
> As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
> moved to the end, since it seems those three members should stick
> around together. :)
> 
> Cc: stable@vger.kernel.org
> Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Update subject and changelog text (include feedback from Simon and
>    Michael --thanks folks)
>  - Add Fixes tag and CC -stable.

@Michael, @Jason: This is still apparently targeting 'net-next', but I
think it should land in the 'net' tree, right?

/P

