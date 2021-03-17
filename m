Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-28.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204BBC433E9
	for <linux-hardening@archiver.kernel.org>; Wed, 17 Mar 2021 17:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0E464F07
	for <linux-hardening@archiver.kernel.org>; Wed, 17 Mar 2021 17:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhCQRMN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 Mar 2021 13:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhCQRL6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 Mar 2021 13:11:58 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FD6C06175F
        for <linux-hardening@vger.kernel.org>; Wed, 17 Mar 2021 10:11:58 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t18so4087809lfl.3
        for <linux-hardening@vger.kernel.org>; Wed, 17 Mar 2021 10:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jzrcb4snjLsfCfgL7oJZ6fFGa4UZcs/jVCaFF495Y9I=;
        b=jhsTx4u3bX6dnuVOods1QVHxDvDRiLqaGF+PGS54cjNTi9eg9MypoGpTSGldjNDPn4
         WpwX3M8TKZuSW/TAGQkVP9BS/k6wwj2WpG5ssv7ZXigAiiLALXIWU/T8oLqh32ji2/ph
         8/G/6m3jCydCfwIjD8/cBRg+tvtl67RTRYxHJcP6LqnTbVgq/JeFyGr0I4Oam0Mf24fB
         d8JRTAbUa0HJOsPpSaomCtqmexfQZUBd30in19OoWMB44of9N6YcEIZ/Iz6CrDL4Q7ba
         kPCaUhZ69478SbyyCqVG5sRGOWAzYWe3ayXkl0fe5uDUJngVJmExKdU3bcAzmOM75kIs
         xR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jzrcb4snjLsfCfgL7oJZ6fFGa4UZcs/jVCaFF495Y9I=;
        b=UjT3BOTa+qTbnZmopeqgO07Z471ou24BT+HEyrxg/ov2zjGfnK9f730GENA2GCQ9F4
         8pYPrPc8AJZp9AldAG6LkDUJ2xq04vlxv9T1dRjyiLncK73XXDuGmB7ctSMrajSX9GTf
         eO40W3Z7LblVkmHLDucsEdvRQmOI8p+vApLnSPOsMXyiJ1PUu6NurwjhrJlKY0EOHX7B
         QRRDSIND442f2vWKG/z9uqOvqrKQhoh986RWjKk2QIjmQCgVvAgkLNp59jtdx0HWmAVq
         J+5fsQ+Zps2drrw+ofHHL2gceCR2JgyT3zNk3kcLPhic/XtgyIXFeWx4EjvmZL5Iprda
         2Xgw==
X-Gm-Message-State: AOAM531VFFNYr7db1p/pnYTHIpfKQt6f3iB9yq3KpPbrZyRm0VBZksmf
        kyebn0plT9ujgo2cFCLoCngezTOdj+pPO0+ZD89Udw==
X-Google-Smtp-Source: ABdhPJwy1vfNQZQDVVE72SA1/HppIJ+ANP8e2YQaMqPQRoEHa1oHuTdWoG9xh3SZl2KCgAetkOywA6CCUAUxOlAF/5U=
X-Received: by 2002:a05:6512:3481:: with SMTP id v1mr2853789lfr.193.1616001116260;
 Wed, 17 Mar 2021 10:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210317064148.GA55123@embeddedor>
In-Reply-To: <20210317064148.GA55123@embeddedor>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 17 Mar 2021 18:11:29 +0100
Message-ID: <CAG48ez2RDqKwx=umOHjo_1mYyNQgzvcP=KOw1HgSo4Prs_VQDw@mail.gmail.com>
Subject: Re: [PATCH][next] ixgbe: Fix out-of-bounds warning in ixgbe_host_interface_command()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        intel-wired-lan@lists.osuosl.org,
        Network Development <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Mar 17, 2021 at 8:43 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
> Fix the following out-of-bounds warning by replacing the one-element
> array in an anonymous union with a pointer:
>
>   CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_common.o
> drivers/net/ethernet/intel/ixgbe/ixgbe_common.c: In function =E2=80=98ixg=
be_host_interface_command=E2=80=99:
> drivers/net/ethernet/intel/ixgbe/ixgbe_common.c:3729:13: warning: array s=
ubscript 1 is above array bounds of =E2=80=98u32[1]=E2=80=99 {aka =E2=80=98=
unsigned int[1]=E2=80=99} [-Warray-bounds]
>  3729 |   bp->u32arr[bi] =3D IXGBE_READ_REG_ARRAY(hw, IXGBE_FLEX_MNG, bi)=
;
>       |   ~~~~~~~~~~^~~~
> drivers/net/ethernet/intel/ixgbe/ixgbe_common.c:3682:7: note: while refer=
encing =E2=80=98u32arr=E2=80=99
>  3682 |   u32 u32arr[1];
>       |       ^~~~~~
>
> This helps with the ongoing efforts to globally enable -Warray-bounds.
>
> Notice that, the usual approach to fix these sorts of issues is to
> replace the one-element array with a flexible-array member. However,
> flexible arrays should not be used in unions. That, together with the
> fact that the array notation is not being affected in any ways, is why
> the pointer approach was chosen in this case.
>
> Link: https://github.com/KSPP/linux/issues/109
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/ne=
t/ethernet/intel/ixgbe/ixgbe_common.c
> index 62ddb452f862..bff3dc1af702 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> @@ -3679,7 +3679,7 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *h=
w, void *buffer,
>         u32 hdr_size =3D sizeof(struct ixgbe_hic_hdr);
>         union {
>                 struct ixgbe_hic_hdr hdr;
> -               u32 u32arr[1];
> +               u32 *u32arr;
>         } *bp =3D buffer;
>         u16 buf_len, dword_len;
>         s32 status;

This looks bogus. An array is inline, a pointer points elsewhere -
they're not interchangeable.
