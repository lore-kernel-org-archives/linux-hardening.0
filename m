Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16C33806B7
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316962; cv=none; b=m+Xb75lOIK53FsCxRBrX+ojBxWiFr/YbbU1qmBwclM7vIr83nLf+Ts5TkhsOdv7Yc29U8lnwIa2Sxu3ndrjCSMjYz1D5BAnioRbOQagFF+iqx8UaCE8t1cU6c+zepCJI49c1/BEZIfsmfPbR1j2URH1GvSiT4CLTXoGYlWd3QMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316962; c=relaxed/simple;
	bh=3zXEgrW72T0HFBYPdNsvotJZJOcjsWCZn/aiSz49gwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oX9IUdleTZ9RGFdKeEJZbsUn+lVdY21XsMltxDEk4IpNmudMkO4SoPgsJvKquddMvSZbpb+/d686WcsR0qywCf0Bo4tjb0kNcu4uJUjC9hhGJbXJPFTa2G/BELKMnoeRjb+PwIQawuwZcD3HRuqFlSdxU2Q6f9r63VOWUm7SdcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZTSAYshh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTSAYshh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768316959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Iv7jtHfyu2FIw37q1VMrstnC0/mkNFUj9G8Fyvhg8A=;
	b=ZTSAYshhQHQ8tFptQB0FUpPLMmqqWMww0lfmXr+gaVjZwxjdNIgEa26iyp7/jTWFcylopM
	OMVMCUjNy6m9oA5D+9yHVJJ35+40raFxuGJz2+42qwDMbTk8sP89KX6lgzEULsEcvRMzRl
	QZu2+g/DRm60EX4dy4eAaBLHSfcQ610=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-8vdihXVePmaaKJbu3VL2Ug-1; Tue, 13 Jan 2026 10:09:17 -0500
X-MC-Unique: 8vdihXVePmaaKJbu3VL2Ug-1
X-Mimecast-MFC-AGG-ID: 8vdihXVePmaaKJbu3VL2Ug_1768316956
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d62cc05daso51043765e9.3
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 07:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768316956; x=1768921756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Iv7jtHfyu2FIw37q1VMrstnC0/mkNFUj9G8Fyvhg8A=;
        b=b2Q0PEnWmHS/+RBTozluM6yiw/YY2ZC5KSh0h0CI2IWhm0HIxLUO8V6O6mAzVbkGxG
         Ha8Gymq2Ko42lY3WpV9jr86TeaToOYrkXQV+A2skUBBddSUN+smSaNnxDsUjEIENYXES
         RJzC5y1N7buorH4MKXTC8yqprLyP9qgtZ8BTmRTtDHeWGMsHxBaqTsyuqSk9/Qx3U671
         r092KV7wvCrL9wfASfdQAo+y3xiKf8iT2kDFl0sAgRQEFCltbOUCZS9Xe9AUlwbI4OqY
         MYlPFJ+8n9Njk2BBA9An+aj82stxa3U7LAQ846+4EWxWpGyeLgxQuLQ65KLA3x9/m2iw
         hTCg==
X-Forwarded-Encrypted: i=1; AJvYcCXHT5DwxNGC2mGGbwzNL3LcE2JmuORRZIUi1BQz5We0PGjSZa9G8phRBy8BIxW12K55sxqAeXbQk/KT2VLMxs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgGabdX+RNvo5VdGJM6noIQk3av/oligzausUbJuhVcxoUdrqD
	GxIskV9B9UpfkrviOViYMnsTo8Vc194hezNobQGGwy1qJFkX5GCdhPwuaN4H4fG2XxOhmGBX4hi
	MoXurAhaWJLm5eSrAYO4HO+5ZnjpQ5ZB0pTYGrbJ4AqcUU2s+yUbv4HzFnzsR2EHnOWimRA==
X-Gm-Gg: AY/fxX55/hzKkHAH7fuX2hWDMzPucbgl+Iat3+1qWHd00aLm76o8omyaMDQ1hegXCqv
	CI3QWxyKnAoSza4VYsUiX86KSr2r3CT8SrqSh/CpR6daVfHRQgcAglDsvfrRNq3IqqNrYS/VKXq
	oKfacMjF1raxu165y5kdfU3RD6Wtrju/arrgjUitNEoOVkdPoDNRNf2rL6wj1QDVHtBnRJMdBbO
	NZbabCyHoAtlCyldUi0qzc23LEKNq89YtCPEnC109gD5Pmy57QEeYcPWZXU6qiRMwGvT1DwFnke
	SXRrFUolA6KCgJ5DKlvWnpO8AHEhvdMpGxdyg30+m52uqRlDA9ag/KaNJMYb9D7a8g+CkP2Remj
	AdFTcixc4Y3ti8JLZb4+bjm1t1AVtVB0=
X-Received: by 2002:a05:600c:37ce:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-47d84b18ee1mr256230625e9.1.1768316956302;
        Tue, 13 Jan 2026 07:09:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIU9tLi+rd1piE3qCw9ltmh0taJcQjyrQSmq1XLBBBIKhKDikjGjztln4jAEzKC9qSMm64QA==
X-Received: by 2002:a05:600c:37ce:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-47d84b18ee1mr256230115e9.1.1768316955786;
        Tue, 13 Jan 2026 07:09:15 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47edee4cbc2sm18216645e9.4.2026.01.13.07.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:09:15 -0800 (PST)
Date: Tue, 13 Jan 2026 10:09:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2][next] virtio_net: Fix misalignment bug in struct
 virtnet_info
Message-ID: <20260113100902-mutt-send-email-mst@kernel.org>
References: <aWIItWq5dV9XTTCJ@kspp>
 <e9607915-892c-4724-b97f-7c90918f86fe@redhat.com>
 <20260113093839-mutt-send-email-mst@kernel.org>
 <916a6c1a-681e-4e5e-8d49-75d0de5c46a1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <916a6c1a-681e-4e5e-8d49-75d0de5c46a1@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 81FY-M0UFMR2_AXby6wAxV3IqjWucqW1QFnpaArSksM_1768316956
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 13, 2026 at 04:06:05PM +0100, Paolo Abeni wrote:
> On 1/13/26 3:39 PM, Michael S. Tsirkin wrote:
> > On Tue, Jan 13, 2026 at 03:30:00PM +0100, Paolo Abeni wrote:
> >> On 1/10/26 9:07 AM, Gustavo A. R. Silva wrote:
> >>> Use the new TRAILING_OVERLAP() helper to fix a misalignment bug
> >>> along with the following warning:
> >>>
> >>> drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> >>>
> >>> This helper creates a union between a flexible-array member (FAM)
> >>> and a set of members that would otherwise follow it (in this case
> >>> `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
> >>> overlays the trailing members (rss_hash_key_data) onto the FAM
> >>> (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
> >>> The static_assert() ensures this alignment remains.
> >>>
> >>> Notice that due to tail padding in flexible `struct
> >>> virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
> >>> (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
> >>> offset 84 in struct virtnet_info) are misaligned by one byte. See
> >>> below:
> >>>
> >>> struct virtio_net_rss_config_trailer {
> >>>         __le16                     max_tx_vq;            /*     0     2 */
> >>>         __u8                       hash_key_length;      /*     2     1 */
> >>>         __u8                       hash_key_data[];      /*     3     0 */
> >>>
> >>>         /* size: 4, cachelines: 1, members: 3 */
> >>>         /* padding: 1 */
> >>>         /* last cacheline: 4 bytes */
> >>> };
> >>>
> >>> struct virtnet_info {
> >>> ...
> >>>         struct virtio_net_rss_config_trailer rss_trailer; /*    80     4 */
> >>>
> >>>         /* XXX last struct has 1 byte of padding */
> >>>
> >>>         u8                         rss_hash_key_data[40]; /*    84    40 */
> >>> ...
> >>>         /* size: 832, cachelines: 13, members: 48 */
> >>>         /* sum members: 801, holes: 8, sum holes: 31 */
> >>>         /* paddings: 2, sum paddings: 5 */
> >>> };
> >>>
> >>> After changes, those members are correctly aligned at offset 795:
> >>>
> >>> struct virtnet_info {
> >>> ...
> >>>         union {
> >>>                 struct virtio_net_rss_config_trailer rss_trailer; /*   792     4 */
> >>>                 struct {
> >>>                         unsigned char __offset_to_hash_key_data[3]; /*   792     3 */
> >>>                         u8         rss_hash_key_data[40]; /*   795    40 */
> >>>                 };                                       /*   792    43 */
> >>>         };                                               /*   792    44 */
> >>> ...
> >>>         /* size: 840, cachelines: 14, members: 47 */
> >>>         /* sum members: 801, holes: 8, sum holes: 35 */
> >>>         /* padding: 4 */
> >>>         /* paddings: 1, sum paddings: 4 */
> >>>         /* last cacheline: 8 bytes */
> >>> };
> >>>
> >>> As a result, the RSS key passed to the device is shifted by 1
> >>> byte: the last byte is cut off, and instead a (possibly
> >>> uninitialized) byte is added at the beginning.
> >>>
> >>> As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
> >>> moved to the end, since it seems those three members should stick
> >>> around together. :)
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
> >>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >>> ---
> >>> Changes in v2:
> >>>  - Update subject and changelog text (include feedback from Simon and
> >>>    Michael --thanks folks)
> >>>  - Add Fixes tag and CC -stable.
> >>
> >> @Michael, @Jason: This is still apparently targeting 'net-next', but I
> >> think it should land in the 'net' tree, right?
> >>
> >> /P
> > 
> > Probably but I'm yet to properly review it. The thing that puzzles me at
> > a first glance is how are things working right now then?
> 
> Apparently they aren't ?!?
> 
> rss self-tests for virtio_net are failing:
> 
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/471521/15-rss-api-py/stdout
> 
> but the result is into the CI reported as success (no idea why?!?)
> 
> /P

and this fixes it?

