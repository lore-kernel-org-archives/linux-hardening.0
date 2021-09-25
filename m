Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C11AC433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 25 Sep 2021 11:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2903060F11
	for <linux-hardening@archiver.kernel.org>; Sat, 25 Sep 2021 11:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhIYLJA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 25 Sep 2021 07:09:00 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:52337 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231706AbhIYLJA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 25 Sep 2021 07:09:00 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 504E02B0063E;
        Sat, 25 Sep 2021 07:07:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 25 Sep 2021 07:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=3uQrqEVhHhLU6E1nXr0ckYIdMZ1
        n/+TcG7HITTU3dkI=; b=Bipe1O7BRRE0DizAoy8TNijIWvKh+TrmfSzetj4DQIQ
        mf1bKGj6w9dgr0khmgQZTh9ss6UWfIjGsndlAoiWWtgqZAKjthEC5MmqpgZQMp10
        J59QXnjtfWwyeJ1gUSa8Osty9TWTSMx3MB/9UMJII61IM5OGXHezutgntp0LB/sS
        8BRiO4AwtynTCZbZcGnnF3LE7UubBZv4b/rieMJJN3wT7ASUJQ0fvwulrvReEekw
        JVxcFsRrU7uMk0ADJYciik5KrCX8JNclvUfZcDETmiLCF2XAgzyQS/atBQYG4j4B
        mBGa4McLyh34IAbn3M+nNEnP+ysS3jKpKCpWG7Uilag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3uQrqE
        VhHhLU6E1nXr0ckYIdMZ1n/+TcG7HITTU3dkI=; b=h759m/5BigSJkwYVjTOB04
        rQAMAZjgCrSV3fvVMYcl7k99lyjGMacz9/NO9gI8du2XeXr0QJLwV32/HMsxsIj0
        zoZggdCj2WkpIPqlJumyihH/sT4hO9O7ZWEfzKfFblq2V/pLY6vP0TuTi2vDGpeA
        Z6Ab6n/dMUBirjiyQVWXt7eKmapK97on3511kBLHHkposEfKifzFJf2qum/LcYXW
        QbbSmrAvPPpWhiZMzp6iwPootN9noh1wGQ8jz/vtEX4Z8dQcpdShNgFBe4rHT76s
        SLsjfgd0+azuTHXbUm6fMNO6p2/lBElosiFZE1mhr0vw4zRSc0GYPGOOaDSmAaYw
        ==
X-ME-Sender: <xms:6wJPYTJ-1Vq28NSW3ObfYiNYzstYOY9JSebhJOAVCoxbKRDCcaDSwA>
    <xme:6wJPYXLDVXar2mKdtwAXbQD34cmhl5uZXRAPnjI1Gc5tGBId6ggVtzo3ULYYFrmBb
    v_YHXrXayapaA>
X-ME-Received: <xmr:6wJPYbv7lHB4X6EyiekiXdM6XvCBdSCUY_yoD7UCOVhHNyMufB_C2dLSjAI5eMQzxlUOBiZxdnAoeG3YhWX1G2l5nvf69TZR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejfedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevffffte
    fhleeuhfefieffhfeifefhhefftefhffduvdfhfffgleetgfdvleehtdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdhkrhhorghhrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:6wJPYcac4EhmEtUn4XmJA2fWY6HGV09Pr_Cj6jSen5LV0yzoKSQnbA>
    <xmx:6wJPYaZoSEvcqefDMEf-nbE5FFwnMksG6G305hi_yiZa2rBxv4ttCA>
    <xmx:6wJPYQBPyAmjWjOvYy9Q-tOfnaFr8FqaCycu1RaIFtxT4PI7CK9M3w>
    <xmx:6wJPYXR8gYW4CmYRCDRPA297DWaRwBYpfuEfdWqBW03hajW92EzXcp0vGSI>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Sep 2021 07:07:22 -0400 (EDT)
Date:   Sat, 25 Sep 2021 13:07:20 +0200
From:   Greg KH <greg@kroah.com>
To:     Len Baker <len.baker@gmx.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <mgross@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Prefer struct_size over
 open coded arithmetic
Message-ID: <YU8C6B5zw5t4vsh7@kroah.com>
References: <20210918150500.21530-1-len.baker@gmx.com>
 <202109192246.B438B42EF@keescook>
 <ba427967-cb1b-58a8-ec93-bd5ae89f58f8@redhat.com>
 <YUn3F9HtgrpN9sSM@kroah.com>
 <20210925081856.GD1660@titan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925081856.GD1660@titan>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Sep 25, 2021 at 12:40:44PM +0200, Len Baker wrote:
> Hi,
> 
> On Tue, Sep 21, 2021 at 05:15:35PM +0200, Greg KH wrote:
> >
> > First off, why is a single driver doing so many odd things with
> > attribute groups?  Why not just use them the way that the rest of the
> > kernel does?  Why does this driver need this special handling and no one
> > else does?
> 
> Is [1] the correct way to deal with devices attributes? I think so.
> 
> [1] https://www.kernel.org/doc/html/latest/driver-api/driver-model/driver.html#attributes

No, do not use driver_create_file(), see:
	http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/
as a more up to date thing.

Someone should fix that in-kernel documentation one day :)

> > I think the default way of handling if an attribute is enabled or not,
> > should suffice here, and make things much simpler overall as all of this
> > crazy attribute handling can just be removed.
> 
> Sorry but what is the default way? Would it be correct to check if the
> file exists?

Use the is_visable() callback for the attribute group to enable/disable
the creation of the sysfs file.

> > Bonus would also be that I think it would fix the race conditions that
> > happen when trying to create attributes after the device is bound to the
> > driver that I think the existing driver has today.
> >
> > > > (I see the caller uses +2? Why? It seems to be using each of hotkey_attributes,
> > > > plus 1 more attr, plus a final NULL?)
> > >
> > > The +2 is actually for 2 extra attributes (making the total number
> > > of extra attributes +3 because the sizeof(struct attribute_set_obj)
> > > already includes 1 extra).
> > >
> > > FWIW these 2 extra attributes are for devices with a
> > > a physical rfkill on/off switch and for the device being
> > > a convertible capable of reporting laptop- vs tablet-mode.
> >
> > Again, using the default way to show (or not show) attributes should
> > solve this issue.  Why not just use that instead?
> 
> What is the default way? Would it be correct to use device_create_file()
> and device_remove_file()?

Put all the attributes into an attribute group and attach it to the
driver.  The driver core will create/remove the files when needed.  The
link above should help explain that a bit better, and I can point you at
examples if needed.

Does that help?

thanks,

greg k-h
