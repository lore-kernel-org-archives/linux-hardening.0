Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15E7C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Nov 2022 03:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiKJDUt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Nov 2022 22:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiKJDUs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Nov 2022 22:20:48 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C3D2E9E5
        for <linux-hardening@vger.kernel.org>; Wed,  9 Nov 2022 19:20:47 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13b23e29e36so921953fac.8
        for <linux-hardening@vger.kernel.org>; Wed, 09 Nov 2022 19:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sKG4G9h9TOTqgYAsSpAovfgI8PcnagrrLPJ5Dk9nkwM=;
        b=n4wtwl3i3PgLhMLKzXNZyDNN/91PNYF/iQdfqKTPEOylqZJVL9o0xC2pwZaIxbKexM
         SR+QPhCjQ6xLqbw6ja5Pjj8+92+Iwjm0eC2Kt8Ij+l8JBPu7wrT+Pc33C6A+2jFvu+kg
         x1PS/IdcF1JwfEXJ15aZBkchXsEkivh0MJMlkAniT3ZaVNBJr23/Qg7dzBAZYJx6dboE
         2fGMp9KJkHTnldkcR4Xixiw5cFCOV4LgQTwVXhRQ0kgGdkP7ObmLKEXKJsyOz5JSWCxo
         TIBjGQLspF1YAqUUeZJbypIcaG6YEH2NvTtDJomz2aEGkpfceAJ5Ayp6cHTNcj6AOABc
         9ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKG4G9h9TOTqgYAsSpAovfgI8PcnagrrLPJ5Dk9nkwM=;
        b=0sy+APeXENJfPPJJW+Cjhy5PxD0Z2J33sMKdGJKtaHtIUuiAzHUsnUYSfBF4u5zTVJ
         psul2y3jL5e12IfGp5d4hVv1C+uZnaeqqXXCION5eCW2zTbs9LgY/sRvvyFn26ftQ68W
         AWQszxmT3+Dfu76pBiL/kiqHUQwkjt+Ssi+orQ5t1KUCYiWB36dZdd2UkuqYU6zNXcYr
         jViUo7tjRi1HaTEbjTlsI0duZabPcmH+9/Iv1dzmMLpHinDd+cJ5KL9jvavvJPOMOkf3
         JfA5zj1piEI6VvPUCLPr/csnpIyUDdZ8rc53Dk+PR1Q3d7EctRFMi4l6GToBNm6IrkmL
         TJYg==
X-Gm-Message-State: ACrzQf3dS7+FN6IKM4+kljWvCHCdA2PyHMwHHAPMDI4upIdN1RmQIw/C
        AZMRs84KETOeG75zz4yaPUaH82h0MjBkmHve3DyIYZGfc78=
X-Google-Smtp-Source: AMsMyM5znauZhG62dW+SB19EIKJtR+jeY3ZOk38/PiLmhOxvQ2TETT3VRqjFEuDmG+dHN5beLp10tLOL2HF6BB9S8Wg=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr37758133oao.96.1668050446788; Wed, 09
 Nov 2022 19:20:46 -0800 (PST)
MIME-Version: 1.0
References: <Y2siZmiTD40mTYpJ@mail.google.com> <Y2xJxUnDnesWYckj@work> <Y2xUc9Q/+zTYbjaL@mail.google.com>
In-Reply-To: <Y2xUc9Q/+zTYbjaL@mail.google.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 9 Nov 2022 22:20:34 -0500
Message-ID: <CADnq5_NKeqFm9ysEC78gYFL_PKzgSfXBa6v6rB+sE8aYZffqfA@mail.gmail.com>
Subject: Re: [RFC] Approaches to deal with a struct with multiple fake
 flexible arrays members
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Nov 9, 2022 at 8:31 PM Paulo Miguel Almeida
<paulo.miguel.almeida.rodenas@gmail.com> wrote:
>
> On Wed, Nov 09, 2022 at 06:45:57PM -0600, Gustavo A. R. Silva wrote:
> > On Wed, Nov 09, 2022 at 04:45:42PM +1300, Paulo Miguel Almeida wrote:
> >
> > Adding Alex, Christian and DRM lists to the thread.
>
> Thanks so much for your reply Gustavo
> Yep, that's a good idea.
>
> >
> > > struct _ATOM_INIT_REG_BLOCK {
> > >     USHORT                     usRegIndexTblSize;    /*     0     2 */
> > >     USHORT                     usRegDataBlkSize;     /*     2     2 */
> > >     ATOM_INIT_REG_INDEX_FORMAT asRegIndexBuf[1];     /*     4     3 */
> > >     ATOM_MEMORY_SETTING_DATA_BLOCK asRegDataBuf[1];  /*     7     8 */
> >
> > I didn't find evidence that asRegDataBuf is used anywhere in the
> > codebase[1].
> > ...
> > <snip>
> > ...
> > As I pointed out above, I don't see asRegDataBuf[] being used in the
> > codebase (of course it may describe firmware memory layout). Instead,
> > there is this jump to a block of data past asRegIndexBuf[]:
> >
> > drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c:1444:
> > 1444: ATOM_MEMORY_SETTING_DATA_BLOCK *reg_data =
> > 1445:         (ATOM_MEMORY_SETTING_DATA_BLOCK *)
> > 1446:         ((u8 *)reg_block + (2 * sizeof(u16)) +
> > 1447:                  le16_to_cpu(reg_block->usRegIndexTblSize));
> >
> > So, it seems the one relevant array, from the kernel side, is
> > asRegIndexBuf[]. I wonder if we really need asRegDataBuf[] in that
> > structure... or if we could try modifying that struct and only have
> > asRegIndexBuf[] as last member? and then we can transform it into a
> > flex-array member.
>
> I saw that one too. That would be the way it's currently accessing
> asRegDataBuf member as the existing struct would make asRegDataBuf[0] point
> to some index within the asRegIndexBuf member (as you probably got it too)
>
> you are right... asRegDataBuff isn't used from a static analysis
> point of view but removing it make the code a bit cryptic, right?
>
> That's pickle, ay? :-)
>
> >
> > If for any strong reasong we cannot remove asRegDataBuf[] then I think we
> > could give it a try and use DECLARE_FLEX_ARRAY() to declare both arrays
> > in the structure.
> >
>
> Out of curiosity, why both rather than just asRegIndexBuf?
>
> > But first, of course, Alex, Christian, it'd be really great if we can
> > have your input and feedback. :)

This header describes the layout of memory stored in the ROM on the
GPU.  It's shared between vbios and driver so some parts aren't
necessarily directly used by the driver.  As for what to do about it,
I'm not sure.  This structure stores a set of register offsets
(asRegIndexBuf) and data values (asRegDataBuf) for specific operations
(e.g., walk this structure and program register X with value Y.  For a
little background on atombios, it's a set of data and command tables
stored in the vbios ROM image.  The driver has an interpreter for the
command tables (see atom.c) so it can parse the command tables to
initialize the asic to a usable state.  The various programming
sequences vary depending on the components the AIB/OEM uses for the
board (different vram vendors, different clock/voltage settings,
etc.).  The legacy VGA/VBE and the GOP driver and the OS driver can
use these tables, so this allows us to initialize any GPU in a generic
way on any architecture even if the platform firmware doesn't post the
card.  For the most part the driver doesn't have to deal with these
particular tables directly, other than for some very specific cases
where the driver needs to grab some elements from the tables to
populate the power management controller for GPU memory reclocking
parameters.  However, the command tables as interpreted by the parser
very often will directly parse these tables.  So you might have a
command table that the driver executes to initialize some part of the
GPU which ultimately fetches the table from the ROM image and walks it
programming registers based on the offset and values in that table.
So if you were debugging something that involves the atombios parser
and walking through one of the command tables, you may be confused if
the data tables don't match what header says.  So ideally, we'd keep
both arrays.

Alex

> >
> > Thanks!
> > --
> > Gustavo
> >
>
> - Paulo A.
