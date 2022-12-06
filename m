Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF13EC4708C
	for <linux-hardening@archiver.kernel.org>; Tue,  6 Dec 2022 02:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbiLFCVB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiLFCU7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 5 Dec 2022 21:20:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF75325295
        for <linux-hardening@vger.kernel.org>; Mon,  5 Dec 2022 18:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XgHpLZolXFhpniWydLmueG76MYWdihoFTNZvRbiBzwM=; b=WaJxTiHC6WjwagJSr48pdIwNp4
        zQG1/zv1giTfMhnlXx4sXrr2qQ3JyZ2V41ktKlzRaLAwd4q5sSbwRstW08LWvh2PsQQCEtUlz0AfU
        YeYcfmExxDT7Uq7eNNRW7yUSheAglyqZ2barL1LP/0NIFZaIN4gVvjzvv9y81eSvhWj36EAPL5S2L
        lY25b0Zk9fLdVIp/O7XPDgsUMIe+c2keKCOxYygIS8aTtWfWhCvTehcOv5WSD8Ocy906qQO3FPqub
        WSQMC1SSbYjx3nGRvOyv6qukpbJTaFuZKbLBbZrHNSVNcqeFTKUZHsZzcQOFGd2VtiWa0bg5mac9v
        WlLFG75Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2NZa-00FR3Z-1G; Tue, 06 Dec 2022 02:20:42 +0000
Date:   Mon, 5 Dec 2022 18:20:42 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stefan Bavendiek <stefan.bavendiek@mailbox.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: Re: Reducing runtime complexity
Message-ID: <Y46m+rhDe7otOFpp@bombadil.infradead.org>
References: <Y4kJ4Hw0DVfy7S37@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4kJ4Hw0DVfy7S37@mailbox.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Dec 01, 2022 at 09:09:04PM +0100, Stefan Bavendiek wrote:
> Distributions are commonly shipping the kernel as one large binary
> that includes support for nearly every hardware driver and optional
> feature, but the end user will normally use very little of this.  In
> comparison, a custom kernel build for a particular device and use
> case, would be significantly smaller. While the reduced complexity
> won't be directly linked with reduction in attack surface, from my
> understanding the difference would make a relevant impact.

I looked into a similar problem back in the day when trying to vet
correctness of the Xen hypervisor when you are boooting a Xen guest
and not a KVM guest, how do we ensure that code that should not be
run should not run? Although it's a separate problem the solution
to strive to block / drop code which should not run essentially
would accomplish the same goal: prevent dead code to run.

It is *one* reason why I ended up implementing linker-tables long
ago on Linux, although this didn't get merged. The idea there was
that *eventually*, once you have mapped code into a section and
you are certain it should not not via ELF sections, you could just
drop / NX the code you don't need at runtime.

It turns out obviously Linux is not the only place where we could
benefit from this sort of work and when I reviewed the prospects
on the Qemu with Alexander Graf we instead persued the idea of a
GCC compiler multiverse support, and thanks to some researchers
that is now real code.

All these things are related, and so I started long ago jotting
some of the ideas here:

https://kernelnewbies.org/KernelProjects/kernel-sandboxing

Since linker tables didn't get merged I didn't follow up though but
in theory a lot of NX / free'ing dead code shoudl be possible for large
parts of text dynamically at runtime.

  Luis
