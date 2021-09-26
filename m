Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A007BC433EF
	for <linux-hardening@archiver.kernel.org>; Sun, 26 Sep 2021 11:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BE7D61090
	for <linux-hardening@archiver.kernel.org>; Sun, 26 Sep 2021 11:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhIZLvq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 26 Sep 2021 07:51:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:45869 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231206AbhIZLvp (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 26 Sep 2021 07:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
        s=badeba3b8450; t=1632656985;
        bh=0rIwgn2+oCBKdiYEGxebf4tyq7xKWUvrjdTls2w8bTQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=lTrRQS9XaD6F1ONfw8099VGdThd5PAgQwBday0keXJxgtR0a6GC329uCQAWKjHzUy
         N1xTUyKJqvj3erwLL3Ml6csLeaL9znZUcFzyMsfXirCqEZKkclP9mBUAo1WY6x9/xM
         ghvLD1yminXNnsbNkp33uiA2vDBBB9sSGmHSEfhA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MnakR-1nE0EO1gbF-00jaCp; Sun, 26
 Sep 2021 13:49:45 +0200
Date:   Sun, 26 Sep 2021 13:49:34 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: thinkpad_acpi: Switch to common use of
 attributes
Message-ID: <20210926114934.GA7286@titan>
References: <20210926111908.6950-1-len.baker@gmx.com>
 <YVBaQAFVX1CeQUPE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVBaQAFVX1CeQUPE@kroah.com>
X-Provags-ID: V03:K1:HkWiYA0Jt5HBdYP/LidFZOnItr02xlDFohMZktYouwwlV4AxKeo
 EApb4Ji3/iX5l/aJIojCmNDEjuqi2GOvjW5v2qLFlvH+4TUEtMkZvvULXTCxJ1a8pMUdJip
 YsBrzKTBateYYU07GQPsBSiF8o8KSShzd7fDUw7WKBGGgod8wHB+fY/2Y3Aa6OZ9c5xdapx
 8nGRB1GDgHzeOmpkGeqQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aUuzZ2iWYWg=:NsMNqTlri2SdA3cPh4zGLb
 yLHgGUr39uAWpMqs2PYOXmr0M1EEH7VzAcV2EG74g/4BSD51m4p1ziooEVIAiCl/s/q+rGkIK
 c2+3Qqsf1yPSGn2bF9kPOOitg2sZLQb/Yz2UpQfosTTccCyCR7CFHzTOOh6cLiFswTSvWOeFl
 3D1tc/9kQ2urkZFTjQmK6dzGzEcUrZ/UVWx98z0/6BIrJ4TlNWGhsAUMPj6VapZvWEkjbw3+P
 0Rg0p2L+/JKjuW1U7vQ2EO2jq/5UBrpkKnKqLZaFQ4tsKadupAxvNklBMDNcZG31ea0Lwu5cY
 no5wqqmx3gLj3wLK84Rv9LI96pLm8zatn6sAy6wMog26YfGU8qxgpvOfD4Om0M172ZERWNd1W
 2A6tGl72a7G5CjVMQwSaPP/QlhOUOPMxJolXQkZh71dkEVSSfo0hOQRQSlJGs/wAjXFjLU01i
 4B6lb2jjmP7P8vNWbtCwuLQnnoc/JlQdnaZpC1VNuicr4J1hHCy19TmADmXb1LE1B4/8PBAZC
 7tc2KrV9ebz/SqOY0CpO6saA2ykCYgGDxyovTot2CTPVan9JwF3zcCbWz3FIKqvHGuLhnPBKm
 I1j8m3ueKKmUGIwyLNAtnOSsf2AACO0hdNNoT6bmkmGOqo3aqzJNXuHWTNwMFwr3E1ECMivxe
 DkOTebD027Ezc6YCO5yCdniaPoqfpQHy33lCNMg8P1mFLuCdtm9g32n/X67aALjvUOr7fGktV
 f16xN6+Q69vvh3mm1QyxyQvLHnYBPlIc5SnvkcU6uLqYuF6zlL6lGSbDaIyBh1vV8AcpWZJXK
 x6EzZCybXkyzSUg0d+xCITUz5P6bSSFn/35QKTbqCexJvKuFFXYBOOdu9FFUlKeG9j59+fm9c
 /U2DgnjhBNtmBybRoThS/m+B7sqL2RPV8SdddrEGMj0AwpUxwR0XDibjqXFkcWm+AqkQfd/W6
 lNAUue60wcU9ckN1vxemRhgeoHI63WeMp9FuG2xhwMB1mPG55FaV9FkmDFFuE7MMb7SjaMa/a
 I/dP/zVNpDiIzGxjdhXJvRDgWG45CMzF6r7iRbhRkfUlc+5Z3rJvVI+uVCfxvz0ZejEeTWX4z
 lQxR4d4+pxSIZ8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Greg,

On Sun, Sep 26, 2021 at 01:32:16PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Sep 26, 2021 at 01:19:08PM +0200, Len Baker wrote:
>
> > @@ -3161,9 +3106,7 @@ static void hotkey_exit(void)
> >  	hotkey_poll_stop_sync();
> >  	mutex_unlock(&hotkey_mutex);
> >  #endif
> > -
> > -	if (hotkey_dev_attributes)
> > -		delete_attr_set(hotkey_dev_attributes, &tpacpi_pdev->dev.kobj);
> > +	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &hotkey_attr_group);
>
> Why do you have to manually add/remove these groups still?
>
> A huge hint that something is going wrong is when you have to call a
> sysfs_*() call from within a driver.  There should be proper driver_*()
> calls for you instead to get the job done.
>
> As this is a platform device, why not set the dev_groups variable in the
> platform_driver field so that these attribute groups get added and
> removed automatically?
>
> An example commit to look at that shows how this was converted for one
> driver is 5bd08a4ae3d0 ("platform: x86: hp-wmi: convert platform driver
> to use dev_groups").  See if that helps here as well.

Ok, I will look at this and I will try to improve the patch. Anyway thanks
for the guidance and advices.

Again, thanks for your time.

Regards,
Len
