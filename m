Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1839A944
	for <linux-hardening@vger.kernel.org>; Thu, 25 Sep 2025 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825806; cv=none; b=A5nfKKQ9tJyp2T7az97c3p0p5FJUiHVLnu8t0HRQ6fBi/1hOyV+X/TfemVBhE6KYyeAoZq/c/XPYZPmn7BdJefZI13GM4q0SpUfwmQdd53Q0eeLKzNOBlAndKJDrFG4Wr5jd26NMdrmf0wyHmAgvsLblCdupavbWZ88vAvPtl68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825806; c=relaxed/simple;
	bh=/EsSPc0xo+BwHuhAuOwZV2CXIW3EGHEN86sfgis0Rdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCKZXxn2zaM1FKmUg5r+ObkJA4JsUdqhbMmRCILjsMpsCTn2Xnr09fBTbMtZFm1vrJZEp1glrgCQhfRoiCJfsm0jp1XT4SZbhWItnDufVylm0FVLPDOg7P17Sn9K0IVdLDo5gVhyhW3EP3Mm3wmSxtvnS1fgnfzs55V0wavfTH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DrppEnMg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrppEnMg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758825802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCwL8SXUdlfwXeL8qzp+u5OC8lgUfGYR3U0v0leyOhE=;
	b=DrppEnMg2WeDkuQLXBy7BOTtbDiMOoKf9UVD2UvJPxzZNHXluAXTxe+dwnQVBdmg7MNmv9
	08vxp8a+RAe9HcuzCu7slKsjqn7Oei0ukppYqfXNBWfqy7mSy4O/RfdbC19T0jcInVTd3d
	Mzm6YAGkCeDME80s5uwc8Un7W90Cu3Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-umPgddsOOfOBzxHi4UJuAA-1; Thu, 25 Sep 2025 14:43:18 -0400
X-MC-Unique: umPgddsOOfOBzxHi4UJuAA-1
X-Mimecast-MFC-AGG-ID: umPgddsOOfOBzxHi4UJuAA_1758825797
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f924ae2a89so1256095f8f.3
        for <linux-hardening@vger.kernel.org>; Thu, 25 Sep 2025 11:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825797; x=1759430597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCwL8SXUdlfwXeL8qzp+u5OC8lgUfGYR3U0v0leyOhE=;
        b=hTf9leC47gAIVygqnp+TdjeTJi5YSWpsB8FDOJlvOursihBqWbSQmpfwBFYFsCIggQ
         ua9hBXgsNMsdPouJTvXL81SbokcI01zcpGRHSkkE6pmem4+oSFXClP+4Ktw561cXu4ws
         Y1fc9jc8KkDxtEpnerdNrSoWzDhG3izUv0IPbdjWyVHYzD28kmrqXSw9m6J7My7ji0Zw
         o5pjr9ssXhTY6BTPPWqdBv2Qc2IyRPWV4WfvwoSF1OqsTYCJzAGq+ubuWr9hgnxECF2G
         Dq0UXXBlfv+0ux2glL16f9SbLqK3aFRthSazSzmhZI+0+KDJT9tquf7yo+rxuXsFR2LD
         G0eg==
X-Forwarded-Encrypted: i=1; AJvYcCUMAtM+cZz9mfaaPEsutdc0W3Nlm+Y4I/BZO4emA8y2AbpOF3Zfc13X5IbX5ONrPVZ4EauTsri1Wmpdo6Z5XJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE3SDHnwWaPXPuP4phhd5FMm61jPH4I/JXeR6J1Wjx5lo5C/xt
	rNsJxCrzClaxOnOyjYcPXgirGevAGSkSdqyVKmbNyh+FP/sqF+cNJ+CHVXGbAO6jvzz2M5XmJE+
	LWpGIgo3+oQm3YegHc6GZCdp4kRqL3DSp/7b4a/dMWwQfX27K/9+zb7G5cYwWvMGXvLN3JH5YEU
	xSabEd0H8maE4FKAKdIukZ/q0N9MLwuSjDGMh15SUE9QEM
X-Gm-Gg: ASbGnctJ6uBUbJM6Z5yRZ1Jnr8d3J4z/6QVsu9gNzb+NTy4wFNk6pgtf+qGNzQVoAip
	SLMb7JlHJjyZ2GeZRFNElfrsdec4HiYm8vB1q9JU+vLTcNRrqcgQyIipOtd3ap4KDlhc2/lOtaL
	7qvlSYO6twG8KCGfgEEte2zA==
X-Received: by 2002:adf:a314:0:b0:40f:5eb7:f234 with SMTP id ffacd0b85a97d-40f5eb7f48cmr2845638f8f.5.1758825796905;
        Thu, 25 Sep 2025 11:43:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE88PMsbz8pPK3SEua9+FkvwWXj3+M2OYdB33VngMoCil+x4wPGRNDKD5gCmIANA4SBdzwL9F5/1f+LVE1qRc=
X-Received: by 2002:adf:a314:0:b0:40f:5eb7:f234 with SMTP id
 ffacd0b85a97d-40f5eb7f48cmr2845619f8f.5.1758825796463; Thu, 25 Sep 2025
 11:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fbbef12e-fc43-464f-b92d-f42f3692a46c@redhat.com>
 <20250925170223.18238-1-bgurney@redhat.com> <e58d743b-a999-4e00-8f2e-31707744c5bb@embeddedor.com>
In-Reply-To: <e58d743b-a999-4e00-8f2e-31707744c5bb@embeddedor.com>
From: Bryan Gurney <bgurney@redhat.com>
Date: Thu, 25 Sep 2025 14:43:04 -0400
X-Gm-Features: AS18NWCHTZQIxNrKgiFSSzKrwF5EleTnCC_ffWawvQOYJkv4JLiwwoWDLY4SGGs
Message-ID: <CAHhmqcTdC_we4x9e0Q-NT=k-9LM5Q8azFH51_Wbpr4tKgpOzDg@mail.gmail.com>
Subject: Re: [PATCH RFC] scsi: qla2xxx: zero default_item last in qla24xx_free_purex_item
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org, kbusch@kernel.org, 
	hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, james.smart@broadcom.com, 
	njavali@marvell.com, linux-scsi@vger.kernel.org, hare@suse.de, 
	linux-hardening@vger.kernel.org, kees@kernel.org, gustavoars@kernel.org, 
	emilne@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qDppl838eG5abjh3LqEv0XQ6RHW1v-xvwRTT0JuQsV4_1758825797
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 1:23=E2=80=AFPM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
>
> On 9/25/25 19:02, Bryan Gurney wrote:
> > In order to avoid a null pointer dereference, the vha->default_item
> > should be set to 0 last if the item pointer passed to the function
> > matches.
> >
> > BUG: kernel NULL pointer dereference, address: 0000000000000936
> > ...
> > RIP: 0010:qla24xx_free_purex_item+0x5e/0x90 [qla2xxx]
> > ...
> > Call Trace:
> >   <TASK>
> >   qla24xx_process_purex_list+0xda/0x110 [qla2xxx]
> >   qla2x00_do_dpc+0x8ac/0xab0 [qla2xxx]
> >   ? __pfx_qla2x00_do_dpc+0x10/0x10 [qla2xxx]
> >   kthread+0xf9/0x240
> >   ? __pfx_kthread+0x10/0x10
> >   ret_from_fork+0xf1/0x110
> >   ? __pfx_kthread+0x10/0x10
> >
> > Also use a local variable to avoid multiple de-referencing of the item.
> >
> > Fixes: 6f4b10226b6b ("scsi: qla2xxx: Fix memcpy() field-spanning write =
issue")
> > Signed-off-by: Bryan Gurney <bgurney@redhat.com>
> > ---
> >   drivers/scsi/qla2xxx/qla_os.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_o=
s.c
> > index 98a5c105fdfd..7e28c7e9aa60 100644
> > --- a/drivers/scsi/qla2xxx/qla_os.c
> > +++ b/drivers/scsi/qla2xxx/qla_os.c
> > @@ -6459,9 +6459,11 @@ void qla24xx_process_purex_rdp(struct scsi_qla_h=
ost *vha,
> >   void
> >   qla24xx_free_purex_item(struct purex_item *item)
> >   {
> > -     if (item =3D=3D &item->vha->default_item) {
> > -             memset(&item->vha->default_item, 0, sizeof(struct purex_i=
tem));
> > -             memset(&item->vha->__default_item_iocb, 0, QLA_DEFAULT_PA=
YLOAD_SIZE);
> > +     scsi_qla_host_t *base_vha =3D item->vha;
> > +
> > +     if (item =3D=3D &base_vha->default_item) {
> > +             memset(&base_vha->__default_item_iocb, 0, QLA_DEFAULT_PAY=
LOAD_SIZE);
> > +             memset(&base_vha->default_item, 0, sizeof(struct purex_it=
em));
> >       } else
> >               kfree(item);
> >   }
>
> I see. I think it's probably better to go ahead with the revert, and then=
 apply
> the patch I proposed in my previous e-mail (it's more straightforward and=
 introduces
> fewer changes).
>
> If you agree with that, I can submit both the revert and the patch.
>
> Thanks
> -Gustavo
>

Hi Gustavo,

I just built a kernel with your patch, on top of the NVMe FPIN link
integrity v9 patch set, and a test run on qla2xxx passes without any
field-spanning write warnings, nor with any null pointer dereference
errors.


Thanks,

Bryan

