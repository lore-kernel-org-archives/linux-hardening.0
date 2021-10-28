Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C61C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Oct 2021 17:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184F760F38
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Oct 2021 17:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhJ1Rfn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 28 Oct 2021 13:35:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhJ1Rfn (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 28 Oct 2021 13:35:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D018960296;
        Thu, 28 Oct 2021 17:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635442395;
        bh=XA/MQSlcp4ctFJUiuMolr/e1TlKVq0ib84LjTsjf758=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o7XIZfpN2EylO/+qIscP2AHoQB9g3JvcZrrardPff+9HfiskvhjPMQauRhzlW3UYG
         cNbFIC23oli5Auqe810O/50v2jeE+zNHs7rilp/CR2W+FCX/FUqRXvlfHZp57+HxfF
         rjD1UqiKBJluiiDrWKejRw+ZY05fnlHUyFzP7jikxzEnTMchN8mgVgpMusJBW/30DV
         5yBDLl0xsRs2VNfhnlQ048kWZnl2dWYdKellWu94RdPm7EUb8ac3GB96lrqf5Ymugw
         5WX1IZAsZihK4y4GnymYjnoNmaNohl4DEY5aTdAZJ6aKKnDhj3wzam5Kc67cNI0nE3
         7jCqUgmR8LeXA==
Date:   Thu, 28 Oct 2021 12:38:13 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Karol Herbst <kherbst@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] nouveau/svm: Use kvcalloc() instead of kvzalloc()
Message-ID: <20211028173813.GA1507412@embeddedor>
References: <20210928222513.GA294575@embeddedor>
 <CACO55tsD98dNzw8fP=CiKLsdbnn2Vg78+wTRM90kutHtv1RZ5A@mail.gmail.com>
 <202110211002.CB975695@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110211002.CB975695@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 21, 2021 at 10:03:19AM -0700, Kees Cook wrote:
> On Wed, Sep 29, 2021 at 05:28:47AM +0200, Karol Herbst wrote:
> > Lack of documentation inside Linux here is a bit annoying, but do I
> > understand it correctly, that the main (and probably only) difference
> > is that kvcalloc checks whether the multiplication overflows and
> > returns NULL in this case?
> 
> That's correct. :)
> 
> > On Wed, Sep 29, 2021 at 12:21 AM Gustavo A. R. Silva
> > <gustavoars@kernel.org> wrote:
> > >
> > > Use 2-factor argument form kvcalloc() instead of kvzalloc().
> > >
> > > Link: https://github.com/KSPP/linux/issues/162
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

I'll take this in my -next tree.

Thanks
--
Gustavo
