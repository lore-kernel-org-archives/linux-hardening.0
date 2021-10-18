Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12C6C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Oct 2021 10:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7E1560F57
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Oct 2021 10:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhJRKCu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Oct 2021 06:02:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:3995 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229848AbhJRKCu (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Oct 2021 06:02:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10140"; a="289068112"
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="289068112"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 03:00:11 -0700
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="493521361"
Received: from foboril-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.44.188])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 03:00:04 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Len Baker <len.baker@gmx.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Len Baker <len.baker@gmx.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Prefer struct_size over open coded arithmetic
In-Reply-To: <20211016111602.GA1996@titan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211003104258.18550-1-len.baker@gmx.com> <20211011092304.GA5790@titan> <87k0ihxj56.fsf@intel.com> <YWbIQmD1TGikpRm2@phenom.ffwll.local> <20211016111602.GA1996@titan>
Date:   Mon, 18 Oct 2021 13:00:01 +0300
Message-ID: <877deatzz2.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, 16 Oct 2021, Len Baker <len.baker@gmx.com> wrote:
> Hi Daniel and Jani,
>
> On Wed, Oct 13, 2021 at 01:51:30PM +0200, Daniel Vetter wrote:
>> On Wed, Oct 13, 2021 at 02:24:05PM +0300, Jani Nikula wrote:
>> > On Mon, 11 Oct 2021, Len Baker <len.baker@gmx.com> wrote:
>> > > Hi,
>> > >
>> > > On Sun, Oct 03, 2021 at 12:42:58PM +0200, Len Baker wrote:
>> > >> As noted in the "Deprecated Interfaces, Language Features, Attributes,
>> > >> and Conventions" documentation [1], size calculations (especially
>> > >> multiplication) should not be performed in memory allocator (or similar)
>> > >> function arguments due to the risk of them overflowing. This could lead
>> > >> to values wrapping around and a smaller allocation being made than the
>> > >> caller was expecting. Using those allocations could lead to linear
>> > >> overflows of heap memory and other misbehaviors.
>> > >>
>> > >> In this case these are not actually dynamic sizes: all the operands
>> > >> involved in the calculation are constant values. However it is better to
>> > >> refactor them anyway, just to keep the open-coded math idiom out of
>> > >> code.
>> > >>
>> > >> So, add at the end of the struct i915_syncmap a union with two flexible
>> > >> array members (these arrays share the same memory layout). This is
>> > >> possible using the new DECLARE_FLEX_ARRAY macro. And then, use the
>> > >> struct_size() helper to do the arithmetic instead of the argument
>> > >> "size + count * size" in the kmalloc and kzalloc() functions.
>> > >>
>> > >> Also, take the opportunity to refactor the __sync_seqno and __sync_child
>> > >> making them more readable.
>> > >>
>> > >> This code was detected with the help of Coccinelle and audited and fixed
>> > >> manually.
>> > >>
>> > >> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
>> > >>
>> > >> Signed-off-by: Len Baker <len.baker@gmx.com>
>> > >> ---
>> > >>  drivers/gpu/drm/i915/i915_syncmap.c | 12 ++++++++----
>> > >>  1 file changed, 8 insertions(+), 4 deletions(-)
>> > >
>> > > I received a mail telling that this patch doesn't build:
>> > >
>> > > == Series Details ==
>> > >
>> > > Series: drm/i915: Prefer struct_size over open coded arithmetic
>> > > URL   : https://patchwork.freedesktop.org/series/95408/
>> > > State : failure
>> > >
>> > > But it builds without error against linux-next (tag next-20211001). Against
>> > > which tree and branch do I need to build?
>> >
>> > drm-tip [1]. It's a sort of linux-next for graphics. I think there are
>> > still some branches that don't feed to linux-next.
>>
>> Yeah we need to get gt-next in linux-next asap. Joonas promised to send
>> out his patch to make that happen in dim.
>> -Daniel
>
> Is there a possibility that you give an "Acked-by" tag? And then this patch
> goes to the mainline through the Kees' tree or Gustavo's tree?

If this does not apply to drm-intel-gt-next (or drm-tip), applying it to
some other branch will just cause unnecessary conflicts later on. It's
unnecessary extra work. It's not an urgent fix or anything, there is no
reason to do that. So that's a NAK.

> Or is it better to wait for drm-tip to update?

drm-tip is up to date, it's just that one of the branches that feed to
it is (was?) not feeding to linux-next.

If you're contributing to drm, please consider basing your patches on
top of drm-tip.


BR,
Jani.


>
> Regards,
> Len
>
>>
>> >
>> > BR,
>> > Jani.
>> >
>> >
>> > [1] https://cgit.freedesktop.org/drm/drm-tip
>> >
>> >
>> > >
>> > > Regards,
>> > > Len
>> >
>> > --
>> > Jani Nikula, Intel Open Source Graphics Center
>>
>> --
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> http://blog.ffwll.ch

-- 
Jani Nikula, Intel Open Source Graphics Center
