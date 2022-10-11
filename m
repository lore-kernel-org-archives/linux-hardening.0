Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1F6C433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 11 Oct 2022 19:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJKTiA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 11 Oct 2022 15:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJKTh4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 11 Oct 2022 15:37:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D558168C;
        Tue, 11 Oct 2022 12:37:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DCF9B80E53;
        Tue, 11 Oct 2022 19:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D173CC433C1;
        Tue, 11 Oct 2022 19:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665517072;
        bh=tM+k2PRjMnFQKnulfBCTpnDO1rLKClZIrZ1X0/5RNmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uE+HdSRwqye+MJY/9Zmy9+PSnHPYQ4yWRLoStpQ8CKh4EEBWTBJD4uU44Qk8juTQU
         C9beu2wSDpArQwWhgQSYbUp2ka3Tf+SWpAnX27lZzNaFeqHXO917RoT86xwWBQeExn
         3WsHTwZCIL2E92QiN8JWDNj5SEiRfiAwjzxxQcu9Wew5k9xl5PgzV9CP5r0eP2YySa
         yEV9iyy/l5MEVijNX9I9TOzPWby3fuifV+PyT1Y0PngbanLPS1cOmYujivM8D34Fk3
         +mV+ue9pg399NP7YoYY3gdMDpjyfa8bEO7h7JVmuyZbx0Vbzgvk/CtZD6QfjM2RHwc
         otiBGrNU5hUYg==
Date:   Tue, 11 Oct 2022 14:37:40 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [next] dlm: replace one-element array with fixed size
 array
Message-ID: <Y0XGBKtNOXIz+1T6@work>
References: <Y0XAxX4g/9N6qdnD@mail.google.com>
 <Y0XDAtQ4eYTgwIgM@work>
 <Y0XD9tTd0ahj2jRZ@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0XD9tTd0ahj2jRZ@mail.google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 12, 2022 at 08:28:54AM +1300, Paulo Miguel Almeida wrote:
> On Tue, Oct 11, 2022 at 02:24:50PM -0500, Gustavo A. R. Silva wrote:
> > On Wed, Oct 12, 2022 at 08:15:17AM +1300, Paulo Miguel Almeida wrote:
> > > One-element arrays are deprecated. So, replace one-element array with
> > > fixed size array member in struct dlm_ls, and refactor the rest of the
> > > code, accordingly.
> > > 
> > > Link: https://github.com/KSPP/linux/issues/79
> > > Link: https://github.com/KSPP/linux/issues/228
> > > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836
> > > Link: https://lore.kernel.org/lkml/Y0W5jkiXUkpNl4ap@mail.google.com/
> > > 
> > > Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> > 
> > I think this should be versioned as v3.
> > 
> I didn't add v3 here because the the patch got changed from 'replacing
> [1]-array with flex-array' to 'replacing [1]-array to fixed-size array'.

The issue remains the same, and there have been comments and feedback on
previous patches. So, yep, v3 seems appropiate for this patch. :)

> 
> Let me know if you still want me to send it as v3 instead.

I think next one would be v4.

Also, when versioning patches it is also necessary to include a version
change log.

Thanks
--
Gustavo
