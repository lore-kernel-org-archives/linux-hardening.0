Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D092C08DA
	for <linux-hardening@vger.kernel.org>; Thu,  4 Sep 2025 21:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021502; cv=none; b=QPY2sQ4s+tlzTyo+2akmVf4bOZ2EemLO0lhD1hepciAy97f6z3y/oWqdT8SPf0PqysMbUFEvZ+bIFQnKIyVELBTOHxh8Gox7vy3igWx1Q8UUC0cBk2Zi0/4B0e9KgT21/aTUUVvvlBYdDf8t18fXuVXEaM7xuZPvr6BzHdWZ4Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021502; c=relaxed/simple;
	bh=UTOOlZIQ4c9dm1bWMI/1leIB+NQMUt7B2+b+Jnoq2CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RmrdchySps/z7kqnKWbW4N/QmaqZlccjKQNi1McwsBFNsG2QJk/57nc4mbD3yHbtOpbk6ZVpr31PYGIlD4XU3jCHJVJ5tWrOIBacpRWHsqiEYevPtd7LR7v+IdBdZ/hqbeUT5KCibjRoET+mnbcizAS1kiZxBLNeozPkMLkDIak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNY5VNYC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNY5VNYC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757021498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ENzZgn6QrvH6M67TV54TxO3IiK3WQ2Mya06rqToR830=;
	b=TNY5VNYCphqsio55zJCWv5iH5Qglin+uPxM/s5JCuOZbm6C0q6dc7xTTGXtaAqpctcXQIW
	pTUThWpgqP//l9oHg9rrb8Rd/lJCpEfHgV1n0DW3vGnYPYRfrfPdku8pu2gL419MG8dntE
	dj0/yjKSxx4rrXSQi2h9MPl63+icQGU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-RtSHBd0ANAi62qWoMX6vJA-1; Thu, 04 Sep 2025 17:31:37 -0400
X-MC-Unique: RtSHBd0ANAi62qWoMX6vJA-1
X-Mimecast-MFC-AGG-ID: RtSHBd0ANAi62qWoMX6vJA_1757021496
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3cf12498799so833363f8f.2
        for <linux-hardening@vger.kernel.org>; Thu, 04 Sep 2025 14:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757021496; x=1757626296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENzZgn6QrvH6M67TV54TxO3IiK3WQ2Mya06rqToR830=;
        b=TIJEQEjXxpMECDEezSzUG6IqrxjyTIcGHuehC4GeLfB+71qhXz9Ny1R5KVbUrIU4kM
         4iCyEuPFZvXtmOcDrIaoWk2T2ynRNuuMqH+dH2bL9eCg1QWt/sWHMTtcFKDsgmG72OWe
         9ET9Dvp+URoAgD+qz0gUl+iKY+nw0NWWOi5Azz01ytqvTKdxB8I3auCVYPkZvmKZtXzY
         0g3Ry7zDlED9jogrvdkVW6zcXVvyIgwafMSGTZ5ox/Ko7wsSiVBMlHERi/ZshD4T0qvu
         SDTZl7a4LKgDQ5qGG6Wkzdo5F2vt8GSX7Qicpo4988RTpmB17k77tmXnyc+RfNp9s4XY
         PfWg==
X-Forwarded-Encrypted: i=1; AJvYcCVjONTGT6cQOUKOPSq7+7LKuU6gYZpAoxAnuov1e8m1ZCf6pwXJhg7RVvyHRffqy51vw4i8TrW4oidheyZq994=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU4bqP6/5GW4K9KTPrSYM8/6J1mI3sdBGT9k6Q1JMw9+8By1k3
	+BNDiHmMmzGLBrluJ6el6adkGGGn9AwGzjb1oKoKOLh0x0UtZ4WZoOuu0jk/jDJCwCyXm43bU7l
	/Rxw1fUMe63q2K1zypftF/Y/XaHHYHnp4IFyGgDIrhLd60Vgh4Bkf2SeyrfmeI/xkWEIhPmxyfA
	3gxpBS
X-Gm-Gg: ASbGncsfZ6y49C6TwFrVNuTHT7AtFO2fEUySwgkWPO6KaYAPkiptTWqQcUgXlsbOFct
	t6DqJjZGtRRV8qdlP/gFxPI0YMMIguG8sjaZqC2Q/i1FwEuuel21y8ztefQPwjDFZ0HEg9ytj6Q
	s2wx2g2t4wmdLbwFg6dItCVKDybaJiJaC17luk3zncr4zQw4WLgP520FkgZFGwhJ+dL5dS9FOt+
	1JdVIe6WRrfYhVvV4v8bqsI1Yzs2b1rSVsAzLUF9L47UagOFoNVn1IB3XDScoD1kaysM3P6cPIh
	4TFWIe13a6nIeYaZI+wzN1EPOoVH0dHAMeL2RPsFN/fhuYUfb6qOjMY4RUWOT2L3Cw==
X-Received: by 2002:a05:6000:381:b0:3d7:38a7:35aa with SMTP id ffacd0b85a97d-3d738a7398bmr13118404f8f.24.1757021496223;
        Thu, 04 Sep 2025 14:31:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER4VSHQehlxm9viGCaLCiSUfIBqClOaGylclXglywjo1Jhx+yPCFvISOavLQeeDAzgnPEefA==
X-Received: by 2002:a05:6000:381:b0:3d7:38a7:35aa with SMTP id ffacd0b85a97d-3d738a7398bmr13118381f8f.24.1757021495725;
        Thu, 04 Sep 2025 14:31:35 -0700 (PDT)
Received: from redhat.com (93-51-222-138.ip268.fastwebnet.it. [93.51.222.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0a1f807f9sm28148640f8f.38.2025.09.04.14.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 14:31:35 -0700 (PDT)
Date: Thu, 4 Sep 2025 17:31:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Simon Horman <horms@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] virtio_net: Fix alignment and avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <20250904172951-mutt-send-email-mst@kernel.org>
References: <aLiYrQGdGmaDTtLF@kspp>
 <20250904091315.GB372207@horms.kernel.org>
 <cac19beb-eefb-4a6a-9eec-b414199ce339@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cac19beb-eefb-4a6a-9eec-b414199ce339@embeddedor.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G6YBtG93594uVRwia6YKW4-HunLLTOk8W98QTAFnafk_1757021496
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 04, 2025 at 08:53:31PM +0200, Gustavo A. R. Silva wrote:
> 
> 
> On 9/4/25 11:13, Simon Horman wrote:
> > On Wed, Sep 03, 2025 at 09:36:13PM +0200, Gustavo A. R. Silva wrote:
> > > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > > getting ready to enable it, globally.
> > > 
> > > Use the new TRAILING_OVERLAP() helper to fix the following warning:
> > > 
> > > drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > > 
> > > This helper creates a union between a flexible-array member (FAM)
> > > and a set of members that would otherwise follow it (in this case
> > > `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
> > > overlays the trailing members (rss_hash_key_data) onto the FAM
> > > (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
> > > The static_assert() ensures this alignment remains, and it's
> > > intentionally placed inmediately after `struct virtnet_info` (no
> > > blank line in between).
> > > 
> > > Notice that due to tail padding in flexible `struct
> > > virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
> > > (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
> > > offset 84 in struct virtnet_info) are misaligned by one byte. See
> > > below:
> > > 
> > > struct virtio_net_rss_config_trailer {
> > >          __le16                     max_tx_vq;            /*     0     2 */
> > >          __u8                       hash_key_length;      /*     2     1 */
> > >          __u8                       hash_key_data[];      /*     3     0 */
> > > 
> > >          /* size: 4, cachelines: 1, members: 3 */
> > >          /* padding: 1 */
> > >          /* last cacheline: 4 bytes */
> > > };
> > > 
> > > struct virtnet_info {
> > > ...
> > >          struct virtio_net_rss_config_trailer rss_trailer; /*    80     4 */
> > > 
> > >          /* XXX last struct has 1 byte of padding */
> > > 
> > >          u8                         rss_hash_key_data[40]; /*    84    40 */
> > > ...
> > >          /* size: 832, cachelines: 13, members: 48 */
> > >          /* sum members: 801, holes: 8, sum holes: 31 */
> > >          /* paddings: 2, sum paddings: 5 */
> > > };
> > > 
> > > After changes, those members are correctly aligned at offset 795:
> > > 
> > > struct virtnet_info {
> > > ...
> > >          union {
> > >                  struct virtio_net_rss_config_trailer rss_trailer; /*   792     4 */
> > >                  struct {
> > >                          unsigned char __offset_to_hash_key_data[3]; /*   792     3 */
> > >                          u8         rss_hash_key_data[40]; /*   795    40 */
> > >                  };                                       /*   792    43 */
> > >          };                                               /*   792    44 */
> > > ...
> > >          /* size: 840, cachelines: 14, members: 47 */
> > >          /* sum members: 801, holes: 8, sum holes: 35 */
> > >          /* padding: 4 */
> > >          /* paddings: 1, sum paddings: 4 */
> > >          /* last cacheline: 8 bytes */
> > > };
> > > 
> > > As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
> > > moved to the end, since it seems those three members should stick
> > > around together. :)
> > > 
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > ---
> > > 
> > > This should probably include the following tag:
> > > 
> > > 	Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
> > > 
> > > but I'd like to hear some feedback, first.
> > 
> > I tend to agree given that:
> > 
> > On the one hand:
> > 
> > 1) in virtnet_init_default_rss(), netdev_rss_key_fill() is used
> >     to write random data to .rss_hash_key_data
> > 
> > 2) In virtnet_set_rxfh() key data written to .rss_hash_key_data
> > 
> > While
> > 
> > 3) In virtnet_commit_rss_command() virtio_net_rss_config_trailer,
> >     including the contents of .hash_key_data based on the length of
> >     that data provided in .hash_key_length is copied.
> > 
> > It seems to me that step 3 will include 1 byte of uninitialised data
> > at the start of .hash_key_data. And, correspondingly, truncate
> > .rss_hash_key_data by one byte.
> > 
> > It's unclear to me what the effect of this - perhaps they key works
> > regardless. But it doesn't seem intended. And while the result may be
> > neutral, I do  suspect this reduces the quality of the key. And I more
> > strongly suspect it doesn't have any positive outcome.
> > 
> > So I would lean towards playing it safe and considering this as a bug.
> > 
> > Of course, other's may have better insight as to the actual effect of this.
> 
> Yeah, in the meantime I'll prepare v2 with both the 'Fixes' and 'stable'
> tags.
> 
> Thanks for the feedback!
> -Gustavo
> 
> 


I agree. It looks like that commit completely broke RSS
configuration. Akihiko do you mind sharing how that was
tested? Maybe help testing the fix? Thanks!

