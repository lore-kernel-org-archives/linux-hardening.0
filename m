Return-Path: <SRS0=DAdQ=DP=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FEAC4363C
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 13:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3215320578
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 13:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602162916;
	bh=UWoDqHo+eFm+eSQ5OGgFYUjO6Z7d50msPdjJxQyta2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fIJ7lY9h11UaCJrUG1S+lFWATQGbaf1z50mb/VvYKW0UovW2c7r11Dzd5DZ/e+Yq4
	 tgFDrUg8QjD7MMkLcTl4Fa1nUohD/N2bu9RmttQ8mL/HyiZ2QeJj/Zm5Z19nTlYPob
	 BiNA91+QUnqgM1RC6ijOBpispK11zYdHwPjZuLfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgJHNPQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Oct 2020 09:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgJHNPP (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Oct 2020 09:15:15 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A848520578;
        Thu,  8 Oct 2020 13:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602162914;
        bh=UWoDqHo+eFm+eSQ5OGgFYUjO6Z7d50msPdjJxQyta2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ug5I0Ytyqwx21KzKcI1lwgbskPJV9lRdMWFNxDBMkUzgIpc6O116yMh595eB4NqaW
         qYSjnz2AYeX27cEJLjiJC7mNDjgO10c+b9f4mLSVqwvTyxNvHjtaoOiHGw1LX9R3Sq
         pXc8OjlgAx6C5b7blalo7EMPtg3k5MxPXIHGJlu4=
Date:   Thu, 8 Oct 2020 08:20:36 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 00/14] drm/amd/pm: Replace one-element arrays with
 flexible-array members
Message-ID: <20201008132036.GB6588@embeddedor>
References: <cover.1602020074.git.gustavoars@kernel.org>
 <d71c8436-334c-45d9-d464-9798e75f2a73@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d71c8436-334c-45d9-d464-9798e75f2a73@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 08, 2020 at 09:19:47AM +0200, Christian König wrote:
> Am 07.10.20 um 18:01 schrieb Gustavo A. R. Silva:
> > Hi all,
> > 
> > This series aims to replace one-element arrays with flexible-array
> > members.
> > 
> > There is a regular need in the kernel to provide a way to declare having
> > a dynamically sized set of trailing elements in a structure. Kernel code
> > should always use “flexible array members”[1] for these cases. The older
> > style of one-element or zero-length arrays should no longer be used[2].
> > 
> > Refactor the code according to the use of flexible-array members, instead
> > of one-element arrays, and use the struct_size() helper to calculate the
> > size for the dynamic memory allocation.
> > 
> > Also, save some heap space in the process. More on this on each individual
> > patch.
> 
> Ah! Nice to see that finally be documented and cleaned up.
> 
> Feel free to add an Acked-by: Christian König <christian.koenig@amd.com>
> 
> I also know about a case where we don't use struct_size in the DMA-buf code.
> 
> I'm the maintainer of that stuff as well, so be prepared to get patches
> thrown at you to clean that up as well.

No problem. Feel free to send all of those my way. :)

Thanks
--
Gustavo

> 
> Thanks,
> Christian.
> 
> > 
> > This series also addresses multiple of the following sorts of warnings:
> > 
> > drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu8_hwmgr.c:1515:37:
> > warning: array subscript 1 is above array bounds of ‘const struct
> > phm_clock_voltage_dependency_record[1]’ [-Warray-bounds]
> > 
> > which, in this case, they are false positives, but nervertheless should be
> > fixed in order to enable -Warray-bounds[3][4].
> > 
> > [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FFlexible_array_member&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C5312862a3b8c41838ef508d86ad969c1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637376829947099179&amp;sdata=5LEWyR8pYSxmHsqhHiYiOS%2BPPk%2Fm5suOc6H7f5cIBL4%3D&amp;reserved=0
> > [2] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2Fhtml%2Fv5.9-rc1%2Fprocess%2Fdeprecated.html%23zero-length-and-one-element-arrays&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C5312862a3b8c41838ef508d86ad969c1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637376829947099179&amp;sdata=wOqxnNkA9FnOI%2BfB3dHn9RU7cqPJ62qqGCK9gsd2i%2Bo%3D&amp;reserved=0
> > [3] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Flinus%2F44720996e2d79e47d508b0abe99b931a726a3197&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C5312862a3b8c41838ef508d86ad969c1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637376829947099179&amp;sdata=x%2BSJeOrQA11HXoTaZEdyLyNWL9rC4GngDyoDMRBUn4M%3D&amp;reserved=0
> > [4] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FKSPP%2Flinux%2Fissues%2F109&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C5312862a3b8c41838ef508d86ad969c1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637376829947099179&amp;sdata=48155uVo7AboCdSZfsTP10i2rHfBJctG%2F432lD%2BpfHo%3D&amp;reserved=0
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
> >   .../powerplay/hwmgr/vega10_processpptables.c  | 88 ++++++-------------
> >   8 files changed, 107 insertions(+), 188 deletions(-)
> > 
> 
