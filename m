Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36F0148857
	for <linux-hardening@vger.kernel.org>; Tue, 21 May 2024 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318473; cv=none; b=LtsWE57PZwMP7JCWym5nsxkuOUtazxFSk1LiyJH/9XfLI25JXT9B/WFR7R7ULUoL6/5TfwB+sseSWZVfX0+WzCakPiJxW84Ee3VlGs6sUs4ZkLzYLwBCASGS7N1I32u62RDhtfmsKSJzA8uBb3Va0lBXw5L1jJdneXCvdXG7m1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318473; c=relaxed/simple;
	bh=GEIFYDMiDqOUlJzRZA4PbPz2WefgTR7JG6gCJS0qa6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwFMDBkpYBTw1pAm9uwmr7yOoXQES9t9z5XRzJZ3c1oq94wVjetea7r4ILkXGDsf4uY60NKG3Kf+EspykzEoqutwwKAWtsatKCzomUvfxY5C9krXO0aHZ1FPZNCnMYTJuDN0hs41kkh/csJaKxIp7oBFXsVKtZm/4GNloq0qSAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gesz1D7t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gesz1D7t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716318470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dn6PdnAbKqai8Gq9rN/hTUE4RYD+AurcNGUDXgp58xI=;
	b=Gesz1D7t34KDgMY24R5HxIWlXESMs+rlfMTt8pCIBVOtSm8h4x0xrLF67ue5qB3tSaWlPq
	D7jtikzf4OPHaaVv7AUaSdVWKOXAtEC59BfHs7OrKzUjnRmS7H65rwDjtqWzlX4GylW4rc
	S8TsthfbIhqBRNn1TYZxOZ7v+LvuYNk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-T6EGcw5rN6mEKuuVouhu3g-1; Tue, 21 May 2024 15:07:47 -0400
X-MC-Unique: T6EGcw5rN6mEKuuVouhu3g-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-627956be166so84248497b3.0
        for <linux-hardening@vger.kernel.org>; Tue, 21 May 2024 12:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318467; x=1716923267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dn6PdnAbKqai8Gq9rN/hTUE4RYD+AurcNGUDXgp58xI=;
        b=rrB5mPp8jHxa4qUMz17ETcvwM9YNFWx/PYCYkasM7mc9MJptxwYZ6mP/OsVrzkD4u4
         UvKFANkHqxEYsm8KmpbFQ9H1LBAPn0xn7TfDdGR4/b0hEHktkB6op6IXpzXfqL2sJNZc
         ELGMVIRgquN2Fvz/vAvJG/J2f4qwLlEA+YC8/qNN41OxTDBkMaPk1qJ5/dgggjwXa4Eb
         QGpNENN7vWu+kP/ZUGkuUaAMYM4gJ4fv+3CyRJ13dLzUHRjkh+wl2kZb/9xA4qJVihzj
         dqWfSowjFDdpGNY2R/FaAsKECWsaO3oI+xwkYU+qtpghAkmW0lenDNvtMdref9QmExGp
         GLMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFdEXUDn4o2/YpgT1n9M9THGC2MZxvZR6rqI5tqz8gO5mchotTwE+IPlOYJ9NhbhjSenlnOe0PFa9JR0O+JG2Fu+dgyElJwGsPY4HAjoZc
X-Gm-Message-State: AOJu0YzaVPTk+d8EKWB0NSonU3E7LtzmaSY/RzLON9J9646rShYthffq
	80Fa4m33oA+8zQTSGmKA/zzhNPHhFZLTF4cnqxnY+Llm+BQMIEXXgI3heRvqFQAV9KdrfJE2CpC
	KWwD2fDSYeesRpAwJ3XIiaMJK0tB5iUPgbxEOwRfnNVrdyj1NrgVfvU1rsvYAP2t+SomHXS97w8
	lQdxCZLwScZQGN+jPPrgCpW6mdIVqVDYCarkNHSQlM
X-Received: by 2002:a0d:cb10:0:b0:618:8b98:f274 with SMTP id 00721157ae682-627e487d5a9mr29997b3.45.1716318466781;
        Tue, 21 May 2024 12:07:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFEv9vVF6nAIe4l5L7JOuOtvqZQrAkg9X0a9fBNuuXzySGrjmaEwIibjaYLGmZjTWPpRC4gxdQ6irvQ3pR+nY=
X-Received: by 2002:a0d:cb10:0:b0:618:8b98:f274 with SMTP id
 00721157ae682-627e487d5a9mr29747b3.45.1716318466428; Tue, 21 May 2024
 12:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410021833.work.750-kees@kernel.org> <20240410023155.2100422-3-keescook@chromium.org>
In-Reply-To: <20240410023155.2100422-3-keescook@chromium.org>
From: Ewan Milne <emilne@redhat.com>
Date: Tue, 21 May 2024 15:07:35 -0400
Message-ID: <CAGtn9rmJ2C=THWn351fH7s=PXTvOwag9P4_ecQx2_=cFCjs4Qg@mail.gmail.com>
Subject: Re: [PATCH 3/5] scsi: mpt3sas: Avoid possible run-time warning with
 long manufacturer strings
To: Kees Cook <keescook@chromium.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, Justin Stitt <justinstitt@google.com>, 
	Sathya Prakash <sathya.prakash@broadcom.com>, 
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>, 
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, MPT-FusionLinux.pdl@broadcom.com, 
	linux-scsi@vger.kernel.org, Charles Bertsch <cbertsch@cox.net>, 
	Bart Van Assche <bvanassche@acm.org>, Andy Shevchenko <andy@kernel.org>, 
	Kashyap Desai <kashyap.desai@broadcom.com>, Sumit Saxena <sumit.saxena@broadcom.com>, 
	Nilesh Javali <njavali@marvell.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Himanshu Madhani <himanshu.madhani@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com, 
	GR-QLogic-Storage-Upstream@marvell.com, Marco Patalano <mpatalan@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 10:32=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> The prior strscpy() replacement of strncpy() here expected the
> manufacture_reply strings to be NUL-terminated, but it is possible
> they are not, as the code pattern here shows, e.g., edev->vendor_id
> being exactly 1 character larger than manufacture_reply->vendor_id,
> and the replaced strncpy() was copying only up to the size of the
> source character array. Replace this with memtostr(), which is the
> unambiguous way to convert a maybe not-NUL-terminated character array
> into a NUL-terminated string.
>
> Fixes: b7e9712a02e8 ("scsi: mpt3sas: Replace deprecated strncpy() with st=
rscpy()")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Sathya Prakash <sathya.prakash@broadcom.com>
> Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: MPT-FusionLinux.pdl@broadcom.com
> Cc: linux-scsi@vger.kernel.org
> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.c      |  2 +-
>  drivers/scsi/mpt3sas/mpt3sas_transport.c | 14 +++++---------
>  2 files changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/m=
pt3sas_base.c
> index 258647fc6bdd..1320e06727df 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
> @@ -4774,7 +4774,7 @@ _base_display_ioc_capabilities(struct MPT3SAS_ADAPT=
ER *ioc)
>         char desc[17] =3D {0};
>         u32 iounit_pg1_flags;
>
> -       strscpy(desc, ioc->manu_pg0.ChipName, sizeof(desc));
> +       memtostr(desc, ioc->manu_pg0.ChipName);
>         ioc_info(ioc, "%s: FWVersion(%02d.%02d.%02d.%02d), ChipRevision(0=
x%02x)\n",
>                  desc,
>                  (ioc->facts.FWVersion.Word & 0xFF000000) >> 24,
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3=
sas/mpt3sas_transport.c
> index 76f9a9177198..d84413b77d84 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
> @@ -458,17 +458,13 @@ _transport_expander_report_manufacture(struct MPT3S=
AS_ADAPTER *ioc,
>                         goto out;
>
>                 manufacture_reply =3D data_out + sizeof(struct rep_manu_r=
equest);
> -               strscpy(edev->vendor_id, manufacture_reply->vendor_id,
> -                       sizeof(edev->vendor_id));
> -               strscpy(edev->product_id, manufacture_reply->product_id,
> -                       sizeof(edev->product_id));
> -               strscpy(edev->product_rev, manufacture_reply->product_rev=
,
> -                       sizeof(edev->product_rev));
> +               memtostr(edev->vendor_id, manufacture_reply->vendor_id);
> +               memtostr(edev->product_id, manufacture_reply->product_id)=
;
> +               memtostr(edev->product_rev, manufacture_reply->product_re=
v);
>                 edev->level =3D manufacture_reply->sas_format & 1;
>                 if (edev->level) {
> -                       strscpy(edev->component_vendor_id,
> -                               manufacture_reply->component_vendor_id,
> -                               sizeof(edev->component_vendor_id));
> +                       memtostr(edev->component_vendor_id,
> +                                manufacture_reply->component_vendor_id);
>                         tmp =3D (u8 *)&manufacture_reply->component_id;
>                         edev->component_id =3D tmp[0] << 8 | tmp[1];
>                         edev->component_revision_id =3D
> --
> 2.34.1
>
>

Tested-by: Marco Patalano <mpatalan@redhat.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com

This fixes the following warning & subsequent panic seen on one of our
test machines:

[    4.986905] ------------[ cut here ]------------
[    4.991545] strnlen: detected buffer overflow: 9 byte read of buffer siz=
e 8
[    4.998528] WARNING: CPU: 2 PID: 13 at lib/string_helpers.c:1029
__fortify_report+0x3f/0x50
[    5.006889] Modules linked in: qla2xxx(+) bnxt_en mpt3sas(+)
nvme_fc ahci crct10dif_pclmul libahci nvme_fabrics crc32_pclmul
crc32c_intel nvme_core libata t10_pi raid_class ghash_clmulni_intel
tg3 scsi_transport_fc scsi_transport_sas dimlib wmi dm_mirror
dm_region_hash dm_log dm_mod
[    5.031912] CPU: 2 PID: 13 Comm: kworker/u128:1 Not tainted 6.9.0+ #1
[    5.038352] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
2.21.2 02/19/2024
[    5.038355] Workqueue: fw_event_mpt3sas0 _firmware_event_work [mpt3sas]
[    5.052557] RIP: 0010:__fortify_report+0x3f/0x50
[    5.052560] Code: c1 83 e7 01 48 c7 c1 5c 4d 08 b9 48 c7 c7 80 c1
01 b9 48 8b 34 c5 80 cc af b8 48 c7 c0 66 4d 08 b9 48 0f 45 c8 e8 01
a8 a8 ff <0f> 0b c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 90 90 90
90 90
[    5.075926] RSP: 0018:ffffb972c02c7bb0 EFLAGS: 00010286
[    5.075928] RAX: 0000000000000000 RBX: ffff915503b12100 RCX: 00000000000=
00000
[    5.088284] RDX: ffff91586faaee40 RSI: ffff91586faa0bc0 RDI: ffff91586fa=
a0bc0
[    5.095418] RBP: ffff915503f11c08 R08: 0000000000000000 R09: ffffb972c02=
c7a60
[    5.102549] R10: ffffb972c02c7a58 R11: ffffffffb95deba8 R12: ffff9155126=
ef010
[    5.102551] R13: ffff9155086ecb50 R14: ffff9155126ef000 R15: ffff9155086=
ec848
[    5.102552] FS:  0000000000000000(0000) GS:ffff91586fa80000(0000)
knlGS:0000000000000000
[    5.116816] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.120583] ata15.00: Security Log not supported
[    5.120723] ata15.00: Security Log not supported
[    5.130645] CR2: 00007f48a3d47a50 CR3: 00000003b2e20006 CR4: 00000000007=
706f0
[    5.130647] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[    5.139880] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[    5.139882] PKRU: 55555554
[    5.139883] Call Trace:
[    5.154146]  <TASK>
[    5.163991]  ? __warn+0x7f/0x120
[    5.168549]  ? __fortify_report+0x3f/0x50
[    5.175791]  ? report_bug+0x18a/0x1a0
[    5.179479]  ? handle_bug+0x3c/0x70
[    5.182994]  ? exc_invalid_op+0x14/0x70
[    5.182997]  ? asm_exc_invalid_op+0x16/0x20
[    5.191021]  ? __fortify_report+0x3f/0x50
[    5.195033]  __fortify_panic+0x9/0x10
[    5.198699]
_transport_expander_report_manufacture.isra.0+0x5f0/0x620 [mpt3sas]
[    5.206145]  mpt3sas_transport_port_add+0x5df/0x7a0 [mpt3sas]
[    5.211931]  _scsih_expander_add+0x28a/0x650 [mpt3sas]
[    5.217112]  ? _scsih_sas_host_refresh+0x2aa/0x510 [mpt3sas]
[    5.222799]  _scsih_sas_topology_change_event.isra.0+0x213/0x440 [mpt3sa=
s]
[    5.229714]  _mpt3sas_fw_work+0x6ab/0xb50 [mpt3sas]
[    5.234636]  ? pick_next_task+0x9e2/0xae0
[    5.238649]  ? finish_task_switch.isra.0+0x97/0x290
[    5.243555]  ? move_linked_works+0x70/0xa0
[    5.247661]  process_one_work+0x184/0x3b0
[    5.251673]  worker_thread+0x2f9/0x410
[    5.251677]  ? __pfx_worker_thread+0x10/0x10
[    5.251679]  kthread+0xcc/0x100
[    5.259713]  ? __pfx_kthread+0x10/0x10
[    5.259715]  ret_from_fork+0x2d/0x50
[    5.270190]  ? __pfx_kthread+0x10/0x10
[    5.273944]  ret_from_fork_asm+0x1a/0x30
[    5.277872]  </TASK>
[    5.280062] ---[ end trace 0000000000000000 ]---

