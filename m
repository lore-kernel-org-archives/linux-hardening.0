Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433C5C6FD1E
	for <linux-hardening@archiver.kernel.org>; Wed,  8 Mar 2023 15:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjCHP1L (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 8 Mar 2023 10:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjCHP1K (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 8 Mar 2023 10:27:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC82C5616
        for <linux-hardening@vger.kernel.org>; Wed,  8 Mar 2023 07:27:07 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7F4081FE47;
        Wed,  8 Mar 2023 15:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678289226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZGjH5COgVdP8437ejGbqbCLhP6qbEkoX1bMEbmXg6s8=;
        b=ZYmQz5nlHTN0xS9mbciT79+soTvuQE30ot9nFoBK+YhirN7CQ6VlyRudO0INMDTd4jsPr2
        AUHH4gdGUc9qeSydyeYaWujgN1rPllpTHCRwTPCTcNzj3nIp4jQ6AwZXyVzUzTQcdB92XS
        4vvChGrt0yR5g9dGPq0EXpRXmzm59zI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678289226;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZGjH5COgVdP8437ejGbqbCLhP6qbEkoX1bMEbmXg6s8=;
        b=Z3HWQqX4PISkUhZTkMUt+ftG9Z2fQfTBHHQMt8QOmAXIJqJcWliSQR0gTzEe1vWIiUUFWW
        mxjCE658vsJgLIAA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DADEE2C141;
        Wed,  8 Mar 2023 15:27:03 +0000 (UTC)
Date:   Wed, 8 Mar 2023 16:27:02 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>,
        ajd@linux.ibm.com, anshuman.khandual@arm.com, npiggin@gmail.com,
        linux-hardening@vger.kernel.org, aneesh.kumar@linux.ibm.com,
        nicholas@linux.ibm.com
Subject: Re: [PATCH v4 1/2] powerpc/mm: Support execute-only memory on the
 Radix MMU
Message-ID: <20230308152702.GR19419@kitsune.suse.cz>
References: <20220817050640.406017-1-ruscur@russell.cc>
 <166195163958.45984.15308325694886524412.b4-ty@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166195163958.45984.15308325694886524412.b4-ty@ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello,

On Wed, Aug 31, 2022 at 11:13:59PM +1000, Michael Ellerman wrote:
> On Wed, 17 Aug 2022 15:06:39 +1000, Russell Currey wrote:
> > Add support for execute-only memory (XOM) for the Radix MMU by using an
> > execute-only mapping, as opposed to the RX mapping used by powerpc's
> > other MMUs.
> > 
> > The Hash MMU already supports XOM through the execute-only pkey,
> > which is a separate mechanism shared with x86.  A PROT_EXEC-only mapping
> > will map to RX, and then the pkey will be applied on top of it.
> > 
> > [...]
> 
> Applied to powerpc/next.
> 
> [1/2] powerpc/mm: Support execute-only memory on the Radix MMU
>       https://git.kernel.org/powerpc/c/395cac7752b905318ae454a8b859d4c190485510

This breaks libaio tests (on POWER9 hash PowerVM):
https://pagure.io/libaio/blob/master/f/harness/cases/5.t#_43

cases/5.p
expect   512: (w), res =   512 [Success]
expect   512: (r), res =   512 [Success]
expect   512: (r), res =   512 [Success]
expect   512: (w), res =   512 [Success]
expect   512: (w), res =   512 [Success]
expect   -14: (r), res =   -14 [Bad address]
expect   512: (r), res =   512 [Success]
expect   512: (w), res =   512 [Success]
test cases/5.t completed PASSED.

cases/5.p
expect   512: (w), res =   512 [Success]
expect   512: (r), res =   512 [Success]
expect   512: (r), res =   512 [Success]
expect   512: (w), res =   512 [Success]
expect   512: (w), res =   512 [Success]
expect   -14: (r), res =   -14 [Bad address]
expect   512: (r), res =   512 [Success]
expect   -14: (w), res =   512 [Success] -- FAILED
test cases/5.t completed FAILED.

Can you have a look if that test assumption is OK?

Thanks

Michal
