Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF23AC433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Sep 2021 15:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6BEC60F6D
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Sep 2021 15:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhIUPRL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 21 Sep 2021 11:17:11 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:56643 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233974AbhIUPRJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 21 Sep 2021 11:17:09 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 488EC2B01343;
        Tue, 21 Sep 2021 11:15:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 21 Sep 2021 11:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=6b4bk+5E8OPLQowTL7kis4IonQ7
        Cljxm8kY9KOSGcPs=; b=rZpPfzSs7Jb93FbC2bda9KAVNQiNL2itKHeoUk8QtO4
        nBfNouIRbOzCMVOAwkrqCbiRklbBDXzt8fYbjKQZJfyE9hSK51MlaU1k5BJaJXPA
        QZZR/dVzp3MOBxZ5qYKUSOI69UU3h29jXS3yjzXBmZGSJZTjHYBU5b2i3OSy+klS
        chgd3LZghrfSzga9MfaLMGDUX0ZaSh19tyL2gJvrARA07G7SChyQc49zg4XwITuP
        CXaUtQYayrE5+G2ytoWthiJ1n0BgJPvgnC9/YeRKN/xvI9qn0y6/INe28jrtq/pJ
        mvmkt8Gdmazj4rO4+C1yfGutYlOPFXdIofAaxB1aqHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=6b4bk+
        5E8OPLQowTL7kis4IonQ7Cljxm8kY9KOSGcPs=; b=eD37gPlHJgVovesHO5uuoI
        N+uyLl/5gkfFL+fAr9k/5/pPL22rUsUuC42Rc+oLsbhLUzjJg7b8/rz4mhocY0t0
        DHJzv3Eqvjgy/z1l3bI9huge0JjW1aKY3Q+41QinCs2WZ69gNO4YEglkqfNIiEWp
        5GJOOSDEINUb1ZcqDgJg1AvyPfO0+rSai5FH7gW8XXTH4SR7h5HV5QH8mRUxwpVu
        7ZSiviVPb27RxoUI42QbIDk9qeEaa9cA05RSIw/QTzPd5Hv9aF3n7uRYCaZCZMWM
        wN4iwnuC2/CBh0dzpReBoPgbiFFTIm5SOpwzl5kzOhWMN/bNAK1E9pWcAcCUmjAg
        ==
X-ME-Sender: <xms:GfdJYWj23d-WWr7-03IMMcrguH72liZ2gH2LFAiJ6cEd87yRrELBpg>
    <xme:GfdJYXB2uVxuBAPPAF0VODCp299Dt3gVF4xRMuc6AYApy3wuaqY4NVj4yOjbP9F04
    0b8B5YsTVdZTg>
X-ME-Received: <xmr:GfdJYeFlAGI7Ex5XjdIALQ1e2C9lS0fcXrBfam4RgwGvGhF7spZ1I-4NelFazSDbcZrjhJqw34qpkeU-ouLVk8gIXlfCl8br>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeigedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeuleeltd
    ehkeeltefhleduuddvhfffuedvffduveegheekgeeiffevheegfeetgfenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:GfdJYfTyAmQvuuIDWQI2AWOEymz5RJ-Jd7ikExPO1vXs4R5rTaEXWA>
    <xmx:GfdJYTxuvAi44xJQBv5O75YkTfZayUXMB33vqLerFN0RGRzz4_ZAug>
    <xmx:GfdJYd5zeyuqfYBFrouN67lG3N9yIfDV-Qm9nn0dPBcKRErBvu2fOQ>
    <xmx:GvdJYUqgEQUA-OnCpFXRTg9Ob23CIAB-EkAa70v175uT6bPdPRJYGDQOaCs>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Sep 2021 11:15:37 -0400 (EDT)
Date:   Tue, 21 Sep 2021 17:15:35 +0200
From:   Greg KH <greg@kroah.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, Len Baker <len.baker@gmx.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <mgross@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Prefer struct_size over
 open coded arithmetic
Message-ID: <YUn3F9HtgrpN9sSM@kroah.com>
References: <20210918150500.21530-1-len.baker@gmx.com>
 <202109192246.B438B42EF@keescook>
 <ba427967-cb1b-58a8-ec93-bd5ae89f58f8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba427967-cb1b-58a8-ec93-bd5ae89f58f8@redhat.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 21, 2021 at 03:46:23PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 9/20/21 7:58 AM, Kees Cook wrote:
> > On Sat, Sep 18, 2021 at 05:05:00PM +0200, Len Baker wrote:
> >> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> >> and Conventions" documentation [1], size calculations (especially
> >> multiplication) should not be performed in memory allocator (or similar)
> >> function arguments due to the risk of them overflowing. This could lead
> >> to values wrapping around and a smaller allocation being made than the
> >> caller was expecting. Using those allocations could lead to linear
> >> overflows of heap memory and other misbehaviors.
> >>
> >> So, switch to flexible array member in the struct attribute_set_obj and
> >> refactor the code accordingly to use the struct_size() helper instead of
> >> the argument "size + count * size" in the kzalloc() function.
> >>
> >> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> >>
> >> Signed-off-by: Len Baker <len.baker@gmx.com>
> >> ---
> >>  drivers/platform/x86/thinkpad_acpi.c | 8 +++-----
> >>  1 file changed, 3 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> >> index 50ff04c84650..ed0b01ead796 100644
> >> --- a/drivers/platform/x86/thinkpad_acpi.c
> >> +++ b/drivers/platform/x86/thinkpad_acpi.c
> >> @@ -1008,7 +1008,7 @@ struct attribute_set {
> >>
> >>  struct attribute_set_obj {
> >>  	struct attribute_set s;
> >> -	struct attribute *a;
> >> +	struct attribute *a[];
> >>  } __attribute__((packed));
> > 
> > Whoa. I have so many questions... :)
> > 
> >>
> >>  static struct attribute_set *create_attr_set(unsigned int max_members,
> >> @@ -1020,13 +1020,11 @@ static struct attribute_set *create_attr_set(unsigned int max_members,
> >>  		return NULL;
> >>
> >>  	/* Allocates space for implicit NULL at the end too */
> >> -	sobj = kzalloc(sizeof(struct attribute_set_obj) +
> >> -		    max_members * sizeof(struct attribute *),
> >> -		    GFP_KERNEL);
> >> +	sobj = kzalloc(struct_size(sobj, a, max_members + 1), GFP_KERNEL);
> > 
> > Whoa, this needs a lot more detail in the changelog if this is actually
> > correct. The original code doesn't seem to match the comment? (Where is
> > the +1?) So is this also a bug-fix?
> 
> Kees, at first I thought you were spot-on with this comment, but the
> truth is more subtle. struct attribute_set_obj was:
> 
> struct attribute_set_obj {
>         struct attribute_set s;
>         struct attribute *a;
> } __attribute__((packed));
> 
> Another way of looking at this, which makes things more clear is as:
> 
> struct attribute_set_obj {
>         struct attribute_set s;
>         struct attribute *a[1];
> } __attribute__((packed));
> 
> So the sizeof(struct attribute_set_obj) in the original kzalloc call
> included room for 1 "extra" pointer which is reserved for the terminating
> NULL pointer.
> 
> Changing the struct to:
> 
> struct attribute_set_obj {
>         struct attribute_set s;
>         struct attribute *a[];
> } __attribute__((packed));
> 
> Is equivalent to changing it to:
> 
> struct attribute_set_obj {
>         struct attribute_set s;
>         struct attribute *a[0];
> } __attribute__((packed));
> 
> So the change in the struct declaration reduces the sizeof(struct attribute_set_obj)
> by the size of 1 pointer, making the +1 necessary.
> 
> So AFAICT there is actually no functional change here.
> 
> Still I will hold off merging this until we agree on this :)

First off, why is a single driver doing so many odd things with
attribute groups?  Why not just use them the way that the rest of the
kernel does?  Why does this driver need this special handling and no one
else does?

I think the default way of handling if an attribute is enabled or not,
should suffice here, and make things much simpler overall as all of this
crazy attribute handling can just be removed.

Bonus would also be that I think it would fix the race conditions that
happen when trying to create attributes after the device is bound to the
driver that I think the existing driver has today.

> > (I see the caller uses +2? Why? It seems to be using each of hotkey_attributes,
> > plus 1 more attr, plus a final NULL?)
> 
> The +2 is actually for 2 extra attributes (making the total number
> of extra attributes +3 because the sizeof(struct attribute_set_obj)
> already includes 1 extra). 
> 
> FWIW these 2 extra attributes are for devices with a
> a physical rfkill on/off switch and for the device being
> a convertible capable of reporting laptop- vs tablet-mode.

Again, using the default way to show (or not show) attributes should
solve this issue.  Why not just use that instead?

> >>  	if (!sobj)
> >>  		return NULL;
> >>  	sobj->s.max_members = max_members;
> >> -	sobj->s.group.attrs = &sobj->a;
> >> +	sobj->s.group.attrs = sobj->a;
> >>  	sobj->s.group.name = name;
> > 
> > The caller also never sets a name?
> 
> attribute_group.name may be NULL, I don't know
> of (m)any drivers which actual set this to non NULL.

It is used by some, that is how you can put all of the attributes in a
subdirectory automatically.  No idea if that's needed here...

All attributes for this driver are documented in Documentation/ABI/,
right? :)

thanks,

greg k-h
