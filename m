Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16E8C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Sep 2021 15:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA25061090
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Sep 2021 15:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhIUPsQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 21 Sep 2021 11:48:16 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:52437 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234211AbhIUPrP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 21 Sep 2021 11:47:15 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 88B752B013BA;
        Tue, 21 Sep 2021 11:45:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 21 Sep 2021 11:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=68Ez9kJNOEr/C+egNL3CEoXa9GE
        O4jmpwrJs9DLpLDg=; b=b8Xq/u2P2r2mU/sMeJ+g7E1UIIBCj7fudf6fVi2NqUW
        gFRfZELr2enVCh6DjaMetTI4G0sFgTfFRDu1L8oE+kOjoeO8nDgZNjrL8O4ruERY
        QQ9pgh/7833+n/+vJy/xB5WvKBQ3yEIODA3ewTf+o7oK0YXRWOYpLXgAhuhn8a0Q
        S8BT9ddw4wuCRnTUW7rnPOKH1pyDeZMLivhpWWvfehamINIQ6Yf2/sAMZvgqqWom
        tTksrBhLNdeThVqgHs6oy0nHdOzGMffxqopCZVR5x+dt32LxZ6ZWF/2Hu3hY+0kx
        P+xAqNi8RA3IqmEJB0K50sfPYXw4qXUUHyfk5rMe+vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=68Ez9k
        JNOEr/C+egNL3CEoXa9GEO4jmpwrJs9DLpLDg=; b=Ls6G5GkOc5MBBotV22r9Uo
        NWjeD1Cwgy7h4PrJJwdCk9xSIpvSspXJn/lK3ole7H8+uLSJuslCV9wfeuzauKAn
        1ilALdzmqL5nY+PTYKicPlSOrfhay6pAI7CQ0CPDh3KDQtbs5xS50gvAyhoVsQ7k
        3BXPHQH6fup08FQIGLCYgYl0lOHz5FX6h5LQEzE5bQWpMi0otBBId/dRG905seJG
        PT72pP7GWElLvcZi01iEbsJZXvUPhyVAy+KMm+/8bvd2N2mPlS11LTXjQSzF6TU/
        zX6Z5uER4cM2L0IRV6d6WL0CSKUFS34W4dKOihzmrw9fJCSReNW/9T3OxJlw+RnA
        ==
X-ME-Sender: <xms:J_5JYSe6D7aaoRNo-_lyZPJQXJcLtD3RsmmkG7frh-Js6XfEx60alQ>
    <xme:J_5JYcNo21un18096Ck-eSIEDCKAR8z1-KjzRBfHAuKRCMe67LZpEoNxht5PNtgGP
    OQ7tOtrS96k9w>
X-ME-Received: <xmr:J_5JYTglr-G_PY_M4IOwYlpO80oVXdNshkJA_XRaL2uiG9NF0zAbp7Cau9jIq3m6MWw7alqv_wislBOpmA7RP10BWbX6XHEk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeigedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:J_5JYf-Uhpe58UIWGYofA7myYYpdIgQx5HGpMYZo3PhIdLcuHA8IkQ>
    <xmx:J_5JYetOgieNVo6mNCisN27dFF55aw0up_BluX1kQqO-1zfnvEAfrQ>
    <xmx:J_5JYWFY7fAUYmYGLo07sDXpHxwKJpnVPzUYtoigI05IgxbyByZQjg>
    <xmx:Kf5JYZlJ8GNH98916Fl08WrKH5ydkjqhrCM6fBTyUWh6JZunx9wTPGrKPho>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Sep 2021 11:45:43 -0400 (EDT)
Date:   Tue, 21 Sep 2021 17:45:41 +0200
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
Message-ID: <YUn+Jfx9a+Ad1PsK@kroah.com>
References: <20210918150500.21530-1-len.baker@gmx.com>
 <202109192246.B438B42EF@keescook>
 <ba427967-cb1b-58a8-ec93-bd5ae89f58f8@redhat.com>
 <YUn3F9HtgrpN9sSM@kroah.com>
 <725ac392-642b-f57d-a286-d662eaa7d2a2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <725ac392-642b-f57d-a286-d662eaa7d2a2@redhat.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 21, 2021 at 05:38:39PM +0200, Hans de Goede wrote:
> > All attributes for this driver are documented in Documentation/ABI/,
> > right? :)
> 
> I'm not sure if all attributes are documented, but a lot of them
> (including all recently added ones) are documented in:
> Documentation/admin-guide/laptops/thinkpad-acpi.rst

They should also go into Documentation/ABI/ which is where sysfs files
are documented.  We are working on tools that make parsing that easier,
so it would be good to keep them out of other random documentation
files whenever possible.

thanks,

greg k-h
