Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903FDC433FE
	for <linux-hardening@archiver.kernel.org>; Sun,  9 Oct 2022 06:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJIGvR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 9 Oct 2022 02:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiJIGvP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 9 Oct 2022 02:51:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782EB2A43B;
        Sat,  8 Oct 2022 23:51:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1553F60B86;
        Sun,  9 Oct 2022 06:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F278C433C1;
        Sun,  9 Oct 2022 06:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665298274;
        bh=cBUWUX/wKjFbBTSR4Zh5FNhzEenYZ+ABG2uNJqaEQsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=frDCiFn3Jr7P510TeiwpjOyrNMYrkiSGac06hyTwM+eGqjB2U2ZU/Gsxn4mMmhLPI
         5Tc/Fzr3dEC/ePBprRXHbkDyBP1BAP2lnr7vZIkJU683aDhx3YKwYkKYpNoBBTY/SG
         ZjfTUs42t0SfoomAz8pZIVERgvbyI4HNthe+mm0Y=
Date:   Sun, 9 Oct 2022 08:51:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] dlm: Replace one-element array with flexible-array
 member
Message-ID: <Y0JvjAfnOB13y2wL@kroah.com>
References: <Y0ICbf8tCtXMn+W0@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0ICbf8tCtXMn+W0@mail.google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Oct 09, 2022 at 12:06:21PM +1300, Paulo Miguel Almeida wrote:
> paulo.miguel.almeida.rodenas@gmail.com
> Bcc: 
> Subject: [PATCH][next] dlm: Replace one-element array with flexible-array
>  member
> Reply-To: 

Something went wrong here :(

