Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FADC433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Nov 2022 01:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiKJBbl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Nov 2022 20:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiKJBbk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Nov 2022 20:31:40 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7CF2529C
        for <linux-hardening@vger.kernel.org>; Wed,  9 Nov 2022 17:31:39 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so3495283pjs.4
        for <linux-hardening@vger.kernel.org>; Wed, 09 Nov 2022 17:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESGvSPPpnxewtL8pi4sMSmnNLSQrLzT7c9wFSP1Mtus=;
        b=NAYDx00fz3eoOTlewhQR7o4e751lSsrceQ0OUlTgFBSTpy8xTcHEAfiDCdzyJZLVcd
         zD7wypzeEKkJU31LVaD+rsGZ8S1xIrD4mdsyXlZFZTmfa8pJuT8X/lP8IyWA+rwYCxwZ
         JdBK5jGzxVFf8+6lkhqgy5wKz7rm8SuyxlpCFc7HM03Mp+7Cd55+dhUZbQE1HE+3yH0z
         thBlAKBNPGMRsOPfwlR1SaJhzw4NXJ3S+cnJyo/QjZkyu5++XS+JKXGs8ZtM+gMFwEgd
         UB5No4mfeslf0izpQwA2wj4mZwqG7BtkVdLQEeAJHlOykYUMhFTFHVO1jmzDQAu9Ob36
         N2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESGvSPPpnxewtL8pi4sMSmnNLSQrLzT7c9wFSP1Mtus=;
        b=X3II7t4GfikjwCng1D5MophZhV36mngmXyvldzc2e2jwGbcIcLObmOuJamhC6KB6vq
         cq5W/4ONBWpR4h0LfHeLvO5EC6dUxK3rzYGOmGE7IM4ByMfp1w/fPxh/WjKVuUq15r4T
         ose7bhXQxkIB2d2d4FS60os+6vyB1WHMwoR4yptTrOuhvJA+3UXMGykT+aKMHoeVQeoM
         2CYyLlbT/kXNlmNm1e26GhKpGWFRf+ONoOeQ1V1bvss7omdOjr8C5V5SbuxBeGn92w1W
         FFm6GtrRj53JKwtnKRtbHYH0mbEKzgRNMIC/DiBJds65jkyCsmy7xKc9bhsqvSR2u0EX
         8u5Q==
X-Gm-Message-State: ACrzQf1o4MLKWZ/QfApZvxu6iOHym4lRdYu+MFztu/oAEuGepIH/Jwc3
        du2+aZ1V/h2Lgb8EOXh1z6Q=
X-Google-Smtp-Source: AMsMyM68UBlS9+k6pCVedRW0PWRn5b2sKHi5M+jsS5QYeObRwefSgCmbUAunNDc6lmtRrOn7Sn4ZWw==
X-Received: by 2002:a17:90b:3690:b0:213:c985:b5ee with SMTP id mj16-20020a17090b369000b00213c985b5eemr59252195pjb.192.1668043898772;
        Wed, 09 Nov 2022 17:31:38 -0800 (PST)
Received: from mail.google.com (125-237-50-34-fibre.sparkbb.co.nz. [125.237.50.34])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090301d100b00177f25f8ab3sm9897101plh.89.2022.11.09.17.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 17:31:38 -0800 (PST)
Date:   Thu, 10 Nov 2022 14:31:31 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: Re: [RFC] Approaches to deal with a struct with multiple fake
 flexible arrays members
Message-ID: <Y2xUc9Q/+zTYbjaL@mail.google.com>
References: <Y2siZmiTD40mTYpJ@mail.google.com>
 <Y2xJxUnDnesWYckj@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2xJxUnDnesWYckj@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Nov 09, 2022 at 06:45:57PM -0600, Gustavo A. R. Silva wrote:
> On Wed, Nov 09, 2022 at 04:45:42PM +1300, Paulo Miguel Almeida wrote:
> 
> Adding Alex, Christian and DRM lists to the thread.

Thanks so much for your reply Gustavo 
Yep, that's a good idea.

> 
> > struct _ATOM_INIT_REG_BLOCK {
> > 	USHORT                     usRegIndexTblSize;    /*     0     2 */
> > 	USHORT                     usRegDataBlkSize;     /*     2     2 */
> > 	ATOM_INIT_REG_INDEX_FORMAT asRegIndexBuf[1];     /*     4     3 */
> > 	ATOM_MEMORY_SETTING_DATA_BLOCK asRegDataBuf[1];  /*     7     8 */
> 
> I didn't find evidence that asRegDataBuf is used anywhere in the
> codebase[1].
> ...
> <snip> 
> ...
> As I pointed out above, I don't see asRegDataBuf[] being used in the
> codebase (of course it may describe firmware memory layout). Instead,
> there is this jump to a block of data past asRegIndexBuf[]:
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c:1444:
> 1444:	ATOM_MEMORY_SETTING_DATA_BLOCK *reg_data =
> 1445:		(ATOM_MEMORY_SETTING_DATA_BLOCK *)
> 1446:		((u8 *)reg_block + (2 * sizeof(u16)) +
> 1447:			 le16_to_cpu(reg_block->usRegIndexTblSize));
> 
> So, it seems the one relevant array, from the kernel side, is
> asRegIndexBuf[]. I wonder if we really need asRegDataBuf[] in that
> structure... or if we could try modifying that struct and only have
> asRegIndexBuf[] as last member? and then we can transform it into a
> flex-array member.

I saw that one too. That would be the way it's currently accessing
asRegDataBuf member as the existing struct would make asRegDataBuf[0] point 
to some index within the asRegIndexBuf member (as you probably got it too)

you are right... asRegDataBuff isn't used from a static analysis
point of view but removing it make the code a bit cryptic, right?

That's pickle, ay? :-)

> 
> If for any strong reasong we cannot remove asRegDataBuf[] then I think we
> could give it a try and use DECLARE_FLEX_ARRAY() to declare both arrays
> in the structure.
> 

Out of curiosity, why both rather than just asRegIndexBuf?

> But first, of course, Alex, Christian, it'd be really great if we can
> have your input and feedback. :)
> 
> Thanks!
> --
> Gustavo
> 

- Paulo A.
