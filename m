Return-Path: <SRS0=DAdQ=DP=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C92C43457
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 16:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12CC6206F0
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 16:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gu/Sv0y8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbgJHQAi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Oct 2020 12:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731539AbgJHPxt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Oct 2020 11:53:49 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD27DC0613D2;
        Thu,  8 Oct 2020 08:53:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k18so7020217wmj.5;
        Thu, 08 Oct 2020 08:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zfnSh1S7AyPLXhddsPPCiUSDnY9RVRvL/aKUF/eOH70=;
        b=gu/Sv0y8h5LSilfHz1MlSh63wBSqedxUpjHZ9D7e7N2KII5tH40//lqH6Fz5UX14ER
         yWvPU8RWuCFlzEETOWn8TqUJmOsaOtWtUrjk+Qe2g5Ik1i3APa/dZeWp3RV3F7dkmyqf
         aXy6M7xwzCfDsWL7DsaE2kWcPHTozXSKfHq9iW3ggLRp61PupjQ5Wh3hOt+o4+gxNlJY
         HeDSM89yFYmjZZwyrui0CcRx4d1kHmPnWAZav0k18FphCpge7vr9gFFlaEwo4HTxgg9G
         z2z930PDCXH39lBpsUOKBuL9TEYHJsrEU3w0zJBHvn4FoFSx3nsjbMQojwb6W+kygXi5
         DZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zfnSh1S7AyPLXhddsPPCiUSDnY9RVRvL/aKUF/eOH70=;
        b=mbLRBmZfQJiD+ItQmzCEvNjitrp/7FdoaBqBc022Abl33KC0EfZIjsr2iovirpHVWZ
         fVrmei23Gv9926DC8w5/wMjQwM/CZFdD3qBRccMlLsvWyD00S/5eygPKFTkzztq/87+0
         RK7WiCBmscZWs/ufPSUeuEQuT0KphyrFD33uDFfnrEPj4cd2yIbLDUrWo6IcY2nFs2Gs
         XYZkTP1wu2wooQcRA6r/xi//Dqc22XO3PKmK9+6m8QlNiMc65BZnDMIxXu2FKJDSBrTS
         a7TGZjQG43dqjiyo+VWLZrGM7id9s723bB2+DB5Ho1HZGlybMlBxopuxTifIlsz5UgAx
         J/wQ==
X-Gm-Message-State: AOAM531rhRVBWwG6IGztAxJvJv/IgW4WO//zVsacolpB9r3i0ZkNvah1
        gwzvrJ7D8N3kCA/LlbkaaRxGNF0YCXnwJZhoSmI=
X-Google-Smtp-Source: ABdhPJy/tXQQdC55L192BlAu88uxZZ2IKYZOOTv9bZVSpdIXRW5uMtsF9H/ESiLz3OiNlXuEgE+LvtzdwHwx4rgwlwY=
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr5233566wmk.73.1602172427513;
 Thu, 08 Oct 2020 08:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602020074.git.gustavoars@kernel.org> <d71c8436-334c-45d9-d464-9798e75f2a73@amd.com>
In-Reply-To: <d71c8436-334c-45d9-d464-9798e75f2a73@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 8 Oct 2020 11:53:36 -0400
Message-ID: <CADnq5_O3KSo3ZkhS0HKiyzM1h-LccUHUOkqi4FE_KnSGHZJiGQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] drm/amd/pm: Replace one-element arrays with
 flexible-array members
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 8, 2020 at 3:20 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 07.10.20 um 18:01 schrieb Gustavo A. R. Silva:
> > Hi all,
> >
> > This series aims to replace one-element arrays with flexible-array
> > members.
> >
> > There is a regular need in the kernel to provide a way to declare havin=
g
> > a dynamically sized set of trailing elements in a structure. Kernel cod=
e
> > should always use =E2=80=9Cflexible array members=E2=80=9D[1] for these=
 cases. The older
> > style of one-element or zero-length arrays should no longer be used[2].
> >
> > Refactor the code according to the use of flexible-array members, inste=
ad
> > of one-element arrays, and use the struct_size() helper to calculate th=
e
> > size for the dynamic memory allocation.
> >
> > Also, save some heap space in the process. More on this on each individ=
ual
> > patch.
>
> Ah! Nice to see that finally be documented and cleaned up.
>
> Feel free to add an Acked-by: Christian K=C3=B6nig <christian.koenig@amd.=
com>

Applied 1-13.  patch 14 is changing a file shared with firmware, so I
left it for consistency.

Thanks!

Alex

>
> I also know about a case where we don't use struct_size in the DMA-buf co=
de.
>
> I'm the maintainer of that stuff as well, so be prepared to get patches
> thrown at you to clean that up as well.
>
> Thanks,
> Christian.
>
> >
> > This series also addresses multiple of the following sorts of warnings:
> >
> > drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu8_hwmgr.c:1515:37:
> > warning: array subscript 1 is above array bounds of =E2=80=98const stru=
ct
> > phm_clock_voltage_dependency_record[1]=E2=80=99 [-Warray-bounds]
> >
> > which, in this case, they are false positives, but nervertheless should=
 be
> > fixed in order to enable -Warray-bounds[3][4].
> >
> > [1] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fen.wikipedia.org%2Fwiki%2FFlexible_array_member&amp;data=3D02%7C01%7Cchris=
tian.koenig%40amd.com%7C5312862a3b8c41838ef508d86ad969c1%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637376829947099179&amp;sdata=3D5LEWyR8pYSxmHsqhH=
iYiOS%2BPPk%2Fm5suOc6H7f5cIBL4%3D&amp;reserved=3D0
> > [2] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fwww.kernel.org%2Fdoc%2Fhtml%2Fv5.9-rc1%2Fprocess%2Fdeprecated.html%23zero-=
length-and-one-element-arrays&amp;data=3D02%7C01%7Cchristian.koenig%40amd.c=
om%7C5312862a3b8c41838ef508d86ad969c1%7C3dd8961fe4884e608e11a82d994e183d%7C=
0%7C0%7C637376829947099179&amp;sdata=3DwOqxnNkA9FnOI%2BfB3dHn9RU7cqPJ62qqGC=
K9gsd2i%2Bo%3D&amp;reserved=3D0
> > [3] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgit.kernel.org%2Flinus%2F44720996e2d79e47d508b0abe99b931a726a3197&amp;data=
=3D02%7C01%7Cchristian.koenig%40amd.com%7C5312862a3b8c41838ef508d86ad969c1%=
7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637376829947099179&amp;sdata=
=3Dx%2BSJeOrQA11HXoTaZEdyLyNWL9rC4GngDyoDMRBUn4M%3D&amp;reserved=3D0
> > [4] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgithub.com%2FKSPP%2Flinux%2Fissues%2F109&amp;data=3D02%7C01%7Cchristian.ko=
enig%40amd.com%7C5312862a3b8c41838ef508d86ad969c1%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637376829947099179&amp;sdata=3D48155uVo7AboCdSZfsTP10i2=
rHfBJctG%2F432lD%2BpfHo%3D&amp;reserved=3D0
> >
> > Gustavo A. R. Silva (14):
> >    drm/amd/pm: Replace one-element array with flexible-array member
> >    drm/amd/pm: Replace one-element array with flexible-array member in
> >      struct vi_dpm_table
> >    drm/amd/pm: Replace one-element array with flexible-array in struct
> >      phm_clock_array
> >    drm/amd/pm: Replace one-element array with flexible-array in struct
> >      phm_uvd_clock_voltage_dependency_table
> >    drm/amd/pm: Replace one-element array with flexible-array in struct
> >      phm_acp_clock_voltage_dependency_table
> >    drm/amd/pm: Replace one-element array with flexible-array in struct
> >      phm_phase_shedding_limits_table
> >    drm/amd/pm: Replace one-element array with flexible-array in struct
> >      phm_vce_clock_voltage_dependency_table
> >    drm/amd/pm: Replace one-element array with flexible-array in struct
> >      phm_cac_leakage_table
> >    drm/amd/pm: Replace one-element array with flexible-array in struct
> >      phm_samu_clock_voltage_dependency_table
> >    drm/amd/pm: Replace one-element array with flexible-array in struct
> >      phm_ppt_v1_clock_voltage_dependency_table
> >    drm/amd/pm: Replace one-element array with flexible-array in struct
> >      phm_ppt_v1_mm_clock_voltage_dependency_table
> >    drm/amd/pm: Replace one-element array with flexible-array in struct
> >      phm_ppt_v1_voltage_lookup_table
> >    drm/amd/pm: Replace one-element array with flexible-array in struct
> >      phm_ppt_v1_pcie_table
> >    drm/amd/pm: Replace one-element array with flexible-array in struct
> >      ATOM_Vega10_GFXCLK_Dependency_Table
> >
> >   drivers/gpu/drm/amd/pm/inc/hwmgr.h            | 20 ++---
> >   .../drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h    |  8 +-
> >   .../powerplay/hwmgr/process_pptables_v1_0.c   | 85 +++++++-----------
> >   .../amd/pm/powerplay/hwmgr/processpptables.c  | 85 +++++++-----------
> >   .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |  2 +-
> >   .../drm/amd/pm/powerplay/hwmgr/smu_helper.c   |  5 +-
> >   .../amd/pm/powerplay/hwmgr/vega10_pptable.h   |  2 +-
> >   .../powerplay/hwmgr/vega10_processpptables.c  | 88 ++++++------------=
-
> >   8 files changed, 107 insertions(+), 188 deletions(-)
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
