Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7056AC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Sep 2021 05:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451EA61153
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Sep 2021 05:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhIJFt0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 10 Sep 2021 01:49:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230324AbhIJFtZ (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 10 Sep 2021 01:49:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B26E6113E;
        Fri, 10 Sep 2021 05:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1631252895;
        bh=y+g5+vYmyUBT33D8ySZgMhBpgV0mbcZV0/vKNAb2F1Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HI1Y6wbkyVgz/bIiw+e47tBIHqeKoFOh5luupaOggukfgTNbnUkN68U86p4s4M+tK
         fpFbaSqX6Q4aLODt1Er2DLwUct/DXsdN8jF/GJrGsEgjWlGNe1IbQE4TZi4CMJuj/1
         1Qy/IiNClojXHoFlWmYSIGS6MStf1/ST+gHqsSxY=
Date:   Thu, 9 Sep 2021 22:48:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] rapidio: Avoid bogus __alloc_size warning
Message-Id: <20210909224814.7460f8dfa3134742b90b34eb@linux-foundation.org>
In-Reply-To: <20210910045010.GO1935@kadam>
References: <20210909161409.2250920-1-keescook@chromium.org>
        <20210909132752.4bde36ccf50720e56160f00c@linux-foundation.org>
        <202109091549.FF8E0C61E2@keescook>
        <20210909161109.14b147628de07ed7c20d84ae@linux-foundation.org>
        <202109091849.53C9A8AD@keescook>
        <20210910045010.GO1935@kadam>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, 10 Sep 2021 07:50:10 +0300 Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Thu, Sep 09, 2021 at 06:52:27PM -0700, Kees Cook wrote:
> > On Thu, Sep 09, 2021 at 04:11:09PM -0700, Andrew Morton wrote:
> > > On Thu, 9 Sep 2021 15:51:23 -0700 Kees Cook <keescook@chromium.org> wrote:
> > > 
> > > > > That's an "error", not a warning.  Or is this thanks to the new -Werror?
> > > > 
> > > > This is a "regular" error (__bad_copy_to() uses __compiletime_error()).
> > > > 
> > > > > Either way, I'm inclined to cc:stable on this, because use of gcc-9 on
> > > > > older kernels will be a common thing down the ages.
> > > > > 
> > > > > If it's really an "error" on non-Werror kernels then definitely cc:stable.
> > > > 
> > > > I would expect that as only being needed if __alloc_size was backported
> > > > to -stable, which seems unlikely.
> > > 
> > > Ah.  Changelog didn't tell me that it's an __alloc_size thing.
> > 
> > Er, it's in the Subject, but I guess I could repeat it?
> > 
> 
> This is how the email looks like to Andrew.
> 
> https://sylpheed.sraoss.jp/images/sylpheed2-mainwindow.png
> 
> Try to find the subject in that nonsense.  Same for everyone else on
> email as well.
> 
> https://marc.info/?l=linux-kernel&m=163120404328790&w=2
> 
> I only either read the subject or the body of the commit message and
> never both.  :P

I read the body if the subject looks relevant ;)

But that subject reads to me as "rapidio: Avoid bogus *blah* warning". 
We have soooooo many alloc_foo functions that one's eyes glaze over
something like "alloc_size"

Why?  Because the identifier "__alloc_size" is of great significance
to Kees because he wrote the thing.  Everyone else just sees "*blah*".
