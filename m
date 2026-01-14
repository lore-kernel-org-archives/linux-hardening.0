Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4EA381719
	for <linux-hardening@vger.kernel.org>; Wed, 14 Jan 2026 08:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380834; cv=none; b=ScM4vmBF1ghw6blr6j7lgN3JH9RDan44eBtBGNgee+nJ6JWNmnKra8QpOAGED9FVQLkwp0p4rqKLS7WDAQb1uNNsnJaTCDYyRgO7ydXE458hpMpwxIqknJ2zkF9BrDTbH/u61L//JtgEmwHnVjsuE6kEtSZteM04VQsK5s3M1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380834; c=relaxed/simple;
	bh=eZ/xPxHf7fjSZecBeCp895uuqc9lBzIafLMnDn+UmVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ck+V6n3HM/VInf1hPm114avEf09gn8xyuytmdInjcJrS+jVzazaVrU9V36l+tL6spaH3Je8uaNshUA25JS+eaQP19LDWIAKNGeRQ8fOOWVN/6CU0Up7IjeQUbHp8FvE7vR7C63UkDPWfr4hakdN/BGkrdOzKghpCHGolnj8wY8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TsmucC2k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsmucC2k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768380828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fIBj+gi/FdScoTtSUNm5kkkcHpY61usILCwaxo9FKtg=;
	b=TsmucC2kWB0ChhoeKSZ1nsJpEdt7bVfm7MN7ZZPkrfNKL2zKGisB+p4MM+dzmX463lM/hm
	fbQCZwvZ+l4UboprMG77Q2+46r+fCjfkKV5xLYbxpBAnXh5nWHzTH3lIKMHjSdzp940C/S
	6akAh8wWcLWE19EHkm87iYLb23eLWJw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-IFRyiHKzN-KuE1dHt4YEkA-1; Wed, 14 Jan 2026 03:53:46 -0500
X-MC-Unique: IFRyiHKzN-KuE1dHt4YEkA-1
X-Mimecast-MFC-AGG-ID: IFRyiHKzN-KuE1dHt4YEkA_1768380826
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430ffa9fccaso6880704f8f.1
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jan 2026 00:53:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768380825; x=1768985625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIBj+gi/FdScoTtSUNm5kkkcHpY61usILCwaxo9FKtg=;
        b=U8kTeep0Q4meYB04er8L073oM8gaPJczrgIVFJPDff1lYIbm2sUlT3IYTR6WrLOPoR
         7SWj11FGdzf2Q5IOcnxg+xJ5CB8LtmdhSu2yPeVmN0IUqGStsswG3Tzs1W3X+Dm3Srxc
         FPlAgPyteHH3jXQX26Tj0y4jqXjuuK/eHquGKuEtBKzsWMSPAwfdLSpnHdyQG+1PAmrs
         P7lYeUzz1J3i8qF/erRBgVlV1gbtaBQpXwPU0r2ZlqV02b3+jt/LwOfLZ41zR39r8VrB
         GVlahNZ2He1CWfT9AoJLwkhyvC1LYzon1gu1HJglj2Eu/6m152YEz//gxASrs9Vd/5tM
         cRMw==
X-Forwarded-Encrypted: i=1; AJvYcCXy5k9EWbEAF2KwMRRBR3X44LIzKDwctmkw6vX/mIITCpfBOETk6Wz96YUQjQJEw93HE3WGQf62+FerIuCVllQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YywqwF5ld7YeMGX80mWzTOrNif+huXfeycXF+/rmtxan36/PfwX
	YjMoJep9bfp0ILaYNbghgoZ1U9JzbYS2heEnOYa0GZpsQh2zyzT3sMWujEB1IwUwfF1kzl5zdkP
	fmOIB4uiaYYlwZ7j7MMH69upQ82oM8RxtUdh29TJEsIKON8k+0kGTxyzO1w8h8c/71GYPDQ==
X-Gm-Gg: AY/fxX5PHzHmvFrCSM9J8aUei/UL5MjoWBmMQPlL19tUKp6swO4Y5LnGPgBe/YZwPMU
	5NfxegE9eWF/HYTbwm9TAHYyBlHzZQz14twG8GGFtBwVERFZvx0Cz3OigoIo5P+oscUbrTBSYo0
	rGdVP95KLWdBwutHBWnVsVws5ZQCEm4sFcdIlTJoGxwCVFYWZwmlL1FKy0R1vT617qO9BsVqTKf
	OjCX/GfH0fZyYD6GsM1MmrRSVOlsbv59Xyeqz4eOaOPwNQqUuWBus5DsLS0yf3KqxCPfESkNdGd
	aR2MM9xq4uS0zjOJXEgR0aCPc/FHUbGa4f2CeIOa9ls5qGm0w7QPV6xEvmJQrJNCCIu4nSHTPOI
	EWZ1tyV/ABdPI8xutBL3j9UPFAokWnIg=
X-Received: by 2002:a05:600c:a088:b0:47b:da85:b9ef with SMTP id 5b1f17b1804b1-47ee47d3988mr16789265e9.16.1768380825322;
        Wed, 14 Jan 2026 00:53:45 -0800 (PST)
X-Received: by 2002:a05:600c:a088:b0:47b:da85:b9ef with SMTP id 5b1f17b1804b1-47ee47d3988mr16788915e9.16.1768380824817;
        Wed, 14 Jan 2026 00:53:44 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee54b90d5sm17411505e9.2.2026.01.14.00.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:53:44 -0800 (PST)
Date: Wed, 14 Jan 2026 03:53:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2][next] virtio_net: Fix misalignment bug in struct
 virtnet_info
Message-ID: <20260114035310-mutt-send-email-mst@kernel.org>
References: <aWIItWq5dV9XTTCJ@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aWIItWq5dV9XTTCJ@kspp>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7jvTk76JC5myVinAAJS_5OUJleoECADiBrXyC6S3yak_1768380826
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 10, 2026 at 05:07:17PM +0900, Gustavo A. R. Silva wrote:
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

Seems to belong in net, not next.

Besides that:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Changes in v2:
>  - Update subject and changelog text (include feedback from Simon and
>    Michael --thanks folks)
>  - Add Fixes tag and CC -stable.
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/aLiYrQGdGmaDTtLF@kspp/
> 
>  drivers/net/virtio_net.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 22d894101c01..5cbcc9926a23 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -425,9 +425,6 @@ struct virtnet_info {
>  	u16 rss_indir_table_size;
>  	u32 rss_hash_types_supported;
>  	u32 rss_hash_types_saved;
> -	struct virtio_net_rss_config_hdr *rss_hdr;
> -	struct virtio_net_rss_config_trailer rss_trailer;
> -	u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>  
>  	/* Has control virtqueue */
>  	bool has_cvq;
> @@ -493,7 +490,16 @@ struct virtnet_info {
>  	struct failover *failover;
>  
>  	u64 device_stats_cap;
> +
> +	struct virtio_net_rss_config_hdr *rss_hdr;
> +
> +	/* Must be last as it ends in a flexible-array member. */
> +	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
> +		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> +	);
>  };
> +static_assert(offsetof(struct virtnet_info, rss_trailer.hash_key_data) ==
> +	      offsetof(struct virtnet_info, rss_hash_key_data));
>  
>  struct padded_vnet_hdr {
>  	struct virtio_net_hdr_v1_hash hdr;
> -- 
> 2.43.0

