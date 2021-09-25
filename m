Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D095BC433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 25 Sep 2021 13:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B46D861151
	for <linux-hardening@archiver.kernel.org>; Sat, 25 Sep 2021 13:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245082AbhIYNf6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 25 Sep 2021 09:35:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:52235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239261AbhIYNf5 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 25 Sep 2021 09:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632576836;
        bh=MjORvyBC1hj7NoDW0ovBI0od8p6GtrJJ3JGRsUyB1qQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=SNYzZ83+/aZ97RDieRgn7QuOdDiXlgLn9adjJ4n7b+D1ZMAQxKPFSnFlDHMMs7Gvn
         eSm1BZxyWSiyjxrcgke9LmdplDIRmsRaoI6FMivIHIT4XiG0bjyzqEFKcOsSrAH5TA
         PLXussSr+4qxepMzMFt48HNrTIj87kzj/3CEVkRc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MQMuR-1mGjfJ0mMz-00MK9q; Sat, 25
 Sep 2021 15:33:56 +0200
Date:   Sat, 25 Sep 2021 15:33:45 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg KH <greg@kroah.com>
Cc:     Len Baker <len.baker@gmx.com>, Hans de Goede <hdegoede@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <mgross@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Prefer struct_size over
 open coded arithmetic
Message-ID: <20210925133345.GA1661@titan>
References: <20210918150500.21530-1-len.baker@gmx.com>
 <202109192246.B438B42EF@keescook>
 <ba427967-cb1b-58a8-ec93-bd5ae89f58f8@redhat.com>
 <YUn3F9HtgrpN9sSM@kroah.com>
 <20210925081856.GD1660@titan>
 <YU8C6B5zw5t4vsh7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YU8C6B5zw5t4vsh7@kroah.com>
X-Provags-ID: V03:K1:JS/aQAuOy+H8ua/BrdysdiJvqdNDfKiWAqy026iwsbZfGDwyVsV
 yvbDwHfP0BUVNckbjSg9bwK81HAFIXABEx9SqLfpxMkZdPBtKwHmjPsUnVjluVCWnGJkEjP
 iFAd7zPwtEcVefgOBS0Ixq1J1FA584T+AQ9Weq4mG0wtDlSZtoQM/r1UfpXcNEelZWL26Qv
 x8OygIcsgfuEQsP+LCQGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TLJ1HoXawzY=:J2Sn7UPrbhAyO7T6yVI/hH
 mYbbvv5fCzC4xQdYENKmSR8wy132ekLOPC3rDRD4ISnzFD33PKro9BbPXtrn1rWGwVg28yJ7y
 RzrbDGEJ2eY8N+fy3vUPoY+NW2XWnv4y61AbCt6/IWbePizWzJqlSx8ZjvBQqZJ16Zzklyhcs
 Xr0y9KjQkp6DstQ6GZfBPY7etop0lr7Nb6Mde3Vo7FXn6WUcZq5DDzp/ULADYYDncfs9pEEub
 hHfkyH/Ke5uW6zWUVK1wyJ0kH9oEt92B/pBQxb7zWTdee/sC16IcICKDIh50XEGOz02FG7X6R
 rY7ACJE/T9BXGr8p/KKW7S1V0c3703oP9rw6WjG4oWb2IOI+yIU2d30X62kUUPISPC4AE/+9N
 3pmHRUzemrvJPtGU6ThJGKf1ZRvJo/NpW3f29N3KK3ZvuqSkzDDL3WEt9lKZQc3w4ASyJS8Z7
 3QaLL3lcj5514pOd5CiPHjn/+XLC8QmFS5DcY6vNpLdK5fWN5sRaxrDNrB1EjBy80gNToCDUf
 jhOek36D9cMXxtKVT4BpSNjghnCgXteURg4VlwtKIMJS/crukL/Qqz3vgCfiykDAauAT99hbq
 6t2gmqpS4fqJCykyHBz8ysu12deYsloHkvcwSiTu+F/PXpN581yCwj0CohWhQeCm3EsI1lWgX
 ffa242fJHJaK/ehAccErZ4+3bUADc1/HQ3u+OhklSDPopaK8YmbUdj45ScoNAOGjYancuOuVq
 UgDOKqLXGTHgPU7hseg69eWnVUCSC6F+Vf4yd9TjFc1fk72ks7SKq8Wu9TJIXqCOpBz2gZvXl
 jIhbY23lTGA2/U+6w75ifXU7mjGOKBC+4wKo1Sh4gKiJrlPYwQ18APIx1kwW/011C8mnGObi7
 47nhOzWXI4J0HNr5DXphlqEWtMeMi18H5ZGyANo1+W7hQ22nZh++IjOj5RJGOnzwZB6U7o9DV
 kBKDw8s3rPo2K4W5S9I0FMJuzAwza4BEhjMuEKKmgN/SZmUg3hsDtfdHi+SJNr9JTyyc59NfM
 04Vy9LFKUScJLUGQAS+B2Ap5hZJUCWmC9DJnUoUF+cykMQwJQEOERcfFrbJW8C7sKTBti5vhz
 XSWiVgcVc/BSBo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Greg,

On Sat, Sep 25, 2021 at 01:07:20PM +0200, Greg KH wrote:
> On Sat, Sep 25, 2021 at 12:40:44PM +0200, Len Baker wrote:
> > Hi,
> >
> > On Tue, Sep 21, 2021 at 05:15:35PM +0200, Greg KH wrote:
> > >
> > > First off, why is a single driver doing so many odd things with
> > > attribute groups?  Why not just use them the way that the rest of th=
e
> > > kernel does?  Why does this driver need this special handling and no=
 one
> > > else does?
> >
> > Is [1] the correct way to deal with devices attributes? I think so.
> >
> > [1] https://www.kernel.org/doc/html/latest/driver-api/driver-model/dri=
ver.html#attributes
>
> No, do not use driver_create_file(), see:
> 	http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correct=
ly/
> as a more up to date thing.

Ok, understood. Thanks.

>
> Someone should fix that in-kernel documentation one day :)
>
> > > I think the default way of handling if an attribute is enabled or no=
t,
> > > should suffice here, and make things much simpler overall as all of =
this
> > > crazy attribute handling can just be removed.
> >
> > Sorry but what is the default way? Would it be correct to check if the
> > file exists?
>
> Use the is_visable() callback for the attribute group to enable/disable
> the creation of the sysfs file.

Ok, I will take a look at it.

>
> > > Bonus would also be that I think it would fix the race conditions th=
at
> > > happen when trying to create attributes after the device is bound to=
 the
> > > driver that I think the existing driver has today.
> > >
> > > > > (I see the caller uses +2? Why? It seems to be using each of hot=
key_attributes,
> > > > > plus 1 more attr, plus a final NULL?)
> > > >
> > > > The +2 is actually for 2 extra attributes (making the total number
> > > > of extra attributes +3 because the sizeof(struct attribute_set_obj=
)
> > > > already includes 1 extra).
> > > >
> > > > FWIW these 2 extra attributes are for devices with a
> > > > a physical rfkill on/off switch and for the device being
> > > > a convertible capable of reporting laptop- vs tablet-mode.
> > >
> > > Again, using the default way to show (or not show) attributes should
> > > solve this issue.  Why not just use that instead?
> >
> > What is the default way? Would it be correct to use device_create_file=
()
> > and device_remove_file()?
>
> Put all the attributes into an attribute group and attach it to the
> driver.  The driver core will create/remove the files when needed.  The
> link above should help explain that a bit better, and I can point you at
> examples if needed.
>
> Does that help?

Yes, things are clearer to me now. Also, since the only way to learn is
to do so, I will take the task to switch this driver to the common use of
attributes.

Thank you very much for your time and guidance.

Regards,
Len
