Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B18EB64D8
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Jun 2023 05:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbjFNFhv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 14 Jun 2023 01:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242937AbjFNFhr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 14 Jun 2023 01:37:47 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36B51BEC
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 22:37:43 -0700 (PDT)
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 119DD3F269
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jun 2023 05:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686721062;
        bh=L700u4JHszhgKkjQdfFwXH0svBOHFooI3nofINxb84U=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=okqFk5+RolA09UeFPVcSkCkAM48GvDtvHdLVY9gONqpZ+RmgUJx4uizASqY0CbUHw
         eGeNeqkhWKgmwwRVXJVeTFBdIwZ9b4FEuNlcwOupcp4El6h4+NLjTVqNSA9CXYEHuL
         1Oz5DANyEb28W65Oxkx0NNq3/VvWekoWPxRLjwRsK7llQhVlu50SCqi+6ifgCRRuN2
         cJvxCsU/7s9s5fI686yIaV6z4qYLBFrm1xx4JXg0+kkfIRO0yktv5SSz+r42pwSGSA
         rnrdgRFZPszjR7rmICyxDGCzlL+gOLVcQDkcCA+Grlh8yDBAhiLPuOa7chy3ZWePlp
         BTACa4GmbfOfQ==
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75d4fb030a8so227385585a.2
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 22:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686721060; x=1689313060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L700u4JHszhgKkjQdfFwXH0svBOHFooI3nofINxb84U=;
        b=Z8kDWc4Bjn0clMHw2bhM9j9RmUdrYC1FLtXQaycslrcEY5rNbw4Uh9nqJ3p2IvGY8n
         i3Y5bBNJhB+g1/wA1khIQjNiKPoBu60gNHy/IlvXnowTjxnDfGoIDwdDQU+zonhEDKJo
         HflVVhpCnXSRN8sa90zPN8FVClGCp2T4OaxvaJ4yPsWpmyT0tuZ+JRvRzmy73GB8WM2G
         lcIhNhxh+k1Agb5aimDxAhTwdPlAIthrAQIJHuKG3Vp9YzZ613eHPsuD0XJ+AjoFOB0h
         Tri6HavymhRPzFHmP+nw8t3yBzcLL7gdXrb3SiUWdmVEgOiMM2Q0EFWNWEUyd7gmRCSy
         WGpg==
X-Gm-Message-State: AC+VfDwzT7rfQlH2yJFJ5DhI1Os6SGNnoOrj/fus8WnxERXcd+xZkwnD
        QF2G4kvlK1iD5R0frZmnxAnp6X8ZL5+5w33F2PehSycn8F/LVqC4eBGGKNbeKceKuzm+JQIlrlG
        ENuDLVBENihpiPgumzu+LsF/7Ein9OBLk7aeqSAkIhvZkgCXoKLkgGx1seGEH2A==
X-Received: by 2002:aca:2301:0:b0:398:19e6:56a9 with SMTP id e1-20020aca2301000000b0039819e656a9mr9458899oie.2.1686721039177;
        Tue, 13 Jun 2023 22:37:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ZCvNJFhBXY5DTwt5hF4ORUgqFO+d5WsQ0PVogShHgfbbdYyTneKVBelaRsDRX0hSU0EGW4U4/NdJvc7kGFqw=
X-Received: by 2002:aca:2301:0:b0:398:19e6:56a9 with SMTP id
 e1-20020aca2301000000b0039819e656a9mr9458892oie.2.1686721038957; Tue, 13 Jun
 2023 22:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <2d1fdf6d-682c-a18d-2260-5c5ee7097f7d@gmail.com>
 <5513e29d-955a-f795-21d6-ec02a2e2e128@gmail.com> <ZIQ6bkau3j6qGef8@duo.ucw.cz>
 <07d6e2e7-a50a-8cf4-5c5d-200551bd6687@gmail.com> <02e4f87a-80e8-dc5d-0d6e-46939f2c74ac@acm.org>
 <b2cf6d96-a55a-d444-d22e-e9b3945ba43f@jmbreuer.net> <84f1c51c-86f9-04b3-0cd1-f685ebee7592@kernel.org>
In-Reply-To: <84f1c51c-86f9-04b3-0cd1-f685ebee7592@kernel.org>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 14 Jun 2023 13:37:07 +0800
Message-ID: <CAAd53p665S+dfOvWZt2UwTs=VrxE=FtpqjzUrSuLKR5tBpAa9Q@mail.gmail.com>
Subject: Re: Fwd: Waking up from resume locks up on sr device
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Joe Breuer <linux-kernel@jmbreuer.net>,
        Bart Van Assche <bvanassche@acm.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Hardening <linux-hardening@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux SCSI <linux-scsi@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 14, 2023 at 12:49=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org=
> wrote:
>
> On 6/11/23 18:05, Joe Breuer wrote:
> > I'm the reporter of this issue.
> >
> > I just tried this patch against 6.3.4, and it completely fixes my
> > suspend/resume issue.
> >
> > The optical drive stays usable after resume, even suspending/resuming
> > during playback of CDDA content works flawlessly and playback resumes
> > seamlessly after system resume.
> >
> > So, from my perspective: Good one!
>
> In place of Bart's fix, could you please try this patch ?

Issue still persists at my end, when /sys/power/pm_async is 0.
device_pm_wait_for_dev() in its current form is only usable for async case.

Kai-Heng

>
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index b80e68000dd3..a81eb4f882ab 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -4006,9 +4006,32 @@ static void ata_eh_handle_port_resume(struct
> ata_port *ap)
>         /* tell ACPI that we're resuming */
>         ata_acpi_on_resume(ap);
>
> -       /* update the flags */
>         spin_lock_irqsave(ap->lock, flags);
> +
> +       /* Update the flags */
>         ap->pflags &=3D ~(ATA_PFLAG_PM_PENDING | ATA_PFLAG_SUSPENDED);
> +
> +       /*
> +        * Resuming the port will trigger a rescan of the ATA device(s)
> +        * connected to it. Before scheduling the rescan, make sure that
> +        * the associated scsi device(s) are fully resumed as well.
> +        */
> +       ata_for_each_link(link, ap, HOST_FIRST) {
> +               ata_for_each_dev(dev, link, ENABLED) {
> +                       struct scsi_device *sdev =3D dev->sdev;
> +
> +                       if (!sdev)
> +                               continue;
> +                       if (scsi_device_get(sdev))
> +                               continue;
> +
> +                       spin_unlock_irqrestore(ap->lock, flags);
> +                       device_pm_wait_for_dev(&ap->tdev,
> +                                              &sdev->sdev_gendev);
> +                       scsi_device_put(sdev);
> +                       spin_lock_irqsave(ap->lock, flags);
> +               }
> +       }
>         spin_unlock_irqrestore(ap->lock, flags);
>  }
>  #endif /* CONFIG_PM */
>
> Thanks !
>
> --
> Damien Le Moal
> Western Digital Research
>
