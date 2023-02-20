Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBB6C05027
	for <linux-hardening@archiver.kernel.org>; Mon, 20 Feb 2023 02:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBTCKz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 19 Feb 2023 21:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBTCKx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 19 Feb 2023 21:10:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AA6AD25
        for <linux-hardening@vger.kernel.org>; Sun, 19 Feb 2023 18:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676859004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=myOlspBXyKT+7T7ajVWWp4s78F3CB2omLo5W2yN/F24=;
        b=HLvEdARlHy2P6zfe/IM5bA7Qq9fKYaDfVHnzrmO5mLnR3pEHAglqD3xRVrC+Xj6AgmrSCB
        i++pjagvdk66d0V6Jne5zRLnP23hTRvvW8JyaAMtua0YRTXnZW8u1xBpLq6e0JvkLRL9X2
        yQRiRpvj3VFjceWCy+t+G8dVVg3zZUQ=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-568-dFRLPTNnPMOlnCqTjMNd7w-1; Sun, 19 Feb 2023 21:10:03 -0500
X-MC-Unique: dFRLPTNnPMOlnCqTjMNd7w-1
Received: by mail-ot1-f72.google.com with SMTP id h10-20020a9d554a000000b00690ec6c3f2fso227188oti.15
        for <linux-hardening@vger.kernel.org>; Sun, 19 Feb 2023 18:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myOlspBXyKT+7T7ajVWWp4s78F3CB2omLo5W2yN/F24=;
        b=Yh6mdas9q07YHk1SNGJ7Z95aRfE4TGkKV7vW46OiPUHzLyV7zhIm9JVtIfDJmQ2+79
         DDWmpQkXuCp3A76VFSh8XvCNNgkq4uurYS+VcvMpahA4qheMIsKo5wefMH0UxZm/ET0G
         KpjZ2Po2DR/3KZFr0Zrc5vEDBB2RDfNJceYYNLVF/bqooWBxnpQZRtTsSQWeMzIWN+Mu
         0CuL0i7Q/E7ajIKbDXniK70C4kfgZ+HUngCdPJwVqIgbWw0T6G4A6IeE2yDnJyHr1zct
         WhNh9Aeau5hIHuxC8pJBGEZunOPgr4EWEp25vB1pTC0sCsDPaIsUlrV02rhTFtYus0Gu
         bubg==
X-Gm-Message-State: AO0yUKXX6oxClqnV/aFeT78D1v/cAce13+9HX6QzvAFgycphAGIkgqno
        5JUNtZZGZPbM7Q/OBQWKj/wu1TmzMX9gHhUBBNbuxcBwwTZj/tQce5BQIw07xBUqjaP8R521+fX
        zJp+K/f6qIwa0N7wWJDQXdWA9oM5DRvuK2b5MBHM9sCAw
X-Received: by 2002:a05:6808:164a:b0:37b:427c:30fb with SMTP id az10-20020a056808164a00b0037b427c30fbmr308279oib.250.1676859002608;
        Sun, 19 Feb 2023 18:10:02 -0800 (PST)
X-Google-Smtp-Source: AK7set9dawxQor9VtvdOZv2pLwu60XTj97f8H793hd1Rce8tmKmDLkpACy6hOlWH3q3/6FwXRZDEB+My67PcX1OXpjM=
X-Received: by 2002:a05:6808:164a:b0:37b:427c:30fb with SMTP id
 az10-20020a056808164a00b0037b427c30fbmr308278oib.250.1676859002262; Sun, 19
 Feb 2023 18:10:02 -0800 (PST)
MIME-Version: 1.0
References: <20230218183842.never.954-kees@kernel.org> <07b5c523-7174-ac30-65cb-182e07db08dc@gmail.com>
In-Reply-To: <07b5c523-7174-ac30-65cb-182e07db08dc@gmail.com>
From:   Josef Oskera <joskera@redhat.com>
Date:   Mon, 20 Feb 2023 03:09:51 +0100
Message-ID: <CA+hmzGDGRTOv9RBe8Kt9b8LdKpHLiGNTA5DkivatraXigWbDjg@mail.gmail.com>
Subject: Re: [PATCH] net/mlx4_en: Introduce flexible array to silence overflow warning
To:     Tariq Toukan <ttoukan.linux@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

I've tried Kees's patch and it works for me. I am able to compile mlx4
without the fortify warning.

ne 19. 2. 2023 v 10:43 odes=C3=ADlatel Tariq Toukan <ttoukan.linux@gmail.co=
m> napsal:
>
>
>
> On 18/02/2023 20:38, Kees Cook wrote:
> > The call "skb_copy_from_linear_data(skb, inl + 1, spc)" triggers a FORT=
IFY
> > memcpy() warning on ppc64 platform:
> >
> > In function =E2=80=98fortify_memcpy_chk=E2=80=99,
> >      inlined from =E2=80=98skb_copy_from_linear_data=E2=80=99 at ./incl=
ude/linux/skbuff.h:4029:2,
> >      inlined from =E2=80=98build_inline_wqe=E2=80=99 at drivers/net/eth=
ernet/mellanox/mlx4/en_tx.c:722:4,
> >      inlined from =E2=80=98mlx4_en_xmit=E2=80=99 at drivers/net/etherne=
t/mellanox/mlx4/en_tx.c:1066:3:
> > ./include/linux/fortify-string.h:513:25: error: call to =E2=80=98__writ=
e_overflow_field=E2=80=99 declared with
> > attribute warning: detected write beyond size of field (1st parameter);=
 maybe use struct_group()?
> > [-Werror=3Dattribute-warning]
> >    513 |                         __write_overflow_field(p_size_field, s=
ize);
> >        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> >
> > Same behaviour on x86 you can get if you use "__always_inline" instead =
of
> > "inline" for skb_copy_from_linear_data() in skbuff.h
> >
> > The call here copies data into inlined tx destricptor, which has 104
> > bytes (MAX_INLINE) space for data payload. In this case "spc" is known
> > in compile-time but the destination is used with hidden knowledge
> > (real structure of destination is different from that the compiler
> > can see). That cause the fortify warning because compiler can check
> > bounds, but the real bounds are different.  "spc" can't be bigger than
> > 64 bytes (MLX4_INLINE_ALIGN), so the data can always fit into inlined
> > tx descriptor. The fact that "inl" points into inlined tx descriptor is
> > determined earlier in mlx4_en_xmit().
> >
> > Avoid confusing the compiler with "inl + 1" constructions to get to pas=
t
> > the inl header by introducing a flexible array "data" to the struct so
> > that the compiler can see that we are not dealing with an array of inl
> > structs, but rather, arbitrary data following the structure. There are
> > no changes to the structure layout reported by pahole, and the resultin=
g
> > machine code is actually smaller.
> >
> > Reported-by: Josef Oskera <joskera@redhat.com>
> > Link: https://lore.kernel.org/lkml/20230217094541.2362873-1-joskera@red=
hat.com
> > Fixes: f68f2ff91512 ("fortify: Detect struct member overflows in memcpy=
() at compile-time")
> > Cc: Tariq Toukan <tariqt@nvidia.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Yishai Hadas <yishaih@nvidia.com>
> > Cc: netdev@vger.kernel.org
> > Cc: linux-rdma@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >   drivers/net/ethernet/mellanox/mlx4/en_tx.c | 22 +++++++++++----------=
-
> >   include/linux/mlx4/qp.h                    |  1 +
> >   2 files changed, 12 insertions(+), 11 deletions(-)
> >
>
> Just saw your patch now, after commenting on the other thread. :)
>
> So you choose not to fix similar usages in RDMA driver
> drivers/infiniband/hw/mlx4/qp.c, like:
>
> 3204         spc =3D MLX4_INLINE_ALIGN -
> 3205                 ((unsigned long) (inl + 1) & (MLX4_INLINE_ALIGN - 1)=
);
> 3206         if (header_size <=3D spc) {
> 3207                 inl->byte_count =3D cpu_to_be32(1 << 31 | header_siz=
e);
> 3208                 memcpy(inl + 1, sqp->header_buf, header_size);
> 3209                 i =3D 1;
> 3210         } else {
> 3211                 inl->byte_count =3D cpu_to_be32(1 << 31 | spc);
> 3212                 memcpy(inl + 1, sqp->header_buf, spc);
> 3213
> 3214                 inl =3D (void *) (inl + 1) + spc;
> 3215                 memcpy(inl + 1, sqp->header_buf + spc, header_size
> - spc);
>
> This keeps the patch minimal indeed.
>
> Did you repro the issue and test this solution?
> Maybe Josef can also verify it works for him?
>
> > diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/e=
thernet/mellanox/mlx4/en_tx.c
> > index c5758637b7be..2f79378fbf6e 100644
> > --- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
> > @@ -699,32 +699,32 @@ static void build_inline_wqe(struct mlx4_en_tx_de=
sc *tx_desc,
> >                       inl->byte_count =3D cpu_to_be32(1 << 31 | skb->le=
n);
> >               } else {
> >                       inl->byte_count =3D cpu_to_be32(1 << 31 | MIN_PKT=
_LEN);
> > -                     memset(((void *)(inl + 1)) + skb->len, 0,
> > +                     memset(inl->data + skb->len, 0,
> >                              MIN_PKT_LEN - skb->len);
> >               }
> > -             skb_copy_from_linear_data(skb, inl + 1, hlen);
> > +             skb_copy_from_linear_data(skb, inl->data, hlen);
> >               if (shinfo->nr_frags)
> > -                     memcpy(((void *)(inl + 1)) + hlen, fragptr,
> > +                     memcpy(inl->data + hlen, fragptr,
> >                              skb_frag_size(&shinfo->frags[0]));
> >
> >       } else {
> >               inl->byte_count =3D cpu_to_be32(1 << 31 | spc);
> >               if (hlen <=3D spc) {
> > -                     skb_copy_from_linear_data(skb, inl + 1, hlen);
> > +                     skb_copy_from_linear_data(skb, inl->data, hlen);
> >                       if (hlen < spc) {
> > -                             memcpy(((void *)(inl + 1)) + hlen,
> > +                             memcpy(inl->data + hlen,
> >                                      fragptr, spc - hlen);
> >                               fragptr +=3D  spc - hlen;
> >                       }
> > -                     inl =3D (void *) (inl + 1) + spc;
> > -                     memcpy(((void *)(inl + 1)), fragptr, skb->len - s=
pc);
> > +                     inl =3D (void *)inl->data + spc;
> > +                     memcpy(inl->data, fragptr, skb->len - spc);
> >               } else {
> > -                     skb_copy_from_linear_data(skb, inl + 1, spc);
> > -                     inl =3D (void *) (inl + 1) + spc;
> > -                     skb_copy_from_linear_data_offset(skb, spc, inl + =
1,
> > +                     skb_copy_from_linear_data(skb, inl->data, spc);
> > +                     inl =3D (void *)inl->data + spc;
>
> No need now for all these (void *) castings.
>
> > +                     skb_copy_from_linear_data_offset(skb, spc, inl->d=
ata,
> >                                                        hlen - spc);
> >                       if (shinfo->nr_frags)
> > -                             memcpy(((void *)(inl + 1)) + hlen - spc,
> > +                             memcpy(inl->data + hlen - spc,
> >                                      fragptr,
> >                                      skb_frag_size(&shinfo->frags[0]));
> >               }
> > diff --git a/include/linux/mlx4/qp.h b/include/linux/mlx4/qp.h
> > index c78b90f2e9a1..b9a7b1319f5d 100644
> > --- a/include/linux/mlx4/qp.h
> > +++ b/include/linux/mlx4/qp.h
> > @@ -446,6 +446,7 @@ enum {
> >
> >   struct mlx4_wqe_inline_seg {
> >       __be32                  byte_count;
> > +     __u8                    data[];
> >   };
> >
> >   enum mlx4_update_qp_attr {
>

