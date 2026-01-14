Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FE0357A56
	for <linux-hardening@vger.kernel.org>; Wed, 14 Jan 2026 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768375130; cv=none; b=qEV6jWMoBEiXlO0zdmtotepsoAkwsb2BWGFOBXs+auFBVgAEe+0b3WPT1St2D9TDCffXtCnhfoFPpH1O5wPdPW6wCWrSsshO1sJj21/HxwzfGgvBsRRf+eWZJEj/BtlvhVAjqmYH/vLdc6b3kVjhFJqmph9qHRewmfiiR+bNf9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768375130; c=relaxed/simple;
	bh=kqP77k226Wx8tCQ/0jWeIHBXDlzM0lq0ign/yDhfiAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Awm/b+5cfR2n8Gk6MuKuGgHr6jPCbGXez4z4Eyi3mRVTYniUd6ggW1k5TAGyCYcVB7s/Ki+Otspjg9qZtrE/K2KCyMZXuiLepy7DVzCf3hFr21tKM94cmXqBBQfguUzw8k/8FCHOe+AZ1XutnnfLi/Vgt5k6Em2cDFTQg2DbNCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vw+UjI7U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vw+UjI7U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768375123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/19S94YPYflLVx22ERVlbrXJL08sz9F6OX2XWU/rfQ=;
	b=Vw+UjI7UgeDsiuTK+AldtFGslG1lpa6BX8qwit8ktjV04T28NF/6JZkLXvWX+JezbhZZjZ
	blBvO00IdKaLRR7uXFex1toqeaiQRsB5cvpRNriGftNCRo1DS1vuj5Ni1MFoiHLkqUlU6t
	8ajpR1bV5fdYtvB7Na3Sqt175FSzlFM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-tT9i5ipHNf6UR9r9EiWE2g-1; Wed, 14 Jan 2026 02:18:42 -0500
X-MC-Unique: tT9i5ipHNf6UR9r9EiWE2g-1
X-Mimecast-MFC-AGG-ID: tT9i5ipHNf6UR9r9EiWE2g_1768375121
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c6e05af3bso8962411a91.3
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 23:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768375121; x=1768979921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L/19S94YPYflLVx22ERVlbrXJL08sz9F6OX2XWU/rfQ=;
        b=maVwl+S/KjfIQHbmCThc8XSXaivVehpU0Wi72tJ6tKhaU8lnEtBCOBdfthw5um2+y2
         P7Iur1xr6k4F2stsGarlXjzT/dumjfCpNQA1LR4PjHYAllSegbwzfTCfcLfRhQ0lZ6fn
         Ps1NjOG5ZlH6N56q3u4iAlvyIwZp1iZr01tHL/j0E+7Ab/m2pK/3XPaFcCiQpq1dQRC8
         AsDUm/r51NzApcr7ZO11IPKoMsBlj9TXMKC8Yd2Z9IUyRLB9ap7bXZEwVNTryH3bhFsG
         7CSYCxmZ6q5kNvPqsQMTPNId2MNDSyDgnjzaYgTVZXwDFFc4R+sdVcAwl2CCQQCl4DTo
         Z6wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnIFDzl2yFLtLQ6PdvTx1ZpeFW/AF1BP7aMj8EwbCh4zecWeaqVEOltOhyEiyeNsSOxjwfuqQiefLHKG/wxVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ6/9NZf4rmNcdZNMOcz7nKHLWHy5e3Ccy6Grz0VKfvEoqotZk
	1YjSF5zj50i5PUNwnsbTjwMYeF2u1L0t/jbM5TtvTcvTF5Xg+9R99ihcQa7oinQpUG8GgMVsYbt
	aI8trTDeg6gu1HyccPU+uK8F5/0M2CWlrP2Pg5GqtYQA12oKPdp39V1TzvPyjkcPBBDfooO9wxA
	Ay2y3x5AYkns8pe64x8aJES7rg56rv6O5O8Mj6qTY0w8Rc
X-Gm-Gg: AY/fxX4+0wzepheIZ2IGqi5hX4ILc8rCn0pYXtSQM2auTgQf8A/GXQRcEjvAgCPYa21
	B3sBVGd/zfkAObLJoHVlOHJuEgUBIhFR3SIRwqZEhIBsd9iFgQhxwEPeiD6nbeCJbasMqtJnZAz
	+Ngvlm0NKj6Tkj4NIUY71B1xm/SIHwOg1s3AuV7SYCdrZhWiSR/QD+8JHsrFSg9t8=
X-Received: by 2002:a17:90b:28cc:b0:335:2747:a9b3 with SMTP id 98e67ed59e1d1-3510913fd7bmr1582680a91.32.1768375120984;
        Tue, 13 Jan 2026 23:18:40 -0800 (PST)
X-Received: by 2002:a17:90b:28cc:b0:335:2747:a9b3 with SMTP id
 98e67ed59e1d1-3510913fd7bmr1582663a91.32.1768375120558; Tue, 13 Jan 2026
 23:18:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aWIItWq5dV9XTTCJ@kspp> <e9607915-892c-4724-b97f-7c90918f86fe@redhat.com>
In-Reply-To: <e9607915-892c-4724-b97f-7c90918f86fe@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 14 Jan 2026 15:18:29 +0800
X-Gm-Features: AZwV_Qil4_emZc9UC594LVQZD_WDE3u0sgwiGLvdx73MXFe_Cb2QNMYVC2G9b8k
Message-ID: <CACGkMEuFePpfpFvnJz6xvrKrVG84KmAfODP55cCJgFzZqba29A@mail.gmail.com>
Subject: Re: [PATCH v2][next] virtio_net: Fix misalignment bug in struct virtnet_info
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Akihiko Odaki <akihiko.odaki@daynix.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pL4ePycYjE0TnZ5pgbwZS0pVGedU-xUG06FtR8JKqAA_1768375121
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 10:30=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 1/10/26 9:07 AM, Gustavo A. R. Silva wrote:
> > Use the new TRAILING_OVERLAP() helper to fix a misalignment bug
> > along with the following warning:
> >
> > drivers/net/virtio_net.c:429:46: warning: structure containing a flexib=
le array member is not at the end of another structure [-Wflex-array-member=
-not-at-end]
> >
> > This helper creates a union between a flexible-array member (FAM)
> > and a set of members that would otherwise follow it (in this case
> > `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
> > overlays the trailing members (rss_hash_key_data) onto the FAM
> > (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
> > The static_assert() ensures this alignment remains.
> >
> > Notice that due to tail padding in flexible `struct
> > virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
> > (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
> > offset 84 in struct virtnet_info) are misaligned by one byte. See
> > below:
> >
> > struct virtio_net_rss_config_trailer {
> >         __le16                     max_tx_vq;            /*     0     2=
 */
> >         __u8                       hash_key_length;      /*     2     1=
 */
> >         __u8                       hash_key_data[];      /*     3     0=
 */
> >
> >         /* size: 4, cachelines: 1, members: 3 */
> >         /* padding: 1 */
> >         /* last cacheline: 4 bytes */
> > };
> >
> > struct virtnet_info {
> > ...
> >         struct virtio_net_rss_config_trailer rss_trailer; /*    80     =
4 */
> >
> >         /* XXX last struct has 1 byte of padding */
> >
> >         u8                         rss_hash_key_data[40]; /*    84    4=
0 */
> > ...
> >         /* size: 832, cachelines: 13, members: 48 */
> >         /* sum members: 801, holes: 8, sum holes: 31 */
> >         /* paddings: 2, sum paddings: 5 */
> > };
> >
> > After changes, those members are correctly aligned at offset 795:
> >
> > struct virtnet_info {
> > ...
> >         union {
> >                 struct virtio_net_rss_config_trailer rss_trailer; /*   =
792     4 */
> >                 struct {
> >                         unsigned char __offset_to_hash_key_data[3]; /* =
  792     3 */
> >                         u8         rss_hash_key_data[40]; /*   795    4=
0 */
> >                 };                                       /*   792    43=
 */
> >         };                                               /*   792    44=
 */
> > ...
> >         /* size: 840, cachelines: 14, members: 47 */
> >         /* sum members: 801, holes: 8, sum holes: 35 */
> >         /* padding: 4 */
> >         /* paddings: 1, sum paddings: 4 */
> >         /* last cacheline: 8 bytes */
> > };
> >
> > As a result, the RSS key passed to the device is shifted by 1
> > byte: the last byte is cut off, and instead a (possibly
> > uninitialized) byte is added at the beginning.
> >
> > As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
> > moved to the end, since it seems those three members should stick
> > around together. :)
> >
> > Cc: stable@vger.kernel.org
> > Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> > Changes in v2:
> >  - Update subject and changelog text (include feedback from Simon and
> >    Michael --thanks folks)
> >  - Add Fixes tag and CC -stable.
>
> @Michael, @Jason: This is still apparently targeting 'net-next', but I
> think it should land in the 'net' tree, right?

Right.

Thanks

>
> /P
>

